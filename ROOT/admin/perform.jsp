<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO"%>
<%@ page import="com.hongshee.ejforum.data.ReplyDAO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.TrashBoxDAO"%>
<%@ page import="com.hongshee.ejforum.data.ActionLogDAO"%>
<%@ page import="com.hongshee.ejforum.data.StatDAO"%>
<%@ page import="com.hongshee.ejforum.data.BookmarkDAO"%>
<%@ page import="com.hongshee.ejforum.data.ShortMsgDAO"%>
<%@ page import="com.hongshee.ejforum.data.TopicISO"%>
<%@ page import="com.hongshee.ejforum.data.AttachDAO"%>
<%@ page import="com.hongshee.ejforum.data.BackupDAO"%>
<%
	String adminPath = request.getContextPath() + "/admin";
	String fromPath = (String)request.getParameter("fromPath");
	if (fromPath == null)
		fromPath = PageUtils.getPathFromReferer(request);

	String msg = "Invalid parameter";
   	String act = request.getParameter("act");
	
	boolean redirect = true;
	try
	{
		PageUtils.checkReferer(request); // Enhance security
	    CacheManager cache = CacheManager.getInstance();

		if (act == null)
		{
			UserInfo userinfo = PageUtils.getAdminUser(request, response);
			if (userinfo == null) return;
			request.setAttribute("errorMsg", "�����������");
			request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
			return;
		}
		else if (act.equals("lgt"))
		{
			UserInfo userinfo = PageUtils.getLoginedUser(request, response);
			if (userinfo == null) return;
			userinfo.isAdminOn = false;
			response.sendRedirect(adminPath + "/login.jsp");
			return;
		}
		else if (act.startsWith("forums_"))
		{
			UserInfo userinfo = PageUtils.getAdminUser(request, response);
			if (userinfo == null) return;
			
			act = act.substring(7);
			
			if (userinfo.groupID != 'A')
			{
				if (!act.equals("trash_restore") && !act.equals("trash_restore_all"))
				{
					request.setAttribute("errorMsg", "����Ȩ�޲���");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
			}
			
			if (act.equals("forum_edit"))
			{
				SectionDAO.getInstance().modifySeqno(request);
    	        cache.loadSections();
				msg = "�޸���ʾ˳��ɹ���";
			}
			else if (act.equals("forum_info"))
			{
				BoardDAO.getInstance().updateBoard(request);
				msg = "�޸İ��ɹ���";
			}
			else if (act.equals("forum_add"))
			{
				BoardDAO.getInstance().addBoard(request);
    	        cache.loadSections();
				msg = "��Ӱ��ɹ���";
			}
			else if (act.equals("section_add"))
			{
				SectionDAO.getInstance().addSection(request);
    	        cache.loadSections();
				msg = "��ӷ����ɹ���";
			}
			else if (act.equals("forum_merge"))
			{
				String sourceID = request.getParameter("sourceBoard");
				String targetID = request.getParameter("targetBoard");
				BoardDAO.getInstance().mergeBoards(sourceID, targetID);
    	        cache.loadSections();
				msg = "�ϲ����ɹ���";
			}
			else if (act.equals("section_edit"))
			{
				SectionDAO.getInstance().updateSection(request);
				msg = "�޸ķ����ɹ���";
			}
			else if (act.equals("forum_copy"))
			{
				BoardDAO.getInstance().copyBoardInfo(request);
    	        cache.loadSections();
				msg = "���ư�����óɹ���";
			}
			else if (act.equals("forum_moderator"))
			{
				String sectionID = request.getParameter("sid");
				String boardID = request.getParameter("fid");
	            String moderator = PageUtils.getParam(request,"moderator").replace(" ","").toLowerCase();
				if (boardID == null || boardID.trim().length() == 0)
                    msg = SectionDAO.getInstance().modifyModerator(sectionID, moderator);
				else
        	        msg = BoardDAO.getInstance().modifyModerator(sectionID, boardID, moderator);

				if (msg.equals("OK"))
					msg = "���°����ɹ���";
				else
					redirect = false;
			}
			else if (act.equals("section_delete"))
			{
				String sectionID = request.getParameter("sid");
				SectionVO aSection = cache.getSection(sectionID);
				if (aSection != null && aSection.boardList != null && aSection.boardList.size() > 0)
				{
					request.setAttribute("errorMsg", "�¼���鲻Ϊ�գ����ȷ���ɾ�����������¼���顣");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
                SectionDAO.getInstance().deleteSection(sectionID);
				fromPath = adminPath + "/forums/forum_edit.jsp";
				msg = "ɾ�������ɹ���";
			}
			else if (act.equals("board_delete"))
			{
				String sectionID = request.getParameter("sid");
				String boardID = request.getParameter("fid");
				BoardDAO.getInstance().deleteBoard(sectionID, boardID);
				fromPath = adminPath + "/forums/forum_edit.jsp";
				msg = "ɾ�����ɹ���";
			}
			else if (act.equals("topic_batch"))
			{
				TopicDAO.getInstance().modifyTopics(request);
				msg = "���������������ɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("post_batch"))
			{
				ReplyDAO.getInstance().deleteReplies(request);
				msg = "����ɾ�����ӳɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("trash_delete"))
			{
				TrashBoxDAO.getInstance().deleteTrash(request);
				msg = "ɾ������վ���ӳɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("trash_archive"))
			{
				TrashBoxDAO.getInstance().archiveTrash(request);
				msg = "�鵵����վ���ӳɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("trash_restore"))
			{
				TrashBoxDAO.getInstance().restoreTrash(request);
				msg = "��ԭ����վ���ӳɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("trash_delete_all"))
			{
				TrashBoxDAO.getInstance().deleteTrashes(request);
				msg = "ɾ������վ���ӳɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("trash_archive_all"))
			{
				TrashBoxDAO.getInstance().archiveTrashes(request);
				msg = "�鵵����վ���ӳɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("trash_restore_all"))
			{
				TrashBoxDAO.getInstance().restoreTrashes(request);
				msg = "��ԭ����վ���ӳɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
		}
		else if (act.startsWith("users_"))
		{
			UserInfo userinfo = PageUtils.getAdminUser(request, response);
			if (userinfo == null) return;

			act = act.substring(6);
			
			if (act.startsWith("group_") && userinfo.groupID != 'A')
			{
				request.setAttribute("errorMsg", "����Ȩ�޲���");
				request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
				return;
			}
			
    	    GroupVO aGroup = PageUtils.getGroupVO(userinfo, cache.getModerators());
			
			if (act.equals("user_group"))
			{
				if (aGroup.rights.indexOf(IConstants.PERMIT_EDIT_USER) < 0)
				{
					request.setAttribute("errorMsg", "����Ȩ�޲���");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
				msg = UserDAO.getInstance().modifyGroup(request);
				if (msg.equals("OK"))
					msg = "�޸��û����������Գɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-2);";
			}
			else if (act.equals("user_credits"))
			{
				if (aGroup.rights.indexOf(IConstants.PERMIT_EDIT_CREDITS) < 0)
				{
					request.setAttribute("errorMsg", "����Ȩ�޲���");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
				UserDAO.getInstance().modifyCredits(request);
				msg = "���ֽ���ִ�гɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-2);";
			}
			else if (act.equals("user_ban"))
			{
				if (aGroup.rights.indexOf(IConstants.PERMIT_BAN_USER) < 0)
				{
					request.setAttribute("errorMsg", "����Ȩ�޲���");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
				UserDAO.getInstance().modifyStates(request);
				msg = "�û�״̬���ִ�гɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-2);";
			}
			else if (act.equals("user_delete"))
			{
				if (aGroup.rights.indexOf(IConstants.PERMIT_DELETE_USER) < 0)
				{
					request.setAttribute("errorMsg", "����Ȩ�޲���");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
				UserDAO.getInstance().deleteUsers(request);
				msg = "ɾ���û�ִ�гɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-2);";
			}
			else if (act.equals("user_noavatar"))
			{
				if (aGroup.rights.indexOf(IConstants.PERMIT_EDIT_USER) < 0)
				{
					request.setAttribute("errorMsg", "����Ȩ�޲���");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
				UserDAO.getInstance().deleteAvatars(request);
				msg = "ɾ���û�ͷ��ִ�гɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-2);";
			}
			else if (act.equals("user_audit"))
			{
				if (aGroup.rights.indexOf(IConstants.PERMIT_AUDIT_USER) < 0)
				{
					request.setAttribute("errorMsg", "����Ȩ�޲���");
					request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
					return;
				}
				UserDAO.getInstance().auditUsers(request);
				msg = "������û��ɹ���";
			}
			else if (act.equals("group_info"))
			{
				GroupDAO.getInstance().modifyRights(request);
				msg = "�޸��û���Ȩ�޳ɹ���";
			}
			else if (act.equals("group_member"))
			{
				msg = GroupDAO.getInstance().updateMemberGroups(request);
				if (msg.equals("OK"))
				{
    		        cache.loadGroups();
					msg = "�޸Ļ�Ա�û���ɹ���";
				}
				else
					redirect = false;
			}
			else if (act.equals("group_delete"))
			{
				String groupID = request.getParameter("id");
				GroupDAO.getInstance().deleteGroup(groupID);
				fromPath = adminPath + "/users/group_member.jsp";
				msg = "ɾ����Ա��ɹ���";
			}
		}
		else if (act.startsWith("tools_"))
		{
			UserInfo userinfo = PageUtils.getAdminUser(request, response);
			if (userinfo == null) return;

			if (userinfo.groupID != 'A')
			{
				request.setAttribute("errorMsg", "����Ȩ�޲���");
				request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
				return;
			}
			
			act = act.substring(6);
			if (act.equals("send_notice"))
			{
				UserDAO.getInstance().sendNotice(request);
				msg = "������̳֪ͨ�ɹ���";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("manage_data"))
			{
				TopicDAO.getInstance().replaceContent(request);
				msg = "�����滻ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("backup_new") || act.equals("backup_setting") || act.equals("backup_data"))
			{
				BackupDAO.getInstance().addTask(request);
				fromPath = adminPath + "/tools/backup_data.jsp";
				msg = "�½���������ִ�гɹ���";
			}
			else if (act.equals("backup_mod"))
			{
				BackupDAO.getInstance().updateTask(request);
				fromPath = adminPath + "/tools/backup_data.jsp";
				msg = "�޸ı�������ִ�гɹ���";
			}
			else if (act.equals("check_expired"))
			{
				TopicDAO.getInstance().checkExpireDate();
				msg = "��������������ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("stat_forum_visits"))
			{
				StatDAO.getInstance().statVisits();
				msg = "ͳ����̳�ķ�����ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("load_hot_links"))
			{
			        cache.loadSpecTopics("recent");
    	        		cache.loadSpecTopics("hot");
				cache.loadSpecTopics("rank");
            			cache.loadSpecTopics("digest");
				msg = "ˢ�������ƽ����������б�ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("clean_sms"))
			{
				ShortMsgDAO.getInstance().cleanOverflowMsgs();
				msg = "�������Ϣִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("clean_favors"))
			{
				BookmarkDAO.getInstance().cleanOverflowMarks();
				msg = "�����ղؼм�¼ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("index_topics"))
			{
				TopicISO.getInstance().buildTopicsIndex();
				msg = "�ؽ�ȫ�������������Ѿ���������������Ҫһ��ʱ��Ż�ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("clean_trashbox"))
			{
				TrashBoxDAO.getInstance().cleanExpiredTrashes();
				msg = "������ڵ��������¼ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("clean_logs"))
			{
				ActionLogDAO.getInstance().cleanExpiredLogs();
				msg = "������ڵ���־��¼ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("stat_board_posts"))
			{
				BoardDAO.getInstance().statBoardInfo();
				msg = "����ͳ�ư������ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("clean_attaches"))
			{
				AttachDAO.getInstance().cleanRecycledAttaches();
				msg = "��������¼���ļ�ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("daily_backup"))
			{
				BackupDAO.getInstance().execBackupTasks("D");
				msg = "���ݱ�������ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
			else if (act.equals("weekly_backup"))
			{
				BackupDAO.getInstance().execBackupTasks("W");
				msg = "���ݱ�������ִ����ϡ�";
				redirect = false;
				fromPath = "javascript:history.go(-1);";
			}
		}
		else if (act.startsWith("basic_"))
		{
			UserInfo userinfo = PageUtils.getAdminUser(request, response);
			if (userinfo == null) return;

			if (userinfo.groupID != 'A')
			{
				request.setAttribute("errorMsg", "����Ȩ�޲���");
				request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
				return;
			}

			act = act.substring(6);
			if (act.equals("censor"))
			{
				ForumSetting setting = ForumSetting.getInstance();
				setting.setOptions(ForumSetting.CENSOR, PageUtils.getParam(request,"badwords"));
				msg = "��̳ѡ����³ɹ���";
			}
			else if (act.equals("styles"))
			{
				ForumSetting setting = ForumSetting.getInstance();
				String[] used = request.getParameterValues("used");
				String[] styleIDs = request.getParameterValues("styleID");
				String[] styleNames = request.getParameterValues("styleName");
				StringBuilder styles = new StringBuilder();
				char isSelected = '1';
				for (int i=0; i<styleIDs.length; i++)
				{
					isSelected = '0';
					for (int j=0; j<used.length; j++)
					{
						if (used[j].equals(styleIDs[i]))
						{
							isSelected = '1';
							break;
						}
					}
					styles.append(isSelected).append('_').append(PageUtils.decodeParam(styleIDs[i], request));
					styles.append('=').append(PageUtils.decodeParam(styleNames[i], request)).append('\n');
				}
				setting.setOptions(ForumSetting.STYLES, styles.toString().trim());
				msg = "��̳ѡ����³ɹ���";
			}
			else if (act.equals("style_info"))
			{
				ForumSetting setting = ForumSetting.getInstance();
				setting.setStyleValues(request);
				msg = "��������³ɹ���";
			}			
			else
			{
				ForumSetting setting = ForumSetting.getInstance();
				setting.setValues(act, request);
				msg = "��̳ѡ����³ɹ���";
			}
		}
	}
	catch(Throwable t)
	{
		String errorMsg = "����˳����쳣 - &nbsp;" + t.getMessage();
		PageUtils.log(request, "admin: " + act, errorMsg, t);
		request.setAttribute("errorMsg", errorMsg);
		request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
		return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD><META http-equiv=Content-Type content="text/html; charset=gbk">
<LINK href="<%= adminPath %>/style/admin.css" type=text/css rel=stylesheet>
<script src="<%= adminPath %>/js/admin.js" type="text/javascript"></script>
</HEAD>
<BODY leftmargin="10" topmargin="10">
<table width="100%" border="0" cellpadding="2" cellspacing="6">
<tr><td>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="guide">
	<tr><td><a href="#" 
		onClick="parent.location='<%= adminPath %>/index.htm'; return false;">��̨��ҳ</a>&nbsp;&raquo;&nbsp;��ʾ��Ϣ
	</td></tr>
	</table><br /><br /><br /><br /><br /><br /><br />
	<table width="500" border="0" cellpadding="0" cellspacing="0" align="center" class="info_tb">
	<tr class="header"><td>��ʾ��Ϣ</td></tr>
	<tr><td class="altbg2">
		<div align="center">
		<br /><br /><br /><%= msg %><br /><br /><br />
<% if (redirect) { %>
		<a href="<%= fromPath %>" class="mediumtxt">[&nbsp;������������û���Զ���ת����������&nbsp;]</a>
		<script>setTimeout("redirect('<%= fromPath %>');", 1500);</script>
<% } else { %>
		<a href="<%= fromPath %>" class="mediumtxt">[&nbsp;������ﷵ����һҳ&nbsp;]</a>
<% } %>
		<br/><br/></div>
		<br /><br />
	</td></tr></table>
	<br /><br /><br />
</td></tr></table>
<br/><br/>
<%= PageUtils.getAdminFooter(request) %>
</BODY></HTML>