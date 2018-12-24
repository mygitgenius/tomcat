<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.AppContext"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;

	CacheManager cache = CacheManager.getInstance();
    GroupVO aGroup = PageUtils.getGroupVO(userinfo, cache.getModerators());
			
	String action = PageUtils.getParam(request,"act");
	String actTitle = null;
	
	if (action.length() == 0)
		actTitle = "�༭�û�";
	else if (action.equals("credits"))
		actTitle = "���ֽ���";
	else if (action.equals("ban"))
		actTitle = "��ֹ�û�";
	else
		actTitle = "�༭�û�";
	
	UserDAO dao = UserDAO.getInstance();
	ArrayList userList = new ArrayList();
	int totalCount = UserDAO.getInstance().searchUser(request, userList);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<LINK href="../style/admin.css" type=text/css rel=stylesheet>
<SCRIPT src="../../js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="../js/admin.js" type=text/javascript></SCRIPT>
</HEAD>
<BODY leftmargin="10" topmargin="10">
<TABLE cellSpacing=6 cellPadding=2 width="100%" border=0>
  <TBODY>
  <TR>
    <TD>
      <TABLE class=guide cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD>
		  <A onclick="parent.location='../index.htm'; return false;" href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;<%= actTitle %>
			</TD></TR></TBODY></TABLE><BR>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="info_tb">
		<tr class="header">
          <TD>
            <DIV style="FLOAT: left; MARGIN-LEFT: 0px; PADDING-TOP: 8px"><A 
            onclick="collapse_change('tip','../images')" href="#">������ʾ</A></DIV>
            <DIV style="FLOAT: right; PADDING-BOTTOM: 9px; MARGIN-RIGHT: 4px"><A 
            onclick="collapse_change('tip','../images')" href="#">
			<IMG id=menuimg_tip src="../images/menu_reduce.gif" border=0></A></DIV></TD></TR>
		<tbody id="menu_tip" style="display:"><tr><td>
		<ul><li>�û�����ͬʱΪ������ͻ�Ա���û������Ա��ͷ��������ֵĶ�����������</li>
			<li>ɾ�������ֽ��͡���ֹ�û������ȫ����ѯ������ԣ�����û����ʾ�����ļ�¼��������ϵͳ����Ա����</li>
		</ul>
		</td></tr></tbody></table><br/>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="users_user_list">
	  <INPUT type=hidden name="totalCount" value="<%= totalCount %>">
	  <%= PageUtils.getQueryFields(request) %>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="info_tb">
		<tr align="left" class="header">
			<td colSpan="3" width="230">
				�����������û���:&nbsp;<%= totalCount %> ��,&nbsp;��ʾ&nbsp;<%= userList.size() %>&nbsp;��</td>
			<td colSpan="5" width="280">&nbsp;</td>
			<td width="120">&nbsp;</td>
			</tr>
		<tr align="center" class="category">
			<td style="width:50px;">
				<input type="checkbox" name="chkall" value="1" checked disabled	class="checkbox"> ȫѡ</td>
			<td width="90">�û���</td><td width="90">�ǳ�</td><td width="50">����</td>
			<td width="50">������</td><td width="60">������</td><td width="60">��Ա��</td>
			<td width="60">״̬</td><td width="120">�༭</td></tr>
<%
	UserInfo aUser = null;
	GroupVO adminGroup = null;
	GroupVO memberGroup = null;
	String moderators = cache.getModerators();
		
	for (int i=0; i<userList.size(); i++)
	{	
		aUser = (UserInfo)userList.get(i);

		adminGroup = null;
		if (aUser.groupID > '9')
			adminGroup = cache.getGroup(aUser.groupID);
		else if (moderators.indexOf("," + aUser.userID + ",") >= 0)
			adminGroup = cache.getGroup('M');
					
		memberGroup = cache.getGroup(aUser.credits);
%>			
		<tr align="center" class="smalltxt">
			<td class="altbg1">
				<input type="checkbox" name="chkUserID" value="<%= aUser.userID %>" disabled checked class="checkbox"></td>
			<td class="altbg2">
				<a href="../../uspace.jsp?uid=<%= aUser.userID %>" target="_blank"><%= aUser.userID %></a></td>
			<td class="altbg1"><%= aUser.nickname %></td>
			<td class="altbg2"><%= aUser.credits %></td>
			<td class="altbg1"><%= aUser.posts %></td>
			<td class="altbg2"><%= adminGroup==null?"&nbsp;":adminGroup.groupName %></td>
			<td class="altbg1"><%= memberGroup==null?"&nbsp;":memberGroup.groupName %></td>
			<td class="altbg2"><%= dao.getStateStr(aUser.state) %></td>
			<td class="altbg1">
				[&nbsp;<a href="user_group.jsp?uid=<%= aUser.userID %>">������</a>&nbsp;]
				[&nbsp;<a href="user_forums.jsp?uid=<%= aUser.userID %>">���</a>&nbsp;]
			</td></tr>
<%
	}	
%>				
		</table><br/>
		<center>
		<%
			if (action.length() == 0) {
				String disabled = null;
				if (aGroup.rights.indexOf(IConstants.PERMIT_DELETE_USER) < 0)
					disabled = " disabled=true";
				else
					disabled = "";
		%>
		<input class="button" type="submit" value="ɾ���û�" 
				onclick="$('settings').action='./user_delete.jsp';"<%= disabled %>>&nbsp;
		<%
				if (aGroup.rights.indexOf(IConstants.PERMIT_EDIT_USER) < 0)
					disabled = " disabled=true";
				else
					disabled = "";
		%>
		<input class="button" type="submit" value="ɾ��ͷ��" 
				onclick="$('settings').action='./user_noavatar.jsp';"<%= disabled %>>&nbsp;
		<%
			} else if (action.equals("credits")) {
		%>
		<input class="button" type="submit" value="���ֽ���" onclick="$('settings').action='./user_credits.jsp';">&nbsp;
		<%
			} else if (action.equals("ban")) {
		%>
		<input class="button" type="submit" value="��ֹ�û�" onclick="$('settings').action='./user_ban.jsp';">&nbsp;
		<%
			}
		%>
		<input class="button" type="button" value="ˢ ��" onclick="window.location.reload(true);">
		</center>
</form></td></tr></table><br/><br/>
<script language="javascript">
function checkfields(theform) 
{
	if (theform.totalCount.value <= 0) {
		alert('û�з����������û���¼');
		return;
	}
	theform.submit();
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>