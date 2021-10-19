
<%@page import="pack.LoginDao,java.sql.*, pack.AlunoBean, pack.Provider"%>
<jsp:useBean id="obj" class="pack.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

	<!DOCTYPE html>
	<html lang="pt-BR">
	<head>
	<title>Lista de Alunos</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	</head>
<body>
      <center>
      <h1>Alterando dados do usuário: </h1>
      
      <ul>
         <li><p><b>RA:</b>
            <%= request.getParameter("RA")%>
         </p></li>
         <li><p><b>Nome:</b>
            <%= request.getParameter("Nome")%>
         </p></li>
         <li><p><b>Email:</b>
            <%= request.getParameter("email")%>
         </p></li>
      </ul>
   
   </body>
</html>
