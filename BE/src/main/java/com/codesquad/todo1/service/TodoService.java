package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Todo;
import com.codesquad.todo1.repository.TodoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class TodoService {

    private final TodoRepository todoRepository;

    @Transactional
    public List<Todo> showTodoList() {
        return (List<Todo>) todoRepository.findAll();
    }

}
