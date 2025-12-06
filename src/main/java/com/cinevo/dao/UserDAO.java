package com.cinevo.dao;

import com.cinevo.entity.User;

public interface UserDAO extends BaseDAO<User, Long> {
    
    User findByEmail(String email);
    
    User findByEmailAndPassword(String email, String password);
}
