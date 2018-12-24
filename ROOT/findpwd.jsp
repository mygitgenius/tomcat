<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%
	String ctxPath = request.getContextPath();
	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, null);
	String homeUrl = ctxPath + "/index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�һ����� - <%= title %></TITLE>
<LINK href="styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/member.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
</DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo; �һ�����</DIV>
<FORM name="findpwd" onsubmit="return checkfields();" action="perform.jsp?act=fdp" method="post">
<DIV class="mainbox formbox"> 
<H1>�һ�����</H1>
<TABLE cellSpacing=0 cellPadding=0>
  <THEAD>
  <TR>
    <TH>�������û�����Email</TH>
    <TD>&nbsp;</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH><LABEL for=verifycode>��֤��</LABEL></TH>
    <TD>
      <DIV id=verifycodeimage style="margin-bottom:3px"></DIV><INPUT id=verifycode onblur=checkverifycode() 
      tabIndex=1 maxLength=4 size=15 name=verifycode> <SPAN id=checkverifycode></SPAN></TD>
	    <SCRIPT type=text/javascript>
				refreshVerifyCode(112,42);
		</SCRIPT>
  </TR>
  <TR>
    <TH><LABEL for=userID>�û���</LABEL></TH>
    <TD><INPUT id=userID onblur=checkuserID() tabIndex=2 maxLength=15 
      size=25 name=userID> <SPAN id=checkuserID>&nbsp;</SPAN> </TD></TR>
  <TR>
    <TH><LABEL for=email>Email</LABEL></TD> 
    <TD><INPUT id=email onblur=checkemail() tabIndex=6 size=25 maxLength=40 name=email> 
      <SPAN id=checkemail>&nbsp;</SPAN></TD></TR>
  <TR>
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit tabIndex=100 name=findsubmit type=submit 
      value="true">�ύ</BUTTON></TD></TR></TBODY></TABLE></DIV></FORM>
<SCRIPT type=text/javascript>
	var verifycode_invalid = '��֤�����������������д';
	var lastuserID = lastemail = '';

	$('userID').focus();

	function checkfields() 
	{
		if (trim($('verifycode').value) == '')
		{
			warning($('checkverifycode'), '��������֤��');
			return false;
		}
		if (trim($('userID').value) == '' && trim($('email').value) == '')
		{
			warning($('checkuserID'), '�����������û�����Email��������һ��');
			return false;
		}
		findpwd.findsubmit.disabled = true;
	}
	function checkuserID() {
		var userID = trim($('userID').value);
		if(userID == lastuserID) {
			return;
		} else {
			lastuserID = userID;
		}
		var cu = $('checkuserID');
		var unlen = userID.replace(/[^\x00-\xff]/g, "**").length;
		if(unlen < 3  && userID != '') {
			warning(cu, '�Բ�����������û���С��3���ַ�, ������һ���ϳ����û���');
		} else {
			cu.style.display = 'none';
		}
	}
	function checkemail() {
		var email = trim($('email').value);
		if(email == lastemail) {
			return;
		} else {
			lastemail = email;
		}
		
		var ce = $('checkemail');
		if(email != '' && !isLegalEmail(email)) {
			warning(ce, 'Email ��ַ��Ч����������д');
		} else {
			ce.style.display = 'none';
		}
	}
</SCRIPT>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request, forumStyle) %>
</BODY></HTML>
