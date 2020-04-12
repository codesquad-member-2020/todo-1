package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.Card;
import com.codesquad.todo1.domain.Category;
import com.codesquad.todo1.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface CategoryRepository extends CrudRepository<Category, Long> {

    @Query("select * from card where id = :cardId")
    Optional<Card> findByCardId(Long cardId);

    @Query("select * from user where user_id = :userId")
    Optional<User> findByUserId(String userId);
}
