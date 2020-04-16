package com.codesquad.todo1.controller;

import com.codesquad.todo1.domain.History;
import com.codesquad.todo1.service.HistoryService;
import com.codesquad.todo1.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class HistoryController {

    private final HistoryService historyService;

    @GetMapping("/activity")
    public List<History> activityLog(HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        return historyService.showActivityList(userId);
    }
}
