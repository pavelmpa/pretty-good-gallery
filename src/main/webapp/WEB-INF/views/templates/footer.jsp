<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<div id="footer">
    <div class="container">
        <p class="pull-right"><a href="#">Back to top</a></p>

        <p>Very important thing &copy; 2013 Big-Company, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a>
        </p>
    </div>
</div>
<security:authorize access="isAnonymous()">
    <div class="modal fade" id="sign-in" tabindex="-1" role="dialog" aria-labelledby="signInDialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Sign in</h4>
                </div>
                <form class="form-horizontal" role="form" method="post"
                      action="<spring:url value="/j_spring_security_check"/>">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Email</label>

                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="inputEmail3" name="j_username" autofocus>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword3" class="col-sm-2 control-label">Password</label>

                            <div class="col-sm-10">
                                <input type="password" class="form-control" id="inputPassword3" name="j_password">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Sign in</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</security:authorize>
