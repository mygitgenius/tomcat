<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�༭�������� - <%= title %></TITLE>
<%= PageUtils.getMetas(title, null) %>
<LINK href="../styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="../js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="../js/md5.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �༭��������</DIV>
<DIV class=container><DIV class=content>
<SCRIPT type=text/javascript>
var charset = 'gbk';
function validate(theform) {
	if (trim(theform.oldpwd1.value) == '')
	{
		alert('������ԭ����');
		theform.oldpwd1.focus();
		return false;
	}
	var pwd = trim(theform.pwd1.value);
	if (pwd == '')
	{
		alert('�����벻��Ϊ��');
		theform.pwd1.focus();
		return false;
	}
	var pwd2 = trim(theform.pwd2.value);
	if(pwd != pwd2)
	{
		alert('������������������ͬ');
		theform.pwd2.focus();
		return false;
	}
	theform.pwd.value = hex_md5(pwd);
	theform.oldpwd.value = hex_md5(trim(theform.oldpwd1.value));
	theform.oldpwd1.value = '';
	theform.pwd1.value = '';
	theform.pwd2.value = '';
	return true;
}
</SCRIPT>
<FORM name="settings" onSubmit="return validate(this)" action="../perform.jsp?act=member_chgpwd" method=post>
<DIV class="mainbox formbox">
<H1>�༭��������</H1>
<UL class="tabs">
  <LI class=current><A href="my_pwd.jsp">�޸�����</A> </LI>
  <LI><A href="my_profile.jsp">��������</A> </LI>
  <LI><A href="my_special.jsp">���Ի�����</A> </LI>
</UL>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TD class=altbg1><SPAN class=bold>ԭ����</SPAN></TD>
    <TD class=altbg2><INPUT type=password size=25 name=oldpwd1><INPUT type=hidden name=oldpwd></TD></TR>
  <TR>
    <TD class=altbg1><SPAN class=bold>������</SPAN></TD>
    <TD class=altbg2><INPUT type=password size=25 name=pwd1><INPUT type=hidden name=pwd></TD></TR>
  <TR>
    <TD class=altbg1><SPAN class=bold>ȷ��������</SPAN></TD>
    <TD class=altbg2><INPUT type=password size=25 name=pwd2></TD></TR>
  <TR>
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit name=editsubmit type=submit>�ύ</BUTTON></TD></TR>
	</TBODY></TABLE></DIV></FORM></DIV>
<DIV class=side>
<DIV>
<H2>�ҵĿռ�</H2>
<UL>
  <LI><H3><A href="../uspace.jsp?uid=<%= userinfo.userID %>" target="_blank">������Ϣҳ</A></H3></LI>
  <LI class="side_on"><H3><A href="my_profile.jsp">�༭��������</A></H3></LI>
  <LI><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
  <LI><H3><A href="my_topics.jsp">�ҵĻ���</A></H3></LI>
  <LI><H3><A href="my_favors.jsp">�ҵ��ղ�</A></H3></LI>
  <LI><H3><A href="my_friends.jsp">�ҵĺ���</A></H3></LI>
  <LI><H3><A href="my_rights.jsp">�ҵ�Ȩ��</A></H3></LI>
  <LI><H3><A href="my_credits.jsp">���ֽ��׼�¼</A></H3></LI>
</UL>
</DIV>
<DIV>
<H2>���ָſ�</H2>
<UL class="credits">
  <LI>����: <%= userinfo.credits %></LI>
  <LI>����: <%= userinfo.posts %></LI>
</UL></DIV></DIV></DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
