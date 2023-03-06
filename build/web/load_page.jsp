

<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
    <%
        Thread.sleep(2000); 
        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if(cid==0){
           posts = dao.getAllPosts();
        }else{
           posts = dao.getPostByCatId(cid);
       } 
       if(posts.size()==0){
          out.println("<h3 class= 'display-3 text-center ' >No Post In This Category..</h3>");
          return;
        }
        for (Post p : posts) {
    %>   
    <div class="col-md-6 mt-2">
        <div class="card">
            <img src="blog_pics/<%= p.getpPic()%>" class="card-img-top" alt="...">
            <div class="card-body">
                <b><%= p.getpTitle()%></b>
                <p><%=p.getpContent()%></p>
                <pre><%= p.getpCode()%></pre>
            </div>
            <div class=" card-footer" >
                <a href="#" class="btn btn-outline-primary btn-sm"  ><i class="fa-regular fa-thumbs-up"></i><span>10</span></a>&nbsp; 
                <a href="#" class="btn btn-outline-primary btn-sm"  ><i class="fa-regular fa-comment"></i><span>10 </span></a>
                   &nbsp; &nbsp; &nbsp; &nbsp; <a href="show_blog.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-primary btn-sm"  >Read more.....</a>
            </div>
        </div>
    </div> 
    <%
        }
    %>
</div>