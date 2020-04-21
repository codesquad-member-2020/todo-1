package com.codesquad.todo1.controller;

import com.codesquad.todo1.error.AuthorizationFail;
import com.codesquad.todo1.utils.JwtUtils;
import com.codesquad.todo1.api.ApiLogin;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequiredArgsConstructor
public class LoginController {

    private Logger logger = LoggerFactory.getLogger(LoginController.class);
    private final TodoService todoService;

    @PostMapping("login")
    public ApiLogin login(@RequestBody User user,
                        HttpServletResponse response) {
        String userId = user.getUserId();
        String password = user.getPassword();
        try {
            checkValidation(userId, password);
            // 인증 통과한 userId로 jwt를 만든다.
            String jwt = JwtUtils.jwtCreate(userId);
            // 만든 jwt를 쿠키에 담아서 response 한다.
            Cookie cookie = new Cookie("jwt", jwt);
            response.addCookie(cookie);
            response.setStatus(200);
            return new ApiLogin(200, jwt);
        } catch (Exception e) {
            response.setStatus(401);
            return new ApiLogin(401, null);
        }
    }

    private void checkValidation(String userId, String password) throws AuthorizationFail {
        User savedUser = todoService.findByUserId(userId).orElseThrow(AuthorizationFail::new);
        String savedPassword = savedUser.getPassword();
        if (!password.equals(savedPassword)) {
            throw new AuthorizationFail();
        }
    }
}
