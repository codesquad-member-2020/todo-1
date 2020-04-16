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
        savedUser(card);
        historyBuilder(card, "add", category, category);
        Category savedCategory = categoryRepository.save(category);
        Long cardId = savedCategory.getCards().get(0).getId();
        return categoryRepository.findByCardId(cardId);
    }

    @Transactional
    public Optional<Card> updateCard(Card card, Long categoryId, Long cardId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
        try {
            User savedUser = userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                    new IllegalStateException("No User"));
            category.updateCard(card, cardId);
            History history = History.builder()
                    .userId(card.getUserId())
                    .profileUrl(savedUser.getProfileUrl())
                    .action("update")
                    .title(card.getTitle())
                    .fromColumn(category.getColumnName())
                    .toColumn(category.getColumnName())
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
        try {
            Card card = category.deleteCard(cardId);
            User savedUser = userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                    new IllegalStateException("No User"));
            History history = History.builder()
                    .userId(card.getUserId())
                    .profileUrl(savedUser.getProfileUrl())
                    .action("remove")
                    .title(card.getTitle())
                    .fromColumn(category.getColumnName())
                    .toColumn(category.getColumnName())
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

        categoryRepository.save(moveFromCategory);
        Category moveToCategory = categoryRepository.findById((long) toCategoryId).orElseThrow(() ->
                new IllegalStateException("No Category."));
        History history = History.builder()
                .userId(deletedCard.getUserId())
                .profileUrl(savedUser.getProfileUrl())
                .action("move")
                .title(deletedCard.getTitle())
                .fromColumn(moveFromCategory.getColumnName())
                .toColumn(moveToCategory.getColumnName())
                .build();
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

    private User savedUser(Card card) {
        return userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                new IllegalStateException("No User"));
    }

    private void historyBuilder(Card card, String action, Category fromCategory, Category toCategory) {
        History history = History.builder()
                .userId(card.getUserId())
                .profileUrl(savedUser(card).getProfileUrl())
                .action(action)
                .title(card.getTitle())
                .fromColumn(fromCategory.getColumnName())
                .toColumn(toCategory.getColumnName())
                .build();
        historyRepository.save(history);
    }
}
