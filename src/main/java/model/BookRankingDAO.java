package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookRankingDAO {
    public ArrayList<BookRanking> getBestSellingBooks() throws SQLException, ClassNotFoundException {
        ArrayList<BookRanking> bestSellingBooks = new ArrayList<>();
        Connection conn = DBConnection.getConnection();

        String sql = "SELECT books.title, SUM(order_items.quantityOrdered) AS copiesSold " +
                     "FROM books " +
                     "INNER JOIN order_items ON books.book_id = order_items.book_id " +
                     "GROUP BY books.book_id " +
                     "ORDER BY copiesSold DESC " +
                     "LIMIT 5;";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String title = rs.getString("title");
            int copiesSold = rs.getInt("copiesSold");
            BookRanking bookRanking = new BookRanking(title, copiesSold);
            bestSellingBooks.add(bookRanking);
        }

        rs.close();
        pstmt.close();
        conn.close();

        return bestSellingBooks;
    }

    public ArrayList<BookRanking> getLeastSellingBooks() throws SQLException, ClassNotFoundException {
        ArrayList<BookRanking> leastSellingBooks = new ArrayList<>();
        Connection conn = DBConnection.getConnection();

        String sql = "SELECT books.title, IFNULL(SUM(order_items.quantityOrdered), 0) AS copiesSold " +
                     "FROM books " +
                     "LEFT JOIN order_items ON books.book_id = order_items.book_id " +
                     "GROUP BY books.book_id " +
                     "ORDER BY copiesSold ASC " +
                     "LIMIT 5;";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String title = rs.getString("title");
            int copiesSold = rs.getInt("copiesSold");
            BookRanking bookRanking = new BookRanking(title, copiesSold);
            leastSellingBooks.add(bookRanking);
        }

        rs.close();
        pstmt.close();
        conn.close();

        return leastSellingBooks;
    }
    
    public ArrayList<BookRanking> getLowStockBooks() throws SQLException, ClassNotFoundException {
        ArrayList<BookRanking> lowStockBooks = new ArrayList<>();
        Connection conn = DBConnection.getConnection();

        String sql = "SELECT title, quantity FROM books WHERE quantity <= 3 ORDER BY quantity ASC";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String title = rs.getString("title");
            int quantity = rs.getInt("quantity");
            BookRanking bookRanking = new BookRanking(title, 0, quantity); // Use the constructor with three parameters
            lowStockBooks.add(bookRanking);
        }

        rs.close();
        pstmt.close();
        conn.close();

        return lowStockBooks;
    }


    public ArrayList<BookRanking> searchBooksByTitle(String title) throws SQLException, ClassNotFoundException {
        ArrayList<BookRanking> searchResults = new ArrayList<>();
        Connection conn = DBConnection.getConnection();

        String sql = "SELECT books.title, SUM(order_items.quantityOrdered) AS copiesSold, books.quantity " +
                     "FROM books " +
                     "LEFT JOIN order_items ON books.book_id = order_items.book_id " +
                     "WHERE books.title LIKE ? " +
                     "GROUP BY books.book_id;";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + title + "%");
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String bookTitle = rs.getString("title");
            int copiesSold = rs.getInt("copiesSold");
            int quantity = rs.getInt("quantity");
            BookRanking bookRanking = new BookRanking(bookTitle, copiesSold, quantity);
            searchResults.add(bookRanking);
        }

        rs.close();
        pstmt.close();
        conn.close();

        return searchResults;
    }

}
