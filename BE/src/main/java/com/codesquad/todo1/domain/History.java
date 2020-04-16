package com.codesquad.todo1.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@ToString
@NoArgsConstructor
public class History {
    @Id
    private Long id;

    private String userId;
    private String profileUrl;
    private String action;
    private String title;
    private Integer fromColumn;
    private Integer toColumn;
    private String actionTime;

    @Builder
    public History(String userId, String profileUrl, String action, String title,
                   Integer fromColumn, Integer toColumn, String actionTime) {
        this.userId = userId;
        this.profileUrl = profileUrl;
        this.action = action;
        this.title = title;
        this.fromColumn = fromColumn;
        this.toColumn = toColumn;
        this.actionTime = ZonedDateTime.now(ZoneId.of("Asia/Seoul"))
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}
