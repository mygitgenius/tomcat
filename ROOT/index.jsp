<%@ page contentType="text/html;charset=gbk" errorPage="error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.util.AppUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.AppContext"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.StatDAO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%
	String ctxPath = request.getContextPath();
	String serverName = request.getServerName();
	if (!ctxPath.equals("/"))
		serverName = serverName + ctxPath;
	
	AppContext appCtx = AppContext.getInstance();
	CacheManager cache = CacheManager.getInstance();
    ArrayList sections = cache.getSections();
	
	String sectionID = PageUtils.getParam(request,"sid");
	StringBuilder sbuf = new StringBuilder();
	SectionVO currentSection = null;
	String sectionLink = null;
	
	ForumSetting setting = ForumSetting.getInstance();
	if (sectionID != null && sectionID.length() > 0)
	{
		currentSection = cache.getSection(sectionID);
		if (currentSection != null)
		{
			String showSectionLink = setting.getString(ForumSetting.DISPLAY, "showSectionLink");
			if (showSectionLink.equalsIgnoreCase("yes"))
			{
				sbuf.append(" &raquo;&nbsp; ").append(currentSection.sectionName);
				sectionLink = sbuf.toString();
			}
		}
	}
	
	String forumName = setting.getForumName();
	String title = PageUtils.getTitle(forumName);
	UserInfo userinfo = PageUtils.getSessionUser(request);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = ctxPath + "/index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);

	boolean isModerator = false;
	GroupVO userGroup = PageUtils.getGroupVO(userinfo, cache.getModerators());
	if (userGroup.groupID == 'A' || userGroup.groupID == 'M' || userGroup.groupID == 'S')
		isModerator = true;
	
	HashMap statInfo = StatDAO.getInstance().getBaseStatInfo();
	int topics = Integer.parseInt((String)statInfo.get("topics"));
	int replies = Integer.parseInt((String)statInfo.get("replies"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%= title %></TITLE>
<%= PageUtils.getMetas(title, null) %>
<%= PageUtils.getRSSLink(request, forumName, currentSection, null) %>
<LINK href="styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY onkeydown="if(event.keyCode==27) return false;">
<SCRIPT src="js/common.js" type=text/javascript></SCRIPT>
<DIV class=wrap>
<DIV id=header>
<%= PageUtils.getHeader(request, title) %>
<%= PageUtils.getHeadAdBanner(request, null) %>
</DIV>
<%= menus[0] %>
<DIV id=foruminfo>
<DIV id=nav><A href="<%= homeUrl %>"><%= forumName %></A><%= sectionLink==null?"":sectionLink %>
<% if (userinfo != null) { %><p>��ӭ&nbsp;<%= userinfo.userID %>, 
���ϴη�������&nbsp;<%= AppUtils.formatSQLTimeStr(userinfo.lastVisited) %><br/>
<a href="spec_topics.jsp?spec=recent&uid=<%= userinfo.userID %>" style="font-weight:normal">�鿴������</a></p>
<% } else { %>
<p><form id=loginform method=post name=login action="<%= ctxPath %>/perform.jsp?act=lgn" 
    style="vertical-align:middle" onSubmit="checkfield(this); return false;">
<input type=hidden name=cookietime value=0/>
<input type=text id=userID name=userID size=13 maxlength=30 tabindex=1/>
<input type=password id=pwd1 name=pwd1 size=8 tabindex=2 onkeypress="if((event.keyCode?event.keyCode:event.charCode)==13) $('loginform').submit();"/><INPUT type=hidden id=pwd name=pwd>&nbsp;<button type=submit name=loginsubmit tabIndex=3 style="width:46px">��¼</button>
</form></p>
<SCRIPT src="<%= ctxPath %>/js/md5.js" type=text/javascript></SCRIPT>
<SCRIPT type=text/javascript>
function checkfield(theform) {
	if(trim($('userID').value) == '') {
		$('userID').focus();	return false;
	} else if(trim($('pwd1').value) == '') {
		$('pwd1').focus(); return false;
	} else {
		$('pwd').value = hex_md5(trim($('pwd1').value)); 
		$('pwd1').value = '';
		theform.submit();return false;
	}
}
</SCRIPT>
<% } %>
</DIV>
<DIV id=headsearch>
<P style="margin-bottom:5px; margin-right:2px">
����: <em><%= topics %></em>&nbsp; ����: <em><%= topics + replies %></em>&nbsp; 
<A href="spec_topics.jsp?spec=reward">����</A><em>: <%= (String)statInfo.get("rewards") %></em>&nbsp; 
<A href="spec_topics.jsp?spec=digest">����</A><em>: <%= (String)statInfo.get("digests") %></em>
&nbsp;&nbsp;<A title="RSS Ƶ���б�" href="./feeds.jsp"><IMG alt="RSS Ƶ���б�" 
   src="images/rss_sub.gif" align="absmiddle">����</A>&nbsp;</P>
<SCRIPT type=text/javascript>
function doSearch() {
	if(trim($('frmsearch').q.value)=='')
	{
		alert('�����������ؼ���');
		return false;
	}
	frmsearch.submit();
}
</SCRIPT>
<FORM id="frmsearch" name="frmsearch" 
	  action="http://www.google.cn/search" onsubmit="doSearch(); return false;" method=get target="google_window">
<INPUT type=hidden value="GB2312" name=ie> 
<INPUT type=hidden value="GB2312" name=oe> 
<INPUT type=hidden value=zh-CN name=hl> 
<INPUT type=hidden value="<%= serverName %>" name=sitesearch> 
<div style="float:left;width:100px">&nbsp;</div><div onclick="javascript:window.open('http://www.google.cn/')" 
 style="cursor:pointer;float:left;width:70px;height:23px;background: url(images/google.png)! important;background: none; filter: 
 progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/google.png',sizingMethod='scale')"></div>&nbsp;
<INPUT maxLength=255 size=12 name=q class="search">&nbsp; 
<a href="#" onclick="doSearch(); return false;" style="vertical-align:middle">
<img src="styles/<%= forumStyle %>/images/search.gif" border="0" alt="վ������" align="absbottom"/></a></FORM></DIV></DIV>
<DIV id=ad_text></DIV>
<%
	String showHotlinks = setting.getString(ForumSetting.DISPLAY, "showHotlinks");
	String[] hotLinks = showHotlinks.split(",");
	if (hotLinks.length >= 3) {
		String colWidth = String.valueOf(100 / hotLinks.length) + "%";
%>
<DIV class="mainbox forumlist" style="padding-top:0px">
<TABLE cellSpacing=0 cellPadding=0>
  <THEAD class=category>
  <TR>
	  <% if (showHotlinks.indexOf("image") >= 0){ %><TD style="padding-bottom: 1px" 
			align=center>��&nbsp;����ͼƬ&nbsp;��</TD><% } %>
	  <% if (showHotlinks.indexOf("recent") >= 0){ %><TD style="padding-bottom: 1px" 
			align=center>��&nbsp;���·���&nbsp;��</TD><% } %>
	  <% if (showHotlinks.indexOf("hot") >= 0){ %><TD style="padding-bottom: 1px" 
			align=center>��&nbsp;��������&nbsp;��</TD><% } %>
	  <% if (showHotlinks.indexOf("rank") >= 0){ %><TD style="padding-bottom: 1px" 
			align=center>��&nbsp;��������&nbsp;��</TD><% } %>
	  <% if (showHotlinks.indexOf("digest") >= 0){ %><TD style="padding-bottom: 1px" 
			align=center>��&nbsp;���¾���&nbsp;��</TD><% } %>
  </TR></THEAD>
  <TBODY>
  <TR>
<% 		
		if (showHotlinks.indexOf("image") >= 0){
			out.write("<TD align=center width='");out.write(colWidth);out.write("' style='padding-left:5px;padding-top:2px'>\n");
			String imageUrl = setting.getString(ForumSetting.DISPLAY, "imageFile");
            StringBuilder tagBuf = new StringBuilder();
			if (imageUrl.toLowerCase().indexOf(".swf") > 0)
			{
				String[] width_height = imageUrl.split(",");
	                int width = 310;
   		            int height = 205;
					if (hotLinks.length > 3) width = 236;
	                width = PageUtils.getIntValue(width_height, 1, width);
    	            height = PageUtils.getIntValue(width_height, 2, height);

                tagBuf.append("<script type=text/javascript>showFlash('")
                      .append(width_height[0]).append("','").append(width).append("','")
                      .append(height).append("');</script>");
			}
			else
			{
				String imageLink = setting.getString(ForumSetting.DISPLAY, "imageLink");
				String imageTitle = setting.getString(ForumSetting.DISPLAY, "imageTitle");
				if (imageLink.length() > 0)
					tagBuf.append("<a href=\"").append(imageLink).append("\" target=\"_blank\">");
                tagBuf.append("<img src=\"").append(imageUrl).append("\" alt=\"").append(imageTitle)
                      .append("\" border=\"0\">");
				if (imageLink.length() > 0)
					tagBuf.append("</a>");
			}
			out.write(tagBuf.toString());
			out.write("</TD>\n");
		} 
		if (showHotlinks.indexOf("recent") >= 0){	
			out.write("<TD valign=top width='");out.write(colWidth);out.write("' style='MARGIN:1px'>\n");
			out.write(cache.getRecentTopics());
			out.write("</TD>\n");
		} 
		if (showHotlinks.indexOf("hot") >= 0){
			out.write("<TD valign=top width='");out.write(colWidth);out.write("' style='MARGIN:1px'>\n");
			out.write(cache.getHotTopics());
			out.write("</TD>\n");
		} 
		if (showHotlinks.indexOf("rank") >= 0){
			out.write("<TD valign=top width='");out.write(colWidth);out.write("' style='MARGIN:1px'>\n");
			out.write(cache.getRankTopics());
			out.write("</TD>\n");
		} 
		if (showHotlinks.indexOf("digest") >= 0){ 	
			out.write("<TD valign=top width='");out.write(colWidth);out.write("' style='MARGIN:1px'>\n");
			out.write(cache.getDigestTopics());
			out.write("</TD>\n");
		}  	  
%>
  </TR></TBODY></TABLE></DIV>
<%
	}
	if (sections != null)
	{
		SectionVO aSection = null;
		BoardVO aBoard = null;
		String forumUrl = null;
		String topicUrl = null;
		String lastPostInfo = null;
		String lastNickname = null;
		String moderators = null;
		String moderatorLink = null;
		String displayName = null;
		
		if (sectionID != null)
			sectionID = sectionID.trim();
		
		for (int i=0; i<sections.size(); i++)	
		{
			aSection = (SectionVO)sections.get(i);
			if (currentSection != null)
			{
				if (aSection != currentSection) continue;
			}
			if (aSection.boardList == null) continue;
%>
<DIV class="mainbox forumlist">
	<SPAN class=headactions><IMG id=section_<%= i %>_img title="����/չ��" onClick="toggle_collapse('section_<%= i %>');"
		alt="����/չ��" src="styles/<%= forumStyle %>/images/collapsed_no.gif"></SPAN>
	<H3><A href="./index.jsp?sid=<%= aSection.sectionID %>"><%= aSection.sectionName %></A></H3>
<TABLE id="section_<%= i %>" cellSpacing=0 cellPadding=0>
<%
			if (aSection.cols < 2) 
			{
%>
  <THEAD class=category>
  <TR>
    <TH>���</TH>
    <TD class=nums>����</TD>
    <TD class=nums>����</TD>
    <TD class=lastpost>��󷢱�</TD></TR></THEAD>
<%
				for (int j=0; j<aSection.boardList.size(); j++)
				{
					aBoard = (BoardVO)aSection.boardList.get(j);
					if (aBoard.state == 'I' && !isModerator) continue;
					
					sbuf.setLength(0);
					sbuf.append("./forum-").append(aSection.sectionID).append("-").append(aBoard.boardID).append("-1.html");
					forumUrl = sbuf.toString();
					
					if (aBoard.allowGroups == null || aBoard.allowGroups.indexOf('G') < 0)
					{
						lastPostInfo = "˽�ܰ��";
					}
					else if (aBoard.lastTopicID != null)
					{
						sbuf.setLength(0);
						sbuf.append("./topic-").append(aBoard.lastTopicID).append("-999.html");
						topicUrl = sbuf.toString();

						lastNickname = (aBoard.lastNickname==null 
								|| aBoard.lastNickname.length()==0)	? aBoard.lastTopicUser : aBoard.lastNickname;
						lastNickname = lastNickname.length()==0?"�ο�":lastNickname;
								
						sbuf.setLength(0);
						sbuf.append("<A href='").append(topicUrl).append("'>").append(aBoard.lastTopicTitle).append("</A>")
						    .append("<CITE>").append(aBoard.lastTopicTime).append("&nbsp; by &nbsp;<A href='uspace.jsp?uid=")
							.append(aBoard.lastTopicUser).append("' target='_blank'>").append(lastNickname).append("</A></CITE>");
						lastPostInfo = sbuf.toString();
					}
					else
					{
						lastPostInfo = "��";
					}
					moderators = PageUtils.getModerators(aSection, aBoard);
					moderatorLink = PageUtils.getModeratorLink(moderators);
					
					if (aBoard.highColor != null && aBoard.highColor.length() > 0)
					{
						sbuf.setLength(0);
						sbuf.append("<font color='#").append(aBoard.highColor).append("'>")
							.append(aBoard.boardName).append("</font>");
						displayName = sbuf.toString();
					}
					else
						displayName = aBoard.boardName;
%>	
  <TBODY>
  <TR>
    <TH<%= aBoard.todayPosts>0?" class=new":"" %>>
      <H2><A href='<%= forumUrl %>'><%= displayName %></A>
	  	  <%= aBoard.todayPosts>0?"<em> (����: " + aBoard.todayPosts + ")</em>":"" %></H2>
      <% if(aBoard.brief!=null){ out.write("<P>"); out.write(aBoard.brief); out.write("</P>"); } %>
	  <p class="moderators">����: <%= moderatorLink==null?"��ȱ��":moderatorLink %></p></TH>
    <TD class=nums><%= aBoard.topics %></TD>
    <TD class=nums><%= aBoard.posts %></TD>
    <TD class=lastpost><%= lastPostInfo %></TD></TR></TBODY>
<%
				}
			}
			else // cols >= 2
			{
				String colWidth = String.valueOf(100 / aSection.cols) + "%";
				int boardCount =  aSection.boardList.size();
				int visibleCount = 0;
				for (int j=0; j<boardCount; j++)
				{
					aBoard = (BoardVO)aSection.boardList.get(j);
					if (aBoard.state == 'I' && !isModerator) continue;
					
					sbuf.setLength(0);
					sbuf.append("./forum-").append(aSection.sectionID).append("-").append(aBoard.boardID).append("-1.html");
					forumUrl = sbuf.toString();
					
					if (aBoard.allowGroups == null || aBoard.allowGroups.indexOf('G') < 0)
					{
						lastPostInfo = "˽�ܰ��";
					}
					else if (aBoard.lastTopicID != null)
					{
						sbuf.setLength(0);
						sbuf.append("./topic-").append(aBoard.lastTopicID).append("-999.html");
						topicUrl = sbuf.toString();

						lastNickname = (aBoard.lastNickname==null 
								|| aBoard.lastNickname.length()==0)	? aBoard.lastTopicUser : aBoard.lastNickname;
						lastNickname = lastNickname.length()==0?"�ο�":lastNickname;
					
						sbuf.setLength(0);
						sbuf.append("<A href='").append(topicUrl).append("'>").append(aBoard.lastTopicTime).append("</A>")
							.append("&nbsp; by &nbsp;<A href='uspace.jsp?uid=")
						    .append(aBoard.lastTopicUser).append("' target='_blank'>").append(lastNickname).append("</A>");
						lastPostInfo = sbuf.toString();
					}
					else
					{
						lastPostInfo = "��";
					}

					if (aBoard.highColor != null && aBoard.highColor.length() > 0)
					{
						sbuf.setLength(0);
						sbuf.append("<font color='#").append(aBoard.highColor).append("'>")
							.append(aBoard.boardName).append("</font>");
						displayName = sbuf.toString();
					}
					else
						displayName = aBoard.boardName;
					
					if (visibleCount % aSection.cols == 0)
						out.write("<TBODY><TR>\n");
%>
    <TH<%= aBoard.todayPosts>0?" class=new":"" %> width="<%= colWidth %>" valign="top">
      <% if(aBoard.brief!=null){ out.write("<P>"); out.write(aBoard.brief); out.write("</P>"); } %>
      <H2><A href="<%= forumUrl %>"><%= displayName %></A>
	  	  <%= aBoard.todayPosts>0?"<em> (����: " + aBoard.todayPosts + ")</em>":"" %></H2>
      <P>����: <%= aBoard.topics %>, ����: <%= aBoard.posts %></P>
      <P>��󷢱�: <%= lastPostInfo %></P></TH>
<%
					if ((visibleCount+1) % aSection.cols == 0)
						out.write("</TR></TBODY>\n");
					visibleCount++;
				}
				int blankCount = aSection.cols - visibleCount % aSection.cols;
				if (blankCount < aSection.cols)
				{
					for (int j=0; j<blankCount; j++)
					{
						out.write("<TD>&nbsp;</TD>\n");
					}
					out.write("</TR></TBODY>\n");
				}
			}
%>
</TABLE></DIV>
<%
		}
	}
	String showUnion = setting.getString(ForumSetting.DISPLAY, "showUnion");
	if (showUnion.equals("yes")) {
%>
<DIV class=box><SPAN class=headactions><IMG id=forumlinks_img 
onclick="toggle_collapse('forumlinks');" src="styles/<%= forumStyle %>/images/collapsed_no.gif"></SPAN> 
<H4>��̳����</H4>
<TABLE id=forumlinks cellSpacing=0 cellPadding=0 class="forumlinks">
  <TBODY>
  <TR>
    <TD><A href="http://www.wisol.net.cn/wisc.jsp" target="_blank" style="FLOAT: right"><img src="http://www.wisol.net.cn/images/wisol_120x50.gif" alt="Wisol Reader"/></A>
	    <h5><A href="http://www.wisol.net.cn/" target=_blank>��ά����</A></h5>
		<p>��Ϣ�ۺϡ����絼������Ч��ݵĵ����Ķ�����������Ȼ�ĳ��˸о�</p> 
  </TD></TR>
  <TR>
    <TD>
	    <h5><A href="http://www.21focus.cn/" target=_blank>21������</A></h5>
		<p>Ϊ��С��վ�ṩ��õ������̳�����԰��Լ���ѵ������</p> 
  </TD></TR>
  </TBODY></TABLE></DIV>
<%
	}
	String showOnlineUsers = setting.getString(ForumSetting.DISPLAY, "showOnlineUsers");
	if (showOnlineUsers.equals("yes")) {
%>  
<DIV class=box id=online>
<H4><strong>���߻�Ա</strong>&nbsp;&nbsp;-&nbsp;&nbsp;��&nbsp;<EM><%= appCtx.getSessionCount() %></EM> �����ߣ����л�Ա&nbsp;<EM><%= appCtx.getSessions().size() %></EM> ��&nbsp;-&nbsp;&nbsp;��߼�¼��&nbsp;<EM><%= appCtx.getTopOnlines() %></EM>&nbsp; ��&nbsp;<EM><%= appCtx.getTopOnlineTime() %></EM>
</H4></DIV>
<%
	}
%>
<DIV class=legend><LABEL><IMG alt=�������İ�� align="absmiddle" 
src="styles/<%= forumStyle %>/images/forum_new.gif">�������İ��</LABEL> <LABEL><IMG alt=�������İ�� align="absmiddle" 
src="styles/<%= forumStyle %>/images/forum.gif">�������İ��</LABEL> </DIV>
</DIV>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFootAdBanner(request, null) %>
<%= PageUtils.getFooter(request, forumStyle) %>
</BODY></HTML>
