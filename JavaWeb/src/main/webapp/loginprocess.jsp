<%@page import="pack.LoginBean"%>
<%@page import="pack.LoginDao,java.sql.*, pack.AlunoBean, pack.Provider, javax.servlet.http.*"%>
<jsp:useBean id="obj" class="pack.LoginBean"/>
<jsp:setProperty property="*" name="obj"/>

<%
String perfil =  "";
boolean status=LoginDao.validate(obj);
String TipoConta = "";
Connection con=DriverManager.getConnection(Provider.CONNECTION_URL,Provider.USERNAME,Provider.PASSWORD);    
Statement statement = con.createStatement(); 
if(status){
	session.setAttribute("login_username", request.getParameter("username"));
	session.setAttribute("login_pass", request.getParameter("pass"));
	session.setAttribute("login_type", obj.getType());
	%>
	<!DOCTYPE html>
	<html lang="pt-BR">
	<head>
	<title>Lista de Alunos</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	</head>
    <body>
    <table width="1300" border="1" >
	<tr>
	<td>
	<table border="0">
	<tr>
	<td><img src="images/cloud-background-1.jpg" width="1520" height="185"></td>
	</tr>
	<tr>
	<td align="center">
	 <% 
	if (obj.getType()==1){
		perfil = "Administrador";
	
		out.println("Você Logou com sucesso com perfil de "+perfil); %> <br><br> <%
		session.setAttribute("session","TRUE"); 
		
	}else if  (obj.getType()==2){
		perfil = "Usuario Comum";
	
		out.println("Você Logou com sucesso com perfil de "+perfil); %> <br><br> 
		<% } %>
	</td>
	</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	<table width="1400" heigth="100" border="1">
	<tr>
	<td valign="top">
	<table width="200" border="0">

<tr><br/><br/><br/></tr>

<% 
int qtd = 0 ;
if (obj.getType()==1){
	ResultSet rs = statement.executeQuery("Select count(*) as qtd from alunos");
	rs.next();
	qtd = rs.getInt("qtd");
	rs.close();
}

for (int i= 0; i<=qtd; i++){ 

%>
	<tr>
	<td><img src="images/index_06.gif" width="190" height="55" border="0" alt="butt_2"></td>
	</tr>
	
<% } %>

	</table>   

    <td valign="top" align="center">
    
	<h2>
	<%
	if (obj.getType()==1){
		
		session.setAttribute("session","TRUE");
		
		ResultSet resultSetAluno = statement.executeQuery("Select * from exemplo.alunos as al inner join exemplo.usuarios as usr on usr.Login = al.RA");
		out.println("Lista de Alunos: "); %><br> <%
		
		%></h2> <table width="1310" border="1"> <%
				%> <tr class="text5" align="left" > <%
				%> <td> Selecionar </td> <% 
				%> <td> RA </td> <% 
				%> <td> Nome </td> <%
				%> <td> E-mail </td> <%
				%> <td> Tipo de conta </td> <%
				%> </tr> <%
		while (resultSetAluno.next()) {
			if (resultSetAluno.getInt("Tipo")==1){
				TipoConta = "Administrador";
			}else{
				TipoConta = "Usuário Comum";
			}
			%> 
			<form class="login-form" action="alterausuario.jsp" method="post"> 
			<tr> <%
			%> <td><input type="submit" name="action" value="alterar"/> 
			<input type="submit" name="action" value="excluir"/></td>
			<input type="hidden" name="ID_AL" value="<%out.println(resultSetAluno.getInt("ID_AL"));%>">  
			<input type="hidden" name="ID_USR" value="<%out.println(resultSetAluno.getInt("ID_USR"));%>">  
			<input type="hidden" name="pass" value="<%out.println(resultSetAluno.getString("Senha"));%>"> <%
			%> <td> <input type="hidden" name="RA" value="<%out.println(resultSetAluno.getString("RA"));%>"><%out.println(resultSetAluno.getString("RA"));%></td> <% 
			%> <td> <input type="hidden" name="Nome" value="<%out.println(resultSetAluno.getString("Nome"));%>"><%out.println(resultSetAluno.getString("Nome")); %> </td> <%
			%> <td class="text4"> <input type="hidden" name="email" value="<%out.println(resultSetAluno.getString("email"));%>"> <%out.println(resultSetAluno.getString("email")); %> </td> <%
			%> <td><input type="text" hidden="true" name="tipo" value="<%out.println(resultSetAluno.getInt("Tipo"));%>"> <%out.println(TipoConta);%> </td> <%
			%> </tr> 
			</form>
			<%
		}
		%> </table> 
			<form class="login-form" action="alterausuario.jsp" method="post"> 
			<input type="submit" name="action" value="adicionar novo usuario"/> 
			</form>
		<%
	}else if  (obj.getType()==2){
		
		session.setAttribute("session","TRUE");
		ResultSet resultSetAluno = statement.executeQuery("Select * from exemplo.alunos as al inner join exemplo.usuarios as usr on usr.Login = al.RA where RA = \""+obj.getUsername()+"\"");
		out.println("Lista de Alunos: "); %><br><br> <%
		%> </h1> <table width="1310" border="1"> <%
				%> <tr class="text5" align="left" > <%
				%> <td> Selecionar </td> <% 
				%> <td> RA </td> <% 
				%> <td> Nome </td> <%
				%> <td> E-mail </td> <%
				%> <td> Tipo de conta </td> <%
				%> </tr> <%
		while (resultSetAluno.next()) {
			if (resultSetAluno.getInt("Tipo")==1){
				TipoConta = "Administrador";
			}else{
				TipoConta = "Usuário Comum";
			}
			%> 
			<form class="login-form" action="alterausuario.jsp" method="post"> 
			<tr> <%
			%> <td><input type="submit" name="action" value="alterar"/> 
			<input type="hidden" name="ID_AL" value="<%out.println(resultSetAluno.getInt("ID_AL"));%>">  
			<input type="hidden" name="ID_USR" value="<%out.println(resultSetAluno.getInt("ID_USR"));%>">  
			<input type="hidden" name="pass" value="<%out.println(resultSetAluno.getString("Senha"));%>"> <%
			%> <td> <input type="hidden" name="RA" value="<%out.println(resultSetAluno.getString("RA"));%>"><%out.println(resultSetAluno.getString("RA"));%></td> <% 
			%> <td> <input type="hidden" name="Nome" value="<%out.println(resultSetAluno.getString("Nome"));%>"><%out.println(resultSetAluno.getString("Nome")); %> </td> <%
			%> <td class="text4"> <input type="hidden" name="email" value="<%out.println(resultSetAluno.getString("email"));%>"> <%out.println(resultSetAluno.getString("email")); %> </td> <%
			%> <td><input type="text" hidden="hidden" name="tipo" value="<%out.println(resultSetAluno.getInt("Tipo"));%>"> <%out.println(TipoConta);%> </td> <%
			%> </tr> 
			</form>
			<%
		}
				
		%> </table> </td>
<%
	}
	%> 

	</table>
		<tr>
 		<form class="login-form" action="logout.jsp" method="post">
		<td align="center"><input type="submit" name="logout" value="Logout"/> </td> 
		</form>
 		</tr>
</td>
</tr>
</table>	
	</body>
</html>
	
	 <%
}
else
{
out.print("Sinto muito, usuário e/ou senha incorretos");
%>
<jsp:include page="index.jsp"></jsp:include>
<%
}
%>