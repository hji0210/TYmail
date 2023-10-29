package com.example.demo.smartMail.enums;

public enum SnsEmailAddress {
    INSTAGRAM("no-reply@mail.instagram.com"),
    YOUTUBE("noreply@youtube.com");

    private final String value;

    SnsEmailAddress(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static boolean containsSnsEmailAddress(String email) {
        for (SnsEmailAddress snsEmailAddress : SnsEmailAddress.values()) {
            if (snsEmailAddress.getValue().equals(email)) {
                return true;
            }
        }
        return false;
    }
}
