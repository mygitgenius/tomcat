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
			<A href="./index.jsp">����</A> &raquo;&nbsp; �û���֪</DIV>
<table cellpadding="0" cellspacing="0" class="helpbox">
<tr><td valign="top" width="30%">
	<h1 id="faq01">�ұ���Ҫע����</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">�����ֻ�������̳��һ�㲻��Ҫע�ᣬ��ȡ���ڹ���Ա���������̳���û���Ȩ�ޣ���Щ˽�а����ܱ�����ע�����ʽ�û������������
	<br/>�����Ҫ�������ͻظ��������ӣ�һ����Ҫע�ᣬ�����Ҫ���Լ��������ӽ��й��������ע���Ϊ��Ա��
	<br/>ǿ�ҽ�����ע�ᣬ������õ��ܶ����ο�����޷�ʵ�ֵĹ��ܡ�
	</li></ul>
	<h1 id="faq02">ע�������ʲô��Ȩ��</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
		ע���Ļ�Ա���������ɹ���Ա�趨�ķ�����Ȩ���⣬���������ӹ�������վ�ڶ���Ϣ�������ղؼС���û��ֵȹ��ܡ�
	<br/>���⣬���Ż��ֵ����������Ļ�Ա��ȼ�����Ӧ�������Ӷ���ø���Ĳ���Ȩ�ޡ�����Ȩ����鿴���ҵĿռ䡱�µġ��ҵ�Ȩ�ޡ��б�
	</li></ul>
	<h1 id="faq03">��¼��Ч����ʲô���壿</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">	�û���¼ʱ����ѡ��ͬ�ĵ�¼��Ч�ڣ����С���������̡���ָ����������ִ򿪵�����£��������ʱ�䲻����Լ30���ӣ���¼״̬��һֱ��Ч����������رգ����´α������µ�¼�����⣬������ѡ���ָ��ͬһ̨�����ϣ�����������������ָ����ʱ�����û������ٴ������û�������Ϳ���ֱ�ӵ�¼��<br/>������������ɵȹ�������������������ѡ���¼��Ч��Ϊ����������̡����������ѡ������ѡ�
	</li></ul>
	<h1 id="faq04">�����ʹ�ø��Ի�ͷ��</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">	�ڵ�¼�󵼺����ϡ��ҵĿռ䡱�µġ��༭�������ϡ�-�����Ի����ϡ�����һ����ͷ�񡱵�ѡ�����ʹ����̳�Դ���ͷ������Զ����ͷ����ҪȨ����ɣ���
	</li></ul>
	<h1 id="faq05">�����ʹ�ö���Ϣ���ܣ�</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
		����Ϣ����̳�ϵ�ע���û�֮�估����Ա�ͻ�Ա֮�����ͨ�ŵ�һ�ַ�ʽ����¼����������ϵĶ���Ϣ��ť�����ɽ������Ϣ����
	<br/>�����ڵ����ʼ�������Ϣ���ռ���ͷ����䣬�Լ��ظ���ת���ȹ��ܡ����Ͷ���Ϣʱ��ʹ���û����������ǳơ�
	<br/>����Ϣ�ռ�����һ�����������ƣ�������������ʱϵͳ�����Զ�ɾ������ļ�¼��
	</li></ul>
	<h1 id="faq06">�����ʹ���ղؼй��ܣ�</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
		�ڵ�¼�󵼺����ϡ��ҵĿռ䡱�µġ��ҵ��ղء�����һ�������ղؼУ����ղؼв��������ղر���̳�µ��������ӣ�Ҳ�����ղ��κ� Internet ��ַ��
	<br/>����̳ÿһ������ҳ�����Ͻ���һ�����ղء���ť������˰�ť����ֱ�ӽ���������ӵ������ղؼ��С�
	</li></ul>
	<h1 id="faq07">�����������̳���ѣ�</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
		�ڵ�¼�󵼺����ϡ��ҵĿռ䡱�µġ��ҵĺ��ѡ�����һ�����������б����ڼ�¼���ĺ�����Ϣ��
	<br/>����̳ÿһ��������ߵ�������Ϣ�����������Ϊ���ѡ�����ֱ�ӽ���������ӵ����ĺ����б��С�
	</li></ul>
	</td>
</tr>
</table>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
