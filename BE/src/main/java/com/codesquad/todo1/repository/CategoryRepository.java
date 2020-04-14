package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface CategoryRepository extends CrudRepository<Category, Long> {

    @Query("select * from card where id = :cardId")
    Card findByCardId(@Param("cardId") Long cardId);
}
