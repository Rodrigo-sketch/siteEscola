package pack;

import java.sql.*;

public class ConnectionProvider {
	static Connection con=null;
	static{
		try{
			Class.forName(Provider.DRIVER);
			con=DriverManager.getConnection(Provider.CONNECTION_URL,Provider.USERNAME,Provider.PASSWORD);
			}catch(Exception e){
				System.out.println(e.getMessage() + " - " + e.getCause());
			}
	}
	public static Connection getCon(){
		return con;
	}
}
