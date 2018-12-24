<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.common.util.DBManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.AppContext"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	ForumSetting setting = ForumSetting.getInstance();
    DBManager dbManager = DBManager.getInstance();
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
          <TD><A onclick="parent.location='../index.htm'; return false;" href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;���в���
		  </TD></TR></TBODY></TABLE><BR>
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
            <UL><LI>�˴��г��Ĳ���һ�㲻��Ҫ�޸ģ������Ҫ�����ֶ��޸������ļ�&nbsp;config.xml&nbsp;������������̳��</LI></UL>
			  </TD></TR></TBODY></TABLE><BR>
	   <A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>ȱʡ���ò���<A onClick="collapse_change('tb01','../images')" 
            href="#"><IMG id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 width="45%"><B>ϵͳ����Ա��:</B><BR><SPAN 
            class=smalltxt>����̳ϵͳ����Ա���û���</SPAN></TD>
          <TD class=altbg2><%= AppContext.getInstance().getAdminUser() %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��Ա�б����ҳ��:</B><BR><SPAN 
            class=smalltxt>��Ա�б��п��Է��ĵ������ҳ����0 Ϊ������</SPAN></TD>
          <TD class=altbg2><%= setting.getInt(ForumSetting.MISC,"maxMemberPages") %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��Աÿ�ε�¼����������:</B><BR><SPAN 
            class=smalltxt>��Աÿ�ε�¼���������ķ�������</SPAN></TD>
          <TD class=altbg2><%= setting.getInt(ForumSetting.MISC,"maxSessionPosts") %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�ղؼ�����:</B><BR><SPAN 
            class=smalltxt>�����ղص����������������������ʱ���ڵ����ӽ��ᱻɾ��</SPAN></TD>
          <TD class=altbg2><%= setting.getInt(ForumSetting.MISC,"maxFavorites") %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����Ϣ����:</B><BR><SPAN 
            class=smalltxt>����Ϣ�ռ�����������������������ʱ���ڵ���Ϣ���ᱻɾ��</SPAN></TD>
          <TD class=altbg2><%= setting.getInt(ForumSetting.MISC,"maxShortMsgs") %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>ͷ�����ߴ�(����):</B><BR><SPAN 
            class=smalltxt>�û�ͷ�񽫱���С���˴�С��Χ֮��</SPAN></TD>
          <TD class=altbg2><%= setting.getInt(ForumSetting.MISC,"maxAvatarPixels") %></TD></TR>
		</TBODY></TABLE>
      <BR><A name=tb02></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>���ݿ�����<A onClick="collapse_change('tb02','../images')" href="#"><IMG 
            id=menuimg_tb02 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb02>
        <TR>
          <TD class=altbg1 width="45%"><B>���������:</B><BR><SPAN 
            class=smalltxt>��ǰ���ݿ����ӳ���������������</SPAN></TD>
          <TD class=altbg2><%= dbManager.getConnectionsMaxActive() %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>������������:</B><BR><SPAN 
            class=smalltxt>��ǰ���ݿ����ӳ������������������</SPAN></TD>
          <TD class=altbg2><%= dbManager.getConnectionsMaxIdle() %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��С����������:</B><BR><SPAN 
            class=smalltxt>��ǰ���ݿ����ӳ��������С����������</SPAN></TD>
          <TD class=altbg2><%= dbManager.getConnectionsMinIdle() %></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�ȴ����ݿ����ӵ����ʱ��(����):</B><BR><SPAN 
            class=smalltxt>�����ӳػ�ȡ����ʱ��������ȴ�ʱ��</SPAN></TD>
          <TD class=altbg2><%= dbManager.getConnectionsMaxWait() %></TD></TR>
        </TBODY></TABLE>
      <BR>
	  </TD></TR></TBODY></TABLE><BR><BR>
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
