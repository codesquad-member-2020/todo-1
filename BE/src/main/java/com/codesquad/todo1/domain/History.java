package com.codesquad.todo1.domain;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

@Getter
@ToString
@RequiredArgsConstructor
public class History {
    @Id
    private Long id;

    private String userId;
    private String profileUrl;
    private String action;
    private String title;
    private Integer fromColumn;
    private Integer toColumn;
    private LocalDateTime actionTime;

}
