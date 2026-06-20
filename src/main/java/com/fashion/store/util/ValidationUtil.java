package com.fashion.store.util;

public class ValidationUtil {

    private ValidationUtil() {
    }

    public static boolean isEmailValid(String email) {

        return email != null &&
                email.matches(
                        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    public static boolean isPhoneValid(String phone) {

        return phone != null &&
                phone.matches("\\d{10}");
    }

    public static boolean isPincodeValid(String pincode) {

        return pincode != null &&
                pincode.matches("\\d{6}");
    }
}