<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.ShortMsgDAO"%>
<%@ page import="com.hongshee.ejforum.data.ShortMsgDAO.ShortMsgVO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	String subject = null;
	String message = null;
	String toUser = null;
	
	String act = request.getParameter("act");
	if (act != null)
	{
		String msgID = PageUtils.getParam(request,"mid");
		if (msgID.length() > 0)
		{
			ShortMsgVO msgVO = ShortMsgDAO.getInstance().getShortMsg(msgID);
			if (msgVO != null)
			{
				if (act.equals("reply"))
				{
					toUser = msgVO.fromUser;
					subject = "Re: " + msgVO.title;
					subject = subject.replace("\"","&quot;");
				}
				else if (act.equals("forward"))
				{
					subject = "Fw: " + msgVO.title;
					subject = subject.replace("\"","&quot;");

					StringBuilder sbuf = new StringBuilder();
					sbuf.append(msgVO.createTime).append("&nbsp;").append(msgVO.fromUser).append("&nbsp;��&nbsp;")
					    .append(msgVO.userID).append(" ���Ͷ���Ϣ���£�\n").append(msgVO.message);
					message = sbuf.toString();
				}
			}
		}
	}
	if (toUser == null)
	{
		toUser = PageUtils.getParam(request, "uid");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>����Ϣ - <%= title %></TITLE>
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
<SCRIPT src="../js/viewthread.js" type=text/javascript></SCRIPT>
<SCRIPT type=text/javascript>zoomstatus = parseInt(1);</SCRIPT>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; ����Ϣ</DIV>
<DIV class=container><DIV class=content>
<FORM name="smsform" onSubmit="return validate(this)" action="../perform.jsp?act=member_sms_compose" method=post>
<DIV class="mainbox formbox">
<H1>���Ͷ���Ϣ</H1>
<UL class=tabs>
  <LI class="current additem"><A href="sms_compose.jsp">���Ͷ���Ϣ</A> </LI>
  <LI><A href="sms_list.jsp?act=inbox">�ռ���[<SPAN id=pm_unread><%= userinfo.unreadSMs %></SPAN>]</A> </LI>
  <LI><A href="sms_list.jsp?act=outbox">�ѷ���</A> </LI>
</UL>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TH><LABEL for=users>���͵�</LABEL></TH>
    <TD><INPUT id=users tabIndex=2 size=65 name=users maxlength="100" value="<%= toUser==null?"":toUser %>">
		&nbsp;(����û���֮���Զ���","�ָ�)</TD></TR>
  <TR>
    <TH><LABEL for=subject>����</LABEL></TH>
    <TD><INPUT id=subject tabIndex=4 size=65 name=subject maxlength="100" value="<%= subject==null?"":subject %>"></TD></TR>
  <TR>
    <TH vAlign=top><LABEL for=message>����</LABEL><BR/>(200 ��������)</TH>
    <TD>
		<TEXTAREA id=message style="WIDTH: 85%" tabIndex=5 name=message rows=8><%= message==null?"":message %></TEXTAREA> 
    </TD></TR>
  <TR>
    <TH></TH>
    <TD><input type="checkbox" name="sendmail" value="yes" tabindex="6"/> ͬʱ���͵� Email ����</TD></TR>
  <TR>
    <TH><LABEL for=verifycode>��֤��</LABEL></TH>
    <TD>
      <DIV id=verifycodeimage style="margin-bottom:3px"></DIV>
	  <INPUT id=verifycode name=verifycode tabIndex=8 maxLength=4 size=15>
	  <SPAN id=checkverifycode></SPAN></TD>
  </TR>
  <TR class=btns>
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit id=postsubmit tabIndex=7 name=smssubmit type=submit>�ύ</BUTTON> 
  </TD></TR></TBODY></TABLE></DIV></FORM>
<SCRIPT src="../js/member.js" type=text/javascript></SCRIPT>
<SCRIPT type=text/javascript>
msgs['post_vcode_empty'] = '��������֤��';
var verifycode_invalid = '��֤�����������������д';
$('verifycodeimage').innerHTML = '<img width="112" height="42" src="../vcode" class="absmiddle"/>';
function validate(theform) {
	if (trim(theform.users.value) == '') {
		alert("�����뷢����Ϣ��Ŀ���û�����");
		theform.users.focus();
		return false;
	}
	if (trim(theform.subject.value) == '' || trim(theform.message.value) == '') {
		alert("�������������ݡ�");
		theform.subject.focus();
		return false;
	}
	if (theform.subject.value.length > 100) {
		alert("���ı��ⳬ�� 100 ���ַ������ơ�");
		theform.subject.focus();
		return false;
	}
	if (theform.message.value.length > 200) {
		alert("������Ϣ���ݳ��� 200 ���ַ������ơ�");
		theform.message.focus();
		return false;
	}
	if (trim($('verifycode').value) == '')
	{
		warning($('checkverifycode'), msgs['post_vcode_empty']);
		theform.verifycode.focus();
		return false;
	}
	if (!checkverifycode())
	{
		theform.verifycode.focus();
		return false;
	}
	return true;
}
</SCRIPT>
</DIV>
<DIV class=side>
<DIV>
<H2>�ҵĿռ�</H2>
<UL>
  <LI><H3><A href="../uspace.jsp?uid=<%= userinfo.userID %>" target="_blank">������Ϣҳ</A></H3></LI>
  <LI><H3><A href="my_profile.jsp">�༭��������</A></H3></LI>
  <LI class="side_on"><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
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
