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
		  	href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;ע������ʿ���</TD></TR></TBODY></TABLE><BR>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="basic_access">
		<A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>ע���������<A onClick="collapse_change('tb01','../images')" href="#"><IMG 
            id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 width="45%"><B>���û�ע�᷽ʽ:</B><BR><SPAN 
            class=smalltxt>�����ο�ע����Ƿ�������Ϊ��Ա</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio CHECKED 
            value="open" name=registerType id=registerType[open]> ����ʽע�� - ע���������Ϊ��Ա<BR>
			<INPUT class=radio type=radio value="close" 
            name=registerType id=registerType[close]> ���ʽע�� - ע�����Ҫ�����˹���˲��ܳ�Ϊ��Ա<BR></TD></TR>
        <TR>
          <TD class=altbg1 vAlign=top width="45%"><B>�û���Ϣ�����ؼ���:</B><BR><SPAN 
            class=smalltxt>�û������û���Ϣ(���û������ǳƵ�)���޷�ʹ����Щ�ؼ��֣�ÿ���ؼ���һ��</SPAN></TD>
          <TD class=altbg2>
		  	<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('reserveWords', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('reserveWords', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id=reserveWords name=reserveWords rows=6 cols=50 style="width:278px"></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>ע���û���Ч������(��):</B><BR><SPAN 
            class=smalltxt>��ע���û���ĳһ���Ƶ�������û�е�¼, �Ҵ�δ�������£����ע���û����Զ�ʧЧ��0 Ϊ������</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=0 id=userExpireDays name=userExpireDays> 
          </TD></TR>
		</TBODY></TABLE><BR>
		<A name=tb02></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>���ʿ����������<A onclick="collapse_change('tb02','../images')" href="#">
		  <IMG id=menuimg_tb02 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
		  	   src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb02>
		<TR>
          <TD class=altbg1 vAlign=top width="45%"><B>IP ��ֹ�б�:</B><BR><SPAN class=smalltxt>
            ���û����ڱ��б��е� IP ��ַʱ������ֹ���ʱ���̳��
			�����ܶԹ���Աû�����������������ʹ�ñ����ܡ�ÿ�� IP һ�У��ȿ�����������ַ��Ҳ��ֻ���� IP ��ͷ��
			���� "192.168."(��������) ��ƥ�� 192.168.0.0��192.168.255.255 ��Χ�ڵ����е�ַ��
			������� IP �����б�Ϊ��ʱ���б���Ч</SPAN></TD>
          <TD class=altbg2>
		  	<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ipBanned', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ipBanned', 0)" src="../images/zoomout.gif">
			<BR><TEXTAREA id=ipBanned name=ipBanned rows=6 cols=50 style="width:278px"></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 vAlign=top width="45%"><B>IP �����б�:</B><BR><SPAN class=smalltxt>
		  ֻ�е��û����ڱ��б��е� IP ��ַʱ�ſ��Է��ʱ���̳���б�����ĵ�ַ���ʽ���Ϊ IP ����ֹ��
		  ��������������ҵ��ѧУ�ڲ���̳�ȼ����𳡺ϡ������ܶԹ���Աû�����������������ʹ�ñ����ܡ�
		  ��ʽ������ͬ�ϣ�����Ϊ���� IP ����ȷ��ֹ��������ɷ���</SPAN></TD>
          <TD class=altbg2>
		  	<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ipAllowed', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ipAllowed', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id=ipAllowed name=ipAllowed rows=6 cols=50 style="width:278px"></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 vAlign=top width="45%"><B>����Ա��̨ IP �����б�:</B><BR><SPAN class=smalltxt>
            ֻ�е�����Ա(�������ڴ���)���ڱ��б��е� IP ��ַʱ�ſ��Է�����̳��̨����
            �б�����ĵ�ַ���ʽ��޷����ʣ����Կɷ�����̳ǰ���û����棬���������ʹ�ñ����ܡ�
			��ʽ������ͬ�ϣ�����Ϊ���� IP ����ȷ��ֹ��������ɷ���ϵͳ����</SPAN></TD>
          <TD class=altbg2>
	  	<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ipAdminAllowed', 1)" src="../images/zoomin.gif"> 
		<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ipAdminAllowed', 0)" src="../images/zoomout.gif">
		<BR><TEXTAREA id=ipAdminAllowed name=ipAdminAllowed rows=6 cols=50 style="width:278px"></TEXTAREA></TD></TR>
		</TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM>
	  </TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
    var filter = /^\d+$/;
	var value = trim(theform.userExpireDays.value);
    if (!filter.test(value)) {
    	alert('ע���û���Ч�����Ʊ���Ϊ����');
      	theform.userExpireDays.focus();
		return;
	}
	theform.submit();
}
$('registerType[<%= setting.getHTMLStr(ForumSetting.ACCESS,"registerType") %>]').checked = "true";
$('settings').reserveWords.value = "<%= setting.getHTMLStr(ForumSetting.ACCESS,"reserveWords") %>";
$('settings').userExpireDays.value = 
	"<%= setting.getInt(ForumSetting.ACCESS,"userExpireDays") %>";
$('settings').ipBanned.value = "<%= setting.getHTMLStr(ForumSetting.ACCESS,"ipBanned") %>";
$('settings').ipAllowed.value = "<%= setting.getHTMLStr(ForumSetting.ACCESS,"ipAllowed") %>";
$('settings').ipAdminAllowed.value = "<%= setting.getHTMLStr(ForumSetting.ACCESS,"ipAdminAllowed") %>";
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
