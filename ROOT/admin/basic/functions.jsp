<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%
	UserInfo userinfo = PageUtils.getAdminUser(request, response);
	if (userinfo == null) return;
	ForumSetting setting = ForumSetting.getInstance();
	String[] mailEvents = setting.getHTMLStr(ForumSetting.FUNCTIONS,"mailEvents").split(",");
	StringBuilder judgeOptions = new StringBuilder();
	judgeOptions.append("�������\n").append("�����ˮ\n").append("Υ������\n").append("�Ĳ�����\n").append("�ظ�����\n\n")
				.append("�Һ���ͬ\n").append("��Ʒ����\n").append("ԭ������");
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
		  		href="#">��̨������ҳ</A>&nbsp;&raquo;&nbsp;��̳����</TD></TR></TBODY></TABLE><BR>
      <FORM id=settings name=settings onSubmit="checkfields(this); return false;" action="../perform.jsp" method=post>
	  <INPUT type=hidden name="act" value="basic_functions">
	  <A name=tb05></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�����������<A onClick="collapse_change('tb05','../images')" href="#">
			<IMG id=menuimg_tb05 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb05>
        <TR>
          <TD class=altbg1 width="45%"><B>�����������(K �ֽ�):</B><BR><SPAN 
            class=smalltxt>ÿ�����ӵ�������������������Ƶ����ӽ������ύ</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=10 name="maxPostLength"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>������󸽼���:</B><BR><SPAN 
            class=smalltxt>��һƪ�����п��Ը��ӵ���󸽼���������Ϊ10</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=2 name="maxAttachNum"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>����������:</B><BR><SPAN 
            class=smalltxt>���������ϴ��ĸ�����չ���������չ��֮���ð�Ƕ��� "," �ָ����Ϊ������</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value="chm, pdf, zip, rar, tar, gz, jar, gif, jpg, jpeg, png" 
				            name="allowAttachTypes"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��󸽼��ܳߴ�(K �ֽ�):</B><BR><SPAN 
            class=smalltxt>����ÿ�ο��ϴ������ܳߴ������ֽ���</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=100 name="maxAttachSize"></TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�������������:</B><BR><SPAN 
            class=smalltxt>ÿ������������������������������Ƶ����⽫���Զ��ر�</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=2000 name="maxReplies"> </TD></TR>
	</TBODY></TABLE><BR>			  
	  <A name=tb04></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�������<A onClick="collapse_change('tb04','../images')" href="#">
			<IMG id=menuimg_tb04 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb04>
        <TR>
          <TD class=altbg1 width="45%" valign="top"><B>ҳ�׹�����:</B><BR><SPAN 
            class=smalltxt>��������̳ÿ��ҳ��ҳ��&nbsp;(logo �Ҳ�)&nbsp;�Ĺ��&nbsp;HTML&nbsp;
				���룬��Ϊ����ҳ�ײ���ʾ��棬���ھ�����ҳ�����԰������Ĺ���������Ϊ׼</SPAN></TD>
          <TD class=altbg2>
		    <IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('headAdCode', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('headAdCode', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id="headAdCode" name="headAdCode" rows=6 cols=50 
				 style="width:278px"><%= setting.getString(ForumSetting.FUNCTIONS,"headAdCode") %></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 width="45%" valign="top"><B>ҳ�Ź�����:</B><BR><SPAN 
            class=smalltxt>��������̳ÿ��ҳ��ҳ�ŵĹ��&nbsp;HTML&nbsp;���룬��Ϊ����ҳ�Ų���ʾ��棬���ھ�����ҳ�����԰������Ĺ���������Ϊ׼</SPAN></TD>
          <TD class=altbg2>
		    <IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('footAdCode', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('footAdCode', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id="footAdCode" name="footAdCode" rows=6 cols=50 
				 style="width:278px"><%= setting.getString(ForumSetting.FUNCTIONS,"footAdCode") %></TEXTAREA> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%" valign="top"><B>���½���Ϣ����:</B><BR><SPAN 
            class=smalltxt>��������̳ÿ��ҳ�����½�&nbsp;(EasyJForum&nbsp;��Ȩ��ʶ������)&nbsp;�ĸ�����Ϣ&nbsp;HTML&nbsp;���룬�������ڷ��þ�Ӫ�������ʶ��ͳ����Ϣ��</SPAN></TD>
          <TD class=altbg2>
		    <IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('footRemark', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('footRemark', 0)" src="../images/zoomout.gif">
            <BR><TEXTAREA id="footRemark" name="footRemark" rows=6 cols=50 
				 style="width:278px"><%= setting.getString(ForumSetting.FUNCTIONS,"footRemark") %></TEXTAREA> </TD></TR>
	</TBODY></TABLE><BR>			  
	<A name=tb01></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>�����������<A onClick="collapse_change('tb01','../images')" href="#">
			<IMG id=menuimg_tb01 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
            src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb01>
        <TR>
          <TD class=altbg1 vAlign=top width="45%"><B>�����������ѡ��:</B><BR><SPAN 
            class=smalltxt>���趨�����û�ִ�в��ֹ������ʱ��ʾ��ÿ������һ�У������������ʾһ�зָ�����--------�����û���ѡ���趨��Ԥ�õ�����ѡ�����������</SPAN></TD>
          <TD class=altbg2>
		  	<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('judgeOptions', 1)" src="../images/zoomin.gif"> 
			<IMG onmouseover="this.style.cursor='pointer'" onclick="zoomtextarea('judgeOptions', 0)" src="../images/zoomout.gif">
			<BR><TEXTAREA id="judgeOptions" name="judgeOptions" rows=6 cols=50 style="width:278px"></TEXTAREA></TD></TR>
        <TR>
          <TD class=altbg1 
            width="45%"><B>�����¼����ʱ��(��):</B><BR><SPAN 
            class=smalltxt>ϵͳ�б�����̳������־��ʱ�䣬Ĭ��Ϊ&nbsp;3&nbsp;���£�0 Ϊ���ñ���</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=3 name="logKeepMonths"> </TD></TR>
        <TR>
          <TD class=altbg1 
            width="45%"><B>���ӻ���վ��¼����ʱ��(��):</B><BR><SPAN 
            class=smalltxt>ϵͳ�б������ӻ���վ��¼��ʱ�䣬Ĭ��Ϊ&nbsp;3&nbsp;���£�0 Ϊ���ñ���</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=3 name="trashKeepMonths"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>�Ƿ��ͼ�ʱ�ʼ�֪ͨ:</B><BR>
			<SPAN class=smalltxt>�����������¼�ʱ��ϵͳ�Զ������ʼ�֪ͨ����Ա��������ΰ���</SPAN></TD>
          <TD class=altbg2>		  
			<INPUT class=checkbox type=checkbox value="error" name="[chk]mailEvents" id="mailEvents[error]"> ϵͳ���� <br/>
			<INPUT class=checkbox type=checkbox value="audit" name="[chk]mailEvents" id="mailEvents[audit]"> ���û�������� <br/>
			<INPUT class=checkbox type=checkbox value="report" name="[chk]mailEvents" id="mailEvents[report]"> �յ��ٱ���Ϣ <br/>
			<INPUT class=checkbox type=checkbox value="version" name="[chk]mailEvents" id="mailEvents[version]"> ��ϵͳ��������Ϣ 
			<INPUT type=hidden value="" name="[chk]mailEvents" id="mailEvents[]">
			</TD></TR>
		</TBODY></TABLE><BR>
		<A name=tb02></A>
      <TABLE class=info_tb cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR class=header>
          <TD colSpan=2>RSS ����<A onClick="collapse_change('tb02','../images')" href="#">
		    <IMG id=menuimg_tb02 style="MARGIN-TOP: -12px; FLOAT: right; MARGIN-RIGHT: 8px" 
	             src="../images/menu_reduce.gif" border=0></A> </TD></TR>
        <TBODY id=menu_tb02>
        <TR>
          <TD class=altbg1 width="45%"><B>Ĭ�ϵ�&nbsp;RSS&nbsp;�����ʽ:</B><BR><SPAN class=smalltxt>
ָ��Ĭ�ϵ�&nbsp;RSS&nbsp;�����ʽ��������ʽ�����������ÿ������ı�����Ϣ������ȫ��ʽ����������ÿ������ı����������Ϣ��
ͨ��ʹ�ú��ʵ�&nbsp;RSS&nbsp;�ͻ����������ȫ��ʽ��������Լ���������ʴ���������Ķ�Ч�ʣ��Ӷ����ܼ������������</SPAN></TD>
          <TD class=altbg2>		  
			<INPUT class=radio type=radio value="A" name="RssStyle" id="RssStyle[A]" checked> ȫ��ʽ <br/>
			<INPUT class=radio type=radio value="B" name="RssStyle" id="RssStyle[B]"> ����ʽ 
			</TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>RSS ���������:</B><BR><SPAN 
            class=smalltxt>ÿ��&nbsp;RSS&nbsp;Ƶ�������������Ŀ������Ϊ100</SPAN></TD>
          <TD class=altbg2><INPUT size=50 value=15 name="topicsPerChannel"> </TD></TR>
        <TR>
          <TD class=altbg1 width="45%"><B>��ʾ&nbsp;RSS&nbsp;���İ�ť</B><BR><SPAN class=smalltxt>
ָ����&nbsp;RSS&nbsp;����ҳ���Ƿ���ʾ�����ġ���ť&nbsp;(ʹ��&nbsp;Wisol&nbsp;Reader&nbsp;���ж���)</SPAN></TD>
          <TD class=altbg2>		  
			<INPUT class=radio type=radio value="yes" name="RssSub" id="RssSub[yes]" checked> �� &nbsp;
			<INPUT class=radio type=radio value="no" name="RssSub" id="RssSub[no]"> �� 
			</TD></TR>
		</TBODY></TABLE><BR>
      <CENTER><INPUT class=button type=submit value="�� ��"></CENTER></FORM>
	  </TD></TR></TBODY></TABLE><BR><BR>
<script language="javascript">
function checkfields(theform) {
    var filter = /^\d+$/;
    if (!filter.test(trim(theform.logKeepMonths.value))) {
    	alert('�����¼����ʱ�����Ϊ����');
      	theform.logKeepMonths.focus();
		return;
    }
    if (!filter.test(trim(theform.trashKeepMonths.value))) {
    	alert('����վ��¼����ʱ�����Ϊ����');
      	theform.trashKeepMonths.focus();
		return;
    }
    if (!filter.test(trim(theform.maxPostLength.value))) {
    	alert('���������������Ϊ����');
      	theform.maxPostLength.focus();
		return;
    }
    if (!filter.test(trim(theform.maxReplies.value))) {
    	alert('�����������������Ϊ����');
      	theform.maxReplies.focus();
		return;
    }
    if (!filter.test(trim(theform.maxAttachNum.value))) {
    	alert('������󸽼�������Ϊ����');
      	theform.maxAttachNum.focus();
		return;
    }
    if (!filter.test(trim(theform.maxAttachSize.value))) {
    	alert('��󸽼��ߴ����Ϊ����');
      	theform.maxAttachSize.focus();
		return;
    }
	theform.submit();
}
$('settings').maxPostLength.value = "<%= setting.getInt(ForumSetting.FUNCTIONS,"maxPostLength") %>";
$('settings').maxAttachNum.value = "<%= setting.getInt(ForumSetting.FUNCTIONS,"maxAttachNum") %>";
$('settings').allowAttachTypes.value = 
	"<%= setting.getHTMLStr(ForumSetting.FUNCTIONS,"allowAttachTypes") %>";
$('settings').maxAttachSize.value = "<%= setting.getInt(ForumSetting.FUNCTIONS,"maxAttachSize") %>";
$('settings').maxReplies.value = "<%= setting.getInt(ForumSetting.FUNCTIONS,"maxReplies") %>";
$('settings').logKeepMonths.value = "<%= setting.getInt(ForumSetting.FUNCTIONS,"logKeepMonths") %>";
$('settings').trashKeepMonths.value = "<%= setting.getInt(ForumSetting.FUNCTIONS,"trashKeepMonths") %>";
$('settings').judgeOptions.value = "<%= setting.getHTMLStr(ForumSetting.FUNCTIONS,"judgeOptions",judgeOptions.toString()) %>";
<%
	for (int i=0; i<mailEvents.length; i++)
	{
		if (mailEvents[i] != null && mailEvents[i].trim().length() > 0)
		{
%>
$('mailEvents[<%= mailEvents[i] %>]').checked = "true";
<%
		}
	}
%>
$('RssStyle[<%= setting.getHTMLStr(ForumSetting.FUNCTIONS,"RssStyle") %>]').checked = "true";
$('settings').topicsPerChannel.value = "<%= setting.getInt(ForumSetting.FUNCTIONS,"topicsPerChannel") %>";
$('RssSub[<%= setting.getHTMLStr(ForumSetting.FUNCTIONS,"RssSub","yes") %>]').checked = "true";
</script>	  
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>
