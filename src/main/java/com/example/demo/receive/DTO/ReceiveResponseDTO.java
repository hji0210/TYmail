package com.example.demo.receive.DTO;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class ReceiveResponseDTO {

	@EqualsAndHashCode.Include
    private String no;
    private String id;
    private String sendName;
    private String sendEmail;
    private String title;
    private String content;
    private String filePath;
    private String likeChecked;
    private String readStatus;
    private String trash;
    private String createAt;

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");

    // 문자열을 'LocalDateTime' 으로 변환
    public LocalDateTime getCreateAtLocalDateTime() {
        return LocalDateTime.parse(this.createAt, FORMATTER);
    }
}
