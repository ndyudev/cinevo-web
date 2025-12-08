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

	@Override
	public List<Video> findRelatedVideos(Long videoId, Integer categoryId, int limit) {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category WHERE v.id != :videoId AND v.category.id = :categoryId ORDER BY v.views DESC";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = null;
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setParameter("videoId", videoId);
			query.setParameter("categoryId", categoryId);
			query.setMaxResults(limit);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findByFilters(Integer categoryId, Integer year, String search, int page, int pageSize) {
		StringBuilder jpql = new StringBuilder("SELECT v FROM Video v LEFT JOIN FETCH v.category WHERE 1=1");
		
		if (categoryId != null && categoryId > 0) {
			jpql.append(" AND v.category.id = :categoryId");
		}
		
		if (year != null && year > 0) {
			jpql.append(" AND v.releaseYear = :year");
		}
		
		if (search != null && !search.trim().isEmpty()) {
			jpql.append(" AND (LOWER(v.title) LIKE :search OR LOWER(v.director) LIKE :search)");
		}
		
		jpql.append(" ORDER BY v.uploadedDate DESC");
		
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = new ArrayList<>();
		try {
			TypedQuery<Video> query = em.createQuery(jpql.toString(), Video.class);
			
			if (categoryId != null && categoryId > 0) {
				query.setParameter("categoryId", categoryId);
			}
			
			if (year != null && year > 0) {
				query.setParameter("year", year);
			}
			
			if (search != null && !search.trim().isEmpty()) {
				query.setParameter("search", "%" + search.toLowerCase().trim() + "%");
			}
			
			query.setFirstResult((page - 1) * pageSize);
			query.setMaxResults(pageSize);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public long countByFilters(Integer categoryId, Integer year, String search) {
		StringBuilder jpql = new StringBuilder("SELECT COUNT(v) FROM Video v WHERE 1=1");
		
		if (categoryId != null && categoryId > 0) {
			jpql.append(" AND v.category.id = :categoryId");
		}
		
		if (year != null && year > 0) {
			jpql.append(" AND v.releaseYear = :year");
		}
		
		if (search != null && !search.trim().isEmpty()) {
			jpql.append(" AND (LOWER(v.title) LIKE :search OR LOWER(v.director) LIKE :search)");
		}
		
		EntityManager em = XJpa.getEntityManager();
		long count = 0;
		try {
			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			
			if (categoryId != null && categoryId > 0) {
				query.setParameter("categoryId", categoryId);
			}
			
			if (year != null && year > 0) {
				query.setParameter("year", year);
			}
			
			if (search != null && !search.trim().isEmpty()) {
				query.setParameter("search", "%" + search.toLowerCase().trim() + "%");
			}
			
			count = query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return count;
	}

	@Override
	public List<Video> findTop4ByViewsToday() {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category WHERE CAST(v.uploadedDate AS date) = CURRENT_DATE ORDER BY v.views DESC";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = new ArrayList<>();
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setMaxResults(4);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findTop4ByViewsThisWeek() {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category WHERE v.uploadedDate >= CURRENT_DATE - 7 ORDER BY v.views DESC";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = new ArrayList<>();
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setMaxResults(4);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findTop4ByViewsThisMonth() {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category WHERE v.uploadedDate >= CURRENT_DATE - 30 ORDER BY v.views DESC";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = new ArrayList<>();
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setMaxResults(4);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Video> findTop4ByViewsAllTime() {
		String jpql = "SELECT v FROM Video v LEFT JOIN FETCH v.category ORDER BY v.views DESC";
		EntityManager em = XJpa.getEntityManager();
		List<Video> list = new ArrayList<>();
		try {
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setMaxResults(4);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}
}
