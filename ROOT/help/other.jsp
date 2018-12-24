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
			<A href="./index.jsp">����</A> &raquo;&nbsp; �����������</DIV>
<table cellpadding="0" cellspacing="0" class="helpbox">
<tr><td valign="top" width="30%">
	<h1 id="faq01">������л�������</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">�����̳������ɣ�����̳ҳ��ĵײ��ұߣ���һ���������񡱲˵��������߿��Ը����Լ���ϲ��������̳�Ľ����񣬴����û�һֱ�������������&nbsp;Cookie&nbsp;�С�
	<br/>���ĳ������Ѿ��ں�̨�趨�����ض��Ľ��������Դ˷��Ϊ׼��
	</li></ul>
	<h1 id="faq02">�����ʹ��&nbsp;RSS&nbsp;���ģ�</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
	RSS&nbsp;��һ�ֶԲ�ͬ��Դ����Ϣ���оۺ��Լ���������ļ������ڵ������ϵ����RSS ���ġ�����̳��&nbsp;RSS&nbsp;Ƶ���б�����̳�ṩ�����ֶ��ķ�ʽ��
	<br/>������ʽ - &nbsp;ÿ����Ϣֻ������̳����ı��⡢���ߡ�����ʱ�����Ϣ��
	<br/>��ȫ��ʽ - &nbsp;�����������⣬ÿ����Ϣ�л�������̳�����ȫ�ģ�ͨ��ʹ�ú��ʵ������Ķ����������Ը����ٵ��������̳���⡣
	<br/><br/>���⣬�����ʹ�������Ķ���������ά�����IE7���ڴ���̳��ҳ�Ͱ��ʱ���乤�����е�Ƶ��Դ��ť���ɻ� <img src="../images/rss2.gif" align="absmiddle"> ���� <img src="../images/rss1.gif" align="absmiddle"> ��ͨ���˰�ť�������˵�����ʵ��&nbsp;RSS&nbsp;���ġ�
	</li></ul>
	<h1 id="faq03">�����ʹ��������</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">	
	һ������£�������ͨ����̳ҳ���ϵ�&nbsp;Google&nbsp;������Ա���̳����������
	<br/>���&nbsp;Google&nbsp;����������������Ҫ�������Ե������������ġ�����������߼�����ҳ�棬������ʵ������������Ϳ��Լ���������Ȩ�޷��ʵ�������ӡ�
	</li></ul>
	<h1 id="faq04">�ҵ����������֧��&nbsp;Cookie&nbsp;��</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
	�ǵġ���������������֧��&nbsp;Cookie&nbsp;������ֻ�������������Ч�ص�¼���ܶ๦��Ҳ��ʧЧ��
	</li></ul>
	<h1 id="faq05">��̳���ֲ����������ģ�</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
	��̳�Ļ�Ծ�û����û��ֹ���������Խ��Ļ�Ա�û�һ������и������̳Ȩ�ޣ�������������-><a href="credits_rule.jsp">���ֲ���˵��</a>��
	</li></ul>
	<h1 id="faq06">�һ�������������ô�죿</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:0px">
	����������κΰ����в��ܽ������⣬��ʹ��ҳ�ŵ���ϵ������������ϵ��Ҳ����ͨ����ͳ�ơ��˵��µġ������Ŷӡ��е��û����Ϸ��Ͷ���Ϣ�����ǡ�
	</li></ul>
	</td>
</tr>
</table>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
