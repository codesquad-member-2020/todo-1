package com.codesquad.todo1.controller;

import com.codesquad.todo1.api.ApiUserInfo;
import com.codesquad.todo1.service.UserService;
import com.codesquad.todo1.api.ApiLogin;
import com.codesquad.todo1.domain.User;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequiredArgsConstructor
public class LoginController {

    private final Logger logger = LoggerFactory.getLogger(LoginController.class);
    private final UserService userService;

    @PostMapping("login")
    public ApiLogin login(@RequestBody User user,
                        HttpServletResponse response) {
        try {
            String jwt = userService.makeJwt(user, response);
            return new ApiLogin(200, jwt);
        } catch (RuntimeException e) {
            response.setStatus(401);
            return new ApiLogin(401, null);
        }
    }

    @GetMapping("/userInfo")
    public ApiUserInfo userInfo(HttpServletRequest request) {
        User user = userService.findUserForInfo(request);
        try {
            return new ApiUserInfo(200, user, "OK");
        } catch (RuntimeException e) {
            return new ApiUserInfo(401, null, "Unauthorized");
        }
    }
}
