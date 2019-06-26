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
<title>我的交易记录</title>
</head>
<body>
<div class="scoreSelect" id="tab-container">
	 <a class="score_select_p" href="javascript:void(-1)"  onclick="window.location.href='${ctx}/memberWechat/myTrading?wechat_id=${param.wechat_id }&selectType=0'" id="tab1">交易明细</a>
    <div class="score_select_line">
      <div class="score_select_linel"></div>
    </div>
    <a class="score_select_p" href="javascript:void(-1)"  onclick="window.location.href='${ctx}/memberWechat/myTrading?wechat_id=${param.wechat_id }&selectType=1'" id="tab2">储值</a>
    <div class="score_select_line">
      <div class="score_select_linel"></div>
    </div>
    <a class="score_select_p"href="javascript:void(-1)"  onclick="window.location.href='${ctx}/memberWechat/myTrading?wechat_id=${param.wechat_id }&selectType=2'" id="tab3">支出</a> 
</div>
<div class="score_show">
    <div class="score_show_available">余额：<span>
	    <c:if test="${empty(member) }" var="status">
	    	无
	    </c:if>
	    <c:if test="${status==false }">
	       <ystech:urlEncrypt enCode="${member.balance }"/> 
	    </c:if>
    </span></div>
    <div class="clear"></div>
</div>
<c:if test="${empty(tradingSnapshots) }">
	<div id="message" class="alert alert-success" style="margin:14px;">
		<strong>提示：</strong>您当前无交易记录！
  	</div>
</c:if>
<c:if test="${!empty(tradingSnapshots) }">
<div class="score_list">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tbody><tr class="score_list_head">
        <th  scope="col">类型</th>
        <th  scope="col">时间</th>
        <th  scope="col">金额</th>
      </tr>
      <c:forEach var="tradingSnapshot" items="${tradingSnapshots }" varStatus="i">
	     <tr>
	       <td style="border-bottom: 1px solid  #BFBFBF;padding: 5px 5px;"  class="left">
		       	<c:if test="${tradingSnapshot.tradingType==1 }">
		       		储值
		       	</c:if>
		       	<c:if test="${tradingSnapshot.tradingType==2 }">
		       		消费
		       	</c:if>
	       </td>
	       <td style="border-bottom: 1px solid  #BFBFBF;">
	       	<fmt:formatDate value="${tradingSnapshot.tradingTime }" pattern="yyyy年MM月dd日 HH:mm"/>
	       </td>
	       	<c:if test="${tradingSnapshot.tradingType==1 }">
	       	<td style="border-bottom: 1px solid  #BFBFBF;color:green; "> <ystech:urlEncrypt enCode="${tradingSnapshot.money}"/></td>
	       </c:if>
	       	<c:if test="${tradingSnapshot.tradingType==2 }">
	       	<td style="border-bottom: 1px solid  #BFBFBF;color:red;"> 
	       		-<ystech:urlEncrypt enCode="${tradingSnapshot.money}"/></td>
	       </c:if>
	     </tr>
      </c:forEach>
    </tbody></table>
  </div>
</c:if> 
  
</body>
</html>
