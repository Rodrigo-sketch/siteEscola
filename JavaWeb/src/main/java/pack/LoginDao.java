package pack;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
public class LoginDao {

	public static boolean validate(LoginBean bean){
		boolean status=false;
		String perfil = "";
		Logger lgr = Logger.getLogger(LoginDao.class.getName());
		try{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(Provider.CONNECTION_URL,Provider.USERNAME,Provider.PASSWORD);    
			Statement statement = con.createStatement(); 
			ResultSet resultSet = statement.executeQuery("select * from users where username=\""+bean.getUsername()+"\" and pass=\""+bean.getPass()+"\"");
			if(resultSet.next()) {  
				status = true;
				perfil = resultSet.getString("type");
			}			
			bean.setType(perfil);
			con.close(); 
			
		}catch(Exception e){			
			lgr.log(Level.SEVERE, e.getMessage(), e);
		}
		return status;
	}

}
