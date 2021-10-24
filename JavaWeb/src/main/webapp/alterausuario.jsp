<%@page import="pack.LoginDao,java.sql.*, pack.AlunoBean, pack.Provider, pack.*"%>
<jsp:useBean id="obj" class="pack.LoginBean"/>
<jsp:setProperty property="*" name="obj"/>
<%
String action = request.getParameter("action"); 
%>
	<!DOCTYPE html>
	<html lang="pt-BR">
	<head>
	<title>Lista de alunoss</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	</head>
<body>
<form class="login-form" action="alterausuario.jsp" method="post"> 
<%
Connection con=DriverManager.getConnection(Provider.CONNECTION_URL,Provider.USERNAME,Provider.PASSWORD);    
Statement statement = con.createStatement();
String login_username = (String)session.getAttribute("login_username");
String login_pass = (String)session.getAttribute("login_pass");
int login_type = (int)session.getAttribute("login_type");
Validacao valid = new Validacao();

if ("alterar".equals(action)) {
	int tipo = Integer.parseInt(request.getParameter("tipo"));
	String valorTipo = "";
	if (tipo==1) valorTipo = "Administrador"; else valorTipo = "Usuario Comum";
	%> <h1> <% out.println(action); %> dados do usuário: </h1>
    <input type="text" hidden="hidden" name="ID_AL" value="<%= request.getParameter("ID_AL")%>" /><br />
    <input type="text" hidden="hidden" name="ID_USR" value="<%= request.getParameter("ID_USR")%>" /><br />
    RA: <input type="text" name="RA" value="<%= request.getParameter("RA")%>" /><br />
    Nome: <input type="text" name="nome" value="<%= request.getParameter("Nome")%>" /><br />
    E-mail: <input type="text" name="email" value="<%= request.getParameter("email")%>" /><br />
    Senha: <input type="password" name="pass" value="<%= request.getParameter("pass")%>" /><br />
    <% if (login_type==1){ %>
    <label for="tipo">Tipo de Conta:</label>
		<select name="tipo" id="tipo">
		  <option <% if (tipo==1){%> selected="selected"<%} %>value="1">Administrador</option>
		  <option <% if (tipo==2){%> selected="selected"<%} %>value="2">Usuário Comum</option>
		</select>
	<% } else { %>
	Tipo de Conta: <input type="hidden" name="tipo" value="<%= request.getParameter("tipo")%>" /><% out.println(valorTipo); %><br />
	<% } %>
    <br/>
    <br/>
    <input type="submit" name="action" value="Alterar Usuario"/>
    <%
} else if ("excluir".equals(action)) {
	%><h1>confirma a ação de <% out.println(action);%> usuário ? </h1>	
	<input type="text" hidden="hidden" name="ID_AL" value="<%= request.getParameter("ID_AL")%>" /><br />
	<input type="text" hidden="hidden" name="ID_USR" value="<%= request.getParameter("ID_USR")%>" /><br />
    RA: <input type="hidden" name="RA" value="<%= request.getParameter("RA")%>" /><%= request.getParameter("RA")%> <br />
    Nome: <input type="hidden" name="nome" value="<%= request.getParameter("Nome")%>" /><%= request.getParameter("Nome")%> <br />
    E-mail: <input type="hidden" name="email" value="<%= request.getParameter("email")%>" /><%= request.getParameter("email")%><br />
    Tipo de Conta: <input type="hidden" name="tipo" value="<%= request.getParameter("tipo")%>" /><%= request.getParameter("tipo")%><br />
    <br/>
    <br/>
    <input type="submit" name="action" value="Excluir Usuario"/>
    <%
} else if ("adicionar novo usuario".equals(action)) {
	%><h1><%out.println(action);%> dados do usuário: </h1>
	RA: <input type="text" name="RA" value=""/><br />
    Nome: <input type="text" name="nome" value="" /><br />
    E-mail: <input type="text" name="email" value="" /><br />
    Senha: <input type="password" name="senha" value="" /><br />
    <label for="tipo">Tipo de Conta:</label>
		<select name="tipo" id="tipo">
		  <option value="1">Administrador</option>
		  <option value="2">Usuário Comum</option>
	</select>
    
    <br/>
    <br/>
    <input type="submit" name="action" value="Adicionar Usuario"/>
<%
} 
%>
</form>
<form class="login-form" action="loginprocess.jsp" method="post"> <%

