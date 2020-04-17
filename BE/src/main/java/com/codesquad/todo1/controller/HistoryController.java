package com.codesquad.todo1.controller;

import com.codesquad.todo1.api.ApiHistory;
import com.codesquad.todo1.service.HistoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequiredArgsConstructor
public class HistoryController {

    private final HistoryService historyService;

    @GetMapping("/activity")
    public ApiHistory activityLog(HttpServletRequest request) {
        try {
            return new ApiHistory(200, historyService.showActivityList(), "OK");
        } catch (RuntimeException e) {
            return new ApiHistory(401, null, "Unauthorized");
        }
    }
}
