/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package penjualanikan;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author MFD7
 */
public class ConnectionManager {
    
    private static Connection con;
    private static String driver = "com.mysql.jdbc.Driver";
    private static String url = "jdbc:mysql://localhost:3308/penjualan_ikan";
    private static String username = "root";
    private static String password = "";

    public static Connection logOn(){
        try{
            Class.forName( driver ).newInstance();
            con = DriverManager.getConnection(url,username,password);
        }
       catch (Exception ex){
           ex.printStackTrace();
       }
        return con;
    }
    public void logOff (){
        try{
            con.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
    
}
