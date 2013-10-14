package com.herokuapp.webgalleryshowcase.web;

import com.herokuapp.webgalleryshowcase.dao.UserDao;
import com.herokuapp.webgalleryshowcase.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.security.Principal;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    UserDao userDao;

    @RequestMapping(method = RequestMethod.GET)
    public String viewProfile(Model model, Principal principal) {

        User user = userDao.getUserByEmail(principal.getName());

        model.addAttribute("first_name", user.getFirstName());
        model.addAttribute("last_name", user.getLastName());
        model.addAttribute("email", user.getEmail());

        return "profile";
    }
}