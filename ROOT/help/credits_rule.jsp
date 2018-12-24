<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%
	ForumSetting setting = ForumSetting.getInstance();
	String forumName = setting.getForumName();
	String title = PageUtils.getTitle(forumName);
	UserInfo userinfo = PageUtils.getSessionUser(request);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	CacheManager cache = CacheManager.getInstance();
    ArrayList groups = cache.getGroups();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���ֲ���˵�� - <%= title %></TITLE>
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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; ���ֲ���˵��</DIV>
<DIV class="mainbox">
<H1>���ֲ���˵��</H1>
<TABLE cellSpacing=0 cellPadding=0>
  <THEAD>
  <TR>
    <TH width="45%">��Ϊ</TH>
    <TD>����</TD>
  </TR></THEAD>
  <TBODY>
  <TR><TH>ע���ʼ����</TH><TD><%= setting.getInt(ForumSetting.CREDITS,"userInitValue") %></TD></TR>
  <TR><TH>��������</TH><TD>+<%= setting.getInt(ForumSetting.CREDITS,"newTopic") %></TD></TR>
  <TR><TH>����ظ�</TH><TD>+<%= setting.getInt(ForumSetting.CREDITS,"newReply") %></TD></TR>
  <TR><TH>��Ϊ��ѻظ�</TH><TD>+<%= setting.getInt(ForumSetting.CREDITS,"bestReply") %></TD></TR>
  <TR><TH>���뾫��</TH><TD>+<%= setting.getInt(ForumSetting.CREDITS,"digestTopic") %></TD></TR>
  <TR><TH>�ϴ�����</TH><TD>+<%= setting.getInt(ForumSetting.CREDITS,"upload") %></TD></TR>
  <TR><TH>���ظ���</TH><TD><%= setting.getInt(ForumSetting.CREDITS,"download") %></TD></TR>
  <TR><TH>���ֽ���</TH><TD>�ɹ���Ա�趨</TD></TR>
  <TR><TH>���ֽ���</TH><TD>�ɾ��彻�׶���</TD></TR>
  </TBODY>
</TABLE></DIV>
<DIV class="mainbox">
<H1>��Ա�û���</H1>
<TABLE cellSpacing=0 cellPadding=0>
  <THEAD>
  <TR>
    <TH width="45%">������</TH>
    <TD>���ַ�Χ</TD>
  </TR></THEAD>
  <TBODY>
<%
	if (groups != null)
	{
		GroupVO aGroup = null;
		for (int i=0; i<groups.size(); i++)
		{
			aGroup = (GroupVO)groups.get(i);
			if (aGroup.groupType == 'M')
			{
%>			
  <TR><TH><%= aGroup.groupName %></TH><TD><%= aGroup.minCredits %>&nbsp;~&nbsp;<%= aGroup.maxCredits %></TD></TR>
<%
			}
		}
	}
%>			
  </TBODY>
</TABLE>
</DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
