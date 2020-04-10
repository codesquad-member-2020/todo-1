package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Todo;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.repository.TodoRepository;
import com.codesquad.todo1.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class TodoService {

    private final TodoRepository todoRepository;
    private final UserRepository userRepository;

    @Transactional
    public List<Todo> showTodoList() {
        return (List<Todo>) todoRepository.findAll();
    }

    @Transactional
    public Optional<User> getUser(String userId) {
        return userRepository.findByUserId(userId);
    }

    @Transactional
    public Optional<User> getPassword(String password) {
        return userRepository.findByPassword(password);
    }
}
