<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.ShortMsgDAO"%>
<%@ page import="com.hongshee.ejforum.data.ShortMsgDAO.ShortMsgVO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	int maxShortMsgs = ForumSetting.getInstance().getInt(ForumSetting.MISC, "maxShortMsgs");
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	String act = request.getParameter("act");
	if (act == null || act.length() == 0)
		act = "inbox";

	String mod = request.getParameter("mod");
	if (mod != null && mod.equals("del"))
	{
		ShortMsgDAO.getInstance().deleteShortMsgs(request, userinfo, act);
	}
	
	String strPageNo = request.getParameter("page");
	int pageNo = PageUtils.getPageNo(strPageNo);
	int pageRows = 10;

	Object[] result = ShortMsgDAO.getInstance().getShortMsgs(userinfo.userID, act, pageNo, pageRows);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>����Ϣ - <%= title %></TITLE>
<%= PageUtils.getMetas(title, null) %>
<LINK href="../styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="../js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="../js/ajax.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; ����Ϣ</DIV>
<DIV class=container><DIV class=content>
<FORM name="smsform" onSubmit="return validate(this)" action="./sms_list.jsp?act=<%= act %>&mod=del" method=post>
<DIV class=mainbox style="padding-bottom:5px">
<H1>����Ϣ</H1>
<UL class="tabs headertabs">
  <LI class=additem><A href="sms_compose.jsp">���Ͷ���Ϣ</A> </LI>
  <LI<%= act.equals("inbox")?" class=current":"" %>>
  	<A href="sms_list.jsp?act=inbox">�ռ��� (<SPAN id=sms_unread><%= userinfo.unreadSMs %></SPAN>)</A></LI>
  <LI<%= act.equals("outbox")?" class=current":"" %>><A href="sms_list.jsp?act=outbox">�ѷ���</A> </LI>
</UL>
<TABLE id=smslist cellSpacing=0 cellPadding=0 style="table-layout: fixed">
  <THEAD>
  <TR>
    <TD class=selector>&nbsp;</TD>
    <TH>����</TH>
    <TD class=user><%= act.equals("inbox")?"����":"���͵�" %></TD>
    <TD class=time>ʱ��</TD>
    <TD width="100">����</TD></TR></THEAD>
  <TBODY>
