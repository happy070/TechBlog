<%-- 
    Document   : index
    Created on : Nov 13, 2022, 12:19:43 PM
    Author     : 91987
--%>

<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="MyCSS/MyStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            .Banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 100%, 75% 90%, 33% 100%, 0 90%, 0 0);
            }
        </style>
    </head>
    <body>
        <!--Navbar-->
        <%@include file="Navbar.jsp" %>

        <!--Banner-->

        <div class="container-fluid m-0 p-0">
            <div class="jumbotron Banner-background" style="background: #ff9800">
                <div class="container"> 
                    <i class="display-3">Welcome To Tech Blog </i>
                    <p>Computer programming is the process of performing a particular computation (or more generally, accomplishing a specific computing result), usually by designing and building an executable computer program. Programming involves tasks such as analysis, generating algorithms, profiling algorithms' accuracy and resource consumption, and the implementation of algorithms (usually in a chosen programming language, commonly referred to as coding).[1][2] The source code of a program is written in one or more languages that are intelligible to programmers, rather than machine code, which is directly executed by the central processing unit.</p>
                    <a class="btn btn-outline-secondary btn-lg" href="register_page.jsp"><i class="fa-solid fa-paper-plane"></i> Start ! it's Free</a> &nbsp;
                    <a class="btn btn-outline-secondary btn-lg" href="Login_page.jsp"> <i class="fa fa-user-circle fa-spin"></i> Login</a>
                </div>
            </div>
        </div>

        <!--Cards-->
        <div class="container">
            <div class="row mb-2">
                <%
                    PostDao dao = new PostDao(ConnectionProvider.getConnection());
                    List<Post> posts = dao.getAllPosts();     
                    int count = 0;
                    for(Post p : posts)
                    {
                     if(count == 3){
                     break;
                }
                %> 
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <img  onclick="showMsg()"  src="blog_pics/<%= p.getpPic()%>" class="card-img-top" alt="...">
                        </div> 
                        <div class="card-body" onclick="showMsg()">
                            <h5 class="card-title"><%=p.getpTitle()%></h5>
                            <p class="card-text"><%=p.getpContent()%></p>
                            <button  href="#" onclick="showMsg()" class="btn btn-secondary">Read More</button> 
                        </div>
                    </div>
                </div>
                <%
               count++;
                    }
                %>
            </div>
        </div>        

        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 
       <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>        
          function showMsg(){
                swal("Please Login To View posts");
            }                                  
        </script>
    </body>
</html>
