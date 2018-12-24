<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
    String totalCount = PageUtils.getParam(request,"totalCount");

	StringBuilder defaultValue = new StringBuilder();
	defaultValue.append("�������\n").append("�����ˮ\n").append("Υ������\n").append("�Ĳ�����\n").append("�ظ�����\n\n")
				.append("�Һ���ͬ\n").append("��Ʒ����\n").append("ԭ������");

	ForumSetting setting = ForumSetting.getInstance();
	String[] judgeOptions = setting.getHTMLStr(ForumSetting.FUNCTIONS,"judgeOptions",defaultValue.toString())
								   .replace("\\n", "\n").split("\n");
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
              <LI>ִ�л��ֽ��Ϳ��ܻ�����û���Ա��ȼ��ı仯���������ϸ���û���ֵ��</LI></UL>
			  </TD></TR></TBODY></TABLE><BR>
      <FORM id="settings" name="settings" onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="users_user_credits">
	  <%= PageUtils.getQueryFields(request) %>
        <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>���ֽ��� -&nbsp; ���������Ļ�Ա��: <%= totalCount %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>���ֽ��͵���ֵ:</B><BR><SPAN 
            class=smalltxt>ǰ׺��+����ʾ���ӻ��֣���-����ʾ���ٻ���</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT id="credits" onblur="checkcredits()" size=5 value="+0" name="credits"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�޸��û����ֵ�����:</B><BR><SPAN 
            class=smalltxt>������޸����û��Ļ������ϣ��������̵Ĳ������ɣ�ϵͳ�������ɼ�¼�ڹ����¼�У��Թ��պ�鿴</SPAN>
			</TD>
          <TD class=altbg2>
			<select id="reasons" name="reasons" onchange="this.form.reason.value=this.value" style="width:100px; height:19px">
			<option value="">�Զ���</option>
			<option value="">------------</option>
<%	for (int i=0; i<judgeOptions.length; i++) { %>
			<option value="<%= judgeOptions[i].length()==0?"":judgeOptions[i].replace("\"", "&quot;") %>">
				<%= judgeOptions[i].length()==0?"------------":judgeOptions[i].replace("\"", "&quot;") %></option>
<%	} %>
			</select>&nbsp;
			<INPUT type=text id="reason" name="reason" size="40" maxlength="35"/>
			</TD></TR>
		  </TBODY></TABLE><BR>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="info_tb">
	<tr class="header">
		<td colspan="2">
	  	<INPUT type=hidden name="sendnotice" value="no"/>
		<input class="checkbox" type="checkbox" value="1" 
onclick="$('tb_msg').style.display = $('tb_msg').style.display == '' ? 'none' : ''; this.checked = $('tb_msg').style.display == 'none' ? false : true">
		 ���ͻ��ֱ��֪ͨ</td></tr>
	<tbody id="tb_msg" style="display: none;">
	<tr>
		<td class="altbg1">����:</td>
		<td class="altbg2"><input type="text" name="subject" size="80" maxlength="100" value="���ֱ��֪ͨ"></td>
	</tr>
	<tr>
	<td class="altbg1" valign="top">����:</td><td class="altbg2">
		<textarea cols="80" rows="10" name="message" style="width:429px"></textarea></td></tr>
	<tr>
		<td class="altbg1">���ͷ�ʽ:</td>
		<td class="altbg2">
		<input class="radio" type="radio" value="email" name="sendby"> Email
		<input class="radio" type="radio" value="sms" checked name="sendby"> ����Ϣ</td></tr>
	</tbody>
	</table><br/>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM></TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	if (trim($('reason').value) == '') {
		alert('�������޸��û����ֵ�����');
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
function checkcredits() {
	var e = $('credits');
	if(e && parseInt(e.value)) {
		$('credits').value = parseInt(e.value);
	} else {
		$('credits').value = 0;
	}
	if ($('credits').value >= 0)
		$('credits').value = '+' + $('credits').value;
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
