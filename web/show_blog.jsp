
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.message"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("Login_page.jsp");
    }
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao dao = new PostDao(ConnectionProvider.getConnection());
    Post p = dao.getPostByPostId(postId);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%></title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="MyCSS/MyStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            .Banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 100%, 75% 90%, 33% 100%, 0 90%, 0 0);
            }
            .post-title{
                font-weight: 500;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            body{
                background : url(img/pexels-gradienta-7135033.jpg);
                background-size : cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
        <nav class="navbar  navbar-expand-lg navbar-light  bg-secondary">
            <a class="navbar-brand" href="index.jsp" > <i class="fa-sharp fa-solid fa-house"></i>Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active"> 
                        <a class="nav-link" href="profile_page.jsp"> <i class="fa-sharp fa-solid fa-code"></i> HappyCodes<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Programming Implimentation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa-sharp fa-solid fa-phone"></i> Contact Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"  href="#" data-toggle="modal" data-target="#add-post-modal"><i class="fa-solid fa-pen"></i> Do Post</a>
                    </li>
                </ul>
                <ul class="navbar-nav mr-right" >
                    <li class="nav-item">
                        <a class="nav-link rounded-circle " style="background-color : #ff9800" href="#!" data-toggle="modal" data-target="#exampleModal"><i class="fa fa-user-circle "></i><%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><i class="fa fa-user-plus"></i> Log out</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--end of navbar--> 
        <%
            message msg = (message) session.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert <%= msg.getCssClass()%>" role="alert">
            <%=msg.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>    
        <!--BODY PART-->    
        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card border border-secondary">
                        <div class="card-header bg-white">
                            <h3 class="post-title"><%= p.getpTitle()%></h3>
                        </div>
                        <div class="card-header ">
                            <img src="blog_pics/<%= p.getpPic()%>" class="card-img-top my-3" alt="...">
                        </div>
                        <div class="body ml-3">
                            <div class="row">
                                <div class="col-md-7 my-2">
                                    <%
                                        UserDao userInfo = new UserDao(ConnectionProvider.getConnection());
                                        String userName = userInfo.getUserByUserId(p.getUserId()).getName();
                                    %>   
                                    <h5 class="post-user-info">Posted By : <a href="#"><%=userName%></a></h5>
                                </div>
                                <div class="col-md-5 my-2">
                                    <h5 class="post-date"><%=p.getpDate().toLocaleString()%></h5>
                                </div>
                            </div>
                            <p class="post-content"><%=p.getpContent()%></p>
                            <br>
                            <div class="post-code">
                                <pre><%= p.getpCode()%></pre>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-outline-primary btn-sm"  ><i class="fa-regular fa-thumbs-up"></i><span>10</span></a>&nbsp; 
                            <a href="#" class="btn btn-outline-primary btn-sm"  ><i class="fa-regular fa-comment"></i><span>10 </span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--END OF BODY PART-->

        <!--start of modal-->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background: #ff9800">
                        <h5 class="modal-title" id="exampleModalLabel"><i>Tech Blog</i></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!--PROFILE DETAILS--> 
                    <div class="modal-body text-center" id="profile_details">
                        <img src = "pics/<%= user.getProfile()%>"  class="img-fluid" style="height:100px; border-radius: 50%; max-width: 150px; " />
                        <h4 class="text-center mt-3"><i><%= user.getName().toUpperCase()%></i></h4>
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th scope="row"> ID : </th>
                                    <td><%= user.getId()%></td>
                                </tr>
                                <tr>
                                    <th scope="row"> Email : </th>
                                    <td><%= user.getEmail()%></td>
                                </tr>
                                <tr>
                                    <th scope="row"> Gender : </th>
                                    <td><%= user.getGender()%></td>
                                </tr>
                                <tr>
                                    <th scope="row"> Registered on : </th>
                                    <td><%= user.getDateTime()%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--PROFILE EDIT--> 
                    <div id="profile_edit" class=" container text-center" style="display : none;">
                        <h3 class="mt-3">Please Enter Carefully</h3>
                        <form action="EditProfileServlet" method="post" enctype="multipart/form-data">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th scope="row">ID : </th>
                                        <td><%=user.getId()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Name : </th>
                                        <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email : </th>
                                        <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Password: </th>
                                        <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Gender : </th>
                                        <td><%=user.getGender().toUpperCase()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Profile Picture :</th>
                                        <td>
                                            <input type="file" name="image" class="form-control">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="container mb-5">
                                <button id="save" type="submit" class="btn btn-outline-primary">Save</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer bg-secondary">
                        <button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
                        <button id="editButton"  type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>

        <!--end of modal-->

        <!--add post modal-->
        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Provide the post details...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="addPostServlet" method="post" id="add-post-form" enctype="multipart/form-data" >
                            <div class="form-group">
                                <select class="form-control" name="catId">
                                    <option selected disabled >-----Select Your Category-----</option>
                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategorys();
                                        for (Category c : list) {
                                    %>   
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>

                                </select>
                            </div>
                            <div class="form-group">
                                <input type="text" placeholder="Enter Post Title"  name="pTitle" class="form-control">
                            </div>
                            <div class="form-group">
                                <textarea placeholder="Enter Your Content" name="pContent" class="form-control"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea placeholder="Enter Your Program(if any)" name="pCode" class="form-control"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Select Your Picture</label>
                                <br>
                                <input type="file" name="pPic">
                            </div>
                            <div class=" container text-center">
                                <button type="submit" id="post" class="btn btn-outline-primary" >Post</button>
                            </div>    
                        </form>
                    </div>
                    <div class="modal-footer"> 
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end of post modal-->

    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>     
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        $(document).ready(function () {
            let editStatus = false;
            $("#editButton").click(function () {
                if (editStatus === false) {
                    $("#profile_details").hide();
                    $("#profile_edit").show();
                    $(this).text("back");
                    editStatus = true;
                } else {
                    $("#profile_details").show();
                    $("#profile_edit").hide();
                    $(this).text("Edit");
                    editStatus = false;
                }
            });
        });
    </script>

    <!--        javascript implimentation for post form-->
    <script>
        $(document).ready(function (e) {

            $("#add-post-form").on("submit", function (event) {
                event.preventDefault();
                let form = new FormData(this);
                $.ajax({
                    url: "addPostServlet",
                    type: "POST",
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        if (data.trim() === "done") {
                            swal({
                                title: "Successfully posted!!!",
                                text: "Keep Posting..",
                                icon: "success",
                                button: "OK",
                            });
                        } else {
                            swal({
                                title: "Something Went Wrong",
                                text: "Please Try Again Later",
                                icon: "error",
                                button: "OK",
                            });
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("error");
                        swal({
                            title: "Something Went Wrong",
                            text: "Please Try Again Later",
                            icon: "error",
                            button: "OK",
                        });
                    },
                    processData: false,
                    contentType: false
                });
            });
        });
    </script>
    <!--loading page from ajax-->
    <script>
        function getPosts(catId, temp) {
            $("#Loader").show();
            $("#post-container").hide();
            $(".c-link").removeClass("active");
            $.ajax({
                url: "load_page.jsp",
                data: {cid: catId},
                success: function (data, textStatus, jqXHR) {
                    $("#Loader").hide();
                    $("#post-container").show();
                    $("#post-container").html(data);
                    $(temp).addClass("active");
                }
            });
        }
        $(document).ready(function (e) {
            let allPostRef = $(".c-link")[0]
            getPosts(0, allPostRef);
        });
    </script>

</body>
</html>
