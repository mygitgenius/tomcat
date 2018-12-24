<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;

	CacheManager cache = CacheManager.getInstance();
    GroupVO userGroup = PageUtils.getGroupVO(userinfo, cache.getModerators());

	if (userGroup.rights.indexOf(IConstants.PERMIT_EDIT_USER) < 0)
	{
		request.setAttribute("errorMsg", "��û�б༭�û���Ȩ��");
		request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
		return;
	}

	String fromPath = PageUtils.getPathFromReferer(request);
	
	String userID = PageUtils.getParam(request,"uid");
	UserVO aUser = UserDAO.getInstance().getUserVO(userID);
	
    ArrayList groups = cache.getGroups();

	if (aUser.groupID <= '9')
	{
		String moderators = cache.getModerators();
		if (moderators.indexOf("," + aUser.userID + ",") >= 0)
			aUser.groupID = 'M';
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<LINK href="../style/admin.css" type=text/css rel=stylesheet>
<SCRIPT src="../../js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="../js/admin.js" type=text/javascript></SCRIPT>
</HEAD>
<BODY topMargin=10>
<TABLE cellSpacing=6 cellPadding=2 width="100%" border=0>
  <TBODY>
  <TR>
    <TD>
      <TABLE class=guide cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD><A onclick="parent.location='../index.htm'; return false;" 
            href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;�༭�û�</TD></TR></TBODY></TABLE><BR>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="info_tb">
		<tr class="header">
          <TD>
            <DIV style="FLOAT: left; MARGIN-LEFT: 0px; PADDING-TOP: 8px"><A 
            onclick="collapse_change('tip','../images')" href="#">������ʾ</A></DIV>
            <DIV style="FLOAT: right; PADDING-BOTTOM: 9px; MARGIN-RIGHT: 4px"><A 
            onclick="collapse_change('tip','../images')" href="#">
			<IMG id=menuimg_tip src="../images/menu_reduce.gif" border=0></A></DIV></TD></TR>
		<tbody id="menu_tip" style="display:"><tr><td>
			<ul><li>���ڰ������ԣ��˴�ֻ�ı��û��Ĺ������ɫ��������ʵ�ʷ������ΰ����û���</li>
			</ul>
		</td></tr></tbody></table><br/>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="users_user_group">
	  <INPUT type=hidden name="userID" value="<%= userID %>">
	  <INPUT type=hidden name="fromPath" value="<%= fromPath %>">
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD>���������� ( �û�:&nbsp;<%= userID %> )</TD>
          <TD>������</TD>
          <TD>�鿴</TD>
		</TR>
<%
	String checked = null;
	boolean isAdmin = false;
	if (groups != null)
	{
		GroupVO aGroup = null;
		for (int i=0; i<groups.size(); i++)
		{
			aGroup = (GroupVO)groups.get(i);
			if (aGroup.groupID == 'G') continue; // Skip Guest
			if (aGroup.groupType == 'S')
			{
				checked = "";
				if (aGroup.groupID == aUser.groupID)
				{
					checked = "checked";
					isAdmin = true;
				}
%>			
        <TR>
          <TD class=altbg1>
		  	<INPUT class=radio type=radio <%= checked %> name="groupID" value="<%= aGroup.groupID %>"> <%= aGroup.groupName %>
		  </TD>
          <TD class=altbg2>������</TD>
          <TD class=altbg1>[&nbsp;<a href="group_info.jsp?id=<%= String.valueOf(aGroup.groupID) %>">����</a>&nbsp;]</TD>
          </TR>
<%
			}
		}
	}
	if (!isAdmin)
		checked = "checked";
	else
		checked = "";	
%>			
        <TR>
          <TD class=altbg1>
		  	<INPUT class=radio type=radio <%= checked %> name="groupID" value="1"> ��ͨ��Ա</TD>
          <TD class=altbg2>��Ա��</TD>
          <TD class=altbg1>&nbsp;</TD>
        </TR>
       </TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��" name=detailsubmit>
	  		&nbsp;<INPUT class=button type=button value="������һҳ" onclick="javascript:history.go(-1);"></CENTER></FORM>
	  </TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	theform.submit();
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
