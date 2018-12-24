<%@ page contentType="text/html;charset=gbk" isErrorPage="true"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.AppException"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%
	String ctxPath = request.getContextPath();
	UserInfo userinfo = null;
	try
	{
		userinfo = PageUtils.getSessionUser(request);
	}
	catch(Exception e){ /* Ignored, avoid throw again when IP is banned */ }

	String errorMsg = (String)request.getAttribute("errorMsg");
	if (errorMsg == null)
	{ 	
		if (exception != null)
		{
			errorMsg = "����˳����쳣�����Ժ����� - " + exception.getMessage();
			if (!(exception instanceof AppException))
				PageUtils.log(request, "jsp error", errorMsg, exception);
		}
		if (errorMsg == null)	
			errorMsg = "����˳����쳣�����Ժ����ԡ�";
	}
	
	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = ctxPath + "/index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������Ϣҳ - <%= title %></TITLE>
<LINK href="<%= ctxPath %>/styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<body onkeydown="if(event.keyCode==27) return false;">
<script src="<%= ctxPath %>/js/common.js" type="text/javascript"></script>
<div class="wrap">
<div id="header">
<%= PageUtils.getHeader(request, title) %>
</div>
<%= menus[0] %>
<div id="nav"><A href="<%= homeUrl %>"><%= forumName %></A> &raquo; ��ʾ��Ϣ</div>
	<div class="box message">
		<h1><%= forumName %>&nbsp;-&nbsp;������ʾ��Ϣ</h1>
<%
		String alertError = (String)request.getAttribute("alertError");
		if (alertError != null)
		{
%>
<script type="text/javascript">
	alert('<%= errorMsg %>');
	history.back();
</script>
<%
		}
%>
		<p align="center"><%= errorMsg %></p>
		<p align="center"><a href="javascript:history.back()">[&nbsp;������ﷵ����һҳ&nbsp;]</a></p>
	</div>
	<p>&nbsp;</p>
</div>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request, forumStyle) %>
</body></html>