package com.herokuapp.webgalleryshowcase.web;

import com.herokuapp.webgalleryshowcase.dao.UserDao;
import com.herokuapp.webgalleryshowcase.domain.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;

@Controller
public class RegisterController {

    private final Logger log = LoggerFactory.getLogger(RegisterController.class);

    @Autowired
    private UserDao userDao;

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(@ModelAttribute("user") @Valid User user, BindingResult bindingResult) {

        validatePasswordMatches(user, bindingResult);
        if (bindingResult.hasErrors()) return "register";

        try {
            userDao.addUser(user);
        } catch (DuplicateKeyException dke) {
            log.info("Tried to add user that already exist.");
            bindingResult.addError(new ObjectError("error", "Email already used."));
            return "register";
        }

        Authentication auth = new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword());
        SecurityContext securityContext = SecurityContextHolder.getContext();
        securityContext.setAuthentication(auth);

        return "redirect:/profile";
    }

    private BindingResult validatePasswordMatches(User user, BindingResult bindingResult) {
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            bindingResult.addError(new ObjectError("error", "Passwords doesn't match."));
        }
        return bindingResult;
    }

    @RequestMapping(value = "/register")
    public String register(Model model) {
        User user = new User();
        model.addAttribute("user", user);
        return "register";
    }
}