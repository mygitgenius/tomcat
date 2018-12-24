<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.util.AppUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;

	String strPageNo = request.getParameter("page");
    int pageNo = PageUtils.getPageNo(strPageNo);
	
	Object[] result = TopicDAO.getInstance().queryTopic(request, pageNo);
	int totalCount = 0;
	
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
            href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;�����������</TD></TR></TBODY></TABLE><BR>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD>
            <DIV style="FLOAT: left; MARGIN-LEFT: 0px; PADDING-TOP: 8px"><A 
            onclick="collapse_change('tip','../images')" href="#">������ʾ</A></DIV>
            <DIV style="FLOAT: right; PADDING-BOTTOM: 9px; MARGIN-RIGHT: 4px"><A 
            onclick="collapse_change('tip','../images')" href="#">
			<IMG id=menuimg_tip src="../images/menu_reduce.gif" border=0></A></DIV></TD></TR>
        <TBODY id=menu_tip>
        <TR>
          <TD>
            <UL>
              <LI>��¼�����϶�ʱ���ܻ�ȽϺ�ʱ�����Էִδ���</LI>
		    </UL></TD></TR></TBODY></TABLE><BR>
      <FORM id="settings" name="settings" action="../perform.jsp" method=post>
	  <input type="hidden" name="page" value="<%= pageNo %>">
	  <%= PageUtils.getQueryFields(request) %>
<%
	if (result != null && result[0] != null)
	{
		totalCount = ((Integer)result[2]).intValue();
%>	  
	<%= result[0] %>
<%
	}
	if (result != null && result[1] != null)
	{
		ArrayList topicList = (ArrayList)result[1];
		HashMap record = null;
		String userID = null;
		String sectionID = null;
		String boardID = null;
		String topicID = null;
		String topicURL = null;
		String topicTitle = null;
		String tmpStr = null;
		BoardVO aBoard = null;
		StringBuilder sbuf = new StringBuilder();
		
		if (totalCount > 0) {
%>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD width="13%">���</TD>
          <TD width="30%">����</TD>
          <TD width="14%">�û���</TD>
          <TD width="9%">�ظ�</TD>
          <TD width="9%">�鿴</TD>
          <TD width="16%">����ʱ��</TD>
          <TD width="9%">״̬</TD>
		</TR>
<%
		}
		for (int i=0; i<topicList.size(); i++)
		{
			record = (HashMap)topicList.get(i);
			userID = (String)record.get("USERID");
			sectionID = (String)record.get("SECTIONID");
			boardID = (String)record.get("BOARDID");
			topicID = (String)record.get("TOPICID");
			topicTitle = (String)record.get("TITLE");
			
			sbuf.setLength(0);
			sbuf.append(" ( ");
			
			tmpStr = (String)record.get("ISDIGEST");
			if (tmpStr.equals("T"))
			{
				sbuf.append("����");
			}
			tmpStr = (String)record.get("TOPSCOPE");
			if (!tmpStr.equals("N"))
			{
				if (sbuf.length() > 3)
					sbuf.append(",");
				sbuf.append("�ö�");
			}
			tmpStr = (String)record.get("HIGHCOLOR");
			if (tmpStr != null && tmpStr.length() > 0)
			{
				if (sbuf.length() > 3)
					sbuf.append(",");
				sbuf.append("����");
			}
			tmpStr = (String)record.get("ATTACHES");
			if (tmpStr != null && !tmpStr.equals("0"))
			{
				if (sbuf.length() > 3)
					sbuf.append(",");
				sbuf.append("����");
			}

			if (sbuf.length() > 3)
			{
				sbuf.append("&nbsp;)");
				topicTitle = topicTitle + sbuf.toString();
			}
				
			sbuf.setLength(0);
			sbuf.append("../../topic.jsp?fid=").append(boardID).append("&tid=").append(topicID);
			topicURL = sbuf.toString();
										
			aBoard = cache.getBoard(sectionID, boardID);
%>	  
        <TR align=middle>
          <TD class=altbg1><A href="../../forum.jsp?sid=<%= sectionID %>&fid=<%= boardID %>" 
			                target=_blank><%= aBoard.boardName %></A></TD>
          <TD class=altbg2>
		  	<A href="<%= topicURL %>" target=_blank><%= topicTitle %></A></TD>
          <TD class=altbg1>
		  	<A href="../../uspace.jsp?uid=<%= userID %>" target=_blank><%= userID.length()==0?"�ο�":userID %></A></TD>
          <TD class=altbg2><%= (String)record.get("REPLIES") %></TD>
          <TD class=altbg1><%= (String)record.get("VISITS") %></TD>
          <TD class=altbg2><%= AppUtils.formatSQLTimeStr((String)record.get("CREATETIME")) %></TD>
          <TD class=altbg1><%= ((String)record.get("STATE")).equals("N")?"����":"�ѹر�" %></TD>
		</TR>
<%
		}
		if (totalCount > 0) {
%>
	</TBODY></TABLE>
<%
		}
	}
	if (result != null && result[0] != null)
	{
%>	  
	<%= result[0] %>
<%
	}
	if (totalCount > 0) { out.write("<BR>"); }
