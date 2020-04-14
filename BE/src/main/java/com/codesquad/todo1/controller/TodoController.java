package com.codesquad.todo1.controller;

import com.codesquad.todo1.api.ApiCard;
import com.codesquad.todo1.api.ApiShowList;
import com.codesquad.todo1.api.ApiStatus;
import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/columns")
public class TodoController {

    private final Logger logger = LoggerFactory.getLogger(TodoController.class);
    private final TodoService todoService;

    @GetMapping("")
    public ApiShowList show() {
        return new ApiShowList(200, todoService.showTodoList());
    }

    @PostMapping("/{id}/cards")
    public ApiCard create(@PathVariable Long id,
                          @RequestBody Card card) {
        return new ApiCard(200, todoService.saveCard(card, id));
    }

    @PutMapping("/{categoryId}/cards/{cardId}")
    public ApiCard update(@PathVariable Long categoryId,
                         @PathVariable Long cardId,
                         @RequestBody Card card) {
        try {
            logger.info("categoryId : {}", categoryId);
            logger.info("cardId : {}", cardId);
            logger.info("card : {}", card);
            return new ApiCard(200, todoService.updateCard(card, categoryId, cardId));
        } catch (Exception e) {
            e.printStackTrace();
           return new ApiCard(204, null);
        }
    }

    @DeleteMapping("/{categoryId}/cards/{cardId}")
    public ApiStatus delete(@PathVariable Long categoryId,
                           @PathVariable Long cardId) {
        try {
            todoService.deleteCard(categoryId, cardId);
            return new ApiStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            return new ApiStatus(204);
        }

    }
}
