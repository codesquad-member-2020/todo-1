package com.codesquad.todo1.domain;

import lombok.Getter;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
public class Project {

    @Id
    private Long id;
    private List<Category> categories = new ArrayList<>();

}
