<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.BookmarkDAO"%>
<%@ page import="com.hongshee.ejforum.data.BookmarkDAO.BookmarkVO"%>
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
		BookmarkDAO.getInstance().deleteBookmarks(request);
	}
	
	String strPageNo = request.getParameter("page");
	int pageNo = PageUtils.getPageNo(strPageNo);
	int pageRows = 10;

	Object[] result = BookmarkDAO.getInstance().getBookmarks(userinfo.userID, pageNo, pageRows);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�ҵ��ղ� - <%= title %></TITLE>
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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �ҵ��ղ�</DIV>
<DIV class=container><DIV class=content>
<FORM name="myform" onSubmit="return validate(this)" action="./my_favors.jsp?mod=del" method=post>
<DIV class=mainbox style="padding-bottom:5px">
<H1>�ҵ��ղ�</H1>
<UL class="tabs headertabs">
  <LI class="additem"><A href="my_addfavor.jsp">����ղ�</A> </LI>
  <LI class="current"><A href="my_favors.jsp">�ҵ��ղؼ�</A> </LI></UL>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <THEAD>
  <TR>
    <TD class=selector>&nbsp;</TD>
    <TD>����</TD>
    <TD width="120">�������&nbsp;/&nbsp;��վ</TD>
    <TD class=time>����ʱ��</TD></TR></THEAD>
  <TBODY>
<%
	if (result != null && result[1] != null)
	{
		ArrayList markList = (ArrayList)result[1];
		BookmarkVO aMark = null;
	
		for (int i=0; i<markList.size(); i++)
		{
			aMark = (BookmarkVO)markList.get(i);
%>  
  <TR>
    <TD><INPUT class=checkbox type=checkbox value="<%= aMark.markID %>" name=markID></TD>
    <TD><A href="<%= aMark.url %>" target=_blank><%= aMark.title %></A></TD>
    <TD><%= aMark.boardName %></TD>
    <TD><%= aMark.createTime %></TD>
	</TR>
<%
		}
	}
	else
	{
%>	
  <TR>
    <TD colspan="4">û�м�¼</TD></TR>
<%
	}
%>
</TBODY></TABLE>
<DIV class="management"><LABEL><INPUT class=checkbox id=chkall onclick=checkall(this.form) 
	type=checkbox name=chkall> ȫѡ</LABEL><BUTTON name=delfavors type=submit>ɾ��</BUTTON></DIV>
</DIV></FORM>
<DIV class=pages_btns>
<%
	if (result != null && result[0] != null)
	{
%>	  
	<%= result[0] %>
<SCRIPT type=text/javascript>
var myUrl = "./my_favors.jsp?act=view";
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
		if (typeof(theform.markID) != "undefined")
		{
			if (typeof(theform.markID.length) != "undefined")
			{
				for (i=0; i<theform.markID.length; i++){
					if (theform.markID[i].checked){
						hasCheckedID = true;
						break;
					}
				}
			}
			else if (theform.markID.checked)
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
  <LI class="side_on"><H3><A href="my_favors.jsp">�ҵ��ղ�</A></H3></LI>
  <LI><H3><A href="my_friends.jsp">�ҵĺ���</A></H3></LI>
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
