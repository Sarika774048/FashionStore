package com.fashion.store.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.fashion.store.constants.DBConstants;

public class DBConnection {

    private static Connection connection;

    private DBConnection() {
    }

    public static Connection getConnection() {

        try {

            if (connection == null || connection.isClosed()) {

                Class.forName(DBConstants.DRIVER);

                connection = DriverManager.getConnection(
                        DBConstants.URL,
                        DBConstants.USERNAME,
                        DBConstants.PASSWORD);

                System.out.println("Database Connected Successfully");
            }

        } catch (ClassNotFoundException e) {

            System.out.println("MySQL Driver Not Found");
            e.printStackTrace();

        } catch (SQLException e) {

            System.out.println("Database Connection Failed");
            e.printStackTrace();
        }

        return connection;
    }
}