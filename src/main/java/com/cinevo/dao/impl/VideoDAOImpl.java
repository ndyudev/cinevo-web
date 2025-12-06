package com.cinevo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.cinevo.dao.VideoDAO;
import com.cinevo.entity.Video;
import com.cinevo.utils.XJpa;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class VideoDAOImpl implements VideoDAO {
	
	@Override
	public Video findById(Long id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			return em.find(Video.class, id);
		} finally {
			em.close();
		}
	}

	@Override
	public List<Video> findAll() {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = new ArrayList<>();
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			list = new ArrayList<>();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public void create(Video entity) {
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
	public void update(Video entity) {
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
			Video entity = em.find(Video.class, id);
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
	public List<Video> findByTitle(String title) {
		String jpql = "SELECT v FROM Video v WHERE v.title LIKE :title";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = null;
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setParameter("title", "%" + title + "%");
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findByCategoryId(Integer categoryId) {
		String jpql = "SELECT v FROM Video v WHERE v.category.id = :categoryId";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = null;
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setParameter("categoryId", categoryId);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findTop10ByViews() {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category ORDER BY v.views DESC";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = null;
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setMaxResults(10);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findFavoriteVideosByUserId(Long userId) {
		String jpql = "SELECT f.video FROM Favorite f WHERE f.user.id = :userId";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = null;
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setParameter("userId", userId);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findLatest3Videos() {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category ORDER BY v.uploadedDate DESC";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = null;
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setMaxResults(3);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}
}
