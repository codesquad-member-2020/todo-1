package com.codesquad.todo1.controller;

import com.codesquad.todo1.api.ApiCard;
import com.codesquad.todo1.api.ApiShowList;
import com.codesquad.todo1.api.ApiStatus;
import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.service.TodoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

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
                          @RequestBody Card card,
                          HttpServletRequest request) {
        try {
            return new ApiCard(200, todoService.addCard(card, id, request), "OK");
        } catch (RuntimeException e) {
            return new ApiCard(400, null, "Bad Request");
        }
    }

    @PutMapping("/{categoryId}/cards/{cardId}")
    public ApiCard update(@PathVariable Long categoryId,
                          @PathVariable Long cardId,
                          @RequestBody Card card,
                          HttpServletRequest request) {
        try {
            logger.info("categoryId : {}", categoryId);
            logger.info("cardId : {}", cardId);
            logger.info("card : {}", card);
            return new ApiCard(200, todoService.updateCard(card, categoryId, cardId, request), "OK");
        } catch (Exception e) {
            e.printStackTrace();
            return new ApiCard(204, "No Content");
        }
    }

    @DeleteMapping("/{categoryId}/cards/{cardId}")
    public ApiStatus delete(@PathVariable Long categoryId,
                            @PathVariable Long cardId,
                            HttpServletRequest request) {
        try {
            todoService.deleteCard(categoryId, cardId, request);
            return new ApiStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            return new ApiStatus(204);
        }
    }

    @PostMapping("{columnsId}/cards/{id}")
    public ApiCard move(@PathVariable Long columnsId,
                        @PathVariable Long id,
                        @RequestBody String moveJson,
                        HttpServletRequest request) {
        try {
            return new ApiCard(200, todoService.moveCard(columnsId, id, moveJson, request), "OK");
        } catch (JsonProcessingException e) {
            return new ApiCard(400, "Not Json");
        }
    }
}
