<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="3; url=http://localhost:8080/JavaWeb/">
<title>Logout</title>
</head>
<body>
<% session.invalidate(); %>
<p>logout efetuado com sucesso!</p>
</body>
</html>