<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
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
          <TD><A 
            onclick="parent.location='../index.htm'; return false;" 
            href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;����ά��</TD></TR></TBODY></TABLE><BR>
      <FORM id="frmsearch" name="frmsearch" onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="tools_manage_data">
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
              <LI>����ά������������������¶���̳���ݽ���ǿ���޸ĵȲ�������������²���Ҫִ�С�</LI>
              <LI>�����滻��������ǿ�ƽ��������������е�ĳһ�ַ����滻Ϊ��һ�ַ��������磺���������վ���������˸ı䣬�����Խ����������еľɵ���ַ���޸�Ϊ�µ���ַ��</LI>
			  </UL></TD></TR>
	  </TBODY></TABLE><BR>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="info_tb">
	<tr class="header"><td colspan=2>�����滻 -&nbsp; ����������������ִ���ַ����滻</td></tr>
	<tbody>
		<tr>
			<td class="altbg1" width="45%">���滻�ľ��ַ���:</td><td class="altbg2" width="55%">
			<input type="text" name="fromStr" size="50" value=""></td></tr>
		<tr>
			<td class="altbg1" width="45%">�µ��ַ���:</td><td class="altbg2" width="55%">
			<input type="text" name="toStr" size="50" value=""></td></tr>
	</tbody></table><br/>
	<center><input class="button" type="submit" value="ִ���滻"></center>
	</FORM></TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	if (theform.action.indexOf('/perform.jsp') >= 0)
	{
		if (trim(theform.fromStr.value) == '') {
			alert('���滻�ľ��ַ���������Ϊ��');
      		theform.fromStr.focus();
			return;
		}
	}
	theform.submit();
}
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
