<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%
	UserInfo userinfo = PageUtils.getSessionUser(request);

	GroupVO userGroup = PageUtils.getGroupVO(userinfo);
	if (userGroup.rights.indexOf(IConstants.PERMIT_VISIT_FORUM) < 0)
	{
		request.setAttribute("errorMsg", "�ܱ�Ǹ����ȱ���㹻�ķ���Ȩ��");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}

	boolean isModerator = false;
	if (userGroup.groupID == 'A' || userGroup.groupID == 'M' || userGroup.groupID == 'S')
		isModerator = true;

	String ctxPath = request.getContextPath();
	String serverName = request.getServerName();
	if (!ctxPath.equals("/"))
		serverName = serverName + ctxPath;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "./index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);

	CacheManager cache = CacheManager.getInstance();
    ArrayList sections = cache.getSections();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���� - <%= title %></TITLE>
<LINK href="styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;" onload="clickgoogle()">
<SCRIPT src="js/common.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %>
</DIV>
<%= menus[0] %>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; ��̳����</DIV>
<FORM id=frmsearch action="search_result.jsp" method=post onsubmit="return validate(this)">
<DIV class="mainbox formbox">
<H1>��̳����</H1>
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TH width="10%">������ʽ</TH>
    <TD width="40%">
	  <LABEL><INPUT onclick="clickgoogle()" type=radio CHECKED value=google name=searchfield 
	  			id="searchfield_google"> Google ����</LABEL> 
	  <LABEL><INPUT onclick="clickgoogle()" type=radio value=title name=searchfield
	  			id="searchfield_title"> ��������</LABEL> 
	  <LABEL><INPUT onclick="clickgoogle()" type=radio value=content name=searchfield
	  			id="searchfield_content"> ȫ������������+�ظ���</LABEL> </TD>
	 <TD width="50%">���µ�������ܲ��ᱻ������</TD></TR></TBODY>
  <TBODY>
  <TR>
    <TH><LABEL for=keys>�ؼ���</LABEL></TH>
    <TD><INPUT id=keys maxLength=50 size=60 name=keys></TD>
    <TD>����ؼ���֮�����ÿո�򶺺ŷָ�, ����&nbsp;"�ƻ� С˵"&nbsp;��ʾͬʱ�����������ؼ���</TD></TR></TBODY>
  <TBODY id=notgoogle1>
  <TR>
    <TH><LABEL for=uid>�û���</LABEL></TH>
    <TD><INPUT id=uid maxLength=50 size=60 name=uid></TD>
    <TD>�û������û��ǳ�</TD></TR></TBODY>
  <TBODY id=notgoogle2>
  <TR>
    <TD vAlign=top><LABEL for=boardid>������Χ</LABEL></TD>
    <TD>
	  <SELECT id=boardid style="width: 335px" name=boardid> 
	    <OPTION value="" selected>���а��</OPTION> 
		<OPTION value="">&nbsp;</OPTION> 
<%
	if (sections != null)
	{
		SectionVO tmpSection = null;
		BoardVO tmpBoard = null;
		StringBuilder sb = new StringBuilder();
		
		for (int i=0; i<sections.size(); i++)	
		{
			tmpSection = (SectionVO)sections.get(i);
			if (tmpSection.boardList == null) continue;
			sb.append("<OPTGROUP label=\"").append(tmpSection.sectionName).append("\">\n");
			for (int j=0; j<tmpSection.boardList.size(); j++)
			{
				tmpBoard = (BoardVO)tmpSection.boardList.get(j);
				if (tmpBoard.state == 'I' && !isModerator) continue;
				sb.append("<OPTION value=\"").append(tmpBoard.boardID).append("\">&nbsp; &gt; ")
				  .append(tmpBoard.boardName).append("</OPTION>\n");
			}
			sb.append("</OPTGROUP>");
		}
		out.write(sb.toString());
	}
%>
	  </SELECT></TD>
	<TD>&nbsp;</TD></TR></TBODY>
  <TBODY>
  <TR class="btns">
    <TH>&nbsp;</TH>
    <TD height="30"><BUTTON class=submit name=searchsubmit type=submit>����</BUTTON></TD>
	<TD>&nbsp;</TD></TR></TBODY></TABLE></DIV></FORM>
<SCRIPT type=text/javascript>
function validate(theform) {
	if (trim(theform.keys.value) == '') {
		alert("�����������ؼ���");
		theform.keys.focus();
		return false;
	}
	if($('searchfield_google').checked) {
		window.open("http://www.google.cn/search?ie=GB2312&oe=GB2312&hl=zh-CN&sitesearch="
       	         	+ "<%= serverName %>&q=" + trim(theform.keys.value));
		return false;
	}
	return true;
}
function clickgoogle() {
	if($('searchfield_google').checked) {
		$('notgoogle1').style.display = 'none';
		$('notgoogle2').style.display = 'none';
	} else {
		$('notgoogle1').style.display = '';
		$('notgoogle2').style.display = '';
	}
}
</SCRIPT>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request, forumStyle) %>
</BODY></HTML>
