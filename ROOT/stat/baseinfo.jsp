<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.StatDAO"%>
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

	HashMap statInfo = StatDAO.getInstance().getBaseStatInfo();
	int topics = Integer.parseInt((String)statInfo.get("topics"));
	int replies = Integer.parseInt((String)statInfo.get("replies"));
	int visits = Integer.parseInt((String)statInfo.get("visits"));
	int users = Integer.parseInt((String)statInfo.get("users"));
	int userLogins = Integer.parseInt((String)statInfo.get("userLogins"));

	if (topics < 1) topics = 1;
	if (users < 1) users = 1;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�����ſ� - <%= title %></TITLE>
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
<A href="./baseinfo.jsp">��̳ͳ��</A> &raquo;&nbsp; �����ſ�</DIV>
<DIV class=container>
<DIV class=side>
<DIV>
<H2>ͳ��ѡ��</H2>
<UL>
  <LI class=side_on><H3><A href="baseinfo.jsp">�����ſ�</A> </H3></LI>
  <LI><H3><A href="flux.jsp">��������¼</A> </H3></LI>
  <LI><H3><A href="top_boards.jsp">�������</A> </H3></LI>
  <LI><H3><A href="top_topics.jsp">��������</A> </H3></LI>
  <LI><H3><A href="top_credits_users.jsp">��������</A> </H3></LI>
  <LI><H3><A href="admins.jsp">�����Ŷ�</A> </H3></LI>
</UL></DIV></DIV>
<DIV class=content>
<DIV class=mainbox>
<H3>��̳ͳ��</H3>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TH width="22%">�����</TH>
    <TD width="11%"><%= (String)statInfo.get("boards") %></TD>
    <TH width="22%">������</TH>
    <TD width="11%"><%= topics %></TD>
    <TH width="22%">������</TH>
    <TD width="11%"><%= (String)statInfo.get("digests") %></TD>
  </TR>
  <TR>
    <TH>����������</TH>
    <TD><%= (String)statInfo.get("rewards") %></TD>
    <TH>�ظ���</TH>
    <TD><%= replies %></TD>
    <TH>������</TH>
    <TD><%= (String)statInfo.get("attaches") %></TD>
  </TR>
  <TR>
    <TH>ƽ��ÿ�����ⱻ�ظ�����</TH>
    <TD><%= replies/topics %></TD>
    <TH>ƽ��ÿ�����ⱻ���ʴ���</TH>
    <TD><%= visits/topics %></TD>
    <TH></TH>
    <TD></TD>
  </TR>
  </TBODY></TABLE></DIV>
<DIV class=mainbox>
<H3>��Աͳ��</H3>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TH width="22%">ע���Ա��</TH>
    <TD width="11%"><%= users %></TD>
    <TH width="22%">������Ա��</TH>
    <TD width="11%"><%= (String)statInfo.get("postUsers") %></TD>
    <TH width="22%">�����Ա��</TH>
    <TD width="11%"><%= (String)statInfo.get("adminUsers") %></TD>
  </TR>
  <TR>
    <TH>ƽ��ÿ�˵�¼����</TH>
    <TD><%= userLogins/users %></TD>
    <TH>ƽ��ÿ�˷�����</TH>
    <TD><%= (topics + replies)/users %></TD>
    <TH></TH>
    <TD></TD>
  </TR>
  </TBODY></TABLE></DIV>
<DIV class=remark><img src="../images/notice.gif" border="0" align="absmiddle"/>&nbsp;
ͳ������ÿ�����һ�Σ�����ͳ��ʱ���� <%= (String)statInfo.get("statTime") %></DIV>  
</DIV></DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
