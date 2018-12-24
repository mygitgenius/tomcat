<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.FriendDAO"%>
<%@ page import="com.hongshee.ejforum.data.FriendDAO.FriendVO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	String mod = request.getParameter("mod");
	if (mod != null && mod.equals("del"))
	{
		FriendDAO.getInstance().deleteFriends(request, userinfo);
	}
	
	String strPageNo = request.getParameter("page");
	int pageNo = PageUtils.getPageNo(strPageNo);
	int pageRows = 10;

	Object[] result = FriendDAO.getInstance().getFriends(userinfo.userID, pageNo, pageRows);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�ҵĺ��� - <%= title %></TITLE>
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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �ҵĺ���</DIV>
<DIV class=container><DIV class=content>
<FORM name="myform" onSubmit="return validate(this)" action="./my_friends.jsp?mod=del" method=post>
<DIV class=mainbox style="padding-bottom:5px">
<H1>�ҵĺ���</H1>
<UL class="tabs headertabs">
  <LI class="additem"><A href="my_addfriend.jsp">��Ӻ���</A> </LI>
  <LI class="current"><A href="my_friends.jsp">�ҵĺ���</A> </LI></UL>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <THEAD>
  <TR>
    <TD class=selector>&nbsp;</TD>
    <TD>�û���</TD>
    <TD width="120">�ǳ�</TD>
    <TD width="120">��ע</TD>
    <TD class=time>����ʱ��</TD></TR></THEAD>
  <TBODY>
<%
	if (result != null && result[1] != null)
	{
		ArrayList friendList = (ArrayList)result[1];
		FriendVO aFriend = null;
	
		for (int i=0; i<friendList.size(); i++)
		{
			aFriend = (FriendVO)friendList.get(i);
%>  
  <TR>
    <TD><INPUT class=checkbox type=checkbox value="<%= aFriend.friendID %>" name=friendID></TD>
    <TD><A href="../uspace.jsp?uid=<%= aFriend.friendID %>" target=_blank><%= aFriend.friendID %></A></TD>
    <TD><%= aFriend.nickname %></TD>
    <TD><%= aFriend.remark %></TD>
    <TD><%= aFriend.createTime %></TD>
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
</TBODY></TABLE>
<DIV class="management"><LABEL><INPUT class=checkbox id=chkall onclick=checkall(this.form) 
	type=checkbox name=chkall> ȫѡ</LABEL><BUTTON name=delfriends type=submit>ɾ��</BUTTON></DIV>
</DIV></FORM>
<DIV class=pages_btns>
<%
	if (result != null && result[0] != null)
	{
%>	  
	<%= result[0] %>
<SCRIPT type=text/javascript>
var myUrl = "./my_friends.jsp?act=view";
function viewPage(pageno)
{
	window.location = myUrl + "&page=" + pageno;
}
</SCRIPT>
<%
	}
%>
</DIV>
<SCRIPT type=text/javascript>
	function validate(theform) 
	{
		var hasCheckedID = false;
		if (typeof(theform.friendID) != "undefined")
		{
			if (typeof(theform.friendID.length) != "undefined")
			{
				for (i=0; i<theform.friendID.length; i++){
					if (theform.friendID[i].checked){
						hasCheckedID = true;
						break;
					}
				}
			}
			else if (theform.friendID.checked)
				hasCheckedID = true;
		}
		if (!hasCheckedID){
			alert("������ѡ��һ����¼");
			return false;
		}
		theform.submit();
	}
</SCRIPT>
</DIV>
<DIV class=side>
<DIV>
<H2>�ҵĿռ�</H2>
<UL>
  <LI><H3><A href="../uspace.jsp?uid=<%= userinfo.userID %>" target="_blank">������Ϣҳ</A></H3></LI>
  <LI><H3><A href="my_profile.jsp">�༭��������</A></H3></LI>
  <LI><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
  <LI><H3><A href="my_topics.jsp">�ҵĻ���</A></H3></LI>
  <LI><H3><A href="my_favors.jsp">�ҵ��ղ�</A></H3></LI>
  <LI class="side_on"><H3><A href="my_friends.jsp">�ҵĺ���</A></H3></LI>
  <LI><H3><A href="my_rights.jsp">�ҵ�Ȩ��</A></H3></LI>
  <LI><H3><A href="my_credits.jsp">���ֽ��׼�¼</A></H3></LI>
</UL>
</DIV>
<DIV>
<H2>���ָſ�</H2>
<UL class="credits">
  <LI>����: <%= userinfo.credits %></LI>
  <LI>����: <%= userinfo.posts %></LI>
</UL></DIV></DIV></DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
