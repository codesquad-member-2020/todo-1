package com.codesquad.todo1.domain;

import lombok.Getter;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

@Getter
@ToString
public class History {
    @Id
    private Long id;

    private String userId;
    private String action;
    private String title;
    private Integer fromColumn;
    private Integer toColumn;
    private LocalDateTime localDateTime;

    public History(String userId, String action, String title,
                   Integer fromColumn, Integer toColumn, LocalDateTime localDateTime) {
        this.userId = userId;
        this.action = action;
        this.title = title;
        this.fromColumn = fromColumn;
        this.toColumn = toColumn;
        this.localDateTime = LocalDateTime.now();
    }
}
