package com.herokuapp.webgalleryshowcase.web.gallery;

import com.herokuapp.webgalleryshowcase.dao.AlbumDao;
import com.herokuapp.webgalleryshowcase.domain.Album;
import com.herokuapp.webgalleryshowcase.service.validators.AlbumValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.List;

@Controller
public class AlbumController {

    private final Logger log = LoggerFactory.getLogger(AlbumController.class);

    @Autowired
    private AlbumDao albumDao;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(new AlbumValidator());
    }

    @RequestMapping(value = "/albums/create", method = RequestMethod.GET)
    public String viewCreateAlbumPage(Model model) {
        model.addAttribute("album", new Album());
        return "createAlbum";
    }

    @RequestMapping(value = "/albums/{id}/edit")
    public String viewEditAlbumPage(@PathVariable int id) {
        log.debug("Coll method album edit not implemented.");
        return "notAvailable";
    }

    @RequestMapping(value = "/albums/{id}/remove")
    public String viewDeleteAlbumPage(@PathVariable int id) {
        log.debug("Coll method remove album not implemented.");
        return "notAvailable";
    }

    @RequestMapping(value = "/albums", method = RequestMethod.GET, produces = "application/json")
    public
    @ResponseBody
    List<Album> listAlbums(Principal principal) {
        log.debug("List albums in JSON");
        String userEmail = principal.getName();
        return albumDao.retrieveUserAlbums(userEmail);
    }

    @RequestMapping(value = "/albums", method = RequestMethod.GET)
    public String showUserAlbums(Model model, Principal principal) {
        List<Album> albums = albumDao.retrieveUserAlbums(principal.getName());
        model.addAttribute("albums", albums);
        return "showAlbumList";
    }

    @RequestMapping(value = "/albums/{id}")
    private String displayAlbum(@PathVariable int id, Model model) {
        model.addAttribute(albumDao.retrieveAlbum(id));
        return "showAlbum";
    }

    @RequestMapping(value = "/albums/{id}", method = RequestMethod.GET, produces = "application/json")
    public
    @ResponseBody
    Album getAlbum(@PathVariable int id) {
        return albumDao.retrieveAlbum(id);
    }

    @RequestMapping(value = "/albums/{id}", method = RequestMethod.DELETE)
    public void deleteAlbum(@PathVariable int id) {
        //TODO: Implement delete album;
    }

    @RequestMapping(value = "/albums", method = RequestMethod.POST)
    public String createAlbum(@ModelAttribute("album") @Valid Album album,
                              BindingResult bindingResult,
                              Principal principal) {
        if (bindingResult.hasErrors()) {
            return "createAlbum";
        }
        album.setUserOwner(principal.getName());
        albumDao.createAlbum(album);
        return "redirect:/albums";
    }
}
