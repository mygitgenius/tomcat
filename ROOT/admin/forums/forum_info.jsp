<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.OptionVO"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	String fromPath = request.getContextPath() + "/admin/forums/forum_edit.jsp";
	
	String sectionID = request.getParameter("sid");
	String boardID = request.getParameter("fid");

	CacheManager cache = CacheManager.getInstance();
    ArrayList sections = cache.getSections();
	BoardVO aBoard = cache.getBoard(sectionID, boardID);

    ArrayList groups = cache.getGroups();

	ForumSetting setting = ForumSetting.getInstance();
	OptionVO[] styles = setting.getStyles();
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
          <TD><A onclick="parent.location='../index.htm';return false;" 
            href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;�����ϸ����</TD></TR></TBODY></TABLE><BR>
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
              <LI>ʵ�ʷ���Ȩ�����û����Ȩ�޺ʹ˴��İ��Ȩ�����ù�ͬ��������ĳһȨ��ֻ�����û����Ȩ�޺Ͱ��Ȩ�޾���ɵ�����²���Ч��</LI></UL></TD></TR></TBODY></TABLE><BR>
      <FORM id="settings" name="settings" onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="forums_forum_info">
	  <INPUT type=hidden name="boardID" value="<%= boardID %>">
	  <INPUT type=hidden name="fromPath" value="<%= fromPath %>">
      <A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>����������<A onClick="collapse_change('tb01','../images')" href="#">
  		    <IMG id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 4px" 
             src="../images/menu_reduce.gif" border=0></A></TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 width="45%"><B>�������:</B></TD>
          <TD class=altbg2><INPUT size=50 value="" name="boardName"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��ʾ���:</B><BR><SPAN 
            class=smalltxt>ѡ�񡰷񡱽���ʱ���ذ�鲻��ʾ��������Ա�Ͱ����Կɼ��˰�飬���û��Կ�ͨ��&nbsp;URL&nbsp;
			ֱ�ӷ��ʵ��˰������ݡ����ô˹��ܿ��Խ�һЩ������ʱ����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio CHECKED value="N" name="state" id="state[N]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio value="I" name="state" id="state[I]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��������:</B><BR><SPAN 
            class=smalltxt>����������ķ���</SPAN></TD>
          <TD class=altbg2>
		  	<SELECT name="sectionID"> 
<%
	if (sections != null)
	{
		SectionVO aSection = null;
		for (int i=0; i<sections.size(); i++)	
		{
			aSection = (SectionVO)sections.get(i);
%>			
				<OPTION value=<%= aSection.sectionID %>><%= aSection.sectionName %></OPTION> 
<%
		}
	}
%>
			</SELECT><INPUT type=hidden name="oldSectionID"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>������ʾɫ:</B><BR><SPAN 
            class=smalltxt>������Ƹ�����ʾ����ɫֵ������λ&nbsp;16&nbsp;����ֵ��ʾ����ֵ��ʾ��Ĭ����ɫ��ʾ�������</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value="" name="highColor"> </TD></TR>
        <TR>
          <TD class=altbg1 vAlign=top width="45%"><B>�����:</B><BR><SPAN 
            class=smalltxt>����ʾ�ڰ���б��а�����Ƶ����棬�ṩ�Ա����ļ�����������100���ַ�</SPAN></TD>
          <TD class=altbg2>
		    <TEXTAREA id="brief" name="brief" rows=3 cols=50 style="width:278px"></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����ؼ���:</B><BR><SPAN 
            class=smalltxt>�˹ؼ����������������Ż������� meta �� keyword ��ǩ�У�����ؼ��ּ����ð�Ƕ��� "," 
            ����</SPAN></TD>
          <TD class=altbg2><INPUT size=50 name="keywords" maxlength="100"></TD></TR>
	  </TBODY></TABLE><BR>
		<A name=tb03></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>��չ����<A onClick="collapse_change('tb03','../images')" href="#">
		    <IMG id=menuimg_tb03 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 4px" 
             src="../images/menu_reduce.gif" border=0></A></TD></TR>
        <TBODY id=menu_tb03>
        <TR>
          <TD class=altbg1 width="45%" valign="top"><B>��������:</B><BR><SPAN 
            class=smalltxt>��ʾ�������б�ҳ�ĵ�ǰ������&nbsp;HTML&nbsp;���룬����Ϊ����ʾ</SPAN></TD>
          <TD class=altbg2>
		    <IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ruleCode', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('ruleCode', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id="ruleCode" name="ruleCode" rows=6 cols=50 
				 style="width:278px"><%= aBoard.ruleCode==null?"":aBoard.ruleCode %></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����񷽰�:</B><BR><SPAN 
            class=smalltxt>�����߽��뱾�����ʹ�õĽ����񷽰�</SPAN></TD>
          <TD class=altbg2>
		   	<SELECT name="viewStyle">
