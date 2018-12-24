<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.util.AppUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserVO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO.TopicInfo"%>
<%@ page import="com.hongshee.ejforum.data.ReplyDAO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	CacheManager cache = CacheManager.getInstance();

	String act = request.getParameter("act");
	if (act == null || act.length() == 0)
		act = "topic";

	String strPageNo = request.getParameter("page");
	int pageNo = PageUtils.getPageNo(strPageNo);
	int pageRows = 15;

	Object[] result = null;
	
	if (act.equals("reply"))
		result = ReplyDAO.getInstance().getUserReplies(userinfo.userID, false, pageNo, pageRows);
	else		
		result = TopicDAO.getInstance().getUserTopics(userinfo.userID, false, pageNo, pageRows);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�ҵĻ��� - <%= title %></TITLE>
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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �ҵĻ���</DIV>
<DIV class=container>
<DIV class=content><DIV class=mainbox>
<H1>�ҵĻ���</H1>
<UL class="tabs headertabs">
  <LI<%= act.equals("topic")?" class=current":"" %>><A href="./my_topics.jsp?act=topic">�ҵ�����</A> </LI>
  <LI<%= act.equals("reply")?" class=current":"" %>><A href="./my_topics.jsp?act=reply">�ҵĻظ�</A> </LI></UL>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <THEAD>
  <TR>
<%	
	int cols = 5;
	if (act.equals("topic")) {
%>		
    <TD WIDTH="50%">����</TD>
    <TD WIDTH="13%">���</TD>
    <TD WIDTH="10%">�鿴/�ظ�</TD>
    <TD WIDTH="17%">����ʱ��</TD>
    <TD WIDTH="10%">״̬</TD>
<%	
	} else {
		cols = 4;
%>	
    <TD WIDTH="60%">����</TD>
    <TD WIDTH="13%">���</TD>
    <TD WIDTH="17%">����ʱ��</TD>
    <TD WIDTH="10%">״̬</TD>
<%	
	}
%>		
	</TR></THEAD>
  <TBODY>
<%
	if (result != null && result[1] != null)
	{
		SectionVO aSection = null;
		BoardVO aBoard = null;
		String topicUrl = null;
		String forumUrl = null;
		StringBuilder sbuf = new StringBuilder();
		int startSeq = (pageNo - 1) * pageRows;
		
		if (act.equals("topic")) 
		{
			ArrayList topicList = (ArrayList)result[1];
			TopicInfo aTopic = null;
		
			for (int i=0; i<topicList.size(); i++)
			{
				aTopic = (TopicInfo)topicList.get(i);

				aSection = cache.getSection(aTopic.sectionID);
				aBoard = cache.getBoard(aSection, aTopic.boardID);

				sbuf.setLength(0);
				sbuf.append("../forum-").append(aTopic.sectionID).append("-").append(aTopic.boardID).append("-1.html");
				forumUrl = sbuf.toString();

				sbuf.setLength(0);
				sbuf.append("../topic-").append(aTopic.topicID);
				topicUrl = sbuf.toString() + "-1.html";
%>  
  <TR>
    <TD><A href="<%= topicUrl %>" target=_blank><%= startSeq + i + 1 %>. <%= aTopic.title %></A></TD>
    <TD><A href="<%= forumUrl %>" target=_blank><%= aBoard.boardName %></A></TD>
    <TD><%= aTopic.visits %> / <%= aTopic.replies %></TD>
    <TD><%= aTopic.createTime %></TD>
    <TD><%= aTopic.state=='R'?"����վ":"����" %></TD></TR>
<%
			}
		}
		else
		{
			ArrayList replyList = (ArrayList)result[1];
			HashMap record = null;
			String replyID = null;
			
			for (int i=0; i<replyList.size(); i++)
			{
				record = (HashMap)replyList.get(i);

				aSection = cache.getSection((String)record.get("SECTIONID"));
				aBoard = cache.getBoard(aSection, (String)record.get("BOARDID"));

				sbuf.setLength(0);
				sbuf.append("../forum-").append(aSection.sectionID).append("-").append(aBoard.boardID).append("-1.html");
				forumUrl = sbuf.toString();
				
				replyID = (String)record.get("REPLYID");
				sbuf.setLength(0);
				sbuf.append("../topic-").append((String)record.get("TOPICID")).append("-r").append(replyID)
					.append(".html#rid").append(replyID);
				topicUrl = sbuf.toString();
%>
  <TR>
    <TD><A href="<%= topicUrl %>" target=_blank><%= startSeq + i + 1 %>. Re: <%= (String)record.get("TITLE") %> 
	  	(RID:<%= replyID %>)</A></TD>
    <TD><A href="<%= forumUrl %>" target=_blank><%= aBoard.boardName %></A></TD>
    <TD><%= AppUtils.formatSQLTimeStr((String)record.get("CREATETIME")) %></TD>
    <TD><%= ((String)record.get("STATE")).charAt(0)=='R'?"����վ":"����" %></TD></TR>
<%		
			}
		}
	}
	else
	{
%>	
  <TR>
    <TD colspan="<%= cols %>">û�м�¼</TD></TR>
<%
	}
%>
	</TBODY></TABLE>
</DIV>
<DIV class=pages_btns>
<%
	if (result != null && result[0] != null)
	{
%>	  
	<%= result[0] %>
<SCRIPT type=text/javascript>
var myUrl = "./my_topics.jsp?act=<%= act %>";
function viewPage(pageno)
{
	window.location = myUrl + "&page=" + pageno;
}
</SCRIPT>
<%
	}
%>
</DIV></DIV>
<DIV class=side>
<DIV>
<H2>�ҵĿռ�</H2>
<UL>
  <LI><H3><A href="../uspace.jsp?uid=<%= userinfo.userID %>" target="_blank">������Ϣҳ</A></H3></LI>
  <LI><H3><A href="my_profile.jsp">�༭��������</A></H3></LI>
  <LI><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
  <LI class="side_on"><H3><A href="my_topics.jsp">�ҵĻ���</A></H3></LI>
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
