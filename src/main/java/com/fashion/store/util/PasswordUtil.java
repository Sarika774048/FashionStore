package com.fashion.store.util;

public class PasswordUtil {

    private PasswordUtil() {
    }

    public static String encryptPassword(String password) {

        return Integer.toHexString(password.hashCode());
    }

    public static boolean matchPassword(
            String rawPassword,
            String encryptedPassword) {

        return encryptPassword(rawPassword)
                .equals(encryptedPassword);
    }
}