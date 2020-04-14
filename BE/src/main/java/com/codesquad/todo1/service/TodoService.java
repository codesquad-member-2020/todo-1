package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.error.FindCategoryFail;
import com.codesquad.todo1.error.UpdateCardFail;
import com.codesquad.todo1.repository.CategoryRepository;
import com.codesquad.todo1.repository.UserRepository;
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
    public Optional<Card> cardSave(Card card, Long categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new FindCategoryFail("There is no category with this categoryId"));
        category.addCard(card);
        Category savedCategory = categoryRepository.save(category);
        Long cardId = savedCategory.getCards().get(savedCategory.getCards().size() - 1).getId();
        return categoryRepository.findByCardId(cardId);
    }

    @Transactional
    public Optional<Card> cardUpdate(Card card, Long categoryId, Long cardId) {
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
    public void cardDelete(Long id, Long cardId) {
        Category category = categoryRepository.findById(id).orElseThrow(() ->
                new IllegalStateException("No category"));
        try {
            category.deleteCard(cardId);
            Category savedCategory = categoryRepository.save(category);
//            Long updatedCardId = savedCategory.findUpdatedCardId(cardId);
//            return categoryRepository.findByCardId(updatedCardId);
        } catch (Exception e) {
            throw new IllegalStateException("update Fail");
        }
    }
}
