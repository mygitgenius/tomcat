<%@ page contentType="text/html;charset=gbk" errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%
	UserInfo userinfo = PageUtils.getLoginedUser(request, response);
	if (userinfo == null) return;

	String forumName = ForumSetting.getInstance().getForumName();
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = "../index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);

	CacheManager cache = CacheManager.getInstance();
    ArrayList groups = cache.getGroups();
	
	String act = request.getParameter("act");
	if (act == null || act.length() == 0)
		act = "my";
		
	String groupID = request.getParameter("gid");
	GroupVO currentGroup = null;
	if (groupID == null || groupID.length() == 0)
	{
		currentGroup = PageUtils.getGroupVO(userinfo);
	}
	else
		currentGroup = cache.getGroup(groupID.charAt(0));
		
	String rights = currentGroup.rights;
	String adminRight = "��";
	if (currentGroup.groupID == 'A')
		adminRight = "ȫ��̳";
	else if (currentGroup.groupID == 'M' || currentGroup.groupID == 'S')
		adminRight = "��������İ��";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�ҵ�Ȩ�� - <%= title %></TITLE>
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
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A> &raquo;&nbsp; �ҵ�Ȩ��</DIV>
<DIV class=container><DIV class=content>
<DIV class=mainbox>
<H1>�ҵ�Ȩ��</H1>
<UL class="tabs headertabs">
  <LI<%= act.equals("my")?" class=current":"" %>><A href="./my_rights.jsp">�ҵ�Ȩ��</A> </LI>
  <LI class="<%= act.equals("member")?"current ":"" %>dropmenu" style='BACKGROUND-POSITION:95%'><A id=membergroup 
  		onmouseover=showMenu(this.id) href="###">��Ա�û���</A> </LI>
  <LI class="<%= act.equals("system")?"current ":"" %>dropmenu" style='BACKGROUND-POSITION:95%'><A id=systemgroup 
  		onmouseover=showMenu(this.id) href="###">ϵͳ�û���</A> 
</LI></UL>
<UL class="popmenu_popup headermenu_popup" id=membergroup_menu style="DISPLAY: none">
<%
	if (groups != null)
	{
		GroupVO aGroup = null;
		for (int i=0; i<groups.size(); i++)
		{
			aGroup = (GroupVO)groups.get(i);
			if (aGroup.groupType == 'M')
			{
%>			
  <LI><A href="./my_rights.jsp?act=member&gid=<%= aGroup.groupID %>"><%= aGroup.groupName %></A></LI>
<%
			}
		}
	}		
%>  
</UL>
<UL class="popmenu_popup headermenu_popup" id=systemgroup_menu style="DISPLAY: none">
<%
	if (groups != null)
	{
		GroupVO aGroup = null;
		for (int i=0; i<groups.size(); i++)
		{
			aGroup = (GroupVO)groups.get(i);
			if (aGroup.groupType == 'S')
			{
%>			
  <LI><A href="./my_rights.jsp?act=system&gid=<%= aGroup.groupID %>"><%= aGroup.groupName %></A></LI>
<%
			}
		}
	}
	
	int count1 = -1;
	int count2 = currentGroup.stars;
	if (currentGroup.stars > 5)
	{
		count1 = currentGroup.stars / 5;
		count2 = currentGroup.stars % 5;
	}
	
	String boards = null;
	if (act.equals("my"))
	{
		String user_id = "," + userinfo.userID + ",";
		if (cache.getModerators().indexOf(user_id) >= 0)
		{
			SectionVO aSection = null;
			BoardVO aBoard = null;
			ArrayList sections = cache.getSections();
			String moderators = null;
			StringBuilder sbuf = new StringBuilder();
						
			for (int i=0; i<sections.size(); i++)
			{
				aSection = (SectionVO)sections.get(i);
				for (int j=0; j<aSection.boardList.size(); j++)
				{
					aBoard = (BoardVO)aSection.boardList.get(j);
					moderators = PageUtils.getModerators(aSection, aBoard);
					if (moderators.indexOf(user_id) >= 0)
					{
						if (sbuf.length() > 0)
							sbuf.append(", ");
						sbuf.append(aBoard.boardName);
					}
				}
			}
			if (sbuf.length() > 0)
			{
				GroupVO aGroup = null;
	        	if (userinfo.groupID <= '9')
                	aGroup = cache.getGroup('M');
                else
                    aGroup = cache.getGroup(userinfo.groupID);
				boards = aGroup.groupName + " ��" + sbuf.toString() + "��";
			}
		}
	}		
