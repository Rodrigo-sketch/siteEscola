package pack;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validacao {

	public String validacamposADDUser(String RA,String Nome,String Email, String Senha,String Tipo) throws SQLException {
		String retorno = "";
		RA = RA.toUpperCase();
		
		Connection con=DriverManager.getConnection(Provider.CONNECTION_URL,Provider.USERNAME,Provider.PASSWORD);    
		Statement statement = con.createStatement();
		ResultSet resultSet = statement.executeQuery("Select * from exemplo.alunos as al inner join exemplo.usuarios as usr on usr.Login = al.RA where RA=\""+RA+"\" ");
		
		if(resultSet.next()) { 
			retorno += "Campo RA ; Valor informado: "+ RA+" - O RA Já Existe, favor informar outro! <br>";	
		}
		
		
		if (RA.length()!=7) {
			retorno += "Campo RA ; Valor informado: "+ RA+" - O RA precisa conter 7 Caracteres. ex: F1234567! <br>";
		}

		if (!RA.substring(0,1).matches("[A-Z]")) {
			retorno += "Campo RA ; Valor informado: "+RA+": O RA precisa Iniciar com uma Letra. ex: F1234567! <br>";
		}
		
		if (!Nome.matches("[^\\d]+")) {
			retorno += "Campo Nome ; Valor informado: "+Nome+": O Nome não deve possuir números! <br>";
		}
		
		Pattern p = Pattern.compile(".+@.+\\.[a-z]+");
		Matcher m = p.matcher(Email);
		boolean matchFound = m.matches();
		if (!matchFound) {
			retorno += "Campo e-mail ; Valor informado: "+Email+": Formato de e-mail inválido.! <br>";
		}
		
		if (Senha.length()<8) {
			retorno += "Campo Senha ; quantidade de caracteres "+Senha.length()+" Senha precisa conter 8 Caracteres ou mais! <br>";
		}
		
		return retorno;
		
	}
}
