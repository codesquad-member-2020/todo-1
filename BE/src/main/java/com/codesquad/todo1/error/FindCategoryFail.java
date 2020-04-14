package com.codesquad.todo1.error;

public class FindCategoryFail extends RuntimeException {
    public FindCategoryFail() {

    }

    public FindCategoryFail(String message) {
        super(message);
    }
}
