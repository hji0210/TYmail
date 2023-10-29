package com.example.demo.smartMail.enums;

public enum EmailAddress {
    NAVER("naver.com"),
    GMAIL("gmail.com"),
    DAUM1("hanmail.net"),
    DAUM2("daum.net"),
	TY("tymail.com");

    private final String value;

    EmailAddress(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static boolean containsEmailAddress(String email) {
        for (EmailAddress emailAddress : EmailAddress.values()) {
            if (emailAddress.getValue().equals(email)) {
                return true;
            }
        }
        return false;
    }
}
