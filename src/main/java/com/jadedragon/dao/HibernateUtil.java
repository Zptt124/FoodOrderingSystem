package com.jadedragon.dao;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import java.io.InputStream;
import java.util.Properties;

// Hibernate SessionFactory — created once, shared across DAOs
public class HibernateUtil {

    private static final SessionFactory sessionFactory;

    static {
        try {
            Properties dbProps = new Properties();
            InputStream input = HibernateUtil.class.getClassLoader()
                    .getResourceAsStream("database.properties");
            if (input == null) {
                throw new RuntimeException(
                    "database.properties not found. Copy database.properties.example " +
                    "to database.properties and fill in your credentials.");
            }
            dbProps.load(input);

            Configuration cfg = new Configuration();
            cfg.configure("hibernate.cfg.xml");

            cfg.setProperty("hibernate.connection.url", dbProps.getProperty("db.url"));
            cfg.setProperty("hibernate.connection.username", dbProps.getProperty("db.username"));
            cfg.setProperty("hibernate.connection.password", dbProps.getProperty("db.password"));

            sessionFactory = cfg.buildSessionFactory();
            System.out.println("[Hibernate] SessionFactory ready.");
        } catch (Exception e) {
            System.err.println("[Hibernate] Error: " + e.getMessage());
            throw new ExceptionInInitializerError(e);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null && !sessionFactory.isClosed()) {
            sessionFactory.close();
            System.out.println("[Hibernate] SessionFactory closed.");
        }
    }
}
