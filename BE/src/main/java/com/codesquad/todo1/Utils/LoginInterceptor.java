package com.codesquad.todo1.Utils;

import com.codesquad.todo1.service.TodoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Autowired
    private TodoService todoService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler) {
        logger.info("target 메서드 전에 실행??");
        Cookie[] cookies = request.getCookies();
        Cookie cookie = null;
        for (Cookie each : cookies) {
            if (each.getName().equals("sunny_jwt")) cookie = each;
        }
        assert cookie != null;
        String jwt = cookie.getValue();
        String jwtUserId = JwtUtils.jwtParsing(jwt);
        try {
            todoService.getUser(jwtUserId).orElseThrow(AuthorizationFail::new);
        } catch (Exception e) {
            request.setAttribute("jwt", false);
            return true;
        }
//        logger.info("cookie : {}", jwt);
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object Handler,
                           ModelAndView modelAndView) {
        logger.info("target 메서드 후에 실행??");
    }
}
