package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.error.FindCategoryFail;
import com.codesquad.todo1.error.UpdateCardFail;
import com.codesquad.todo1.repository.CategoryRepository;
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

    @Transactional
    public List<Category> showTodoList() {
        return (List<Category>) categoryRepository.findAll();
    }

    @Transactional
    public Optional<User> findByUserId(String userId) {
        return userRepository.findByUserId(userId);
    }

    @Transactional
    public Optional<Card> saveCard(Card card, Long categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
        category.addCard(card);
        Category savedCategory = categoryRepository.save(category);
        Long cardId = savedCategory.getCards().get(savedCategory.getCards().size() - 1).getId();
        return categoryRepository.findByCardId(cardId);
    }

    @Transactional
    public Optional<Card> updateCard(Card card, Long categoryId, Long cardId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
        logger.info("category : {}", category);
        try {
            category.updateCard(card, cardId);
            Category savedCategory = categoryRepository.save(category);
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
            category.deleteCard(cardId);
            categoryRepository.save(category);
        } catch (Exception e) {
            throw new IllegalStateException("delete Fail");
        }
    }

    public Optional<Card> moveCard(Long categoryId, Long cardId, String MoveJson) throws JsonProcessingException {
        int[] moveData = parseJson(MoveJson);
        Category moveFromCategory = categoryRepository.findById(categoryId).orElseThrow(() ->
                new IllegalStateException("No Category."));
        Category moveToCategory = categoryRepository.findById((long) moveData[0]).orElseThrow(() ->
                new IllegalStateException("No Category."));
        Card card = categoryRepository.findBycardId(cardId);
        moveFromCategory.deleteCard(cardId);
        categoryRepository.save(moveFromCategory);
        moveToCategory.addCardToIndex(moveData[1], card);
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
