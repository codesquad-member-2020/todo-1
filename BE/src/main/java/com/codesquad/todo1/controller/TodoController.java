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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class TodoController {


}
