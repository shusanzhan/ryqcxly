<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" type="text/css"  href="${ctx }/css/weixin.css"/>
<title>积分记录</title>
</head>
<body>

<div class="scoreSelect" id="tab-container">
	 <a class="score_select_p" href="javascript:void(-1)"  onclick="window.location.href='${ctx}/memberWechat/myScoreRecord?wechat_id=${param.wechat_id }&selectType=0'" id="tab1">积分明细</a>
    <div class="score_select_line">
      <div class="score_select_linel"></div>
    </div>
    <a class="score_select_p" href="javascript:void(-1)"  onclick="window.location.href='${ctx}/memberWechat/myScoreRecord?wechat_id=${param.wechat_id }&selectType=1'" id="tab2">积分收入</a>
    <div class="score_select_line">
      <div class="score_select_linel"></div>
    </div>
    <a class="score_select_p"href="javascript:void(-1)"  onclick="window.location.href='${ctx}/memberWechat/myScoreRecord?wechat_id=${param.wechat_id }&selectType=2'" id="tab3">积分支出</a> 
</div>
<div class="score_show">
    <div class="score_show_available">可用积分：<span>
	    <c:if test="${empty(member) }" var="status">
	    	无
	    </c:if>
	    <c:if test="${status==false }">
	    ${member.overagePiont }
	    </c:if>
    </span></div>
    <div class="score_show_consume">消费积分：<span>
     <c:if test="${empty(member) }" var="status">
	    	无
	    </c:if>
	    <c:if test="${status==false }">
	   	 ${member.consumpiontPoint }
	    </c:if>
   </span></div>
    <div class="clear"></div>
</div>
<c:if test="${empty(pointRecords) }">
	<div id="message" class="alert alert-success" style="margin:14px;">
		<strong>提示：</strong>您当前无积分记录！
  	</div>
</c:if>
<c:if test="${!empty(pointRecords) }">
<div class="score_list">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tbody><tr class="score_list_head">
        <th  scope="col">名称</th>
        <th  scope="col">时间</th>
        <th  scope="col">积分数</th>
      </tr>
      <c:forEach var="pointRecord" items="${pointRecords }" varStatus="i">
      <c:if test="${i.index<(fn:length(pointRecords)-1) }" var="status">
	     <tr>
	       <td style="border-bottom: 1px solid  #BFBFBF;padding: 5px 0"  class="left">${pointRecord.pointFrom }</td>
	       <td style="border-bottom: 1px solid  #BFBFBF;"><fmt:formatDate value="${pointRecord.createTime }" pattern="yyyy年MM月dd日 HH:mm"/></td>
	       <td style="border-bottom: 1px solid  #BFBFBF;">${pointRecord.num }</td>
	     </tr>
      </c:if>
      <c:if test="${status==false }">
	     <tr >
	       <td style="padding: 5px 0" class="left">${pointRecord.pointFrom }</td>
	       <td><fmt:formatDate value="${pointRecord.createTime }" pattern="yyyy年MM月dd日 HH:mm"/></td>
	       <td>${pointRecord.num }</td>
	     </tr>
      </c:if>
      </c:forEach>
    </tbody></table>
  </div>
</c:if>
  
</body>
</html>
