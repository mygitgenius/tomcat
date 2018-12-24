<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	String fromPath = PageUtils.getPathFromReferer(request);
	
	String groupID = request.getParameter("id");
	CacheManager cache = CacheManager.getInstance();
	GroupVO aGroup = cache.getGroup(groupID.charAt(0));
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
            href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;�༭�û���Ȩ��</TD></TR></TBODY></TABLE><BR>
      <FORM id="settings" name="settings" onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="users_group_info">
	  <INPUT type=hidden name="groupID" value="<%= groupID %>">
	  <INPUT type=hidden name="fromPath" value="<%= fromPath %>">
      <A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>����Ȩ��<A onClick="collapse_change('tb01','../images')" href="#">
		  	<IMG id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 width="45%"><B>���������̳:</B><BR><SPAN 
            class=smalltxt>ѡ�񡰷񡱽����׽�ֹ�û�������̳���κ�ҳ��</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="A" name="VISIT_FORUM" id="A[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="VISIT_FORUM" id="A[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����鿴��Ա�б�:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����鿴��̳�Ļ�Ա�б�</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="B" name="VIEW_MEMBERS" id="B[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="VIEW_MEMBERS" id="B[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����鿴�û���Ϣ:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����鿴������Ա�û�����Ϣҳ</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="C" name="VIEW_USERINFO" id="C[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="VIEW_USERINFO" id="C[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����鿴ͳ������:</B><BR><SPAN 
            class=smalltxt>�����Ƿ������û��鿴��̳ͳ������</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="D" name="VIEW_STAT" id="D[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="VIEW_STAT" id="D[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����ϴ�ͷ��:</B><BR>
            <SPAN 
            class=smalltxt>�����Ƿ������ϴ�ͷ���ļ�</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="E" name="UPLOAD_AVATAR" id="E[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="UPLOAD_AVATAR" id="E[0]"> �� </TD></TR>
		</TBODY></TABLE>
      <BR><A name=tb02></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�������<A onClick="collapse_change('tb02','../images')" href="#">
		  	<IMG id=menuimg_tb02 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb02>
        <TR>
          <TD class=altbg1 width="45%"><B>�����»���:</B><BR>
          <SPAN 
            class=smalltxt>�����Ƿ��������»���</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="F" name="NEW_TOPIC" id="F[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="NEW_TOPIC" id="F[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��������������:</B><BR><SPAN 
            class=smalltxt>�����Ƿ��������������⣬����Ϊ��ѻظ��߽�������͵Ļ���</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="W" name="NEW_REWARD" id="W[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="NEW_REWARD" id="W[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����������:</B><BR><SPAN 
            class=smalltxt>�Ƿ������û�������������ͻظ�������������ͬ���οͷ������û���Ҫ��¼��ſ�ʹ�ã������͹���Ա���Բ鿴��ʵ����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="H" name="HIDE_POST" id="H[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="HIDE_POST" id="H[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>������ظ�:</B><BR>
            <SPAN 
            class=smalltxt>�����Ƿ�������ظ�</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="G" name="NEW_REPLY" id="G[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="NEW_REPLY" id="G[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����ʹ��&nbsp;HTML&nbsp;����:</B><BR><SPAN 
            class=smalltxt>ѡ���ǡ�����û�������߿�����������ֱ��ʹ���κ�&nbsp;HTML&nbsp;���롣����&nbsp;HTML&nbsp;
			���ܽ�������ȫ�����������á�����ֻ��ʮ�ֱ�Ҫ�������ʹ�ã�������ֻ���Ÿ�����ĵĹ�����Ա
			</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="I" name="USE_HTML" id="I[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="USE_HTML" id="I[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����ö�����:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����ֱ�ӷ����ڵ�ǰ����ö������⡣</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="T" name="TOP_POST" id="T[1]"> �� &nbsp; &nbsp;
		  	<INPUT class=radio type=radio CHECKED value="" name="TOP_POST" id="T[0]"> �� </TD></TR>
        </TBODY></TABLE>
      <BR><A name=tb03></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�������<A onClick="collapse_change('tb03','../images')" href="#">
		  	<IMG id=menuimg_tb03 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb03>
        <TR>
          <TD class=altbg1 width="45%"><B>��������/�鿴����:</B><BR><SPAN 
            class=smalltxt>�����Ƿ���������̳�����ػ�鿴����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="J" name="DOWNLOAD" id="J[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="DOWNLOAD" id="J[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����������:</B><BR><SPAN 
            class=smalltxt>�����Ƿ������ϴ���������̳�С�</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="K" name="UPLOAD" id="K[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="UPLOAD" id="K[0]"> �� </TD></TR>
        </TBODY></TABLE><BR>
<%
	if (aGroup.groupType == 'S' && aGroup.groupID != 'G')
	{
%>		
	  <A name=tb04></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>����Ȩ��<A onclick="collapse_change('tb04','../images')" href="#">
			<IMG id=menuimg_tb04 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb04>
        <TR>
          <TD class=altbg1 width="45%"><B>����ȫ���ö�����:</B><BR><SPAN 
            class=smalltxt>�����Ƿ���������̳ȫ���ö����⡣�������Ϊ����������/���������Ŀ��ö���Χ����������ķ�Χ����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="V" name="TOP_GLOBAL" id="V[1]"> �� &nbsp; &nbsp;
		  	<INPUT class=radio type=radio CHECKED value="" name="TOP_GLOBAL" id="V[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����༭����:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����༭����Χ�ڵ�����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="L" name="EDIT_POST" id="L[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="EDIT_POST" id="L[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����ɾ������:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����ɾ������Χ�ڵ�����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="M" name="DELETE_POST" id="M[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="DELETE_POST" id="M[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����ر�����:</B><BR>
            <SPAN class=smalltxt>�����Ƿ�����رչ���Χ�ڵ�����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="N" name="CLOSE_POST" id="N[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="CLOSE_POST" id="N[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����ƶ�����:</B><BR>
            <SPAN class=smalltxt>�����Ƿ������ƶ�����Χ�ڵ�����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="O" name="MOVE_POST" id="O[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="MOVE_POST" id="O[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����༭�û�:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����༭�û�Ȩ�޵�����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="P" name="EDIT_USER" id="P[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="EDIT_USER" id="P[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����ִ�л��ֽ���:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����ִ�л��ֽ���</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="Q" name="EDIT_CREDITS" id="Q[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="EDIT_CREDITS" id="Q[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����ֹ�û�:</B><BR><SPAN 
            class=smalltxt>�����Ƿ������ֹ�û����������</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="R" name="BAN_USER" id="R[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="BAN_USER" id="R[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��������û�:</B><BR><SPAN 
            class=smalltxt>�����Ƿ����������ע���û���ֻ����̳������Ҫ�˹�������û�ʱ��Ч</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="S" name="AUDIT_USER" id="S[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="AUDIT_USER" id="S[0]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����ɾ���û�:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����ɾ���û��������Ӻ͸���</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="U" name="DELETE_USER" id="U[1]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="" name="DELETE_USER" id="U[0]"> �� </TD></TR>
        </TBODY></TABLE><BR>
<%
	}
%>		
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM></TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	theform.submit();
}
<%
	char right = ' ';
	String elemID = "";
	for (int i=0; i<aGroup.rights.length(); i++)
	{
		right = aGroup.rights.charAt(i);
		elemID = String.valueOf(right) + "[1]";
%>
$('<%= elemID %>').checked = "true";
<%
	}
%>
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>