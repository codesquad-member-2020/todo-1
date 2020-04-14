package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface CategoryRepository extends CrudRepository<Category, Long> {

    @Query("select * from card where id = :cardId")
    Optional<Card> findByCardId(@Param("cardId") Long cardId);

    @Query("select * from card where id = :cardId")
    Card findBycardId(@Param("cardId") Long cardId);
}