<%
	if (result != null && result[1] != null)
	{
		ArrayList msgList = (ArrayList)result[1];
		ShortMsgVO aMsg = null;
		String spaceUrl = null;
		String nickname = null;
		StringBuilder sbuf = new StringBuilder();
		
		if (act.equals("inbox")) 
		{
			for (int i=0; i<msgList.size(); i++)
			{
				aMsg = (ShortMsgVO)msgList.get(i);
				nickname = (aMsg.nickname==null || aMsg.nickname.length()==0) ? aMsg.fromUser : aMsg.nickname;

				sbuf.setLength(0);
				sbuf.append("../uspace.jsp?uid=").append(aMsg.fromUser);
				spaceUrl = sbuf.toString();
%>  
  <TR>
    <TD class=selector>
		<INPUT type=checkbox value="<%= aMsg.msgID %>" name=msgID></TD>
    <TD<%= aMsg.state=='N'?" style='FONT-WEIGHT:bold'":"" %> height="22"><A id="sms_<%= aMsg.msgID %>" 
		onclick="showsms(event, this, '<%= aMsg.msgID %>')" href="#"><%= aMsg.title %></A></TD>
    <TD><A href="<%= spaceUrl %>" target="_blank"><%= nickname %></A></TD>
    <TD><%= aMsg.createTime %></TD>
    <TD>[&nbsp;<a href="sms_compose.jsp?mid=<%= aMsg.msgID %>&act=reply">�ظ�</a>&nbsp;] 
		[&nbsp;<a href="sms_compose.jsp?mid=<%= aMsg.msgID %>&act=forward">ת��</a>&nbsp;]</TD></TR>
<%
			}
		}
		else
		{
			for (int i=0; i<msgList.size(); i++)
			{
				aMsg = (ShortMsgVO)msgList.get(i);
				nickname = (aMsg.nickname==null || aMsg.nickname.length()==0) ? aMsg.userID : aMsg.nickname;

				sbuf.setLength(0);
				sbuf.append("../uspace.jsp?uid=").append(aMsg.userID);
				spaceUrl = sbuf.toString();
%>  
  <TR>
    <TD class=selector><INPUT type=checkbox value="<%= aMsg.msgID %>" name=msgID></TD>
    <TD<%= aMsg.state=='N'?" style='FONT-WEIGHT:bold'":"" %> height="22"><A id="sms_<%= aMsg.msgID %>" 
		   onclick="showsms(event, this, '<%= aMsg.msgID %>')" href="#"><%= aMsg.title %></A></TD>
    <TD><A href="<%= spaceUrl %>" target="_blank"><%= nickname %></A></TD>
    <TD><%= aMsg.createTime %></TD>
    <TD>[&nbsp;<a href="sms_compose.jsp?mid=<%= aMsg.msgID %>&act=forward">ת��</a>&nbsp;]</TD></TR>
<%
			}
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
</TBODY></TABLE>
<DIV class="management"><LABEL><INPUT class=checkbox id=chkall onclick=checkall(this.form) 
	type=checkbox name=chkall> ȫѡ</LABEL><BUTTON name=smssend type=submit>ɾ��</BUTTON></DIV>
</DIV></FORM>
<DIV class=pages_btns>
<%
	if (result != null && result[0] != null)
	{
%>	  
	<%= result[0] %>
<SCRIPT type=text/javascript>
var myUrl = "./sms_list.jsp?act=<%= act %>";
function viewPage(pageno)
{
	window.location = myUrl + "&page=" + pageno;
}
</SCRIPT>
<%
	}
%>
</DIV>
<DIV class=remark><img src="../images/notice.gif" border="0" align="absmiddle"/> &nbsp;�ռ����������: <%= maxShortMsgs %></DIV>
<SCRIPT type=text/javascript>
	var lastdiv_id = '';
	var isinbox = <%= act.equals("inbox")?"true":"false" %>;
	
	function validate(theform) 
	{
		var hasCheckedID = false;
		if (typeof(theform.msgID) != "undefined")
		{		
			if (typeof(theform.msgID.length) != "undefined")
			{
				for (i=0; i<theform.msgID.length; i++){
					if (theform.msgID[i].checked){
						hasCheckedID = true;
						break;
					}
				}
			}
			else if (theform.msgID.checked)
				hasCheckedID = true;
		}
		if (!hasCheckedID){
			alert("������ѡ��һ����Ϣ");
			return false;
		}
		theform.submit();
	}
	
	function changestatus(obj) 
	{
		 if(obj.parentNode.style.fontWeight == "bold") {
			obj.parentNode.style.fontWeight = "normal";
			var unreads = parseInt($('sms_unread').innerHTML);
			if (unreads > 0)
			 	$('sms_unread').innerHTML = unreads - 1;
		}
	}
	
	function showsms(event, obj, msgid) 
	{
		var url = '../ajax?act=';
		if (isinbox)
			url = url + 'smsinbox';
		else	
			url = url + 'smsoutbox';
		url = url + '&id=' + msgid;
		
		var msgdiv_id = 'msg_' + msgid + '_div';
		
		if(!$(msgdiv_id)) {
			var x = new Ajax();
			x.get(url, function(s) {
				var table1 = obj.parentNode.parentNode.parentNode.parentNode;
				var row1 = table1.insertRow(obj.parentNode.parentNode.rowIndex + 1);
				row1.id = msgdiv_id;
				row1.className = 'row';
				
				var cell1 = row1.insertCell(0);
				cell1.innerHTML = '&nbsp;';
				cell1.className = 'selector';
				
				var cell2 = row1.insertCell(1);
				cell2.colSpan = '4';
				cell2.innerHTML = s.replace(/\r?\n/g, '<br/>');
				cell2.className = 'smsmessage';

				if(lastdiv_id) {
					$(lastdiv_id).style.display = 'none';
				}
				if (isinbox)
					changestatus(obj);
				lastdiv_id = msgdiv_id;
			})
		} else {
			if($(msgdiv_id).style.display == 'none') {
				$(msgdiv_id).style.display = '';
				if (isinbox)
					changestatus(obj);
				if(lastdiv_id) {
					$(lastdiv_id).style.display = 'none';
				}
				lastdiv_id = msgdiv_id;
			} else {
				$(msgdiv_id).style.display = 'none';
				lastdiv_id = '';
			}
		}
		cancel(event);
	}
</SCRIPT>
</DIV>
<DIV class=side>
<DIV>
<H2>�ҵĿռ�</H2>
<UL>
  <LI><H3><A href="../uspace.jsp?uid=<%= userinfo.userID %>" target="_blank">������Ϣҳ</A></H3></LI>
  <LI><H3><A href="my_profile.jsp">�༭��������</A></H3></LI>
  <LI class="side_on"><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
  <LI><H3><A href="my_topics.jsp">�ҵĻ���</A></H3></LI>
  <LI><H3><A href="my_favors.jsp">�ҵ��ղ�</A></H3></LI>
  <LI><H3><A href="my_friends.jsp">�ҵĺ���</A></H3></LI>
  <LI><H3><A href="my_rights.jsp">�ҵ�Ȩ��</A></H3></LI>
  <LI><H3><A href="my_credits.jsp">���ֽ��׼�¼</A></H3></LI>
</UL>
</DIV>
<DIV class=credits_info>
<H2>���ָſ�</H2>
<UL class="credits">
  <LI>����: <%= userinfo.credits %></LI>
  <LI>����: <%= userinfo.posts %></LI>
</UL></DIV></DIV></DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