<%
	for (int i=0; i<styles.length; i++)
	{
		if (styles[i].name.startsWith("1_"))
		{
%>			
			  <OPTION value="<%= styles[i].name.substring(2) %>"><%= styles[i].value %></OPTION>
<%
		}
	}
%>			
			  </SELECT></TD></TR>
        <TR>
          <TD class=altbg1 width="45%" valign="top"><B>����Ĭ������ʽ:</B><BR><SPAN 
            class=smalltxt>���ð��������б�Ĭ�ϰ��ĸ��ֶκ��ַ�ʽ������ʾ</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio CHECKED value="lastPostTime" name="sortField" id="sortField[lastPostTime]"> 
			�ظ�ʱ��&nbsp;-&nbsp;���� &nbsp; 
			<INPUT class=radio type=radio value="createTime" name="sortField" id="sortField[createTime]"> 
			����ʱ��&nbsp;-&nbsp;����<BR>
			<INPUT class=radio type=radio value="A_lastPostTime" name="sortField" id="sortField[A_lastPostTime]"> 
			�ظ�ʱ��&nbsp;-&nbsp;���� &nbsp; 
			<INPUT class=radio type=radio value="A_createTime" name="sortField" id="sortField[A_createTime]"> 
			����ʱ��&nbsp;-&nbsp;����</TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����ʹ�� [img] ����:</B><BR><SPAN 
            class=smalltxt>���� [img] �������߽������������в���ͼƬ����ʾ</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio CHECKED value="T" name="isImageOK" id="isImageOK[T]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio value="F" name="isImageOK" id="isImageOK[F]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����ʹ�� [media] ����:</B><BR><SPAN 
            class=smalltxt>���� [media] �������߽������������в���&nbsp;Flash&nbsp;���ý�����</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio CHECKED value="T" name="isMediaOK" id="isMediaOK[T]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio value="F" name="isMediaOK" id="isMediaOK[F]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����οͷ���:</B><BR><SPAN 
            class=smalltxt>�Ƿ������ο��ڱ���������������ͻظ����ο͵�IP��ַ�ᱻ��¼������</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio value="T" name="isGuestPostOK" id="isGuestPostOK[T]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio CHECKED value="F" name="isGuestPostOK" id="isGuestPostOK[F]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%" valign="top"><B>ҳ�׹�����:</B><BR><SPAN 
            class=smalltxt>�����ڱ����ҳ��ҳ��&nbsp;(logo �Ҳ�)&nbsp;�Ĺ��&nbsp;HTML&nbsp;
				���룬��Ϊ��������̳ȫ�ֹ������Ϊ׼</SPAN></TD>
          <TD class=altbg2>
		    <IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('headAdCode', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('headAdCode', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id="headAdCode" name="headAdCode" rows=6 cols=50 
				 style="width:278px"><%= aBoard.headAdCode==null?"":aBoard.headAdCode %></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 width="45%" valign="top"><B>ҳ�Ź�����:</B><BR><SPAN 
            class=smalltxt>�����ڱ����ҳ��ҳ�ŵĹ��&nbsp;HTML&nbsp;
				���룬��Ϊ��������̳ȫ�ֹ������Ϊ׼</SPAN></TD>
          <TD class=altbg2>
		    <IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('footAdCode', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('footAdCode', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id="footAdCode" name="footAdCode" rows=6 cols=50 
				 style="width:278px"><%= aBoard.footAdCode==null?"":aBoard.footAdCode  %></TEXTAREA> </TD></TR>
	</TBODY></TABLE><BR>
	<A name=tb04></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD>���Ȩ��</TD>
          <TD>������</TD>
          <TD>���»���</TD>
          <TD>����ظ�</TD>
          <TD>����/�鿴����</TD>
          <TD>�ϴ�����</TD></TR>
<%
	if (groups != null)
	{
		GroupVO aGroup = null;
		String checked1 = null;
		String checked2 = null;
		String checked3 = null;
		String checked4 = null;
		String checked5 = null;
		String empty = "";
		String checked = null;
			
		for (int i=0; i<groups.size(); i++)	
		{
			aGroup = (GroupVO)groups.get(i);
			if (aBoard.allowGroups == null 
				|| aBoard.allowGroups.indexOf(String.valueOf(aGroup.groupID)) >= 0)
				checked = "checked";
			else
				checked = "";

			if (PageUtils.isPermitted(aBoard, aGroup, IConstants.PERMIT_VISIT_FORUM)) checked1 = "checked"; else checked1 = "";
			if (PageUtils.isPermitted(aBoard, aGroup, IConstants.PERMIT_NEW_TOPIC)) checked2 = "checked"; else checked2 = "";
			if (PageUtils.isPermitted(aBoard, aGroup, IConstants.PERMIT_NEW_REPLY)) checked3 = "checked"; else checked3 = "";
			if (PageUtils.isPermitted(aBoard, aGroup, IConstants.PERMIT_DOWNLOAD)) checked4 = "checked"; else checked4 = "";
			if (PageUtils.isPermitted(aBoard, aGroup, IConstants.PERMIT_UPLOAD)) checked5 = "checked"; else checked5 = "";
%>			
        <TR>
          <TD class=altbg1>
		  	<INPUT class=checkbox title=ѡ�� type=checkbox <%= checked %>
				name="allowGroups" id="allowGroups[<%= aGroup.groupID %>]" 
				value="<%= aGroup.groupID %>" onclick="changeGroups('<%= aGroup.groupID %>')"/> <%= aGroup.groupName %></TD>
          <TD class=altbg2>&nbsp;&nbsp;&nbsp;<INPUT class=checkbox title=ѡ�� type=checkbox <%= checked1 %>
				name="visitGroups" id="visitGroups[<%= aGroup.groupID %>]" 
				value="<%= aGroup.groupID %>" onclick="toggleGroups('<%= aGroup.groupID %>')"/></TD>
          <TD class=altbg1>&nbsp;&nbsp;&nbsp;<INPUT class=checkbox title=ѡ�� type=checkbox <%= checked2 %>
				name="topicGroups" id="topicGroups[<%= aGroup.groupID %>]" 
				value="<%= aGroup.groupID %>" onclick="toggleGroups('<%= aGroup.groupID %>')"/></TD>
          <TD class=altbg2>&nbsp;&nbsp;&nbsp;<INPUT class=checkbox title=ѡ�� type=checkbox <%= checked3 %>
				name="replyGroups" id="replyGroups[<%= aGroup.groupID %>]" 
				value="<%= aGroup.groupID %>" onclick="toggleGroups('<%= aGroup.groupID %>')"/></TD>
          <TD class=altbg1>&nbsp;&nbsp;&nbsp;<INPUT class=checkbox title=ѡ�� type=checkbox <%= checked4 %>
				name="downloadGroups" id="downloadGroups[<%= aGroup.groupID %>]" 
				value="<%= aGroup.groupID %>" onclick="toggleGroups('<%= aGroup.groupID %>')"/></TD>
          <TD class=altbg2>&nbsp;&nbsp;&nbsp;<INPUT class=checkbox title=ѡ�� type=checkbox <%= checked5 %>
				name="uploadGroups" id="uploadGroups[<%= aGroup.groupID %>]" 
				value="<%= aGroup.groupID %>" onclick="toggleGroups('<%= aGroup.groupID %>')"/></TD></TR>
<%
		}
	}
%>			
       </TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM>
	  </TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
	if (trim(theform.boardName.value) == '') {
		alert('������Ʋ�����Ϊ��');
      	theform.sectionName.focus();
		return;
	}
	if ((trim(theform.brief.value)).length > 100) {
		alert('����鲻�ܳ���100���ַ�');
      	theform.brief.focus();
		return;
	}
	theform.submit();
}
function toggleGroups(id) {
	if ($('visitGroups['+id+']').checked || $('topicGroups['+id+']').checked
		|| $('replyGroups['+id+']').checked || $('downloadGroups['+id+']').checked || $('uploadGroups['+id+']').checked)
	{
		$('allowGroups['+id+']').checked = true;
	}
	else
	{
		$('allowGroups['+id+']').checked = false;
	}
}
function changeGroups(id) {
	if ($('allowGroups['+id+']').checked)
	{
		$('visitGroups['+id+']').checked = true;
		$('topicGroups['+id+']').checked = true;
		$('replyGroups['+id+']').checked = true;
		$('downloadGroups['+id+']').checked = true;
		$('uploadGroups['+id+']').checked = true;
	}
	else
	{
		$('visitGroups['+id+']').checked = false;
		$('topicGroups['+id+']').checked = false;
		$('replyGroups['+id+']').checked = false;
		$('downloadGroups['+id+']').checked = false;
		$('uploadGroups['+id+']').checked = false;
	}
}
$('settings').sectionID.value = "<%= sectionID %>";
$('settings').oldSectionID.value = "<%= sectionID %>";
$('settings').boardID.value = "<%= aBoard.boardID %>";
$('settings').boardName.value = "<%= aBoard.boardName %>";
$('settings').highColor.value = "<%= aBoard.highColor==null?"":aBoard.highColor %>";
$('state[<%= aBoard.state %>]').checked = "true";
$('settings').brief.value = "<%= aBoard.brief==null?"":aBoard.brief %>";
$('settings').keywords.value = "<%= aBoard.keywords==null?"":aBoard.keywords %>";
$('settings').viewStyle.value = "<%= aBoard.viewStyle==null?"default":aBoard.viewStyle %>";
$('sortField[<%= aBoard.sortField==null?"lastPostTime":aBoard.sortField %>]').checked = "true";
$('isImageOK[<%= aBoard.isImageOK %>]').checked = "true";
$('isMediaOK[<%= aBoard.isMediaOK %>]').checked = "true";
$('isGuestPostOK[<%= aBoard.isGuestPostOK %>]').checked = "true";
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
