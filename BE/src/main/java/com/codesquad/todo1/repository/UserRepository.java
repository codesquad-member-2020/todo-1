package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {

    @Query("select user from User u where u.user_id = :userId")
    Optional<User> findByUserId(String userId);

    @Query("select password from User u where u.password = :password")
    Optional<User> findByPassword(String password);

}
