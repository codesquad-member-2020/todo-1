package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.repository.CategoryRepository;
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

    @Transactional
    public List<Category> showTodoList() {
        return (List<Category>) categoryRepository.findAll();
    }

    @Transactional
    public Optional<User> findByUserId(String userId) {
        return categoryRepository.findByUserId(userId);
    }

    @Transactional
    public Optional<Card> cardSave(Card card, Long categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() ->
                new IllegalStateException("No category"));
        category.addCard(card);
        Category savedCategory = categoryRepository.save(category);
        Long cardId = savedCategory.getCards().get(savedCategory.getCards().size() - 1).getId();
        logger.info("cardId : {}", cardId);
        return categoryRepository.findByCardId(cardId);
    }
}
