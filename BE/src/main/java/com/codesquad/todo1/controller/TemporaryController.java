package com.codesquad.todo1.controller;

import com.codesquad.todo1.Utils.JwtUtils;
import com.codesquad.todo1.api.ApiShowList;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
public class TemporaryController {
    private Logger logger = LoggerFactory.getLogger(TodoController.class);
    private final TodoService todoService;

    @GetMapping("/columns")
    public ApiShowList show() {
        return new ApiShowList(200, todoService.showTodoList());
    }

    @PostMapping("/login")
    public ApiShowList login(@RequestBody User user,
                             HttpServletResponse response) {
        String userId = user.getUserId();
        logger.info("userId : {}", userId);
        String password = user.getPassword();
//        try {
//            User searchedUser = todoService.getUser(userId).orElseThrow(AuthorizationFail::new);
//            logger.info("searchedUser: {}",searchedUser);
//
//            if (!password.equals(searchedUser.getPassword())) throw new AuthorizationFail();
//        } catch (Exception e) {
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        }

        Cookie cookie = new Cookie("sunny_jwt", JwtUtils.jwtCreate(userId));
        response.addCookie(cookie);

//        logger.info("user : {}", user);
        return new ApiShowList(200);
    }

    @GetMapping("/hello")
    public ApiShowList hello(HttpServletRequest request) {
        logger.info("target 메서드 실행!");
        boolean authorization = (boolean) request.getAttribute("jwt");
        if (!authorization) {
            return new ApiShowList(401);
        }
        return new ApiShowList(200);
    }
}
