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
		  		href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;���������Ż�</TD></TR></TBODY></TABLE><BR>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="basic_seo">
      <A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>���������Ż�<A onClick="collapse_change('tb01','../images')" href="#"><IMG 
            id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 width="45%"><B>���⸽����:</B><BR><SPAN 
            class=smalltxt>��ҳ����ͨ�������������ע���ص㣬�����������ý������ڱ�������̳���Ƶĺ��棬����ж���ؼ��֣������� 
            "|"��","(��������) �ȷ��ŷָ�</SPAN></TD>
          <TD class=altbg2><INPUT size=50 name="appendTitle"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>Meta Keywords:</B><BR><SPAN 
            class=smalltxt>Keywords �������ҳ��ͷ���� Meta ��ǩ�У����ڼ�¼����̳�Ĺؼ��֣�����ؼ��ּ����ð�Ƕ��� 
            "," ����</SPAN></TD>
          <TD class=altbg2><INPUT size=50 name="keywords"> 
		</TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>Meta Description:</B><BR><SPAN 
            class=smalltxt>Description ������ҳ��ͷ���� Meta ��ǩ�У����ڼ�¼����̳�ĸ�Ҫ����</SPAN></TD>
          <TD class=altbg2><INPUT size=50 name="description"> 
        </TD></TR>
		</TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM>
	  </TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	theform.submit();
}
$('settings').appendTitle.value = "<%= setting.getHTMLStr(ForumSetting.SEO,"appendTitle") %>";
$('settings').keywords.value = "<%= setting.getHTMLStr(ForumSetting.SEO,"keywords") %>";
$('settings').description.value = "<%= setting.getHTMLStr(ForumSetting.SEO,"description") %>";
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
