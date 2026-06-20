package com.fashion.store.constants;

public final class DBConstants {

    private DBConstants() {
    }

    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static final String URL = getEnvOrDefault("DB_URL", "jdbc:mysql://localhost:3306/fashion_store_db");

    public static final String USERNAME = getEnvOrDefault("DB_USERNAME", "root");

    public static final String PASSWORD = getEnvOrDefault("DB_PASSWORD", "Sarika9#");

    private static String getEnvOrDefault(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.trim().isEmpty()) ? value : defaultValue;
    }
}