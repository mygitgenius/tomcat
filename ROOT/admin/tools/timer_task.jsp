<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.util.AppUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
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
            href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;�ƻ�����</TD></TR></TBODY></TABLE><BR>
	<FORM id="frmtask" name="frmtask" action="../perform.jsp?" method=post>
	<input type="hidden" name="act" value="">
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
              <LI>����������ϵͳ�Զ�����ִ��(һ������賿ִ��)����������²���Ҫ�ֶ�ִ�С�</LI></UL></TD></TR>
	  </TBODY></TABLE><BR>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>ÿ��ִ��һ��</TD></TR>
		<TR class="altbg2"><TD width="80%">������⣨�������ö��ȣ��Ƿ����:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('check_expired')"></TD></TR>
		<TR class="altbg2"><TD width="80%">ͳ����̳�ķ������������ſ�:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('stat_forum_visits')"></TD></TR>
		<TR class="altbg2"><TD width="80%">ˢ����ҳ�����ƽ����������б�:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('load_hot_links')"></TD></TR>
		<TR class="altbg2"><TD width="80%">�������������Ķ���Ϣ:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('clean_sms')"></TD></TR>
		<TR class="altbg2"><TD width="80%">���������������ղؼм�¼:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('clean_favors')"></TD></TR>
		<TR class="altbg2"><TD width="80%">����ͳ�ư��������������:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('stat_board_posts')"></TD></TR>
		<TR class="altbg2"><TD width="80%">�ؽ�����������ȫ������:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('index_topics')"></TD></TR>
		<TR class="altbg2"><TD width="80%">ִ��ÿ�����ݱ�������:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('daily_backup')"></TD></TR>
        </TBODY></TABLE><BR>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>ÿ��ִ��һ��</TD></TR>
		<TR class="altbg2"><TD width="80%">������ڵ��������¼:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('clean_trashbox')"></TD></TR>
		<TR class="altbg2"><TD width="80%">������ڵ���־��¼:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('clean_logs')"></TD></TR>
		<TR class="altbg2"><TD width="80%">������Ч�ĸ�����ͷ���ļ�:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('clean_attaches')"></TD></TR>
		<TR class="altbg2"><TD width="80%">ִ��ÿ�����ݱ�������:</TD>
			<TD width="20%"><input class="button" type="button" value="�ֶ�ִ��" onclick="doTask('weekly_backup')"></TD></TR>
        </TBODY></TABLE>
	  </FORM>
<script language="javascript">
function doTask(task) {
	$('frmtask').act.value = "tools_" + task;
	$('frmtask').submit();
}
</script>
</TD></TR></TBODY></TABLE><BR><BR>
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>