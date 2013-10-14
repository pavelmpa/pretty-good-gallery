package com.herokuapp.webgalleryshowcase.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class HomeController {

    Logger log = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping(method = RequestMethod.GET)
    public String homePage() {
        return "home";
    }
}