%>	  
    <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
		<tr class="header">
			<td colspan="2">����������������: <%= totalCount %></td>
		</tr>
		<tr>
			<td class="altbg1"><input class="radio" type="radio" name="exe_operation" checked 
				id="exe_operation[delete]" value="delete"> ����ɾ��</td>
			<td class="altbg2">
				ɾ���������û��������ͻ���</td>
		</tr>
		<tr>
			<td class="altbg1"><input class="radio" type="radio" name="exe_operation" 
				id="exe_operation[move]" value="move"> �����ƶ������</td>
			<td class="altbg2"><select name="exe_targetBoard">
		  <OPTION value="" selected>&nbsp;&nbsp;&gt; ��ѡ��</OPTION><OPTION value="">&nbsp;</OPTION>
<%
	if (sections != null) 
	{
		SectionVO aSection = null;
		BoardVO aBoard = null;
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
%>		  
		  <OPTION value="<%= aBoard.sectionID %>_<%= aBoard.boardID %>">&nbsp; &gt; <%= aBoard.boardName %></OPTION>
<%
				}
			}
%>		  
		  </OPTGROUP>
<%
		}
	}
%>
			</select></td>
		</tr>
		<tr>
			<td class="altbg1"><input class="radio" type="radio" name="exe_operation" 
				id="exe_operation[state]" value="state"> �����򿪹ر�</td>
			<td class="altbg2">
				<INPUT class=radio type=radio CHECKED value="N" name="exe_state"> ��&nbsp;&nbsp;
				<INPUT class=radio type=radio value="C" name="exe_state"> �ر�</td>
		</tr>
	</TBODY></TABLE><br/>
		<p align="center">
			<input class="button" type="button" value="�� ��" onclick="doAction();">&nbsp;&nbsp;
			<input class="button" type="button" value="ˢ ��" onclick="window.location.reload(true);">
		</p>
	</FORM>
	</TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function viewPage(pageno)
{
	$('settings').action = 'topic_list.jsp';
	$('settings').page.value = pageno;
	$('settings').submit();
}
function doAction() {
	var totalCount = <%= totalCount %>;
 	if (totalCount <= 0) 
	{
		alert('û�з��������ļ�¼');
		return;
	}
	if ($('exe_operation[delete]').checked && !confirm('��ȷ��Ҫִ������ɾ����?  '))
		return;
	if ($('exe_operation[move]').checked)
	{ 
		if (trim($('settings').exe_targetBoard.value) == '') {
			alert('��ѡ��Ŀ����');
      		$('settings').exe_targetBoard.focus();
			return;
		}
		if (!confirm('��ȷ��Ҫִ�������ƶ���?  '))
			return;
	}
	if ($('exe_operation[state]').checked && !confirm('��ȷ��Ҫִ�������򿪹ر���?  '))
		return;
	$('settings').action = '../perform.jsp?act=forums_topic_batch';
	$('settings').submit();
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
