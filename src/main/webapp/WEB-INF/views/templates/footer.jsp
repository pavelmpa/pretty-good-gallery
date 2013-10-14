<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="footer">
    <div class="container" style="border-top: 1px solid #c7c7c7">
        <p class="muted credit">
            Here will be something soon. Visit
            <a href="<spring:url value="/" />">Home</a>
            and
            <a href="<spring:url value="/profile" />">profile</a>
            . Or
            <a href="<spring:url value="/register" />">sign up</a>
            now.
        </p>
    </div>
</div>