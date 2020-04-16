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

    private final Logger logger = LoggerFactory.getLogger(TodoService.class);

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
        Category category = findCategory(categoryId);
        category.addNewCard(0, card);
        savedUser(card);
        historySave(card, "add", category, category);
        Category savedCategory = categoryRepository.save(category);
        Long cardId = savedCategory.getCards().get(0).getId();
        return categoryRepository.findByCardId(cardId);
    }

    @Transactional
    public Optional<Card> updateCard(Card card, Long categoryId, Long cardId) {
        Category category = findCategory(categoryId);
        try {
            savedUser(card);
            category.updateCard(card, cardId);
            historySave(card, "update", category, category);
            Category savedCategory = categoryRepository.save(category);
            Long updatedCardId = savedCategory.findUpdatedCardId(cardId);
            return categoryRepository.findByCardId(updatedCardId);
        } catch (RuntimeException e) {
            throw new UpdateCardFail();
        }
    }

    @Transactional
    public void deleteCard(Long categoryId, Long cardId) {
        Category category = findCategory(categoryId);
        try {
            Card card = category.deleteCard(cardId);
            savedUser(card);
            historySave(card, "remove", category, category);
            categoryRepository.save(category);
        } catch (RuntimeException e) {
            throw new IllegalStateException("delete Fail");
        }
    }

    @Transactional
    public Optional<Card> moveCard(Long categoryId, Long cardId, String MoveJson) throws JsonProcessingException {
        int[] moveData = parseJson(MoveJson);
        int toCategoryId = moveData[0];
        int toRow = moveData[1];
        Category moveFromCategory = findCategory(categoryId);
        try {
            Card deletedCard = moveFromCategory.deleteCard(cardId);
            savedUser(deletedCard);
            categoryRepository.save(moveFromCategory);
            Category moveToCategory = findCategory((long) toCategoryId);
            historySave(deletedCard, "move", moveFromCategory, moveToCategory);
            moveToCategory.addCardToIndex(toRow, deletedCard);
            categoryRepository.save(moveToCategory);
            return categoryRepository.findByCardId(cardId);
        } catch (RuntimeException e) {
            throw new IllegalStateException("move Fail");
        }
    }

    private int[] parseJson(String moveJson) throws JsonProcessingException {
        JsonNode jsonNode = new ObjectMapper().readTree(moveJson);
        int toColumn = jsonNode.get("toColumn").asInt();
        int toRow = jsonNode.get("toRow").asInt();
        return new int[]{toColumn, toRow};
    }

    private Category findCategory(Long categoryId) {
        return categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
    }

    private User savedUser(Card card) {
        return userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                new IllegalStateException("No User"));
    }

    private void historySave(Card card, String action, Category fromCategory, Category toCategory) {
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
