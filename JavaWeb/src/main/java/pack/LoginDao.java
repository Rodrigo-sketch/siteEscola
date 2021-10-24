package pack;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
public class LoginDao {

	public static boolean validate(LoginBean bean){
		boolean status=false;
		int perfil = 0;
		Logger lgr = Logger.getLogger(LoginDao.class.getName());
		try{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(Provider.CONNECTION_URL,Provider.USERNAME,Provider.PASSWORD);    
			Statement statement = con.createStatement(); 
			ResultSet resultSet = statement.executeQuery("select * from usuarios where Login=\""+bean.getUsername()+"\" and Senha=\""+bean.getPass()+"\"");
			if(resultSet.next()) {  
				status = true;
				perfil = resultSet.getInt("tipo");
				bean.setType(perfil);
			}			
			
			con.close(); 
			
		}catch(Exception e){			
			lgr.log(Level.SEVERE, e.getMessage(), e);
		}
		return status;
	}

}
