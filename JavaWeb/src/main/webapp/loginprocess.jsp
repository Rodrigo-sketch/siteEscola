<%@page import="pack.LoginDao,java.sql.*, pack.AlunoBean, pack.Provider"%>
<jsp:useBean id="obj" class="pack.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%
String perfil =  "";
boolean status=LoginDao.validate(obj);
Connection con=DriverManager.getConnection(Provider.CONNECTION_URL,Provider.USERNAME,Provider.PASSWORD);    
Statement statement = con.createStatement(); 
if(status){
	%>
	<!DOCTYPE html>
	<html lang="pt-BR">
	<head>
	<title>Lista de Alunos</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	</head>
    <body>
    <table width="1780" border="1" >
	<tr>
	<td>
	<table border="0">
	<tr>
	<td><img src="images/cloud-background-1.jpg" width="1860" height="185"></td>
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
	<table width="780" border="1">
	<tr>
	<td valign="top">
	<table width="200" border="0">

<tr><br/><br/><br/><br/><br/></tr>

<% 
int qtd = 0 ;
if (obj.getType()==1){
	ResultSet rs = statement.executeQuery("Select count(*) as qtd from aluno");
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
    <form class="login-form" action="alterausuario.jsp" method="post"> 
	<h1>
	<%
	if (obj.getType()==1){
		
		session.setAttribute("session","TRUE");
		
		ResultSet resultSetAluno = statement.executeQuery("Select * from aluno");
		out.println("Lista de Alunos: "); %><br> <%
		
		%></h1> <table class="text3" width="1650" height="300" border="1"> <%
				%> <tr class="text5" align="left" > <%
				%> <td> Selecionar </td> <% 
				%> <td> RA </td> <% 
				%> <td> Nome </td> <%
				%> <td> E-mail </td> <%
				%> </tr> <%
		while (resultSetAluno.next()) {
			%> <tr> <%
			%> <td><input type="checkbox" name="selecionar"> </input> </td><%
			%> <td> <input type="hidden" name="RA" value="<%out.println(resultSetAluno.getString("RA"));%>">  <%out.println(resultSetAluno.getString("RA"));%></td> <% 
			%> <td> <input type="hidden" name="Nome" value="<%out.println(resultSetAluno.getString("Nome"));%>"><%out.println(resultSetAluno.getString("Nome")); %> </td> <%
			%> <td class="text4"> <input type="hidden" name="email" value="<%out.println(resultSetAluno.getString("email"));%>"> <%out.println(resultSetAluno.getString("email")); %> </td> <%
			%> </tr> <%
		}
		%> </table> <%
	}else if  (obj.getType()==2){
		
		session.setAttribute("session","TRUE");
		ResultSet resultSetAluno = statement.executeQuery("Select * from aluno where RA = \""+obj.getUsername()+"\"");
		out.println("Lista de Alunos: "); %><br><br> <%
		%> </h1> <table class="text3" width="1600" height="300" border="1"> <%
				%> <tr class="text5" align="left" > <%
				%> <td> Selecionar </td> <% 
				%> <td> RA </td> <% 
				%> <td> Nome </td> <%
				%> <td> E-mail </td> <%
				%> </tr> <%
		while (resultSetAluno.next()) {
			%> <tr> <%
			%> <td><input type="checkbox" name="selecionar"> </input> </td><%
			%> <td> <%out.println(resultSetAluno.getString("RA"));%> </td> <% 
			%> <td> <%out.println(resultSetAluno.getString("Nome")); %> </td> <%
			%> <td class="text4"> <%out.println(resultSetAluno.getString("email")); %> </td> <%
			%> </tr> <%
		}
				
		%> </table> </td>
<%
	}
	%> 

	</table>
		<div class="container-login-form-btn">
		<button class="login-form-btn">
			Alterar
		</button>
	    </div>
</td>
</tr>
</table>
	
	</form>
	
		<script>
		let inputs = document.getElementsByClassName('input-form');
		for (let input of inputs) {
			input.addEventListener("blur", function() {
				if(input.value.trim() != ""){
					input.classList.add("has-val");
				} else {
					input.classList.remove("has-val");
				}
			});
		}
	</script>
	
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