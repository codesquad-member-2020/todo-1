package com.codesquad.todo1.domain;

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
    private Integer order;

    public Card(String userId, String title, String contents, String device, Integer order) {
        this.userId = userId;
        this.title = title;
        this.contents = contents;
        this.device = device;
        this.order = order;
    }
}
