<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%
	if (!request.isRequestedSessionIdFromCookie())
	{
		request.setAttribute("errorMsg", "�������������� Cookie ֧�ֹ���, ���߽���վ��Ϊ����վ��, ������ע��");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}

	String ctxPath = request.getContextPath();
    String fromPath = request.getParameter("from");
	if (fromPath == null)
		fromPath = "";
		
	ForumSetting setting = ForumSetting.getInstance();	
	String forumName = setting.getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, null);
	String homeUrl = ctxPath + "/index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
	
    String registerType = setting.getString(ForumSetting.ACCESS, "registerType");
	String registerTip = null;
    if (registerType != null && registerType.equalsIgnoreCase("close"))
        registerTip = "<font style='color:#090'>(&nbsp;ע����辭����Ա��˲Ż���Ч&nbsp;)</font>";
	else
		registerTip = "";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>ע�����û� - <%= title %></TITLE>
<LINK href="styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;" onload="loaded()">
<SCRIPT src="js/common.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/member.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/ajax.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/md5.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %></DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; ע��</DIV>
<FORM name="register" onsubmit="return checkfields();" action="perform.jsp?act=reg" method="post">
<INPUT type=hidden name=fromPath value="<%= fromPath %>">
<DIV class="mainbox formbox"><SPAN class=headactions><A class=notabs
href="./help/credits_rule.jsp" target=_blank>�鿴���ֲ���˵��</A> </SPAN> 
<H1>ע��</H1>
<TABLE cellSpacing=0 cellPadding=0>
  <THEAD>
  <TR>
    <TH>������Ϣ ( * Ϊ������)</TH>
    <TD><%= registerTip %></TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH><LABEL for=verifycode>��֤�� *</LABEL></TH>
    <TD>
      <DIV id=verifycodeimage style="margin-bottom:3px"></DIV><INPUT id=verifycode onblur=checkverifycode() 
      tabIndex=1 maxLength=4 size=15 name=verifycode> <SPAN id=checkverifycode></SPAN></TD>
	    <SCRIPT type=text/javascript>
				refreshVerifyCode(112,42);
		</SCRIPT>
  </TR>
  <TR>
    <TH><LABEL for=userID>�û��� *</LABEL></TH>
    <TD><INPUT id=userID onblur=checkuserID() tabIndex=2 maxLength=15 
      size=25 name=userID> <SPAN id=checkuserID>&nbsp;</SPAN> </TD></TR>
  <TR>
    <TH><LABEL for=nickname>�س�</LABEL></TH>
    <TD><INPUT id=nickname tabIndex=3 maxLength=15 size=25 name=nickname></TD></TR>
  <TR>
    <TH><LABEL for=pwd1>���� *</LABEL></TH> 
    <TD><INPUT id=pwd1 tabIndex=4 type=password maxLength=15
      size=25 name=pwd1> <SPAN id=checkpwd>&nbsp;</SPAN>
	  <INPUT type=hidden id=pwd name=pwd></TD></TR>
  <TR>
    <TH><LABEL for=pwd2>ȷ������ *</LABEL></TH>
    <TD><INPUT id=pwd2 onblur=checkpwd2() tabIndex=5 type=password maxLength=15
      size=25 name=pwd2> <SPAN id=checkpwd2>&nbsp;</SPAN> </TD></TR>
  <TR>
    <TH><LABEL for=email>Email *</LABEL></TH> 
    <TD><INPUT id=email onblur=checkemail() tabIndex=6 size=25 maxLength=40 name=email> 
      <SPAN id=checkemail>&nbsp;</SPAN></TD></TR>
  <TR>
    <TH>&nbsp;</TH>
    <TD><INPUT class=checkbox id=advshow onclick=showadv() tabIndex=12 
      type=checkbox value=1 name=advshow> ��ʾ��չ��Ϣ</TD></TR></TBODY></TABLE>
<TABLE id=adv style="DISPLAY: none" cellSpacing=0 cellPadding=0>
  <THEAD>
  <TR>
    <TH>��չ��Ϣ</TH>
    <TD>&nbsp;</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH>�Ա�</TH>
    <TD><INPUT tabIndex=17 type=radio value=M name=gender> ��&nbsp; 
      <INPUT tabIndex=18 type=radio value=F name=gender> Ů&nbsp; 
      <INPUT tabIndex=19 type=radio CHECKED value=U name=gender> ���� </TD></TR>
  <TR>
    <TH><LABEL for=birth>����</LABEL></TH>
    <TD><INPUT id=birth tabIndex=20 size=25 maxLength=10 value=1970-01-01 name=birth>
		(&nbsp;��ʽΪ yyyy-mm-dd , ��-��-��&nbsp;)
	</TD></TR>
  <TR>
    <TH><LABEL for=city>����</LABEL></TH>
    <TD><INPUT id=city tabIndex=21 size=25 maxLength=20 name=city></TD></TR>
  <TR>
    <TH><LABEL for=webpage>������ҳ</LABEL></TH>
    <TD><INPUT id=webpage tabIndex=22 size=25 maxLength=40 name=webpage></TD></TR>
  <TR>
    <TH><LABEL for=icq>QQ/MSN</LABEL></TH>
    <TD><INPUT id=icq tabIndex=23 size=25 maxLength=40 name=icq></TD></TR>
  <TR>
    <TH vAlign=top><LABEL for=brief>���ҽ���&nbsp;/&nbsp;����ǩ��</LABEL></TD> 
    <TD><TEXTAREA id=brief tabIndex=28 name=brief rows=5 cols=40 maxLength=200></TEXTAREA></TD></TR>
  <TR>
    <TH></TH>
    <TD><INPUT tabIndex=42 type=checkbox value=T name=isMailPub> 
      Email ��ַ�ɼ�</TD></TR>
</TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR class="btns">
    <TH><LABEL>ע������</LABEL></TH>
    <TD>
	<INPUT class=checkbox id=protocol tabIndex=99 type=checkbox value='T' onclick="agreerule()" 
 	 name=protocol>&nbsp;������ϸ�Ķ�������&nbsp;&raquo;&nbsp;<a href="./help/protocol.jsp" target="_blank">��̳�û�����</a>
	  </TD></TR>
  <TR>
    <TH>&nbsp;</TH>
    <TD height="30">
	<BUTTON class=submit tabIndex=100 name=regsubmit type=submit disabled id=regsubmit style="color:gray">�ύ</BUTTON>
    </TD></TR></TBODY></TABLE></DIV></FORM>
<SCRIPT type=text/javascript>
var verifycode_invalid = '��֤�����������������д';
var passwd_dismatch = '������������벻һ�£����������';
var lastuserID = lastpwd = lastemail = '';

$('userID').focus();

function checkfields() 
{
	if (trim($('userID').value) == '')
	{
		warning($('checkuserID'), '�������û���');
		return false;
	}
	var tmpStr = trim($('userID').value);
	if (tmpStr.indexOf('=') >= 0 || tmpStr.indexOf('*') >= 0 || tmpStr.indexOf('\\') >= 0 
		|| tmpStr.indexOf('&') >= 0 || tmpStr.indexOf('>') >= 0 || tmpStr.indexOf('<') >= 0
		|| tmpStr.indexOf(',') >= 0 || tmpStr.indexOf('\'') >= 0 || tmpStr.indexOf('"') >= 0)
	{
		warning($('checkuserID'), '�Բ����û����в��ܰ��������ַ���= * & < > , \" \' \\');
		return false;
	}
	if (trim($('pwd1').value) == '')
	{
		warning($('checkpwd'), '����������');
		return false;
	}
	if (trim($('pwd2').value) == '')
	{
		warning($('checkpwd2'), '���ٴ���������');
		return false;
	}
	if (!checkpwd2())
	{
		return false;
	}
	if (trim($('email').value) == '')
	{
		warning($('checkemail'), '���������� Email');
		return false;
	}
	if (trim($('verifycode').value) == '')
	{
		warning($('checkverifycode'), '��������֤��');
		return false;
	}
	if (!checkverifycode())
	{
		$('verifycode').focus();
		return false;
	}
	$('pwd').value = hex_md5(trim($('pwd1').value)); 
	$('pwd1').value = '';
	register.regsubmit.disabled = true;
}
function checkuserID() {
	var userID = trim($('userID').value);
	$('userID').value = userID = userID.replace(/[\s]+/g, ''); 
	
	if(userID == lastuserID) {
		return;
	} else {
		lastuserID = userID;
	}
	var cu = $('checkuserID');
	var unlen = userID.replace(/[^\x00-\xff]/g, "**").length;

	if(unlen < 3) {
		warning(cu, '�Բ�����������û���С��3���ַ�, ������һ���ϳ����û���');
		return;
	}
    ajaxcheck('checkuserID', 'act=checkuserID&user=' + 
			 (is_ie && document.charset == 'utf-8' ? encodeURIComponent(userID) : userID));
}
function checkemail() {
	var email = trim($('email').value);
	if(email == lastemail) {
		return;
	} else {
		lastemail = email;
	}
	if(!isLegalEmail(email)) {
		var ce = $('checkemail');
		warning(ce, 'Email ��ַ��Ч����������д');
		return;
	}
	ajaxcheck('checkemail', 'act=checkemail&mail=' + 
			 (is_ie && document.charset == 'utf-8' ? encodeURIComponent(email) : email));		
}
function ajaxcheck(objId, data) {
   	var x = new Ajax();
   	x.get('ajax?' + data, function(s){
   	        var obj = $(objId);
   	        if(s == 'OK') {
     	        obj.style.display = '';
       	        obj.innerHTML = '&nbsp;';
        		obj.className = "passed";
       		} else {
       			warning(obj, s);
       		}
   	});
}
function showadv() {
	if(document.register.advshow.checked == true) {
		$("adv").style.display = "";
	} else {
		$("adv").style.display = "none";
	}
}
function agreerule() {
	if(document.register.protocol.checked == true) {
		$("regsubmit").disabled = false;
		$("regsubmit").style.color = "#090";
	} else {
		$("regsubmit").disabled = true;
		$("regsubmit").style.color = "gray";
	}
}
function loaded() {
	agreerule();
}	
</SCRIPT>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request, forumStyle) %>
</BODY></HTML>
