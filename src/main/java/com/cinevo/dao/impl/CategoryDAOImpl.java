package com.cinevo.dao.impl;

import java.util.List;

import com.cinevo.dao.CategoryDAO;
import com.cinevo.entity.Category;
import com.cinevo.utils.XJpa;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class CategoryDAOImpl implements CategoryDAO {
	
	@Override
	public Category findById(Integer id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			return em.find(Category.class, id);
		} finally {
			em.close();
		}
	}

	@Override
	public List<Category> findAll() {
		String jpql = "SELECT c FROM Category c ORDER BY c.id ASC";
		EntityManager em = XJpa.getEntityManager();
		List<Category> list = null;
		try {
			TypedQuery<Category> query = em.createQuery(jpql, Category.class);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public void create(Category entity) {
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
	public void update(Category entity) {
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
	public void delete(Integer id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			Category entity = em.find(Category.class, id);
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
	public Category findByName(String name) {
		EntityManager em = XJpa.getEntityManager();
		Category category = null;
		String jpql = "SELECT c FROM Category c WHERE c.name = :name";
		try {
			TypedQuery<Category> query = em.createQuery(jpql, Category.class);
			query.setParameter("name", name);
			List<Category> list = query.getResultList();
			if (!list.isEmpty()) {
				category = list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return category;
	}
}
