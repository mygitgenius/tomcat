<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	ForumSetting setting = ForumSetting.getInstance();
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
		  		href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;���ֲ���</TD></TR></TBODY></TABLE><BR>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="basic_credits">
        <A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>������������<A onclick="collapse_change('tb01','../images')" href="#">
			<IMG id=tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
		<TR>
          <TD class=altbg1 width="45%"><B>ע���ʼ����:</B><BR><SPAN 
            class=smalltxt>���û�ע���ӵ�еĳ�ʼ���ֵ���ֵ</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=0 name="userInitValue"></TD></TR>        
		<TR>
          <TD class=altbg1 width="45%"><B>������(+)</B><BR><SPAN 
            class=smalltxt>���߷����������ӵĻ���������������ⱻɾ�������߻���Ҳ�ᰴ�˱�׼��Ӧ����</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=10 name="newTopic"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�ظ�(+)</B><BR><SPAN 
            class=smalltxt>���߷��»ظ����ӵĻ�����������ûظ���ɾ�������߻���Ҳ�ᰴ�˱�׼��Ӧ����</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=5 name="newReply"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��ѻظ�(+)</B><BR><SPAN 
            class=smalltxt>���������ظ�����Ϊ��ѻظ�ʱ���ӵĻ�������������������������⣬���������͵Ļ���Ϊ׼��
			��ȡ������ѻظ������߻���Ҳ�ᰴ�˱�׼��Ӧ����</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=10 name="bestReply"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�Ӿ���(+)</B><BR><SPAN 
            class=smalltxt>���ⱻ���뾫��ʱ��λ�����������ӵĻ���������������ⱻ�Ƴ����������߻���Ҳ�ᰴ�˱�׼��Ӧ����</SPAN>
		  </TD>
          <TD class=altbg2><INPUT size=50 value=20 name="digestTopic"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�ϴ�����(+)</B><BR><SPAN 
            class=smalltxt>�û�ÿ�ϴ�һ���������ӵĻ�����������ø�����ɾ���������߻���Ҳ�ᰴ�˱�׼��Ӧ����</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=10 name="upload"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>���ظ���(-)</B><BR><SPAN 
            class=smalltxt>�û�����һ������ʱ���ٵĻ�����������ϴ��û��趨�˸���������Ҫ�ľ�����֣������û��趨Ϊ׼</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=-0 name="download"> </TD></TR>
        <TR>
          <TD class=altbg1 
            colSpan=2>���ϱ���(+)�ı�ʾ���ӻ�����������(-)�ı�ʾ���ٻ�����(��ֵ����Ϊ����)�����������������ķ�ΧΪ 
            -99��+99</TD>
        </TR></TBODY></TABLE>
      <BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM>
	  </TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
var filter = /^[-+]?[\d]{1,2}$/;
function isvalidfield(field) {
    if (!filter.test(trim(field.value))) {
    	alert('��������ֵ����Ϊ-99��+99֮�������');
      	field.focus();
		return false;
	}
	else
		return true;
}
function checkfields(theform) {
    if (!isvalidfield(theform.userInitValue)) return;
    if (!isvalidfield(theform.newTopic)) return;
    if (!isvalidfield(theform.newReply)) return;
    if (!isvalidfield(theform.bestReply)) return;
    if (!isvalidfield(theform.digestTopic)) return;
    if (!isvalidfield(theform.upload)) return;
    if (!isvalidfield(theform.download)) return;
	theform.submit();
}
$('settings').userInitValue.value = "<%= setting.getInt(ForumSetting.CREDITS,"userInitValue") %>";
$('settings').newTopic.value = "+<%= setting.getInt(ForumSetting.CREDITS,"newTopic") %>";
$('settings').newReply.value = "+<%= setting.getInt(ForumSetting.CREDITS,"newReply") %>";
$('settings').bestReply.value = "+<%= setting.getInt(ForumSetting.CREDITS,"bestReply") %>";
$('settings').digestTopic.value = "+<%= setting.getInt(ForumSetting.CREDITS,"digestTopic") %>";
$('settings').upload.value = "+<%= setting.getInt(ForumSetting.CREDITS,"upload") %>";
$('settings').download.value = "<%= setting.getInt(ForumSetting.CREDITS,"download") %>";
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
