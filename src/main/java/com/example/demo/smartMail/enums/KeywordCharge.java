package com.example.demo.smartMail.enums;

import java.util.Arrays;

public enum KeywordCharge {
    결제, 청구, 구매, 이체, 주문;

    public static boolean containsKeywordCharge(String text) {
        return Arrays.stream(KeywordCharge.values()).anyMatch(it -> text.contains(it.name()));
    }
}

