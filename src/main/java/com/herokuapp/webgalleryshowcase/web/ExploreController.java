package com.herokuapp.webgalleryshowcase.web;

import com.herokuapp.webgalleryshowcase.dao.ImageItemDao;
import com.herokuapp.webgalleryshowcase.domain.ImageItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ExploreController {

    private Logger log = LoggerFactory.getLogger(ExploreController.class);

    @Autowired
    private ImageItemDao imageItemDao;

    @RequestMapping(value = "/explore", method = RequestMethod.GET)
    public String explore() {
        log.debug("explore");
        return "explore";
    }

    @RequestMapping(value = "/explore.json", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<ImageItem>> explore(@RequestParam int fromItem, @RequestParam int amount) {
        log.debug("explore json");
        List<ImageItem> thumbList = imageItemDao.retrieveExploreThumbnailList(fromItem, amount);
        return new ResponseEntity<>(thumbList, HttpStatus.OK);
    }
}
