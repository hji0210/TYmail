package com.example.demo.spam.enums;

import java.util.Arrays;

public enum KeywordSpam {
    SF, SP, SS, SO, SW;

    public static boolean containsKeywordSpam(String text) {
        return Arrays.stream(KeywordSpam.values()).anyMatch(it -> text.contains(it.name()));
    }
}

