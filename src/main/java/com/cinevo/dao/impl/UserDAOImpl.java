package com.cinevo.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import com.cinevo.dao.UserDAO;
import com.cinevo.entity.User;
import com.cinevo.utils.XJpa;

public class UserDAOImpl implements UserDAO {
	
	@Override
	public User findById(Long id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			return em.find(User.class, id);
		} finally {
			em.close();
		}
	}

	@Override
	public List<User> findAll() {
		String jpql = "SELECT u FROM User u";
		EntityManager em = XJpa.getEntityManager();
		List<User> list = null;
		try {
			TypedQuery<User> query = em.createQuery(jpql, User.class);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public void create(User entity) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			throw e;
		} finally {
			em.close();
		}
	}

	@Override
	public void update(User entity) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			em.merge(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		} finally {
			em.close();
		}
	}

	@Override
	public void delete(Long id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			User entity = em.find(User.class, id);
			if (entity != null) {
				em.remove(entity);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		} finally {
			em.close();
		}
	}

	@Override
	public User findByEmail(String email) {
		EntityManager em = XJpa.getEntityManager();
		User user = null;
		String jpql = "SELECT u FROM User u WHERE u.email = :email";
		try {
			TypedQuery<User> query = em.createQuery(jpql, User.class);
			query.setParameter("email", email);
			user = query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return user;
	}

	@Override
	public User findByEmailAndPassword(String email, String password) {
		EntityManager em = XJpa.getEntityManager();
		User user = null;
		String jpql = "SELECT u FROM User u WHERE u.email = :email AND u.password = :password";
		try {
			TypedQuery<User> query = em.createQuery(jpql, User.class);
			query.setParameter("email", email);
			query.setParameter("password", password);
			user = query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return user;
	}
}
