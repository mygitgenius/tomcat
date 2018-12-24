<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.AppContext"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserVO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	UserVO aUser = UserDAO.getInstance().getUserVO(userinfo.userID);
	if (aUser == null)
	{		
		request.setAttribute("errorMsg", "���û��������ڻ��Ѿ���ɾ��");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}
	if (aUser.email==null || aUser.email.length()==0)
	{
	 	if (userinfo.userID.equals(AppContext.getInstance().getAdminUser()))
		{
			aUser.email = ForumSetting.getInstance().getAdminMailAddr();
		}
	}
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
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �༭��������</DIV>
<DIV class=container><DIV class=content>
<SCRIPT type=text/javascript>
function validate(theform) {
	var email = trim(theform.email.value);
	if (email == '')
	{
		alert("���������� Email");
		theform.email.focus();
		return false;
	}
	var illegalemail = !(/^[\-\.\w]+@[\.\-\w]+(\.\w+)+$/.test(email));
	if(illegalemail) 
	{
		alert("��������Ч�� Email ��ַ");
		theform.email.focus();
		return false;
	}
	return true;
}
</SCRIPT>
<FORM name="settings" onSubmit="return validate(this)" action="../perform.jsp?act=member_profile" method=post>
<DIV class="mainbox formbox">
<H1>�༭��������</H1>
<UL class="tabs">
  <LI><A href="my_pwd.jsp">�޸�����</A> </LI>
  <LI class=current><A href="my_profile.jsp">��������</A> </LI>
  <LI><A href="my_special.jsp">���Ի�����</A> </LI>
</UL>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TH><LABEL for=nickname>�ǳ�</LABEL></TH>
    <TD><INPUT id=nickname size=30 name=nickname maxlength="15"></TD></TR>
  <TR>
    <TH>�Ա�</TH>
    <TD><INPUT class=radio type=radio value='M' name=gender id="gender[M]"> �� &nbsp;
	    <INPUT class=radio type=radio value='F' name=gender id="gender[F]"> Ů &nbsp;
		<INPUT class=radio type=radio CHECKED value='U' name=gender id="gender[U]"> ���� </TD></TR>
  <TR>
    <TH><LABEL for=birth>����</LABEL></TH>
    <TD><INPUT id=birth maxlength=10 size=30 value=1970-01-01 name=birth>
		(&nbsp;��ʽΪ yyyy-mm-dd , ��-��-��&nbsp;)
	</TD></TR>
  <TR>
    <TH><LABEL for=city >����</LABEL></TH>
    <TD><INPUT id=city size=30 name=city maxlength="20"></TD></TR>
  <TR>
    <TH><LABEL for=webpage>������վ</LABEL></TH>
    <TD><INPUT id=webpage size=30 name=webpage maxlength="60"></TD></TR>
  <TR>
    <TH><LABEL for=icq>QQ/MSN</LABEL></TH>
    <TD><INPUT id=icq size=30 name=icq maxlength="40"></TD></TR>
  <TR>
    <TH><LABEL for=email>Email</LABEL></TH>
    <TD><INPUT id=email size=30 name=email maxlength="40"></TD></TR>
  <TR>
    <TH></TH>
    <TD><INPUT id=isMailPub class=checkbox type=checkbox value='T' name=isMailPub> Email ��ַ�ɼ� &nbsp;</TD></TR>
  <TR>
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit name=editsubmit type=submit>�ύ</BUTTON>
	  </TD></TR></TBODY></TABLE></DIV></FORM></DIV>
<script language="javascript">
$('nickname').value = "<%= aUser.nickname==null?"":aUser.nickname %>";
$('gender[<%= aUser.gender %>]').checked = true;
$('birth').value = "<%= aUser.birth==null?"1970-01-01":aUser.birth %>";
$('city').value = "<%= aUser.city==null?"":aUser.city %>";
$('webpage').value = "<%= aUser.webpage==null?"":aUser.webpage %>";
$('icq').value = "<%= aUser.icq==null?"":aUser.icq %>";
$('email').value = "<%= aUser.email==null?"":aUser.email %>";
$('isMailPub').checked = <%= aUser.isMailPub=='T'?"true":"false" %>;
</script>
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
