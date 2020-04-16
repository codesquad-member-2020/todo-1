package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import com.codesquad.todo1.domain.History;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.error.FindCategoryFail;
import com.codesquad.todo1.error.UpdateCardFail;
import com.codesquad.todo1.repository.CategoryRepository;
import com.codesquad.todo1.repository.HistoryRepository;
import com.codesquad.todo1.repository.UserRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class TodoService {

    private Logger logger = LoggerFactory.getLogger(TodoService.class);
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;
    private final HistoryRepository historyRepository;

    @Transactional
    public List<Category> showTodoList() {
        return (List<Category>) categoryRepository.findAll();
    }

    @Transactional
    public List<History> showActivityList(String userId) {
        return historyRepository.findByUserIdOrderByIdDesc(userId);
    }

    @Transactional
    public Optional<Card> addCard(Card card, Long categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
        category.addNewCard(0, card);
        Category savedCategory = categoryRepository.save(category);
        //todo: 유저 Optional util이나 private method로 리팩토링.
        User savedUser = userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                new IllegalStateException("No User"));
        //todo: History builder (userId, profileUrl, title) 중복 제거.
        History history = History.builder()
                .userId(card.getUserId())
                .profileUrl(savedUser.getProfileUrl())
                .action("add")
                .title(card.getTitle())
                .fromColumn(Math.toIntExact(categoryId))
                .toColumn(Math.toIntExact(categoryId))
                .build();
        historyRepository.save(history);
        Long cardId = savedCategory.getCards().get(0).getId();
        return categoryRepository.findByCardId(cardId);
    }

    @Transactional
    public Optional<Card> updateCard(Card card, Long categoryId, Long cardId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
        logger.info("category : {}", category);
        try {
            category.updateCard(card, cardId);
            User savedUser = userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                    new IllegalStateException("No User"));
            History history = History.builder()
                    .userId(card.getUserId())
                    .profileUrl(savedUser.getProfileUrl())
                    .action("update")
                    .title(card.getTitle())
                    .fromColumn(Math.toIntExact(categoryId))
                    .toColumn(Math.toIntExact(categoryId))
                    .build();
            Category savedCategory = categoryRepository.save(category);
            historyRepository.save(history);
            Long updatedCardId = savedCategory.findUpdatedCardId(cardId);
            return categoryRepository.findByCardId(updatedCardId);
        } catch (Exception e) {
            throw new UpdateCardFail();
        }
    }

    @Transactional
    public void deleteCard(Long categoryId, Long cardId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
        logger.info("category : {}", category);
        try {
            Card card = category.deleteCard(cardId);
            User savedUser = userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                    new IllegalStateException("No User"));
            History history = History.builder()
                    .userId(card.getUserId())
                    .profileUrl(savedUser.getProfileUrl())
                    .action("remove")
                    .title(card.getTitle())
                    .fromColumn(Math.toIntExact(categoryId))
                    .toColumn(Math.toIntExact(categoryId))
                    .build();
            categoryRepository.save(category);
            historyRepository.save(history);
        } catch (Exception e) {
            throw new IllegalStateException("delete Fail");
        }
    }

    @Transactional
    public Optional<Card> moveCard(Long categoryId, Long cardId, String MoveJson) throws JsonProcessingException {
        int[] moveData = parseJson(MoveJson);
        int toCategoryId = moveData[0];
        int toRow = moveData[1];
        Category moveFromCategory = categoryRepository.findById(categoryId).orElseThrow(() ->
                new IllegalStateException("No Category."));
        logger.info("moveFromCategory : {}", moveFromCategory);

        Card deletedCard = moveFromCategory.deleteCard(cardId);
        User savedUser = userRepository.findByUserId(deletedCard.getUserId()).orElseThrow(() ->
                new IllegalStateException("No User"));
        History history = History.builder()
                .userId(deletedCard.getUserId())
                .profileUrl(savedUser.getProfileUrl())
                .action("move")
                .title(deletedCard.getTitle())
                .fromColumn(Math.toIntExact(categoryId))
                .toColumn(toCategoryId)
                .build();
        logger.info("deletedCard : {}", deletedCard);
        logger.info("moveFromCategory2 : {}", moveFromCategory);

        categoryRepository.save(moveFromCategory);
        Category moveToCategory = categoryRepository.findById((long) toCategoryId).orElseThrow(() ->
                new IllegalStateException("No Category."));

        logger.info("moveToCategory : {}", moveToCategory);

        moveToCategory.addCardToIndex(toRow, deletedCard);
        historyRepository.save(history);
        categoryRepository.save(moveToCategory);
        return categoryRepository.findByCardId(cardId);
    }

    private int[] parseJson(String moveJson) throws JsonProcessingException {
        JsonNode jsonNode = new ObjectMapper().readTree(moveJson);
        int toColumn = jsonNode.get("toColumn").asInt();
        int toRow = jsonNode.get("toRow").asInt();
        return new int[]{toColumn, toRow};
    }
}
