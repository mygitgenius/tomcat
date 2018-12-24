<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%
	ForumSetting setting = ForumSetting.getInstance();
	String forumName = setting.getForumName();
	String title = PageUtils.getTitle(forumName);
	UserInfo userinfo = PageUtils.getSessionUser(request);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���� - <%= title %></TITLE>
<%= PageUtils.getMetas(title, null) %>
<LINK href="../styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="../js/common.js" type=text/javascript></SCRIPT>
<DIV class=wrap style="padding-bottom:5px">
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; ����</DIV>
<table cellpadding="0" cellspacing="0" class="helpbox">
<tr><td valign="top" width="30%" style="border-right:none">
	<h3>�û���֪</h3>
	<ul style="margin: 2px auto;">
		<li><a href="member.jsp#faq01">�ұ���Ҫע����</a></li>
		<li><a href="member.jsp#faq02">ע�������ʲô��Ȩ</a></li>
		<li><a href="member.jsp#faq03">��¼��Ч����ʲô����</a></li>
		<li><a href="member.jsp#faq04">�����ʹ�ø��Ի�ͷ��</a></li>
		<li><a href="member.jsp#faq05">�����ʹ�ö���Ϣ����</a></li>
		<li><a href="member.jsp#faq06">�����ʹ���ղؼй���</a></li>
		<li><a href="member.jsp#faq07">�����������̳����</a></li>
	</ul>
	</td>
	<td valign="top" width="37%" style="border-right:none">
	<h3>������ز���</h3>
	<ul style="margin: 2px auto;">				
		<li><a href="post.jsp#faq01">����η���������</a></li>
		<li><a href="post.jsp#faq02">����η���ظ�</a></li>
		<li><a href="post.jsp#faq03">�༭ʱ�ҿ���ʹ��&nbsp;BBCode&nbsp;������</a></li>
		<li><a href="post.jsp#faq04">�༭ʱ�ҿ���ʹ��&nbsp;HTML&nbsp;������</a></li>
		<li><a href="post.jsp#faq05">����������в���ͼƬ��ý��</a></li>
		<li><a href="post.jsp#faq06">����ʱ���½ǵ�ѡ���ʲô����</a></li>
		<li><a href="post.jsp#faq07">ҳ����תʱ�༭�����ݶ�ʧ����ô��</a></li>
		<li><a href="post.jsp#faq08">�ҿ����޸��Ѿ�������������</a></li>
	</ul>
	</td>
	<td valign="top" width="33%">
	<h3>�����������</h3>
	<ul style="margin: 2px auto;">			
		<li><a href="other.jsp#faq01">������л�������</a></li>
		<li><a href="other.jsp#faq02">�����ʹ��&nbsp;RSS&nbsp;����</a></li>
		<li><a href="other.jsp#faq03">�����ʹ������</a></li>
		<li><a href="other.jsp#faq04">�ҵ����������֧��&nbsp;Cookie&nbsp;��</a></li>
		<li><a href="credits_rule.jsp">��̳���ֲ�����������</a></li>
		<li><a href="protocol.jsp">��̳�û�������������</a></li>
		<li><a href="other.jsp#faq06">�һ�������������ô��</a></li>
	</ul>
	</td>
</tr>
</table>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
