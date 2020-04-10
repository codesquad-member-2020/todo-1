package com.codesquad.todo1.controller;

import com.codesquad.todo1.Utils.AuthorizationFail;
import com.codesquad.todo1.Utils.JwtUtils;
import com.codesquad.todo1.api.ApiShowList;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class TodoController {

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

        logger.info("user : {}", user);
        return new ApiShowList(200);
    }

    @GetMapping("/hello")
    public String hello() {
        return "hello";
    }



}
