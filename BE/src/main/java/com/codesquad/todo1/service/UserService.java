package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.error.AuthorizationFail;
import com.codesquad.todo1.repository.UserRepository;
import com.codesquad.todo1.utils.JwtUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional
    public Optional<User> findByUserId(String userId) {
        return userRepository.findByUserId(userId);
    }

    @Transactional
    public User findUser(Card card) {
        return userRepository.findByUserId(card.getUserId()).orElseThrow(() ->
                new IllegalStateException("No User"));
    }

    public String makeJwt(User user, HttpServletResponse response) {
        String userId = user.getUserId();
        String password = user.getPassword();
        User validationSuccessUser = checkValidation(userId, password);
        // 인증 통과한 userId로 jwt를 만든다.
        String jwt = JwtUtils.jwtCreate(validationSuccessUser.getUserId());
        // 만든 jwt를 쿠키에 담아서 response 한다.
        Cookie cookie = new Cookie("jwt", jwt);
        response.addCookie(cookie);
        response.setStatus(200);
        return jwt;
    }

    public User findUserForInfo(HttpServletRequest request) {
        String userInfo = (String) request.getAttribute("userId");
        return findByUserId(userInfo).orElseThrow(() ->
                new IllegalStateException("No User"));
    }

    private User checkValidation(String userId, String password) {
        User savedUser = userRepository.findByUserId(userId).orElseThrow(AuthorizationFail::new);
        String savedPassword = savedUser.getPassword();
        if (!password.equals(savedPassword)) {
            throw new AuthorizationFail();
        }
        return savedUser;
    }
}
