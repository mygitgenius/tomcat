<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	ForumSetting setting = ForumSetting.getInstance();
	String serverName = request.getServerName();
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
          <TD><A onclick="parent.location='../index.htm'; return false;" href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;��������
 		  </TD></TR></TBODY></TABLE><BR>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="basic_baseinfo">
	  <A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>��������<A onClick="collapse_change('tb01','../images')" href="#">
		  <IMG id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 width="45%"><B>��̳����:</B><BR><SPAN 
            class=smalltxt>��̳���ƣ�����ʾ�ڵ������ͱ�����</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 id="forumName" name="forumName"> </TD></TR>
		<tr>
			<td width="45%" class="altbg1" valign="top"><b>��̳ logo:</b><br/>
			<span class="smalltxt">��̳ images ��Ŀ¼�µ� logo �ļ����ƣ���ʹ�� Flash ���������ö��Ÿ��� URL����Ⱥ͸߶ȣ��硰logo.swf,80,40��</span></td>
			<td class="altbg2"><input type="text" size="50" name="forumLogo"></td>
		</tr>			
        <TR>
          <TD class=altbg1 width="45%"><B>��վ����:</B><BR><SPAN 
            class=smalltxt>��վ���ƣ�����ʾ��ҳ��ײ�����ϵ��ʽ��</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 name="website"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��վ URL:</B><BR><SPAN 
            class=smalltxt>��վ URL������Ϊ������ʾ��ҳ��ײ�</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 name="siteUrl"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>ҳ����ϵ����:</B><BR><SPAN 
            class=smalltxt>����ʱ��ϵ����Ϊϵͳ����Ա�������ַ</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 id="footerMailAddr" name="footerMailAddr"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��վ������Ϣ����:</B><BR><SPAN 
            class=smalltxt>ҳ��ײ�������ʾ ICP 
            ������Ϣ�������վ�ѱ������ڴ�����������Ȩ�룬������ʾ��ҳ��ײ������û��������</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 name="certCode"> </TD></TR>
		<tr><td width="45%" class="altbg1">
			<b>��̳���ڸ�ʽ:</b><br/>
			<span class="smalltxt">ʹ�� yyyy ��ʾ�꣬mm ��ʾ�£�dd ��ʾ��</span></td>
			<td class="altbg2">
				<select name="dateFormat">
					<option value="yyyy-mm-dd">yyyy-mm-dd</option>
					<option value="yyyy/mm/dd">yyyy/mm/dd</option>
					<option value="dd-mm-yyyy">dd-mm-yyyy</option>
					<option value="dd/mm/yyyy">dd/mm/yyyy</option>
				</select>
			</td></tr>
        <TR>
          <TD class=altbg1 width="45%"><B>��վʱ��:</B><BR><SPAN 
            class=smalltxt>��վ����ʱ���� GMT ��׼��ʱ���</SPAN></TD>
          <TD class=altbg2>
		  		<select name="timezone">
		  			<jsp:include page="../../include/timezone.html"/>
				</select>
		  </TD></TR>
		</TBODY></TABLE><BR>
      <A name=tb03></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>ϵͳ�ʼ�����<A onClick="collapse_change('tb03','../images')" href="#"><IMG 
            id=menuimg_tb03 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb03>
        <TR>
          <TD class=altbg1 width="45%"><B>����Ա�ʼ���ַ:</B><BR><SPAN 
            class=smalltxt>����̳ϵͳ����Ա���ʼ���ַ</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 id="adminMailAddr" name="adminMailAddr"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>ϵͳ�ʼ���ַ:</B><BR><SPAN 
            class=smalltxt>ϵͳ��������ڷ����ʼ�ʱʹ�õ��ʼ���ַ</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 id="sysMailAddr" name="sysMailAddr"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>ϵͳ�ʼ��û���:</B><BR><SPAN 
            class=smalltxt>ϵͳ�Զ������ʼ�ʱ��ʹ�õ��ʼ��û���</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 id="sysMailUser" name="sysMailUser"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>ϵͳ�ʼ�����:</B><BR><SPAN 
            class=smalltxt>ϵͳ�Զ������ʼ�ʱ��ʹ�õ��ʼ�����</SPAN></TD>
          <TD class=altbg2><INPUT type="password" size=50 id="sysMailPasswd" name="sysMailPasswd"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>ϵͳ�ʼ����ͷ�����:</B><BR><SPAN 
            class=smalltxt>ϵͳĬ�ϵ��ʼ�&nbsp;SMTP&nbsp;��������ַ���������ʹ��&nbsp;SSL&nbsp;����Э�鷢���ʼ�������ǰ��ע��"SSL:"�����磺SSL:smtp.gmail.com</SPAN></TD>
          <TD class=altbg2><INPUT type="text" size=50 id="sysSmtpHost" name="sysSmtpHost"></TD></TR>
        </TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM></TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	if (trim($('forumName').value) == '') {
		alert('��̳���Ʋ�����Ϊ��');
		$('forumName').focus();
	} else if(!isLegalEmail(trim($('adminMailAddr').value))) {
		alert('��������Ч�Ĺ���Ա�ʼ���ַ');
		$('adminMailAddr').focus();
	} else if(!isLegalEmail(trim($('sysMailAddr').value))) {
		alert('��������Ч��ϵͳ�ʼ���ַ');
		$('sysMailAddr').focus();
	} else if(trim($('sysMailUser').value) == '') {
		alert('������ϵͳ�ʼ��û���');
		$('sysMailUser').focus();
	} else if(trim($('sysSmtpHost').value) == '') {
		alert('������ϵͳ�ʼ����ͷ�����');
		$('sysSmtpHost').focus();
	} else {
		theform.submit();
	}
}
$('settings').forumName.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"forumName") %>";
$('settings').forumLogo.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"forumLogo") %>";
$('settings').website.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"website",serverName) %>";
$('settings').siteUrl.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"siteUrl","http://" + serverName) %>";
$('settings').footerMailAddr.value = 
	"<%= setting.getHTMLStr(ForumSetting.BASEINFO,"footerMailAddr",setting.getAdminMailAddr()) %>";
$('settings').certCode.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"certCode") %>";
$('settings').dateFormat.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"dateFormat") %>";
$('settings').timezone.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"timezone") %>";
$('settings').adminMailAddr.value = "<%= setting.getAdminMailAddr() %>";
$('settings').sysMailAddr.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"sysMailAddr") %>";
$('settings').sysMailUser.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"sysMailUser") %>";
$('settings').sysMailPasswd.value = 
	"<%= setting.getString(ForumSetting.BASEINFO,"sysMailPasswd").trim().length()==0?"":"      " %>";
$('settings').sysSmtpHost.value = "<%= setting.getHTMLStr(ForumSetting.BASEINFO,"sysSmtpHost") %>";
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
