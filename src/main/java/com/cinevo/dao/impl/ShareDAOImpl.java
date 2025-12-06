package com.cinevo.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import com.cinevo.dao.ShareDAO;
import com.cinevo.entity.Share;
import com.cinevo.utils.XJpa;

public class ShareDAOImpl implements ShareDAO {
	
	@Override
	public Share findById(Long id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			return em.find(Share.class, id);
		} finally {
			em.close();
		}
	}

	@Override
	public List<Share> findAll() {
		String jpql = "SELECT s FROM Share s";
		EntityManager em = XJpa.getEntityManager();
		List<Share> list = null;
		try {
			TypedQuery<Share> query = em.createQuery(jpql, Share.class);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public void create(Share entity) {
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
	public void update(Share entity) {
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
			Share entity = em.find(Share.class, id);
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
	public List<Share> findByUserId(Long userId) {
		String jpql = "SELECT s FROM Share s WHERE s.user.id = :userId";
		EntityManager em = XJpa.getEntityManager();
		List<Share> list = null;
		try {
			TypedQuery<Share> query = em.createQuery(jpql, Share.class);
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
	public List<Share> findByVideoId(Long videoId) {
		String jpql = "SELECT s FROM Share s WHERE s.video.id = :videoId";
		EntityManager em = XJpa.getEntityManager();
		List<Share> list = null;
		try {
			TypedQuery<Share> query = em.createQuery(jpql, Share.class);
			query.setParameter("videoId", videoId);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Share> findBySharedToEmail(String email) {
		String jpql = "SELECT s FROM Share s WHERE s.sharedToEmail = :email";
		EntityManager em = XJpa.getEntityManager();
		List<Share> list = null;
		try {
			TypedQuery<Share> query = em.createQuery(jpql, Share.class);
			query.setParameter("email", email);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}
}
