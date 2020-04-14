package com.codesquad.todo1.controller;

import com.codesquad.todo1.api.ApiCard;
import com.codesquad.todo1.api.ApiLogin;
import com.codesquad.todo1.api.ApiShowList;
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
        return new ApiCard(200, todoService.cardSave(card, id));
    }

    @PutMapping("/{id}/cards/{cardId}")
    public ApiCard update(@PathVariable Long id,
                         @PathVariable Long cardId,
                         @RequestBody Card card) {
        try {
            return new ApiCard(200, todoService.cardUpdate(card, id, cardId));
        } catch (Exception e) {
           return new ApiCard(204, null);
        }
    }

    @DeleteMapping("{id}/cards/{cardId}")
    public ApiLogin delete(@PathVariable Long id,
                           @PathVariable Long cardId) {
        todoService.cardDelete(id, cardId);
        return new ApiLogin(200, null);

    }
}
