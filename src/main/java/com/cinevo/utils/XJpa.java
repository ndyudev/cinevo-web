package com.cinevo.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJpa {

	private static EntityManagerFactory factory;

	static {
		try {
			factory = Persistence.createEntityManagerFactory("Cinevo_web");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public static EntityManager getEntityManager() {
		return factory.createEntityManager();
	}	public static void close() {
		if (factory != null && factory.isOpen()) {
			factory.close();
		}
	}
}
