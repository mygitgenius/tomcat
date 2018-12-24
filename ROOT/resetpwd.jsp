<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.util.AppUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%
	String ctxPath = request.getContextPath();
    String setID = PageUtils.getParam(request,"id");
    String[] values = AppUtils.decode32(setID).split("\\|");
    if (values.length != 2)
	{
		request.setAttribute("errorMsg", "�һ�����ʧ�� - ���������Ч��");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}
	setID = values[0];
    String userID = values[1];
	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, null);
	String homeUrl = ctxPath + "/index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�������� - <%= title %></TITLE>
<LINK href="styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/member.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/md5.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo; ��������</DIV>
<FORM name="findpwd" onsubmit="return checkfields();" action="perform.jsp?act=rsp" method="post">
<INPUT type=hidden name="sid" value="<%= setID %>">
<DIV class="mainbox formbox">
<H1>��������</H1>
<TABLE cellSpacing=0 cellPadding=0>
  <THEAD>
  <TR>
    <TH>�������µ�����</TH>
    <TD>&nbsp;</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH><LABEL for=verifycode>��֤�� *</LABEL></TH>
    <TD>
      <DIV id=verifycodeimage style="margin-bottom:3px"></DIV><INPUT id=verifycode onblur=checkverifycode() 
      tabIndex=1 maxLength=4 size=8 name=verifycode> <SPAN id=checkverifycode></SPAN></TD>
	    <SCRIPT type=text/javascript>
				refreshVerifyCode(112,42);
		</SCRIPT>
  </TR>
  <TR>
    <TH><LABEL for=userID>�û���</LABEL></TH>
    <TD><INPUT id=userID tabIndex=2 maxLength=15 
      size=25 name=userID readonly="true" value="<%= userID %>"> <SPAN id=checkuserID>&nbsp;</SPAN> </TD></TR>
  <TR>
    <TH><LABEL for=pwd1>������ *</LABEL></TD> 
    <TD><INPUT id=pwd1 tabIndex=4 type=password maxLength=15
      size=25 name=pwd1> <SPAN id=checkpwd>&nbsp;</SPAN><INPUT id=pwd type=hidden name=pwd></TD></TR>
  <TR>
    <TH><LABEL for=pwd2>ȷ������ *</LABEL></TH>
    <TD><INPUT id=pwd2 onblur=checkpwd2() tabIndex=5 type=password maxLength=15
      size=25 name=pwd2> <SPAN id=checkpwd2>&nbsp;</SPAN> </TD></TR>
  <TR>
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit tabIndex=100 name=findsubmit type=submit 
      value="true">�ύ</BUTTON></TD></TR></TBODY></TABLE></DIV></FORM>
<SCRIPT type=text/javascript>
	var verifycode_invalid = '��֤�����������������д';
	var passwd_dismatch = '������������벻һ�£����������';
	var lastpwd = '';

	$('pwd1').focus();

	function checkfields() 
	{
		if (trim($('verifycode').value) == '')
		{
			warning($('checkverifycode'), '��������֤��');
			return false;
		}
		if (trim($('pwd1').value) == '')
		{
			warning($('checkpwd'), '����������');
			return false;
		}
		if (trim($('pwd2').value) == '')
		{
			warning($('checkpwd2'), '���ٴ���������');
			return false;
		}
		if (!checkpwd2())
		{
			return false;
		}
		$('pwd').value = hex_md5(trim($('pwd1').value)); 
		$('pwd1').value = '';
		$('pwd2').value = '';
		findpwd.findsubmit.disabled = true;
	}
</SCRIPT>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request, forumStyle) %>
</BODY></HTML>
