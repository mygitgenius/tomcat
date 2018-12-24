<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	String fromPath = request.getContextPath() + "/admin/forums/forum_edit.jsp";
	
	String sectionID = request.getParameter("sid");
	String boardID = request.getParameter("fid");
	String objName = null;
	String parentModerator = null;
	String moderator = null;
	CacheManager cache = CacheManager.getInstance();
	SectionVO aSection = cache.getSection(sectionID);
	if (boardID == null || boardID.trim().length() == 0)
	{
		boardID = "";
		parentModerator = "";
		moderator = aSection.moderator;
		objName = aSection.sectionName;
	}
	else
	{
		BoardVO aBoard = cache.getBoard(sectionID, boardID);
		objName = aBoard.boardName;
		parentModerator = aSection.moderator;
		moderator = aBoard.moderator;
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
          <TD>
		  <A onclick="parent.location='../index.htm'; return false;" href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;�༭����
		  </TD></TR></TBODY></TABLE><BR>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="forums_forum_moderator">
	  <INPUT type=hidden name="sid" value="<%= sectionID %>">
	  <INPUT type=hidden name="fid" value="<%= boardID %>">
	  <INPUT type=hidden name="fromPath" value="<%= fromPath %>">
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�༭����&nbsp;-&nbsp;<%= objName %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>���ϼ������̳еİ���:</B><BR><SPAN 
            class=smalltxt>�����ϼ��ķ�����˵����ֵΪ��</SPAN></TD>
          <TD class=altbg2><%= parentModerator==null?"":parentModerator %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�������������:</B><BR><SPAN 
            class=smalltxt>����������İ����������������֮���Զ���","�ָ�</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value="<%= moderator==null?"":moderator %>" name="moderator"> </TD></TR>
		</TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM></TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	theform.submit();
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
