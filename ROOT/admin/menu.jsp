<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD>
<TITLE>EasyJForum ��̨����</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<LINK id=css href="style/admin.css" type=text/css rel=stylesheet>
<SCRIPT src="../js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/admin.js" type=text/javascript></SCRIPT>
</HEAD>
<BODY style="MARGIN: 5px">
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>
      <DIV align=center><A href="../index.jsp" target=_blank>��̳��ҳ</A>&nbsp;&nbsp;<A 
      onclick="parent.location='./index.htm'; return false;" href="#">��̨��ҳ</A></DIV></TD></TR></TBODY></TABLE>
<% if (userinfo.groupID == 'A') { %>
<DIV id=basic style="DISPLAY: none">
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;��̳ѡ��</TD></TR>
  <TBODY id=menu_1>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="basic/baseinfo.jsp" target=main>��������</A></TD></TR>
        <TR>
          <TD><A href="basic/access.jsp" target=main>ע������ʿ���</A></TD></TR>
        <TR>
          <TD><A 
            href="basic/display.jsp" 
            target=main>��������ʾ��ʽ</A></TD></TR>
        <TR>
          <TD><A 
            href="basic/seo.jsp" 
            target=main>���������Ż�</A></TD></TR>
        <TR>
          <TD><A 
            href="basic/functions.jsp" 
            target=main>��̳����</A></TD></TR>
        <TR>
          <TD><A 
            href="basic/credit_rule.jsp" 
            target=main>���ֲ���</A></TD></TR>
        <TR>
          <TD><A 
            href="basic/censor.jsp" 
            target=main>�������</A></TD></TR>
		</TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;��̳����</TD></TR>
  <TBODY id=menu_2>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="basic/ui_styles.jsp" target=main>������</A></TD></TR>
        <TR>
          <TD><A href="basic/config.jsp" target=main>���в���</A></TD></TR>
	</TBODY></TABLE></TD></TR></TBODY></TABLE>			
</DIV>
<% } %>
<DIV id=forums>
<% if (userinfo.groupID == 'A') { %>
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;�������</TD></TR>
  <TBODY id=menu_3>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="forums/forum_edit.jsp" 
            target=main>�༭���</A></TD></TR>
        <TR>
          <TD><A href="forums/forum_add.jsp" 
            target=main>��Ӱ��</A></TD></TR>
        <TR>
          <TD><A href="forums/forum_merge.jsp" 
            target=main>�ϲ����</A></TD></TR>
		</TBODY></TABLE></TD></TR></TBODY></TABLE>
<% } %>		
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;��̳ά��</TD></TR>
  <TBODY id=menu_4>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="forums/log_report.jsp" 
            target=main>�û��ٱ���¼</A></TD></TR>
        <TR>
          <TD><A href="forums/log_censor.jsp" 
            target=main>������˼�¼</A></TD></TR>
<% if (userinfo.groupID == 'A') { %>
        <TR>
          <TD><A href="forums/topic_admin.jsp" 
            target=main>�����������</A></TD></TR>
        <TR>
          <TD><A href="forums/post_delete.jsp" 
            target=main>����ɾ��</A></TD></TR>
<% } %>		
        <TR>
          <TD><A href="forums/attach_query.jsp" 
            target=main>������ѯ</A></TD></TR>
        <TR>
          <TD><A href="forums/trash_admin.jsp" 
            target=main>���ӻ���վ</A></TD></TR>
        </TBODY></TABLE></TD></TR></TBODY></TABLE></DIV>		
<DIV id=users style="DISPLAY: none">
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;�û�����</TD></TR>
  <TBODY id=menu_5>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="users/user_edit.jsp" 
            target=main>�༭�û�</A></TD></TR>
        <TR>
          <TD><A href="users/user_edit.jsp?act=ban" 
            target=main>��ֹ�û�</A></TD></TR>
        <TR>
          <TD><A href="users/user_edit.jsp?act=credits" 
            target=main>���ֽ���</A></TD></TR>
        <TR>
          <TD><A href="users/user_audit.jsp" 
            target=main>������û�</A></TD></TR>
		</TBODY></TABLE></TD></TR></TBODY></TABLE>
<% if (userinfo.groupID == 'A') { %>
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;�û������</TD></TR>
  <TBODY id=menu_6>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="users/group_system.jsp" 
            target=main>ϵͳ�û���</A></TD></TR>
        <TR>
          <TD><A href="users/group_member.jsp" 
            target=main>��Ա�û���</A></TD></TR>
		</TBODY></TABLE></TD></TR></TBODY></TABLE>
<% } %></DIV>
<% if (userinfo.groupID == 'A') { %>
<DIV id=tools style="DISPLAY: none">
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;ϵͳ����</TD></TR>
  <TBODY id=menu_7>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="tools/send_notice.jsp" 
            target=main>��̳֪ͨ</A></TD></TR>
        <TR>
          <TD><A href="tools/manage_data.jsp" 
            target=main>����ά��</A></TD></TR>
        <TR>
          <TD><A href="tools/timer_task.jsp" 
            target=main>�ƻ�����</A></TD></TR>
        <TR>
          <TD><A href="tools/backup_data.jsp" 
            target=main>���ݱ���</A></TD></TR>
		</TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE class=leftmenu_tb style="MARGIN-BOTTOM: 5px" cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>&nbsp;&nbsp;���м�¼</TD></TR>
  <TBODY id=menu_8>
  <TR>
    <TD>
      <TABLE class=leftmenu_items cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD><A href="tools/log_moderator.jsp" 
            target=main>���������¼</A></TD></TR>
        <TR>
          <TD><A href="tools/log_credits.jsp" 
            target=main>���ֽ��׼�¼</A></TD></TR>
        <TR>
          <TD><A href="tools/log_admin_action.jsp" 
            target=main>��̨�����¼</A></TD></TR>
        <TR>
          <TD><A href="tools/log_sys_error.jsp" 
            target=main>ϵͳ�����¼</A></TD></TR>
		</TBODY></TABLE></TD></TR></TBODY></TABLE></DIV>
<% } %>
<TABLE class=leftmenu_tb cellSpacing=0 cellPadding=0 width=146 align=center border=0>
  <TBODY>
  <TR class=leftmenu_box>
    <TD>
      <DIV style="MARGIN-LEFT: 48px"><A href="perform.jsp?act=lgt" target=_top>�˳�</A></DIV></TD></TR>
  </TBODY></TABLE>
</BODY></HTML>
