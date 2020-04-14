package com.codesquad.todo1.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.annotation.Id;

@Getter
@ToString
public class Card {
    @Id
    private Long id;

    private String userId;
    private String title;
    private String contents;
    private String device;

    @Builder
    public Card(String userId, String title, String contents, String device) {
        this.userId = userId;
        this.title = title;
        this.contents = contents;
        this.device = device;
    }
}