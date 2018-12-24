<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserVO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String ctxPath = request.getContextPath();
	ForumSetting setting = ForumSetting.getInstance();
	String forumName = setting.getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
	CacheManager cache = CacheManager.getInstance();
    GroupVO aGroup = PageUtils.getGroupVO(userinfo);
	
	String upload = null;
	if (aGroup.rights.indexOf(IConstants.PERMIT_UPLOAD_AVATAR) < 0)
		upload = " style='display:none'";
	else
		upload = "";	
	
	String userID = userinfo.userID;
	
	UserVO aUser = UserDAO.getInstance().getUserVO(userID);
	if (aUser == null)
	{		
		request.setAttribute("errorMsg", "���û��������ڻ��Ѿ���ɾ��");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}
	int maxAvatarSize = setting.getInt(ForumSetting.MISC, "maxAvatarPixels");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�༭�������� - <%= title %></TITLE>
<%= PageUtils.getMetas(title, null) %>
<LINK href="../styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="../js/common.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �༭��������</DIV>
<DIV class=container><DIV class=content>
<SCRIPT type=text/javascript>
var encoding = 'gbk';
function validate(theform) {
	if(uc_strlen(theform.brief.value) > 200) {
		alert('�������ҽ��ܳ��ȳ��� 200 �ַ������ƣ��뷵���޸ġ�');
		theform.brief.focus();
		return false;
	}
	return true;
}
function previewavatar(url) {
	if(url) {
		$('avatarview').innerHTML = '<img id="previewimg" onload="resizeImage(this, <%= maxAvatarSize %>);"/><br/>';
		$('previewimg').src = "<%= ctxPath %>/upload/avatar/" + url;
	} else {
		$('avatarview').innerHTML = '';
	}
}
function customavatar(value) {
	$('urlavatar').value = '';
	if(value) previewavatar('');
}
function selectavatar(value) {
	if($('urlavatar')) { 
		$('urlavatar').value = value;
		previewavatar(value); 
		switchavatarlist();
	}
}
function switchavatarlist() {
	if ($('avatardiv').style.display == 'none')
		$('avatardiv').style.display = '';
	else
		$('avatardiv').style.display = 'none';
}
</SCRIPT>
<FORM name="settings" onSubmit="return validate(this)" action="../perform.jsp?act=member_special" 
	  method=post enctype="multipart/form-data">
<DIV class="mainbox formbox">
<H1>�༭��������</H1>
<UL class="tabs">
  <LI><A href="my_pwd.jsp">�޸�����</A> </LI>
  <LI><A href="my_profile.jsp">��������</A> </LI>
  <LI class=current><A href="my_special.jsp">���Ի�����</A> </LI>
</UL>
<TABLE cellSpacing=0 cellPadding=0 summary=�༭��������>
  <TBODY>
  <TR>
    <TH vAlign=top><LABEL for=urlavatar>ͷ��<BR/>
		(&nbsp;<%= maxAvatarSize %>x<%= maxAvatarSize %>&nbsp;��������&nbsp;)</LABEL></TH>
    <TD><SPAN id=avatarview></SPAN>
		<INPUT id=urlavatar onchange=previewavatar(this.value) size=25 name=urlavatar> &nbsp; 
		<A href="#" onclick="switchavatarlist();">��̳ͷ���б�</A> 
		<DIV id=avatardiv style="MARGIN-TOP: 10px; DISPLAY: none">
			<jsp:include page="../include/avatars.html"/>
		</DIV><BR>
	  <INPUT type=file onchange="customavatar(this.value);" size=60 name=avatarcustom<%= upload %>>
	</TD></TR>
  <TR>
    <TH vAlign=top><LABEL for=brief>���ҽ���&nbsp;/&nbsp;����ǩ��<BR/>(&nbsp;200 ��������&nbsp;)</LABEL></TH>
    <TD>
      <TEXTAREA id=brief style="WIDTH: 393px" name=brief rows=7><%= aUser.brief==null?"":aUser.brief %></TEXTAREA> 
    </TD></TR>
  <TR>
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit name=editsubmit type=submit>�ύ</BUTTON></TD></TR>
	</TBODY></TABLE></DIV></FORM></DIV>
<script language="javascript">
$('urlavatar').value = "<%= aUser.avatar==null?"":aUser.avatar %>";
previewavatar($('urlavatar').value);
</script>	  
<DIV class=side>
<DIV>
<H2>�ҵĿռ�</H2>
<UL>
  <LI><H3><A href="../uspace.jsp?uid=<%= userID %>" target="_blank">������Ϣҳ</A></H3></LI>
  <LI class="side_on"><H3><A href="my_profile.jsp">�༭��������</A></H3></LI>
  <LI><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
  <LI><H3><A href="my_topics.jsp">�ҵĻ���</A></H3></LI>
  <LI><H3><A href="my_favors.jsp">�ҵ��ղ�</A></H3></LI>
  <LI><H3><A href="my_friends.jsp">�ҵĺ���</A></H3></LI>
  <LI><H3><A href="my_rights.jsp">�ҵ�Ȩ��</A></H3></LI>
  <LI><H3><A href="my_credits.jsp">���ֽ��׼�¼</A></H3></LI>
</UL>
</DIV>
<DIV>
<H2>���ָſ�</H2>
<UL class="credits">
  <LI>����: <%= aUser.credits %></LI>
  <LI>����: <%= aUser.posts %></LI>
</UL></DIV></DIV></DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
