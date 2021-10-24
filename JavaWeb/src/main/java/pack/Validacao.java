package pack;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validacao {

	public String validacamposADDUser(String RA,String Nome,String Email, String Senha,String Tipo) {
		String retorno = "";
		RA = RA.toUpperCase();
		if (RA.length()!=7) {
			retorno += "Valor informado: "+ RA+" - O RA precisa conter 7 Caracteres. ex: F1234567! <br>";
		}

		if (!RA.substring(0,1).matches("[A-Z]")) {
			retorno += "Valor informado: "+RA+": O RA precisa Iniciar com uma Letra. ex: F1234567! <br>";
		}
		
		if (!Nome.matches("[^\\d]+")) {
			retorno += "Valor informado: "+Nome+": O Nome não deve possuir números! <br>";
		}
		
		Pattern p = Pattern.compile(".+@.+\\.[a-z]+");
		Matcher m = p.matcher(Email);
		boolean matchFound = m.matches();
		if (!matchFound) {
			retorno += "Valor informado: "+Email+": Formato de e-mail inválido.! <br>";
		}
		
		if (Senha.length()<8) {
			retorno += "Valor informado: : A Senha precisa conter 8 Caracteres ou mais! <br>";
		}
		
		return retorno;
		
	}
}
