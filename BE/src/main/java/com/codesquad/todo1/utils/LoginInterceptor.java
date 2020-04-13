package com.codesquad.todo1.utils;

import com.codesquad.todo1.error.AuthorizationFail;
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
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) {
        logger.info("preHandle Interceptor");
        try {
            Cookie[] cookies = request.getCookies();
            if (cookies == null) throw new AuthorizationFail();

            Cookie cookie = null;
            for (Cookie each : cookies) {
                if (each.getName().equals("jwt")) cookie = each;
            }
            if (cookie == null) throw new AuthorizationFail();

            String jwt = cookie.getValue();
            String jwtUserId = JwtUtils.jwtParsing(jwt);
            todoService.findByUserId(jwtUserId).orElseThrow(AuthorizationFail::new);
        } catch (Exception e) {
            response.setStatus(401);
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object Handler,
                           ModelAndView modelAndView) {
        logger.info("postHandle Interceptor");
    }
}
