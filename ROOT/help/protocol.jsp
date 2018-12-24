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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; 
			<A href="./index.jsp">����</A> &raquo;&nbsp; ��̳�û�����</DIV>
<table cellpadding="0" cellspacing="0" class="helpbox">
<tr><td valign="top" width="30%">
	<h1 id="faq01">��̳�û�����</h1>
	<ul style="margin: 2px auto; padding-bottom:15px">
	<li style="padding-left:2px">һ����̳��������</li>
	<li style="padding-left:12px">
		1. ���÷�������Υ���л����񹲺͹��ܷ��ͷ��ɵ����ۡ�<br/>
		2. ���÷���������ҥ���̰����������˵����ۡ�<br/>
		3. ���÷�������������ɫ�顢���ŵ����ۡ�<br/>
		4. ����й¶���һ��ܡ�<br/>
		5. ���÷�������ˮ���»�����������Ϣ��<br/>
		6. ���÷�������������޹ص����»����������Ϣ��<br/>
		7. �û��������Ʒ����������˹۵㣬���뱾վ�޹ء�<br/><br/></li>
	<li style="padding-left:2px">������̳�����취</li>
	<li style="padding-left:12px">
		1. ����Υ�����Ϲ涨�����£��ڲ���Ҫ���͵�����£������͹�����Ա��Ȩת����ɾ����ǰ���¡�<br/>
		2. ����̳��Ȩ�Բ����������ֽ��й��˴���<br/>
	    3. Υ���涨��������ߣ�������Ա��Ȩ�����û�����̳�ķ���Ȩ������ر������ߣ���վ����������IP��Ȩ����<br/> 
        4. ����Υ�����ҷ��ɡ��������Ϊ������Ϲ�����˾������׷���䷨�����Ρ�<br/><br/></li>
	<li style="padding-left:2px">������������</li>
	<li style="padding-left:12px">
	    1. δ����վ��Ȩ��ɣ��κ��˲������κ���ʽ�Ա�վ���ݸ��ơ�ת�ء�������ժ�ࡢ���桢���С���������ȡ�<br/>
        2. �û�����̳������������������Ȩ����Ʒ������ʾ����Ȩί�б�վ����������δ����վ��������ɣ��κε��������öԸ���Ʒ����ת�ء�������ժ�ࡢ���桢���Ʒ��еȡ�<br/>
        3. �û����䷢����������Ʒ�ĺϷ��Եȸ����û�������Ʒ������ֺ����˰�Ȩ���κξ��ף����뱾վ�޹ء�<br/> 
        4. ��վ��Ȩ�ڱ�Ҫʱ�޸���̳�ķ������ݣ�ͬʱ�����޸Ļ��жϷ������������֪ͨ�û���Ȩ����<br/>
        5. ����������ս���Ȩ�鱾վ���С�<br/></li>
	</ul>
	</td>
</tr>
</table>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
