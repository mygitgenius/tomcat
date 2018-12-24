<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO.TopicInfo"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%
	ForumSetting setting = ForumSetting.getInstance();
	String forumName = setting.getForumName();
	String title = PageUtils.getTitle(forumName);
	UserInfo userinfo = PageUtils.getSessionUser(request);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "./index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	CacheManager cache = CacheManager.getInstance();
	
	String strPageNo = request.getParameter("page");
	int pageNo = PageUtils.getPageNo(strPageNo);
	int pageRows = 15;

	String spec = request.getParameter("spec");
	if (spec == null || spec.length() == 0)
		spec = "recent";
		
	String pageTitle = null;
	if (spec.equals("reward"))
		pageTitle = "��������";
	else if (spec.equals("digest"))
		pageTitle = "������";
	else if (spec.equals("hot"))
		pageTitle = "��������";
	else if (spec.equals("recent"))
		pageTitle = "�½�����";
	else
		pageTitle = "���·���";

	Object[] result = TopicDAO.getInstance().getSpecTopics(spec, userinfo, pageNo, pageRows);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%= pageTitle %> - <%= title %></TITLE>
<%= PageUtils.getMetas(title, null) %>
<LINK href="styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="js/common.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; <%= pageTitle %></DIV>
<%
	if (result != null && result[0] != null)
	{
%>	  
<DIV class=pages_btns>
	<%= result[0] %>
</DIV>
<%
	}
%>
<DIV class="mainbox topiclist">
<H1><%= pageTitle %></H1>
<TABLE cellSpacing=0 cellPadding=0>
  <THEAD class=category>
  <TR>
    <TD>&nbsp;</TD>
    <TD>����</TD>
	<TD class=author>����</TD>
    <TD class=nums>�ظ�/�鿴</TD>
    <TD class=lastpost>�������</TD>
  </TR></THEAD>
<%
	if (result != null && result[1] != null)
	{
		ArrayList topicList = (ArrayList)result[1];

		TopicInfo aTopic = null;
		String topicUrl = null;
		String forumUrl = null;
		String nickname = null;
		String topicIcon = null;
		String userID = null;
		BoardVO aBoard = null;
		int hotTopicPosts = setting.getInt(ForumSetting.DISPLAY, "hotTopicPosts");
		StringBuilder sbuf = new StringBuilder();
			
		for (int i=0; i<topicList.size(); i++)
		{
			aTopic = (TopicInfo)topicList.get(i);

			sbuf.setLength(0);
			sbuf.append("./topic-").append(aTopic.topicID).append("-1.html");
				
			topicUrl = sbuf.toString();

			sbuf.setLength(0);
			sbuf.append("./forum-").append(aTopic.sectionID).append('-').append(aTopic.boardID).append("-1.html");
			forumUrl = sbuf.toString();
			
			aBoard = cache.getBoard(aTopic.sectionID, aTopic.boardID);
			
			if (aTopic.isHidePost == 'T')
			{
				userID = "";
				nickname = "";
			}
			else
			{
				userID = aTopic.userID;	
				nickname = (aTopic.nickname==null || aTopic.nickname.length()==0) ? userID : aTopic.nickname;
			}

			if (aTopic.state == 'C')
				topicIcon = "folder_lock.gif";
			else if (Integer.parseInt(aTopic.replies) > hotTopicPosts)
				topicIcon = "folder_hot.gif";
			else	
				topicIcon = "folder_common.gif";
%>	
  <TBODY>
  <TR>
    <TD class=folder><A title=�´��ڴ� href='<%= topicUrl %>' target=_blank><IMG src="images/<%= topicIcon %>"></A></TD>
    <TD>
<%
			if (aTopic.isDigest == 'T') {
%>	
		<LABEL><IMG alt="����" src="images/digest.gif">&nbsp;</LABEL>
<%
			}
%>		
		<A href='<%= topicUrl %>' target=_blank><%= aTopic.title %></A>
<%
			if (aTopic.attachIcon != null) {
			 	if (aTopic.attachIcon.indexOf('I') >= 0) {
					out.write("<LABEL class=\"pic\">(&nbsp;ͼ&nbsp;)&nbsp;</LABEL>");
				}
			 	else if (aTopic.attachIcon.indexOf('F') >= 0) {
					out.write("<LABEL class=\"pic\">(&nbsp;ý&nbsp;)&nbsp;</LABEL>");
				}
				if (aTopic.attachIcon.indexOf('A') >= 0) {
					out.write("<LABEL class=\"attach\">&nbsp;</LABEL>");
				}
			}
			if (aTopic.reward > 0) {
				out.write("<LABEL class=\"reward\">&nbsp;[&nbsp;����&nbsp;" + aTopic.reward + "&nbsp;");
				if (aTopic.isSolved == 'T')
					out.write("&nbsp;�ѽ��&nbsp;");
				out.write("]</LABEL>");
			}
%>		
	</TD>
    <TD class=author><CITE><A href="uspace.jsp?uid=<%= userID %>" target=_blank><%= nickname.length()==0?"�ο�":nickname %></A> 
      </CITE><EM><%= aTopic.createTime %></EM></TD>
    <TD class=nums><SPAN><%= aTopic.replies %></SPAN> / <EM><%= aTopic.visits %></EM></TD>
    <TD class=lastpost><A href="<%= forumUrl %>" target=_blank><%= aBoard==null?"":aBoard.boardName %></A></TD>
    </TR></TBODY>
<%		
		}
	} 
	else 
	{
%>
	<tbody><tr><td class=folder>&nbsp;</td><th colspan="4">Ŀǰ���޴���������</th></tr></tbody>
<%
	}
%>	
</TABLE>
</DIV>
<%
	if (result != null && result[0] != null)
	{
%>	  
<DIV class=pages_btns>
	<%= result[0] %>
</DIV>
<SCRIPT type=text/javascript>
var myUrl = "spec_topics.jsp?spec=<%= spec %>";
function viewPage(pageno)
{
	location = myUrl + "&page=" + pageno;
}
</SCRIPT>
<%
	}
%>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request, forumStyle) %>
</BODY></HTML>
