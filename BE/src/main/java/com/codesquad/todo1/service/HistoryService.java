package com.codesquad.todo1.service;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import com.codesquad.todo1.domain.History;
import com.codesquad.todo1.repository.HistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HistoryService {

    private final HistoryRepository historyRepository;

    private final UserService userService;

    @Transactional
    public List<History> showActivityList(String userId) {
        return historyRepository.findByUserIdOrderByIdDesc(userId);
    }

    @Transactional
    public void historySave(Card card, String action, Category fromCategory, Category toCategory) {
        History history = History.builder()
                .userId(card.getUserId())
                .profileUrl(userService.findUser(card).getProfileUrl())
                .action(action)
                .title(card.getTitle())
                .fromColumn(fromCategory.getColumnName())
                .toColumn(toCategory.getColumnName())
                .build();
        historyRepository.save(history);
    }
}
