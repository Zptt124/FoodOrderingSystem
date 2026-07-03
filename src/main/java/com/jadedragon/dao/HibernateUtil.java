package com.jadedragon.dao;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Hibernate Utility Class (Chapter 10).
 * Manages the SessionFactory lifecycle — the factory is heavyweight
 * and should be created ONCE per application.
 *
 * Hibernate flow:
 *   Configuration → SessionFactory → Session → Transaction → commit → close
 *
 * This provides an ALTERNATIVE data access layer alongside the JDBC DAOs,
 * demonstrating the ORM (Object-Relational Mapping) approach.
 * JDBC vs Hibernate comparison taught in Chapter 10.
 */
public class HibernateUtil {

    private static final SessionFactory sessionFactory;

    static {
        try {
            // Load and configure Hibernate from hibernate.cfg.xml
            Configuration cfg = new Configuration();
            cfg.configure("hibernate.cfg.xml");
            sessionFactory = cfg.buildSessionFactory();
            System.out.println("[HibernateUtil] SessionFactory created successfully.");
        } catch (Exception e) {
            System.err.println("[HibernateUtil] Failed to create SessionFactory: " + e.getMessage());
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }
    }

    /**
     * Returns the singleton SessionFactory instance.
     * SessionFactory is thread-safe and shared across the application.
     */
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    /**
     * Clean shutdown — close SessionFactory when the application shuts down.
     */
    public static void shutdown() {
        if (sessionFactory != null && !sessionFactory.isClosed()) {
            sessionFactory.close();
            System.out.println("[HibernateUtil] SessionFactory closed.");
        }
    }
}
