
<%@page import="pack.LoginDao"%>
<jsp:useBean id="obj" class="pack.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%
boolean status=LoginDao.validate(obj);
if(status){
out.println("Voc� Logou com sucesso com perfil de "+obj.getType());
session.setAttribute("session","TRUE");
}
else
{
out.print("Sinto muito, usu�rio e/ou senha incorretos");
%>
<jsp:include page="index.jsp"></jsp:include>
<%
}
%>