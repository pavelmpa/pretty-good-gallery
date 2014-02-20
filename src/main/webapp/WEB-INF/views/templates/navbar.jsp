<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<spring:url value="/"/>">Pretty good gallery</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="<spring:url value="/"/>">Home</a></li>
                <li><a href="<c:url value="/explore"/>">Explore</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">My Gallery<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="<spring:url value="/albums"/>">View</a></li>
                        <li><a href="<c:url value="/albums/manage"/>">Manage</a></li>
                    </ul>
                </li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <security:authorize access="isAnonymous()">
                    <li><a href="<spring:url value="/register"/>">Sign up</a></li>
                    <li><a href="#sign-in" data-toggle="modal" data-target="#sign-in">Sign in</a></li>
                </security:authorize>
                <security:authorize access="isAuthenticated()">
                    <li><a href="<spring:url value="/profile"/>">Profile</a></li>
                    <li><a href="<spring:url value="/j_spring_security_logout"/>">Logout</a></li>
                </security:authorize>
            </ul>
        </div>
    </div>
</div>