<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.OptionVO"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	ForumSetting setting = ForumSetting.getInstance();
	String[] showHotlinks = setting.getHTMLStr(ForumSetting.DISPLAY,"showHotlinks").split(",");
	OptionVO[] styles = setting.getStyles();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<LINK href="../style/admin.css" type=text/css rel=stylesheet>
<SCRIPT src="../../js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="../js/admin.js" type=text/javascript></SCRIPT>
</HEAD>
<BODY topMargin=10 onload="clickImageLinks()">
<TABLE cellSpacing=6 cellPadding=2 width="100%" border=0>
  <TBODY>
  <TR>
    <TD>
      <TABLE class=guide cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD><A onclick="parent.location='../index.htm'; return false;" 
		  href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;��������ʾ��ʽ</TD></TR></TBODY></TABLE><BR>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="basic_display">
      <A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�������<A onClick="collapse_change('tb01','../images')" href="#">
		  	<IMG id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 width="45%"><B>Ĭ�Ͻ�����:</B><BR><SPAN 
            class=smalltxt>��̳Ĭ�ϵĽ������οͺ�ʹ��Ĭ�Ϸ��Ļ�Ա���Դ˷����ʾ</SPAN></TD>
          <TD class=altbg2>
		  	<SELECT name="defaultStyle"> 
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
          <TD class=altbg1 width="45%"><B>��ʾ��������˵�:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����̳�ײ���ʾ���õ���̳��������˵����û�����ͨ���˲˵��л���ͬ����̳���</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio checked value="yes" name="showStyleList" id="showStyleList[yes]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio value="no" name="showStyleList" id="showStyleList[no]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��ʾ����·��:</B><BR><SPAN 
            class=smalltxt>�����Ƿ�����̳����������ʾ����·��</SPAN></TD>
          <TD class=altbg2>
		  	<INPUT class=radio type=radio checked value="yes" name="showSectionLink" id="showSectionLink[yes]"> �� &nbsp; &nbsp; 
			<INPUT class=radio type=radio value="no" name="showSectionLink" id="showSectionLink[no]"> �� </TD></TR>
		 <TR>
		 	<TD width="45%" class="altbg1" ><b>�Ƿ�����ת��</b><BR><SPAN 
            class=smalltxt>�����Ƿ���ǰ̨����ת������</SPAN></TD>
			<TD class="altbg2">
			<input class="radio" type="radio" name="tsExchange" id="tsExchange[none]" value="none" checked> �ر�<br/>
			<input class="radio" type="radio" name="tsExchange" id="tsExchange[chs]" value="chs"> ����&nbsp;-&nbsp;Ĭ�ϼ���<br/>
			<input class="radio" type="radio" name="tsExchange" id="tsExchange[cht]" value="cht"> ����&nbsp;-&nbsp;Ĭ�Ϸ���<br/>
			</TD></TR>			
       </TBODY></TABLE><BR>
	   <A name=tb02></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>��ҳ����<A onClick="collapse_change('tb02','../images')" href="#">
		  	<IMG id=menuimg_tb02 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb02>
		<TR>
			<TD width="45%" class="altbg1" ><b>��ʾ��̳����:</b><br/>
				<span class="smalltxt">��̳��ҳ�Ƿ���ʾ��̳����</span></TD>
			<TD class="altbg2">
			<input class="radio" type="radio" name="showUnion" id="showUnion[yes]" value="yes" checked> �� &nbsp; &nbsp; 
			<input class="radio" type="radio" name="showUnion" id="showUnion[no]" value="no"> ��</TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��ʾ�����û���:</B><BR><SPAN 
            class=smalltxt>����ҳ��ʾ���߻�Ա����������߻�Ա��</SPAN></TD>
          <TD class=altbg2>
	  	<INPUT class=radio type=radio value="yes" name="showOnlineUsers" id="showOnlineUsers[yes]" checked> �� &nbsp; &nbsp; 
		<INPUT class=radio type=radio value="no" name="showOnlineUsers" id="showOnlineUsers[no]"> �� </TD></TR>
		 <TR>
		 	<TD width="45%" class="altbg1" ><b>��ʾ�����ƽ���</b><br/>
				<span class="smalltxt">����̳�������ﵽһ������ʱ������ѡ���������ƽ�������������Ӧ����ѡ��������������������������Ķ�����±�</span></TD>
			<TD class="altbg2">
		<input class="checkbox" type="checkbox" name="[chk]showHotlinks" value="image" id="showHotlinks[image]" 
			   onclick="clickImageLinks()"> ����ͼƬ
		<input class="checkbox" type="checkbox" name="[chk]showHotlinks" value="hot" id="showHotlinks[hot]"> ������������ 
		<input class="checkbox" type="checkbox" name="[chk]showHotlinks" value="rank" id="showHotlinks[rank]"> ������������ <br/>
		<input class="checkbox" type="checkbox" name="[chk]showHotlinks" value="recent" id="showHotlinks[recent]"> ���·���
		<input class="checkbox" type="checkbox" name="[chk]showHotlinks" value="digest" id="showHotlinks[digest]"> ���¾��� 
		<input type="hidden" name="[chk]showHotlinks" value="" id="showHotlinks[]">
			</TD></TR>
        <TBODY id=advanceoption style="DISPLAY: none">
		<TR>
			<TD width="45%" class="altbg1" ><b>����ͼƬ:</b><br/>
				<span class="smalltxt">����һ��ѡ��ѡ�С�����ͼƬ��ʱ��Ҫ�ƽ��ͼƬ������д��Ի���Ե�ַ��
					��ʹ��&nbsp;Flash&nbsp;���������ö��Ÿ���URL����Ⱥ͸߶ȣ��硰forum.swf,80,40��</span></TD>
			<TD class="altbg2"><input type="text" size="50" name="imageFile" value="" ></TD></TR>
		<TR>
			<TD width="45%" class="altbg1" ><b>����ͼƬ��Ŀ������:</b><br/>
				<span class="smalltxt">���������ͼƬʱҪ�򿪵����ӵ�ַ������д��Ի���Ե�ַ</span></TD>
			<TD class="altbg2"><input type="text" size="50" name="imageLink" value="" ></TD></TR>
		<TR>
			<TD width="45%" class="altbg1" ><b>����ͼƬ������˵��:</b><br/>
				<span class="smalltxt">����ͼƬ������˵������������������¼</span></TD>
			<TD class="altbg2"><input type="text" size="50" name="imageTitle" value="" ></TD></TR>
		</TBODY></TABLE><BR>
		<A name=tb03></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�����б�<A 
            onclick="collapse_change('tb03','../images')" href="#">
			<IMG id=menuimg_tb03 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb03>
        <TR>
          <TD class=altbg1 width="45%"><B>ÿҳ��ʾ������:</B><BR><SPAN 
            class=smalltxt>�����б���ÿҳ��ʾ������Ŀ������Ϊ50</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=30 name="topicsPerPage"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�����б����ҳ��:</B><BR><SPAN 
            class=smalltxt>�����б����û����Է��ĵ������ҳ����Ĭ��ֵΪ50��0 Ϊ������</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=50 name="maxTopicPages"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��������ظ���:</B><BR><SPAN 
            class=smalltxt>�����ûظ��������⽫���Ϊ�������⣬��ʹ�������ͼ����ʾ</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=10 name="hotTopicPosts"> 
          </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��������鿴��:</B><BR><SPAN 
            class=smalltxt>�����ò鿴�������⽫���Ϊ�������⣬��ʹ�������ͼ����ʾ</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=100 name="hotTopicVisits"> 
          </TD></TR>
		</TBODY></TABLE><BR>
		<A name=tb04></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>��������<A onclick="collapse_change('tb04','../images')" href="#">
		  	<IMG id=menuimg_tb04 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb04>
        <TR>
          <TD class=altbg1 width="45%"><B>ÿҳ��ʾ����:</B><BR><SPAN 
            class=smalltxt>�����б���ÿҳ��ʾ������Ŀ������Ϊ50</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=30 name="postsPerPage"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�Ƿ���ʾ����ͷ��:</B><BR><SPAN 
            class=smalltxt>�Ƿ������ӵ��û���Ϣ����ʾ����ͷ��</SPAN></TD>
          <TD class=altbg2>
		  <INPUT class=radio type=radio value=yes name="showAvatar" id="showAvatar[yes]" checked> �� &nbsp; &nbsp; 
		  <INPUT class=radio type=radio value=no name="showAvatar" id="showAvatar[no]"> �� </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�Ƿ���ʾ����ǩ��:</B><BR><SPAN 
            class=smalltxt>�Ƿ������ӵĺ�����ʾ���߸���ǩ����Ϣ</SPAN></TD>
          <TD class=altbg2>
		  <INPUT class=radio type=radio value=yes name="showBrief" id="showBrief[yes]"> �� &nbsp; &nbsp; 
		  <INPUT class=radio type=radio value=no name="showBrief" id="showBrief[no]" checked> �� </TD></TR>
		</TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM>
	  </TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) 
{
    var filter = /^\d+$/;
    if (!filter.test(trim(theform.topicsPerPage.value))) {
    	alert('ÿҳ��ʾ����������Ϊ����');
      	theform.topicsPerPage.focus();
		return;
    }
    if (!filter.test(trim(theform.maxTopicPages.value))) {
    	alert('�����б����ҳ������Ϊ����');
      	theform.maxTopicPages.focus();
		return;
    }
    if (!filter.test(trim(theform.hotTopicPosts.value))) {
    	alert('��������ظ�������Ϊ����');
      	theform.hotTopicPosts.focus();
		return;
    }
    if (!filter.test(trim(theform.hotTopicVisits.value))) {
    	alert('��������鿴������Ϊ����');
      	theform.hotTopicVisits.focus();
		return;
    }
    if (!filter.test(trim(theform.postsPerPage.value))) {
    	alert('ÿҳ��ʾ��������Ϊ����');
      	theform.postsPerPage.focus();
		return;
	}
	theform.submit();
}
function clickImageLinks() 
{
	$('advanceoption').style.display = $('showHotlinks[image]').checked ? '' : 'none';
}

