<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="masthead">
    <security:authorize access="isAuthenticated()">
        <a href="<spring:url value="/j_spring_security_logout" />" class="btn pull-right">Logout</a>
        <a href="<spring:url value="/profile" />" title="Profile" class="btn-link pull-right"
           style="padding-right: 5px">
            <security:authentication property="principal.username"/>
        </a>
    </security:authorize>
    <security:authorize access="isAnonymous()">
        <form id="sing-in" class="form-inline  pull-right" action="<spring:url value="/j_spring_security_check" />"
              method="post">
            <input class="span2" type="text" placeholder="Email" name="j_username"/>
            <input class="span2" type="password" placeholder="Password" name="j_password"/>
            <button type="submit" class="btn">Sign in</button>
        </form>
    </security:authorize>
    <h3 class="muted">Pretty good gallery</h3>

    <div class="navbar">
        <div class="navbar-inner">
            <div class="container">
                <ul class="nav">
                    <li>
                        <a href="<spring:url value="/"/>">Home</a>
                    </li>
                    <li>
                        <a href="<spring:url value="/albums" />">My gallery</a>
                    </li>
                    <li>
                        <a href="<spring:url value="/profile" />">Profile</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>