if ("Adicionar Usuario".equals(action)) {
	String RA = request.getParameter("RA");
	String Nome = request.getParameter("nome");
	String Email = request.getParameter("email");
	String Senha = request.getParameter("senha");
	String Tipo = request.getParameter("tipo");
	String val = valid.validacamposADDUser(RA, Nome, Email, Senha, Tipo);
	if (val.equals("")){
		try {
			int i = statement.executeUpdate("INSERT INTO usuarios (Login, Senha, Tipo) VALUES (\""+RA+"\",\""+Senha+"\",\""+Tipo+"\")");
			int j = statement.executeUpdate("INSERT INTO alunos (RA, Nome, email) VALUES (\""+RA+"\",\""+Nome+"\",\""+Email+"\")");
			if (i==1){
				out.println("Usuário "+RA+" adicionado com sucesso!");
			}else{
				out.println("Usuário "+RA+" não foi adicionado! Contacte o administrador do sistema !");
			}
		
			%>		
			<input type="text" hidden="hidden" name="username" value="<%out.println(login_username); %>">
			<input type="password" hidden="hidden" name="pass" value="<%out.println(login_pass);%>">
			<br/>
	        <input type="submit" value="Click aqui para continuar..." />
			
			<%
			
		} catch (Exception e) {
			System.out.print(e);
			e.printStackTrace();
		} 
	}else{
		out.println(val);
		%>				
		<form class="login-form" action="loginprocess.jsp" method="post"> 
		<input type="text" hidden="hidden" name="username" value="<%out.println(login_username); %>">
		<input type="password" hidden="hidden" name="pass" value="<%out.println(login_pass);%>">
		<br/>
        <input type="submit" value="Click aqui para acessar a lista de alunos novamente..." />
		</form>
		<%
	}
	
} else if ("Excluir Usuario".equals(action)) { 
	int ID_AL = Integer.parseInt(request.getParameter("ID_AL"));
	int ID_USR = Integer.parseInt(request.getParameter("ID_USR"));
	String RA = request.getParameter("RA");

	try {
		int i = statement.executeUpdate("Delete from alunos where ID_AL ="+ID_AL+"");
		int j = statement.executeUpdate("Delete from usuarios where ID_USR ="+ID_USR+"");
		if (i+j==2){
			out.println("Usuário "+RA+" excluído com sucesso!");
		}else{
			out.println("Usuário "+RA+" não foi excluído! Contacte o administrador do sistema !");
		}
				
		%>		
		<input type="text" hidden="hidden" name="username" value="<%out.println(login_username); %>">
		<input type="password" hidden="hidden" name="pass" value="<%out.println(login_pass);%>">
        <br/>
        <input type="submit" value="Click aqui para continuar..." />
		
		<%
		
	} catch (Exception e) {
		System.out.print(e);
		e.printStackTrace();
	}

} else if ("Alterar Usuario".equals(action)) {
	int ID_AL = Integer.parseInt(request.getParameter("ID_AL"));
	int ID_USR = Integer.parseInt(request.getParameter("ID_USR"));
	String RA = request.getParameter("RA");
	String Nome = request.getParameter("nome");
	String Email = request.getParameter("email");
	String Senha = request.getParameter("pass");
	String Tipo = request.getParameter("tipo");
	try {
		int i = statement.executeUpdate("Update alunos set RA = \""+RA+"\", Nome = \""+Nome+"\", email = \""+Email+"\" where ID_AL ="+ID_AL+"");
		int j = statement.executeUpdate("Update usuarios set Login = \""+RA+"\", Senha = \""+Senha+"\", Tipo = "+Tipo+" where ID_USR ="+ID_USR+"");
		if (i+j==2){
			out.println("Usuário "+RA+" atualizado com sucesso!");
		}else{
			out.println("Usuário "+RA+" não foi atualizado! Contacte o administrador do sistema !");
		}
		login_username = (String)session.getAttribute("login_username");
		login_pass = (String)session.getAttribute("login_pass");		
		%>		
		<input type="text" hidden="hidden" name="username" value="<%out.println(login_username); %>">
		<input type="password" hidden="hidden" name="pass" value="<%out.println(login_pass);%>">
        <br/>
        <input type="submit" value="Click aqui para continuar..." />
		
		<%
		
	} catch (Exception e) {
		System.out.print(e);
		e.printStackTrace();
	}
}


%>
     </form>
     
     	<tr>
 		<form class="login-form" action="logout.jsp" method="post">
		<td align="center"><input type="submit" name="logout" value="Logout"/> </td> 
		</form>
 		</tr>
  
   </body>
</html>
