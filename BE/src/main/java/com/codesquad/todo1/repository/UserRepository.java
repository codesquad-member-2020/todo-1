package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {

    @Query("select * from user where user_id = :userId")
    Optional<User> findByUserId(@Param("userId") String userId);
}
