
package com.tech.blog.dao;

import com.tech.blog.entities.User;
import com.tech.blog.entities.message;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
//    method to insert user into dattabase.....
    public boolean SaveUser(User user) {
        boolean f = false;
        try {
//            user database.....
           
            String query = "insert into user(name,email,password,gender) values (?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());

            pstmt.executeUpdate();
            System.out.println("database inserted");
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
//    get user by email and password
    public User getUserByEmailAndPassword(String email, String password){
    User user = null;
        try {
            String query = "select * from user where email=? and password=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                user = new User();
//                data from database
                String name = set.getString("name");
//                  set to user object
                user.setName(name);
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setId(set.getInt("id"));
                user.setGender(set.getString("gender"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
        } catch (Exception e){
         e.printStackTrace();
        }   
    return user;
    }
        
//    create user update method.......
    public boolean updateUser(User user){
        boolean f  = false;
        try {
            //creating query....
                String q = "update user set name=?, email=?,password=?,gender=?,profile=? where id=?";
                //get the preparedStatement object....
                PreparedStatement pstm = con.prepareStatement(q);

                //set the values to query....
                pstm.setString(1, user.getName());
                pstm.setString(2, user.getEmail());
                pstm.setString(3, user.getPassword());
                pstm.setString(4, user.getGender());
                pstm.setString(5, user.getProfile());
                pstm.setInt(6, user.getId());
                pstm.executeUpdate();
                
                f= true;
                
        } catch (Exception e) {
              e.printStackTrace();
        }
        return f;
    }
     public User getUserByUserId(int userId){
     User user = null;
         try {
             String q = "select * from user where id=?";
             PreparedStatement pstmt = this.con.prepareStatement(q);
             pstmt.setInt(1, userId);
             ResultSet set = pstmt.executeQuery();
             if(set.next()){
              user = new User();
//                data from database
                String name = set.getString("name");
//                  set to user object
                user.setName(name);
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setId(set.getInt("id"));
                user.setGender(set.getString("gender"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));           
             }
         } catch (Exception e) {
          e.printStackTrace();
         } 
     return user;
     }

}
