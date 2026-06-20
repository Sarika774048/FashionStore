package com.fashion.store.util;

import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    private SessionUtil() {
    }

    public static void setUserSession(
            HttpSession session,
            int userId) {

        session.setAttribute("userId", userId);
    }

    public static Integer getUserId(
            HttpSession session) {

        return (Integer) session.getAttribute("userId");
    }

    public static void invalidate(
            HttpSession session) {

        session.invalidate();
    }
}