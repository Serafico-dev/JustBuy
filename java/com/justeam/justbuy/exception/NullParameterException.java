package com.justeam.justbuy.exception;

public class NullParameterException extends RuntimeException {
	
	public NullParameterException () {
	}

	public NullParameterException (String message) {
		super(message);
	}

	public NullParameterException (String message, Throwable cause) {
		super(message, cause);
	}

}