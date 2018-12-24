<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	String url = null;
	String subject = null;
	String boardName = null;
	
	String topicID = PageUtils.getParam(request,"tid");
	if (topicID.length() > 0)
	{
		HashMap record = TopicDAO.getInstance().getTopic(topicID);
		if (record != null)
		{
			subject = (String)record.get("TITLE");
			if (subject != null)
				subject = subject.replace("\"","&quot;");

			String boardID = PageUtils.getParam(request,"fid");
			CacheManager cache = CacheManager.getInstance();
			BoardVO tmpBoard = cache.getBoard(boardID);
			if (tmpBoard != null)
			{
				StringBuilder sbuf = new StringBuilder();
				sbuf.append(PageUtils.getForumURL(request))
				    .append("topic-").append(topicID).append("-1.html");
				url = sbuf.toString();
				boardName = tmpBoard.boardName;
			}
		}
	}	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�ҵ��ղ� - <%= title %></TITLE>
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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �ҵ��ղ�</DIV>
<DIV class=container><DIV class=content>
<FORM name="favorform" onSubmit="return validate(this)" action="../perform.jsp?act=member_favor_add" method=post>
<DIV class=mainbox>
<H1>�ҵ��ղ�</H1>
<UL class="tabs">
  <LI class="current additem"><A href="my_addfavor.jsp">����ղ�</A> </LI>
  <LI><A href="my_favors.jsp">�ҵ��ղؼ�</A> </LI></UL>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TH><LABEL for=url>��ַ</LABEL></TH>
    <TD><INPUT id=url tabIndex=1 size=65 name=url maxlength="100" value="<%= url==null?"":url %>">
		&nbsp;(һ����&nbsp;http://&nbsp;��ͷ)</TD></TR>
  <TR>
    <TH><LABEL for=subject>����</LABEL></TH>
    <TD><INPUT id=subject tabIndex=2 size=65 name=subject maxlength="100" value="<%= subject==null?"":subject %>"></TD></TR>
  <TR>
    <TH><LABEL for=board>�������&nbsp;/&nbsp;��վ</LABEL></TH>
    <TD><INPUT id=board tabIndex=4 size=65 name=board maxlength="20" value="<%= boardName==null?"":boardName %>"></TD></TR>
  <TR class=btns>
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit id=postsubmit tabIndex=7 name=postsubmit type=submit>�ύ</BUTTON> 
  </TD></TR>	
  </TBODY></TABLE></DIV></FORM>
<SCRIPT type=text/javascript>
	function validate(theform) {
		if (trim(theform.url.value) == '') {
			alert("�������ղص���ַ��");
			theform.url.focus();
			return false;
		}
		if (trim(theform.subject.value) == '') {
			alert("�������ղصı��⡣");
			theform.subject.focus();
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
  <LI><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
  <LI><H3><A href="my_topics.jsp">�ҵĻ���</A></H3></LI>
  <LI class="side_on"><H3><A href="my_favors.jsp">�ҵ��ղ�</A></H3></LI>
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
