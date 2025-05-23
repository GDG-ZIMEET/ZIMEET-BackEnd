package com.gdg.z_meet.global.exception;

import com.gdg.z_meet.global.response.Code;
import com.gdg.z_meet.global.response.ReasonDTO;
import lombok.Getter;

@Getter
public class BusinessException extends RuntimeException{

    private final Code code;

    public BusinessException(Code code) {
        super(code.getMessage());
        this.code = code;
    }

    public ReasonDTO getReason() {
        return this.code.getReason();
    }
}