package com.codesquad.todo1.domain;

import lombok.Getter;
import org.springframework.data.annotation.Id;

@Getter
public class User {
    @Id
    private Long id;

    private String userId;
    private String password;
}
