package com.codesquad.todo1.controller;

import com.codesquad.todo1.api.ApiShowList;
import com.codesquad.todo1.domain.Todo;
import com.codesquad.todo1.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class TodoController {

    private final TodoService todoService;

    @GetMapping("/columns")
    public ApiShowList show() {
        return new ApiShowList(200, todoService.showTodoList());
    }
}
