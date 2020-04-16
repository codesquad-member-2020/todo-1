package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional
    public Optional<User> findByUserId(String userId) {
        return userRepository.findByUserId(userId);
    }
}
