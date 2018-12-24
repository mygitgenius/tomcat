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
			<A href="./index.jsp">����</A> &raquo;&nbsp; ������ز���</DIV>
<table cellpadding="0" cellspacing="0" class="helpbox">
<tr><td valign="top" width="30%">
	<h1 id="faq01">����η��������⣿</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">�ڰ�������б������ҳ���㡰��������ť�����������˵��еġ����»��⡱�򡰷������͡��������Ȩ�ޣ����ɽ��뷢���༭ҳ�档������ο�һ����Ҫ�ȵ�¼��
	</li></ul>
	<h1 id="faq02">����η���ظ���</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
�ڰ������ҳ���㡰�ظ�����ť���Զ�������лظ��������������½ǵġ��ظ��������á��Ի������лظ��������Ȩ�ޣ����ɽ��뷢���༭ҳ�档<br/>������ο�һ����Ҫ�ȵ�¼��
	</li></ul>
	<h1 id="faq03">�༭ʱ�ҿ���ʹ��&nbsp;BBCode&nbsp;������</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
	BBCode&nbsp;������һ��ר������̳��&nbsp;HTML&nbsp;���ر��﷨��ʹ�� [ and ] ����ʹ�� < and > ��ǩ�Է���༭�ͱ�֤��̳�İ�ȫ������&nbsp;BBCode&nbsp;���ն���ת��Ϊ&nbsp;HTML&nbsp;���룬����̳����Ȩ����ɵ������֧������&nbsp;BBCode&nbsp;: [img], [media], ��������¾�ֱ�Ӳ���&nbsp;HTML&nbsp;���롣<br>
	[img] �﷨: &nbsp;[img="url"]ͼƬ��������[/img]<br>
	[media] �﷨: &nbsp;[media="url"]��,��[/media]
	</li></ul>
	<h1 id="faq04">�༭ʱ�ҿ���ʹ��&nbsp;HTML&nbsp;������</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
		һ���������Ӧʹ�ÿ��ӻ��༭���༭���ӣ�ϵͳ���Զ�������Ӧ��&nbsp;HTML&nbsp;���롣�������ֶ��༭&nbsp;HTML&nbsp;���룬���绻�С�ɾ���ַ��ȣ������ܲ���Ӣ���ַ�������ʹ������&lt;script&gt;, &lt;object&gt;�ȸ��ӵı�ǣ�������ӵ��ʹ��&nbsp;HTML&nbsp;����Ȩ��HTML&nbsp;����ģʽ���Ǹ����Եı༭ģʽ���ڴ�ģʽ�¹�������ť�Ͳ��븽���Ȳ�������Ч��
	</li></ul>
	<h1 id="faq05">����������в���ͼƬ��ý�壿</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
		�����������в���������ʽ��ͼƬ��&nbsp;Flash&nbsp;�ȶ�ý����󣨿�����&nbsp;Flash Player&nbsp;��&nbsp;Windows Media Player&nbsp;���ţ�:
	<br/>1. ������վ�ϵ�ͼƬ���ý���ļ����� - &nbsp;�ڱ༭�������е������ͼƬ���ý��İ�ť��Ȼ��������ַ�Ȳ������ɡ�
	<br/>2. �û����ص�ͼƬ���ý���ļ� - &nbsp;������Ҫ���ϴ������б���ѡ�񱾵ص�ͼƬ��ý���ļ���Ȼ�������ļ����Ƴ��ֵġ��������ڡ����ӣ����ļ��ϴ����ͬʱ���������С�
	</li></ul>
	<h1 id="faq06">����ʱ���½ǵ�ѡ���ʲô���壿</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:0px">
		������BBCode���� - &nbsp;��ֹ���������е�&nbsp;BBCode&nbsp;���롣
	<br/>��ʹ���������� - &nbsp;�������б��в���ʾ�������ƣ��������߸��˿ռ�ͺ�̨�����Բ鿴����������ҪȨ����ɣ���
	<br/>�������»ظ��ʼ�֪ͨ - &nbsp;������˻ظ�����������⣬ϵͳ���Զ���������һ���ʼ�֪ͨ��
	<br/>�������ö� - &nbsp;ֱ�ӽ���Ҫ��������������ڵİ���ö�����ҪȨ����ɣ���
	</li></ul>
	<h1 id="faq07">ҳ����תʱ�༭�����ݶ�ʧ����ô�죿</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">
���ӱ༭ҳ������ת������ҳ��ʱϵͳ���Զ��������ڱ༭�������ڻ����У�ֻҪ�����û�йرգ��ص��༭ҳ��󣬵�����½ǵġ��ָ��ϴ��Զ���������ݡ����Ϳ��Դӻ������һ����ղŵı༭���ݡ�
	</li></ul>
	<h1 id="faq08">�ҿ����޸��Ѿ�������������</h1>
	<ul style="margin: 2px auto; padding-bottom:15px"><li style="padding-left:2px">���ԣ�ע���û��ڷ������Ӻ������ʱ���ڿ���ά���Լ����������ӣ������޸ġ��ƶ����������Ȳ��������Ѿ���Ϊ���������ⲻ�����޸ĺ��ƶ����Ѿ��رյ������µ����Ӿ��������޸ġ�
	</li></ul>
	</td>
</tr>
</table>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