$('settings').defaultStyle.value = "<%= setting.getHTMLStr(ForumSetting.DISPLAY,"defaultStyle") %>";
$('showStyleList[<%= setting.getHTMLStr(ForumSetting.DISPLAY,"showStyleList") %>]').checked = "true";
$('showSectionLink[<%= setting.getHTMLStr(ForumSetting.DISPLAY,"showSectionLink") %>]').checked = "true";
$('tsExchange[<%= setting.getHTMLStr(ForumSetting.DISPLAY,"tsExchange") %>]').checked = "true";
$('showUnion[<%= setting.getHTMLStr(ForumSetting.DISPLAY,"showUnion") %>]').checked = "true";
$('showOnlineUsers[<%= setting.getHTMLStr(ForumSetting.DISPLAY,"showOnlineUsers") %>]').checked = "true";
<%
	for (int i=0; i<showHotlinks.length; i++)
	{
		if (showHotlinks[i] != null && showHotlinks[i].trim().length() > 0)
		{
%>
$('showHotlinks[<%= showHotlinks[i] %>]').checked = "true";
<%
		}
	}
%>
$('settings').imageFile.value = "<%= setting.getHTMLStr(ForumSetting.DISPLAY,"imageFile") %>";
$('settings').imageLink.value = "<%= setting.getHTMLStr(ForumSetting.DISPLAY,"imageLink") %>";
$('settings').imageTitle.value = "<%= setting.getHTMLStr(ForumSetting.DISPLAY,"imageTitle") %>";
$('settings').topicsPerPage.value = "<%= setting.getInt(ForumSetting.DISPLAY,"topicsPerPage") %>";
$('settings').maxTopicPages.value = "<%= setting.getInt(ForumSetting.DISPLAY,"maxTopicPages") %>";
$('settings').hotTopicPosts.value = "<%= setting.getInt(ForumSetting.DISPLAY,"hotTopicPosts") %>";
$('settings').hotTopicVisits.value = "<%= setting.getPInt(ForumSetting.DISPLAY,"hotTopicVisits",100) %>";
$('settings').postsPerPage.value = "<%= setting.getInt(ForumSetting.DISPLAY,"postsPerPage") %>";
$('showAvatar[<%= setting.getHTMLStr(ForumSetting.DISPLAY,"showAvatar") %>]').checked = "true";
$('showBrief[<%= setting.getHTMLStr(ForumSetting.DISPLAY,"showBrief") %>]').checked = "true";

if ($('showHotlinks[image]').checked)
	$('advanceoption').style.display = "";		
else
	$('advanceoption').style.display = "none";
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
