<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
    String totalCount = PageUtils.getParam(request,"totalCount");
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
      <FORM id="settings" name="settings" onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="users_user_ban">
	  <%= PageUtils.getQueryFields(request) %>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>��ֹ/����û� -&nbsp; ���������Ļ�Ա��: <%= totalCount %></TD></TR>
        <TBODY>
        <TR>
          <TD class=altbg1 width="45%"><B>��ֹ����:</B><BR><SPAN 
            class=smalltxt>ѡ���ֹ�����ͻ��߻ָ����û�����ͨ���</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="N" name="newstate" checked> ����״̬<BR>
			<INPUT class=radio type=radio value="P" name="newstate"> ��ֹ����<BR>
			<INPUT class=radio type=radio value="S" name="newstate"> ��ֹ����</TD></TR>
        <TR>
          <TD class=altbg1 vAlign=top width="45%"><B>����:</B><BR><SPAN 
            class=smalltxt>��ֹ�����û�������</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=60 name="reason" id="reason" maxlength="40"></TD></TR>
	</TBODY></TABLE><BR>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="info_tb">
	<tr class="header">
		<td colspan="2">
	  	<INPUT type=hidden name="sendnotice" value="no"/>
		<input class="checkbox" type="checkbox" value="1" 
onclick="$('tb_msg').style.display = $('tb_msg').style.display == '' ? 'none' : ''; this.checked = $('tb_msg').style.display == 'none' ? false : true">
		�����û�״̬���֪ͨ</td></tr>
	<tbody id="tb_msg" style="display: none;">
	<tr>
		<td class="altbg1">����:</td>
		<td class="altbg2"><input type="text" name="subject" size="80" value="�û�״̬���֪ͨ"></td>
	</tr>
	<tr>
	<td class="altbg1" valign="top">����:</td><td class="altbg2">
		<textarea cols="82" rows="10" name="message" style="width:429px"></textarea></td></tr>
	<tr>
		<td class="altbg1">���ͷ�ʽ:</td>
		<td class="altbg2">
		<input class="radio" type="radio" value="email" name="sendby"> Email
		<input class="radio" type="radio" value="sms" checked name="sendby"> ����Ϣ</td></tr>
	</tbody>
	</table><br/>		
      <CENTER><INPUT class=button type=submit value="�� ��" name=bansubmit></CENTER></FORM></TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	if (trim($('reason').value) == '') {
		alert('�������޸��û�״̬������');
		$('reason').focus();
		return;
	}
	theform.sendnotice.value = $('tb_msg').style.display == 'none' ? 'no' : 'yes';
	if (theform.sendnotice.value == 'yes')
	{
		if (trim(theform.subject.value) == '')
		{
			alert('������֪ͨ����');
			theform.subject.focus();
			return;
		}
		if (trim(theform.message.value) == '')
		{
			alert('������֪ͨ����');
			theform.message.focus();
			return;
		}
	}
	theform.submit();
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
