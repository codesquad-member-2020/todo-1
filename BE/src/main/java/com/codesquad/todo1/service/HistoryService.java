package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import com.codesquad.todo1.domain.History;
import com.codesquad.todo1.domain.User;
import com.codesquad.todo1.repository.HistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HistoryService {

    private final HistoryRepository historyRepository;

    private final UserService userService;

    @Transactional
    public List<History> showActivityList() {
        return historyRepository.findAll();
    }

    @Transactional
    public void historySave(Card card, String action, Category fromCategory, Category toCategory,
                            HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        User user = userService.findByUserId(userId).orElseThrow(() ->
                new IllegalStateException("No User"));
        History history = History.builder()
                .userId(userId)
                .profileUrl(user.getProfileUrl())
                .action(action)
                .title(card.getTitle())
                .fromColumn(fromCategory.getColumnName())
                .toColumn(toCategory.getColumnName())
                .build();
        historyRepository.save(history);
    }
}
