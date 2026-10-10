package com.smartbuilding.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
            String port = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
            String dbName = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "smart_building_new";
            String user = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
            String password = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "fycs";

            String url = System.getenv("DB_URL");
            if (url == null || url.trim().isEmpty()) {
                url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            }

            Connection con = DriverManager.getConnection(url, user, password);
            System.out.println("MySQL Connected Successfully! [" + url.split("\\?")[0] + "]");
            return con;

        } catch (Exception e) {
            System.out.println("MySQL Connection Failed: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}