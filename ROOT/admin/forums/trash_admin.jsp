<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;

	CacheManager cache = CacheManager.getInstance();
    ArrayList sections = cache.getSections();
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
          <TD><A onclick="parent.location='../index.htm';return false;" 
            href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;���ӻ���վ</TD></TR></TBODY></TABLE><BR>
      <FORM id="frmsearch" name="frmsearch" onSubmit="checkfields(this); return false;" action="./trash_list.jsp" method=post>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�������������ı�ɾ����</TD></TR>
        <TR>
          <TD class=altbg1 width="45%">��������:</TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="topic" name="trashType" id="trash_topic" checked> ���� &nbsp;
			<INPUT class=radio type=radio value="reply" name="trashType" id="trash_reply"> ����</TD></TR>
        <TR>
          <TD class=altbg1 width="45%">���ڰ��:</TD>
          <TD class=altbg2 align=right>
		  	<SELECT name="boardID">
<%
	if (userinfo.groupID == 'A') {
%>			
			<OPTION value=all selected>&nbsp; &gt; ȫ��</OPTION>
			<OPTION value="">&nbsp;</OPTION>
<%
	}
	if (sections != null) 
	{
		SectionVO aSection = null;
		BoardVO aBoard = null;
		String moderators = null;
		
		for (int i=0; i<sections.size(); i++)	
		{
			aSection = (SectionVO)sections.get(i);
%>			
		  <OPTGROUP label="<%= aSection.sectionName %>">
<%
			if (aSection.boardList != null && aSection.boardList.size() > 0)
			{
				for (int j=0; j<aSection.boardList.size(); j++)
				{
					aBoard = (BoardVO)aSection.boardList.get(j);
					if (userinfo.groupID != 'A') 
					{
						moderators = PageUtils.getModerators(aSection, aBoard);
			           	if (moderators.indexOf("," + userinfo.userID.toLowerCase() + ",") < 0)
							continue;
					}
%>		  
		  <OPTION value="<%= aBoard.boardID %>">&nbsp; &gt; <%= aBoard.boardName %></OPTION>
<%
				}
			}
%>		  
		  </OPTGROUP>
<%
		}
	}
%>
			</SELECT></TD></TR>
        <TR>
          <TD class=altbg1>����ؼ���:</TD>
          <TD class=altbg2 align=right><INPUT size=40 name="topicTitle"></TD></TR>
        <TR>
          <TD class=altbg1>ԭ���û���(��ʹ��ͨ��� *):</TD>
          <TD class=altbg2 align=right><INPUT size=40 name="userID"></TD></TR>
        <TR>
          <TD class=altbg1>ɾ���û���(��ʹ��ͨ��� *):</TD>
          <TD class=altbg2 align=right><INPUT size=40 name="deleteUser"></TD></TR>
        <TR>
          <TD class=altbg1>��ɾ���ڶ�������ǰ:</TD>
          <TD class=altbg2 align=right><INPUT size=40 name="days"></TD></TR>
		</TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��" name=searchsubmit></CENTER></FORM><BR>
	</TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
    var filter = /^\d+$/;
	var tmpStr = trim(theform.days.value);
    if (tmpStr != '' && !filter.test(tmpStr)) {
    	alert('��������Ϊ����');
      	theform.days.focus();
		return;
    }
	theform.submit();
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
