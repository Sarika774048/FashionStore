package com.fashion.store.util;

import java.sql.Connection;

public class ConnectionTest {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if(con != null) {
            System.out.println("Connection Established");
        }
        else {
            System.out.println("Connection Failed");
        }
    }
}