%>  
</UL>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <THEAD>
  <TR>
    <TD colSpan=2>�û���</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH width="25%">�û�����:</TH>
    <TD width="75%"><%= currentGroup.groupName %></TD></TR>
  <TR>
    <TH>�û��鼶��:</TH>
    <TD>
		<%	for (int j=0; j<count1; j++) { %><IMG alt="Rank: <%= currentGroup.stars %>" 
		src="../images/star_5.gif" align="absmiddle" border="0"><% } for (int j=0; j<count2; j++) { %><IMG 
		alt="Rank: <%= currentGroup.stars %>" src="../images/star_1.gif" align="absmiddle" border="0"><% } %>
	</TD></TR>
<%
	if (boards != null) {
%>		
  <TR>
    <TH>���Ȩ��:</TH>
    <TD><%= boards %></TD></TR>
<%	} %>
  <THEAD>
  <TR>
    <TD colSpan=2>����Ȩ��</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH>���������̳:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_VISIT_FORUM)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����鿴��Ա�б�:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_VIEW_MEMBERS)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����鿴�û���Ϣ:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_VIEW_USERINFO)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����鿴ͳ������:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_VIEW_STAT)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>�����ϴ�ͷ��:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_UPLOAD_AVATAR)>=0?"right":"error" %>.gif"></TD></TR>
  <THEAD>
  <TR>
    <TD colSpan=2>�������</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH>�����»���:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_NEW_TOPIC)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>��������������:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_NEW_REWARD)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����������:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_HIDE_POST)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>������ظ�:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_NEW_REPLY)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����ʹ��&nbsp;HTML&nbsp;����:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_USE_HTML)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>�����ö�����:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_TOP_POST)>=0?"right":"error" %>.gif"></TD></TR>
  <THEAD>
  <TR>
    <TD colSpan=2>�������</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH>��������/�鿴����:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_DOWNLOAD)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����������:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_UPLOAD)>=0?"right":"error" %>.gif"></TD></TR>
  <THEAD>
  <TR>
    <TD colSpan=2>����Ȩ��</TD></TR></THEAD>
  <TBODY>
  <TR>
    <TH>����Χ:</TH>
    <TD><%= adminRight %></TD></TR>
<%
	if (!adminRight.equals("��")) {
%>	
  <TR>
    <TH>����ȫ���ö�����:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_TOP_GLOBAL)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����༭����:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_EDIT_POST)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����ɾ������:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_DELETE_POST)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����ر�����:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_CLOSE_POST)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>�����ƶ�����:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_MOVE_POST)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����༭�û�:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_EDIT_USER)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����ִ�л��ֽ���:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_EDIT_CREDITS)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>�����ֹ�û�:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_BAN_USER)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>��������û�:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_AUDIT_USER)>=0?"right":"error" %>.gif"></TD></TR>
  <TR>
    <TH>����ɾ���û�:</TH>
    <TD><IMG src="../images/check_<%= rights.indexOf(IConstants.PERMIT_DELETE_USER)>=0?"right":"error" %>.gif"></TD></TR>
<%
	}
%>	
</TBODY></TABLE></DIV></DIV>
<DIV class=side>
<DIV>
<H2>�ҵĿռ�</H2>
<UL>
  <LI><H3><A href="../uspace.jsp?uid=<%= userinfo.userID %>" target="_blank">������Ϣҳ</A></H3></LI>
  <LI><H3><A href="my_profile.jsp">�༭��������</A></H3></LI>
  <LI><H3><A href="sms_list.jsp">����Ϣ</A></H3></LI>
  <LI><H3><A href="my_topics.jsp">�ҵĻ���</A></H3></LI>
  <LI><H3><A href="my_favors.jsp">�ҵ��ղ�</A></H3></LI>
  <LI><H3><A href="my_friends.jsp">�ҵĺ���</A></H3></LI>
  <LI class="side_on"><H3><A href="my_rights.jsp">�ҵ�Ȩ��</A></H3></LI>
  <LI><H3><A href="my_credits.jsp">���ֽ��׼�¼</A></H3></LI>
</UL>
</DIV>
<DIV>
<H2>���ָſ�</H2>
<UL class="credits">
  <LI>����: <%= userinfo.credits %></LI>
  <LI>����: <%= userinfo.posts %></LI>
</UL></DIV></DIV></DIV></DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request,forumStyle) %>
</BODY></HTML>
