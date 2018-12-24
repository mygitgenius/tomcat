<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.util.AppUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.StatDAO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%
	UserInfo userinfo = PageUtils.getSessionUser(request);
    GroupVO aGroup = PageUtils.getGroupVO(userinfo);
	if (aGroup.rights.indexOf(IConstants.PERMIT_VIEW_STAT) < 0)
	{
		request.setAttribute("errorMsg", "��û�в鿴ͳ�����ݵ�Ȩ��");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}	
	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	String strPageNo = request.getParameter("page");
	int pageNo = PageUtils.getPageNo(strPageNo);
	int pageRows = 15;

	Object[] result = StatDAO.getInstance().getVisitStatInfo(pageNo, pageRows);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>��������¼ - <%= title %></TITLE>
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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; 
<A href="./baseinfo.jsp">��̳ͳ��</A> &raquo;&nbsp; ��������¼ </DIV>
<DIV class=container>
<DIV class=side>
<DIV>
<H2>ͳ��ѡ��</H2>
<UL>
  <LI><H3><A href="baseinfo.jsp">�����ſ�</A> </H3></LI>
  <LI class=side_on><H3><A href="flux.jsp">��������¼</A> </H3></LI>
  <LI><H3><A href="top_boards.jsp">�������</A> </H3></LI>
  <LI><H3><A href="top_topics.jsp">��������</A> </H3></LI>
  <LI><H3><A href="top_credits_users.jsp">��������</A> </H3></LI>
  <LI><H3><A href="admins.jsp">�����Ŷ�</A> </H3></LI>
</UL></DIV></DIV>
<DIV class=content>
<DIV class=mainbox>
<H1>��������¼</H1>
<TABLE cellSpacing=0 cellPadding=0 border="0">
  <THEAD>
  <TR>
    <TH>�·�</TH>
    <TD>����������</TD>
    <TD>�����ظ���</TD>
    <TD>�����û���</TD>
    <TD>���������</TD>
  </TR></THEAD>
  <TBODY>
<%
	if (result != null && result[1] != null)
	{
		ArrayList visitList = (ArrayList)result[1];
		HashMap record = null;
	
		for (int i=0; i<visitList.size(); i++)
		{
			record = (HashMap)visitList.get(i);
%>  
  <TR>
    <TH><%= record.get("statMonth") %></TH>
    <TD><%= record.get("topics") %></TD>
    <TD><%= record.get("replies") %></TD>
    <TD><%= record.get("users") %></TD>
    <TD><%= record.get("visits") %></TD>
  </TR>
<%
		}
	}
	else
	{
%>	
  <TR>
    <TD colspan="5">û�м�¼</TD></TR>
<%
	}
%>
</TBODY></TABLE></DIV>
<DIV class=pages_btns>
<%
	if (result != null && result[0] != null)
	{
%>	  
	<%= result[0] %>
<SCRIPT type=text/javascript>
var myUrl = "./flux.jsp";
function viewPage(pageno)
{
	window.location = myUrl + "?page=" + pageno;
}
</SCRIPT>
<%
	}
%>
</DIV>
</DIV></DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
