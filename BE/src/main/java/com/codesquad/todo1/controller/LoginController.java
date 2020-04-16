package com.codesquad.todo1.controller;

import com.codesquad.todo1.api.ApiUserInfo;
import com.codesquad.todo1.error.AuthorizationFail;
import com.codesquad.todo1.service.UserService;
import com.codesquad.todo1.utils.JwtUtils;
import com.codesquad.todo1.api.ApiLogin;
import com.codesquad.todo1.domain.User;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequiredArgsConstructor
public class LoginController {

    private Logger logger = LoggerFactory.getLogger(LoginController.class);
    private final UserService userService;

    @PostMapping("login")
    public ApiLogin login(@RequestBody User user,
                        HttpServletResponse response) {
        String userId = user.getUserId();
        String password = user.getPassword();
        //todo: 해당 복잡한 로직은 UserService에 넣도록 하기.
        logger.info("loginTryUser : {}", user);
        try {
            User validationSuccessUser = checkValidation(userId, password);
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

    @GetMapping("/userInfo")
    public ApiUserInfo userInfo(HttpServletRequest request) {
        String userInfo = (String) request.getAttribute("userId");
        User user = userService.findByUserId(userInfo).orElseThrow(() ->
                new IllegalStateException("No User"));
        return new ApiUserInfo(user);
    }
        //todo: UserService 로직에 포함 하기.
    private User checkValidation(String userId, String password) throws AuthorizationFail {
        User savedUser = userService.findByUserId(userId).orElseThrow(AuthorizationFail::new);
        logger.info("savedUser : {}", savedUser);
        String savedPassword = savedUser.getPassword();
        if (!password.equals(savedPassword)) {
            throw new AuthorizationFail();
        }
        return savedUser;
    }
}
