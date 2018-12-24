<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.hongshee.ejforum.util.PageUtils"%>
<%@ page import="com.hongshee.ejforum.util.AppUtils"%>
<%@ page import="com.hongshee.ejforum.common.ForumSetting"%>
<%@ page import="com.hongshee.ejforum.common.IConstants"%>
<%@ page import="com.hongshee.ejforum.common.CacheManager"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO"%>
<%@ page import="com.hongshee.ejforum.data.UserDAO.UserInfo"%>
<%@ page import="com.hongshee.ejforum.data.GroupDAO.GroupVO"%>
<%@ page import="com.hongshee.ejforum.data.BoardDAO.BoardVO"%>
<%@ page import="com.hongshee.ejforum.data.SectionDAO.SectionVO"%>
<%@ page import="com.hongshee.ejforum.data.TopicDAO"%>
<%@ page import="com.hongshee.ejforum.data.ReplyDAO"%>
<%@ page import="com.hongshee.ejforum.data.ActionLogDAO"%>
<%@ page import="com.hongshee.ejforum.data.ShortMsgDAO"%>
<%@ page import="com.hongshee.ejforum.data.BookmarkDAO"%>
<%@ page import="com.hongshee.ejforum.data.FriendDAO"%>
<%
	PageUtils.checkReferer(request); // Enhance security
	String ctxPath = request.getContextPath();
	UserInfo userinfo = null; 
	
	ForumSetting setting = ForumSetting.getInstance();
	String forumName = setting.getForumName();

	String result = null;
	String msg = null;
	String backurl = "<a href=\"javascript:history.back()\">[ ������ﷵ����һҳ ]</a>";
    String act = request.getParameter("act");
	
	if (act == null)
	{
		request.setAttribute("errorMsg", "�����������");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}
	else if (act.equals("lgn"))
	{	
		if (!request.isRequestedSessionIdFromCookie())
		{
			request.setAttribute("errorMsg", "���������� Cookie ֧�ֹ���, ���߽���վ��Ϊ����վ��, �����ܵ�¼");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
			return;
		}
	
		UserDAO dao = UserDAO.getInstance();
		result = dao.doLogin(request, response);
		if (result != null && result.equals("OK"))
		{
		    String fromPath = request.getParameter("fromPath");
			if (fromPath == null || fromPath.trim().length() == 0 || fromPath.trim().equals("/"))
				fromPath = ctxPath;
			else
				fromPath = URLDecoder.decode(fromPath);
			response.sendRedirect(fromPath);
			return;
		}
		else
		{
			request.setAttribute("errorMsg", "��¼ʧ�� - " + result);
			request.getRequestDispatcher("/error.jsp").forward(request, response);
			return;
		}
	}
	else if (act.equals("lgt"))
	{
		UserDAO.getInstance().doLogout(request, response);
	    String fromPath = request.getParameter("fromPath");
		if (fromPath == null || fromPath.trim().length() == 0 || fromPath.trim().equals("/"))
			fromPath = ctxPath;
		else
			fromPath = URLDecoder.decode(fromPath);
		response.sendRedirect(fromPath);
		return;
	}
	else if (act.startsWith("post_"))
	{
		String verifycode = request.getParameter("verifycode");
		String vcode = session.getAttribute("vcode")==null?null:session.getAttribute("vcode").toString();
		if (verifycode != null && verifycode.trim().equals(vcode))
		{
			act = act.substring(5);
		    userinfo = PageUtils.getSessionUser(request);

			String sectionID = request.getParameter("sid");
			String boardID = request.getParameter("fid");
			String topicID = request.getParameter("tid");
		
			CacheManager cache = CacheManager.getInstance();
			SectionVO aSection = cache.getSection(sectionID);
			BoardVO aBoard = cache.getBoard(aSection, boardID);
			GroupVO userGroup = PageUtils.getGroupVO(userinfo, aSection, aBoard);

			if (userinfo == null)
			{
				if (aBoard.isGuestPostOK == 'F' 
					|| (act.equals("reply") && !PageUtils.isPermitted(aBoard,userGroup,IConstants.PERMIT_NEW_REPLY))
					|| (act.equals("topic") && !PageUtils.isPermitted(aBoard,userGroup,IConstants.PERMIT_NEW_TOPIC))
					|| (act.equals("reward") && userGroup.rights.indexOf(IConstants.PERMIT_NEW_REWARD) < 0)
					|| (act.equals("reward") && !PageUtils.isPermitted(aBoard,userGroup,IConstants.PERMIT_NEW_TOPIC))
					|| (act.equals("edit")))
				{	
					String fromPath = ctxPath + "/post.jsp";
					String queryStr = request.getQueryString();
					if (queryStr != null)
					{
						queryStr = queryStr.replace("act=post_", "act=");
						int p = queryStr.indexOf("&verifycode=");
						if (p >= 0) 
							queryStr = queryStr.substring(0, p);
						fromPath = fromPath + "?" + queryStr + "&reload=true";
					}
					request.setAttribute("fromPath", fromPath);
					request.getRequestDispatcher("/login.jsp").forward(request, response);
					return;
				}
			}
			else if (userinfo.state == 'P')
			{
				request.setAttribute("errorMsg", "���ѱ���ֹ������༭����");
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}

			boolean hasRight = false;

			if (aBoard.allowGroups.indexOf(userGroup.groupID) < 0)
				hasRight = false;
			else if (act.equals("topic")) {
				if (PageUtils.isPermitted(aBoard,userGroup,IConstants.PERMIT_NEW_TOPIC))
					hasRight = true;
			} else if (act.equals("reward")) {
				if (userGroup.rights.indexOf(IConstants.PERMIT_NEW_REWARD) >= 0 
					&& PageUtils.isPermitted(aBoard,userGroup,IConstants.PERMIT_NEW_TOPIC))
					hasRight = true;
			} else if (act.equals("reply")) {
				if (PageUtils.isPermitted(aBoard,userGroup,IConstants.PERMIT_NEW_REPLY))
					hasRight = true;
			} else if (act.equals("edit")) {
				if (userGroup.rights.indexOf(IConstants.PERMIT_EDIT_POST) >= 0)
					hasRight = true;
				else
				{
					String replyID = request.getParameter("rid");
					String postID = null;
					if (replyID != null && !replyID.equals("0")) // reply
						postID = "r" + replyID + ",";    
					else if (topicID != null)
						postID = "t" + topicID + ",";
						
					if (postID != null)
					{
						String userPostIDs = (String)session.getAttribute("userPostIDs");
						if (userPostIDs != null && userPostIDs.indexOf(postID) >= 0)
							hasRight = true;
					}
				}	
			}				
			if (!hasRight)
			{		
				request.setAttribute("errorMsg", "�û�Ȩ�޲���");
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}

			if (act.equals("topic") || act.equals("reward"))
			{
			    Object sessionPosts = (Object)session.getAttribute("posts");
			    if (sessionPosts != null && userGroup.groupID != 'A')
				{
					int maxSessionPosts = setting.getInt(ForumSetting.MISC, "maxSessionPosts");
					if (Integer.parseInt(sessionPosts.toString()) > maxSessionPosts)
					{
						request.setAttribute("errorMsg", "�������������Ѿ��ﵽ���ޣ����ܼ�������");
						request.getRequestDispatcher("/error.jsp").forward(request, response);
						return;
					}
				}
				result = TopicDAO.getInstance().createTopic(request, userinfo, aSection, aBoard, userGroup);
				if (result != null && result.equals("OK"))
				{
					StringBuilder sbuf = new StringBuilder();
					sbuf.append("forum-").append(sectionID).append("-").append(boardID).append("-1.html");
					response.sendRedirect(sbuf.toString());
					return;
				}
				else
					msg = result;
			}
			else if (act.equals("reply"))
			{
			    Object sessionPosts = (Object)session.getAttribute("posts");
			    if (sessionPosts != null && userGroup.groupID != 'A')
				{
					int maxSessionPosts = setting.getInt(ForumSetting.MISC, "maxSessionPosts");
					if (Integer.parseInt(sessionPosts.toString()) > maxSessionPosts)
					{
						request.setAttribute("errorMsg", "�������������Ѿ��ﵽ���ޣ����ܼ�������");
						request.getRequestDispatcher("/error.jsp").forward(request, response);
						return;
					}
				}
				result = ReplyDAO.getInstance().createReply(request, userinfo, aSection, aBoard, userGroup);
				if (result != null && result.equals("OK"))
				{
					StringBuilder sbuf = new StringBuilder();
					sbuf.append("topic-").append(topicID).append("-999.html");
					response.sendRedirect(sbuf.toString());
					return;
				}
				else
					msg = result;
			}
			else if (act.equals("edit"))
			{
				String replyID = request.getParameter("rid");

				if (replyID != null && !replyID.equals("0")) // reply
					result = ReplyDAO.getInstance().updateReply(request, userinfo, topicID, replyID, aSection, aBoard, userGroup);
				else	
					result = TopicDAO.getInstance().updateTopic(request, userinfo, topicID, aSection, aBoard, userGroup);
					
				if (result != null && result.equals("OK"))
				{
					String strPageNo = request.getParameter("page");
					int pageNo = PageUtils.getPageNo(strPageNo);
					
					StringBuilder sbuf = new StringBuilder();
					sbuf.append("topic-").append(topicID);
					sbuf.append("-").append(pageNo).append(".html");
					response.sendRedirect(sbuf.toString());
					return;
				}
				else
					msg = result;
			}
		}
		else
		{
			msg = "����ʧ�ܣ���֤�����������������д��";
		}
	}
	else if (act.startsWith("member_"))
	{
	    userinfo = PageUtils.getSessionUser(request);
	    if (userinfo == null)
    	{
			String fromPath = request.getHeader("referer");
	        request.setAttribute("fromPath", fromPath);
    	    request.getRequestDispatcher("/login.jsp").forward(request, response);
			return;
    	}
		
		// Do operation
		act = act.substring(7);
		if (act.equals("sms_compose"))
		{
			String verifycode = request.getParameter("verifycode");
			String vcode = session.getAttribute("vcode")==null?null:session.getAttribute("vcode").toString();
			if (verifycode != null && verifycode.trim().equals(vcode))
			{
			    Object sessionPosts = (Object)session.getAttribute("smss");
			    if (sessionPosts != null)
				{
					int maxSessionPosts = setting.getInt(ForumSetting.MISC, "maxSessionPosts");
					if (Integer.parseInt(sessionPosts.toString()) > maxSessionPosts)
					{
						request.setAttribute("errorMsg", "������������Ϣ���Ѿ��ﵽ���ޣ����ܼ�������");
						request.getRequestDispatcher("/error.jsp").forward(request, response);
						return;
					}
				}
		        String users = PageUtils.getParam(request,"users");
        		String[] userIDs = users.split(",");
		        if (userIDs.length <= 3)
		        {
					result = ShortMsgDAO.getInstance().addShortMsg(request, userinfo.userID);
					if (result != null && result.equals("OK"))
					{
						result = "���Ͷ���Ϣ�ɹ���";
		    		    sessionPosts = (Object)session.getAttribute("smss");
			       		if (sessionPosts != null)
							session.setAttribute("smss", new Integer(Integer.parseInt(sessionPosts.toString())+1));
			        	else
    		            	session.setAttribute("smss", new Integer(1));
					}
				}
				else
				{
		        	result = "����ʧ�ܣ�ÿ�η��͵�Ŀ���û������ܳ���3��";
		        }
			}
			else
			{
				result = "����ʧ�ܣ���֤�����������������д��";
			}
		}
		else if (act.equals("profile"))
		{
			result = UserDAO.getInstance().updateUser(request, userinfo);
			if (result != null && result.equals("OK"))
				result = "�޸ĸ��˻������ϳɹ���";
		}
		else if (act.equals("special"))
		{
			result = UserDAO.getInstance().modSpecInfo(request, userinfo);
			if (result != null && result.equals("OK"))
				result = "�޸ĸ��Ի����ϳɹ���";
		}
		else if (act.equals("chgpwd"))
		{
			result = UserDAO.getInstance().changePasswd(request, userinfo);
			if (result != null && result.equals("OK"))
				result = "�޸�����ɹ���";
		}
		else if (act.equals("favor_add"))
		{
			result = BookmarkDAO.getInstance().addBookmark(request, userinfo);
			if (result != null && result.equals("OK"))
			{
				response.sendRedirect("member/my_favors.jsp");
				return;
			}
		}
		else if (act.equals("friend_add"))
		{
			result = FriendDAO.getInstance().addFriend(request, userinfo);
			if (result != null && result.equals("OK"))
			{
				response.sendRedirect("member/my_friends.jsp");
				return;
			}
		}
		msg = result;	
	}
	else if (act.equals("reg"))
	{
		String verifycode = request.getParameter("verifycode");
		String vcode = session.getAttribute("vcode")==null?null:session.getAttribute("vcode").toString();
		if (verifycode != null && verifycode.trim().equals(vcode))
		{
			UserDAO dao = UserDAO.getInstance();
			result = dao.registerUser(request);
			if (result != null && result.equals("OK"))
			{
            	String userID = PageUtils.getParam(request,"userID");
	   	        String pwd = PageUtils.getParam(request,"pwd2");
    	        String email = PageUtils.getParam(request,"email");
				
			    String registerType = setting.getString(ForumSetting.ACCESS, "registerType");
							
        	    StringBuilder content = new StringBuilder();
   	        	content.append("�𾴵�").append(userID).append("�����Ѿ��ɹ�ע���Ϊ")
       	        	   .append(forumName).append("�Ļ�Ա��<br>\n");
	           	content.append("�����û����ǣ�").append(userID)
    	           	   .append("����ʼ�����ǣ�").append(pwd)
        	       	   .append("�������Ʊ��������û��������롣<br>\n");
			    if (registerType != null && registerType.equalsIgnoreCase("close"))
					content.append("���Ļ�Ա����辭����Ա��˺�Ż���Ч�������ĵȺ������Ϣ��<br>\n");
				else	
	            	content.append("�����ڷ�������ʱ���Ծ����ص��ط��ɷ������̳����<br>\n");
	   	        content.append("�������ʲô�������뱾��̳����Ա��ϵ��");
    	       	content.append(PageUtils.getSysMailFooter(request));

				// �Զ����ʼ�
				AppUtils.sendMail(email, forumName + "��Աע��ȷ����", content.toString());
				
				content = new StringBuilder();
				content.append("ע��ɹ���");
				content.append("�����û�����&nbsp;").append(userID)
					   .append("����ʼ������&nbsp;").append(pwd)
					   .append("�������Ʊ��������û��������롣<br>\n");
			    if (registerType != null && registerType.equalsIgnoreCase("close"))
					content.append("���Ļ�Ա����辭����Ա��˺�Ż���Ч�������ĵȺ������Ϣ��<br>\n");
				else	
					content.append("��������&nbsp;[&nbsp;<a href=\"member/my_profile.jsp")
						   .append("\">��������ҳ��</a>&nbsp;]&nbsp;ά���Լ��ĸ������ϻ��޸����롣<br>\n");
	
				msg = content.toString();
				
			    String fromPath = request.getParameter("fromPath");
				if (fromPath == null || fromPath.trim().length() == 0 || fromPath.trim().equals("/"))
					backurl = "<a href=\"" + ctxPath + "\">[ �������ת��ע��ǰ��ҳ�� ]</a>";
				else		
					backurl = "<a href=\"" + URLDecoder.decode(fromPath) + "\">[ �������ת��ע��ǰ��ҳ�� ]</a>";
			}
			else
			{
				msg = result;
			}
		}
		else
		{
			msg = "ע��ʧ�ܣ���֤�����������������д��";
		}
	}
	else if (act.equals("fdp"))
	{	
		String verifycode = request.getParameter("verifycode");
		String vcode = session.getAttribute("vcode")==null?null:session.getAttribute("vcode").toString();
		if (verifycode != null && verifycode.trim().equals(vcode))
		{	
			UserDAO dao = UserDAO.getInstance();
			result = dao.findPasswd(request);
			if (result != null && result.equals("OK"))
			{
			    String userID = (String)request.getAttribute("userID");
			    String email = (String)request.getAttribute("email");
		    	String setID = (String)request.getAttribute("setID");
				String setUrl = PageUtils.getForumURL(request) + "resetpwd.jsp?id=" + setID;
			
        	    StringBuilder content = new StringBuilder();
            	content.append("�𾴵��û������ոճɹ�ִ�����һ�����Ĳ�����<br>\n")
					   .append("�����û����ǣ�").append(userID).append("���������������ҳ�������������룺<br>\n")
					   .append("<a href='").append(setUrl).append("' target='_blank'>").append(setUrl).append("</a><br>\n");
   		        content.append("�������ʲô�������뱾��̳����Ա��ϵ��");
    	       	content.append(PageUtils.getSysMailFooter(request));
                
            	// �Զ����ʼ�
	            AppUtils.sendMail(email, forumName + "�һ�������ʾ��", content.toString());

    	        content = new StringBuilder();
        	    content.append("���ã�").append(userID);
            	content.append("��\nϵͳ�Ѿ�������ע������ ").append(email);
	            content.append(" ����һ���޸���������ӣ����������ڴ򿪴�������ҳ���޸��������룬������Ч��\n");
			
				msg = content.toString();
			}
			else
			{
				msg = result;
			}
		}
		else
		{
			msg = "�һ�����ʧ�ܣ���֤�����������������д��";
		}
	}
	else if (act.equals("rsp"))
	{	
		String verifycode = request.getParameter("verifycode");
		String vcode = session.getAttribute("vcode")==null?null:session.getAttribute("vcode").toString();
		if (verifycode != null && verifycode.trim().equals(vcode))
		{
			UserDAO dao = UserDAO.getInstance();
			result = dao.resetPasswd(request);
			if (result != null && result.equals("OK"))
				msg = "���Ѿ��ɹ����޸����������룬���μ����������롣";
			else
				msg = result;
		}
		else
		{
			msg = "��������ʧ�ܣ���֤�����������������д��";
		}
	}
	else if (act.equals("report"))
	{
	    userinfo = PageUtils.getSessionUser(request);
		result = ActionLogDAO.getInstance().addReportLog(request, userinfo);
		if (result != null && result.equals("OK"))
		{
			msg = "�ύ�ٱ���Ϣ�ɹ���лл���Ա���̳��֧�֣�";
			backurl = "<a href=\"javascript:history.go(-2)\">[ ������ﷵ�ؾٱ�ǰ��ҳ�� ]</a>";
		}
		else
			msg = result;
	}
	else if (act.startsWith("moderate_"))
	{
	    userinfo = PageUtils.getSessionUser(request);
	    if (userinfo == null)
    	{
			String fromPath = ctxPath + "/forum.jsp?" + request.getQueryString();
	        request.setAttribute("fromPath", fromPath);
    	    request.getRequestDispatcher("/login.jsp").forward(request, response);
			return;
    	}
		
		act = act.substring(9);
		
		String sectionID = request.getParameter("sid");
		String boardID = request.getParameter("fid");
		String[] topicIDs = request.getParameterValues("topicID");
		String replyID = request.getParameter("replyID");
	
		CacheManager cache = CacheManager.getInstance();
		SectionVO aSection = cache.getSection(sectionID);
		BoardVO aBoard = cache.getBoard(aSection, boardID);

		GroupVO userGroup = PageUtils.getGroupVO(userinfo, aSection, aBoard);
		boolean hasRight = false;

		String postID = null;
		if (topicIDs.length == 1)   // topic
			postID = "t" + topicIDs[0] + ",";

		if (postID != null)
		{
			if (act.equals("move"))
			{
				String userPostIDs = (String)session.getAttribute("userPostIDs");
				if (userPostIDs != null && userPostIDs.indexOf(postID) >= 0)
					hasRight = true;
			}
			else if (act.equals("setbest"))
			{
				String userTopicID = (String)session.getAttribute("userTopicID");
				if (userTopicID != null && userTopicID.indexOf(topicIDs[0]) >= 0)
					hasRight = true;
			}
		}
		
		if (!hasRight)
		{
			if (userGroup.groupID == 'A' || userGroup.groupID == 'M' || userGroup.groupID == 'S')
			{
				hasRight = true;
				if (act.equals("close") && userGroup.rights.indexOf(IConstants.PERMIT_CLOSE_POST) < 0)
					hasRight = false;
				else if (act.equals("delete") && userGroup.rights.indexOf(IConstants.PERMIT_DELETE_POST) < 0)
					hasRight = false;
				else if (act.equals("move") && userGroup.rights.indexOf(IConstants.PERMIT_MOVE_POST) < 0)
					hasRight = false;
			}
		}
		
		if (!hasRight)
		{		
			request.setAttribute("errorMsg", "�û�Ȩ�޲���");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
			return;
		}

		// Do operation
		if (act.equals("highlight"))
			result = TopicDAO.getInstance().highlightTopics(request);
		else if (act.equals("digest"))
			result = TopicDAO.getInstance().digestTopics(request);
		else if (act.equals("top"))
			result = TopicDAO.getInstance().topTopics(request);
		else if (act.equals("close"))
			result = TopicDAO.getInstance().closeTopics(request);
		else if (act.equals("move"))
			result = TopicDAO.getInstance().moveTopics(request);
		else if (act.equals("delete"))
		{
			if (replyID != null && !replyID.equals("0"))
				result = ReplyDAO.getInstance().deleteReply(request, replyID);
			else
				result = TopicDAO.getInstance().deleteTopics(request);
		}
		else if (act.equals("setbest"))
			result = ReplyDAO.getInstance().setBestReply(request, userinfo);
		
		if (result != null && result.equals("OK"))
		{
			// Get forward page url
			String strPageNo = request.getParameter("page");
			int pageNo = PageUtils.getPageNo(strPageNo);
		
			StringBuilder sbuf = new StringBuilder();
			if (replyID != null && !replyID.equals("0"))
				sbuf.append("topic-").append(topicIDs[0]);
			else	
				sbuf.append("forum-").append(sectionID).append("-").append(boardID);
			sbuf.append("-").append(pageNo).append(".html");
			
			response.sendRedirect(sbuf.toString());
			return;
		}
		else
			msg = result;
	}
	else
	{
		request.setAttribute("errorMsg", "�����������");
		request.getRequestDispatcher("/error.jsp").forward(request, response);
		return;
	}
	String title = PageUtils.getTitle(forumName);
	String[] menus = PageUtils.getHeaderMenu(request, userinfo);
	String homeUrl = ctxPath + "/index.jsp";
	String forumStyle = PageUtils.getForumStyle(request, response, null);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>��ʾ��Ϣ - <%= title %></TITLE>
<LINK href="styles/<%= forumStyle %>/ejforum.css" type=text/css rel=stylesheet>
</HEAD>
<body onkeydown="if(event.keyCode==27) return false;">
<script src="js/common.js" type="text/javascript"></script>
<div class="wrap">
<div id="header">
<%= PageUtils.getHeader(request, title) %>
</div>
<%= menus[0] %>
<div id="nav"><A href="<%= homeUrl %>"><%= forumName %></A> &raquo; ��ʾ��Ϣ</div>
	<div class="box message">
		<h1><%= forumName %> ��ʾ��Ϣ</h1>
		<p align="center"><%= msg %></p>
		<p align="center"><%= backurl %></p>
	</div>
</div>
<%= menus[1]==null?"":menus[1] %>
<%= menus[2]==null?"":menus[2] %>
<%= PageUtils.getFooter(request, forumStyle) %>
</body></html>