package sesoc.global.smartplanner.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class MVCException {
	
	@ExceptionHandler(Exception.class)
	public String errorHandler() {
		return "redirect:/";
	}
}
