<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD>
<TITLE>EasyJForum ��̨����</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK id=css href="style/admin.css" type=text/css rel=stylesheet>
<SCRIPT>
var menus = new Array('basic', 'forums', 'users', 'tools');
function toggleMenu(id) 
{
	if(parent.menu) {
		for(k in menus) {
			if(parent.menu.document.getElementById(menus[k])) 
				parent.menu.document.getElementById(menus[k]).style.display = menus[k] == id ? '' : 'none';
		}
	}
}
function setModule(n) 
{
	var titles = document.getElementsByTagName('li');
	for(var i = 0; i < titles.length; i++) 
	{
		titles[i].id = '';
	}
	titles[n].id = 'menuon';
}
</SCRIPT>
</HEAD>
<BODY>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 style="BACKGROUND: url(images/header_bg.gif) repeat-x">
  <TBODY>
  <TR>
    <TD width=160 rowSpan=2>
	  <div style="PADDING-LEFT: 30px; HEIGHT: 50px; padding-top:10px">	
	  <SPAN style="FONT-WEIGHT: bold; FONT-SIZE:13px; COLOR: #ffffff; TEXT-DECORATION: none">EasyJForum<BR>��̨����</SPAN></div></TD>
    <TD>
      <DIV class=topmenu>
      <UL>
        <LI<%= userinfo.groupID=='A'?"":" style='display:none'" %>><SPAN><A href="#" 
        	onclick="setModule(0); toggleMenu('basic'); parent.main.location='basic/baseinfo.jsp';return false;">��̳����</A>
		</SPAN></LI>
        <LI><SPAN><A href="#" 
        	onclick="setModule(1); toggleMenu('forums'); parent.main.location='forums/log_report.jsp';return false;">��̳����</A>
		</SPAN></LI>
        <LI><SPAN><A href="#" 
	        onclick="setModule(2); toggleMenu('users'); parent.main.location='users/user_edit.jsp';return false;">�û�����</A>
		</SPAN></LI>
        <LI <%= userinfo.groupID=='A'?"":" style='display:none'" %>><SPAN><A href="#" 
	        onclick="setModule(3); toggleMenu('tools'); parent.main.location='tools/send_notice.jsp';return false;">ϵͳ����</A>
		</SPAN></LI>
	  </UL></DIV></TD></TR></TBODY></TABLE>
<SCRIPT>
	setModule(1);
	toggleMenu("forums");
	parent.main.location='./home.jsp';
</SCRIPT>
</BODY></HTML>
