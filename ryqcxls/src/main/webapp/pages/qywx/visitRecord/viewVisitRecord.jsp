<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>${customer.name }回访记录</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${customer.name }回访记录</span>
    <c:if test="${param.type==1 }">
	    <a class="go_home" href="${ctx }/qywxCustomer/index">
	    	<img src="${ctx }/images/jm/go_home.png" alt="">
	    </a>
    </c:if>
</div>
<br>
<br>
<br>

<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：<a href="${ctx}/qywxCustomer/customerDetail?customerId=${customer.dbid }&type=2">${customer.name }</a>&nbsp;&nbsp;${customer.sex }<br/>
	  		电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			车型：${customer.customerBussi.brand.name}&#12288;
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<c:if test="${fn:length(carModel)>16 }" var="status">
				${fn:substring(carModel,0,16) }...
			</c:if>
			<c:if test="${ status==false}">
				${carModel} ${customer.carModelStr}
			</c:if>
			<br>
			vin码:
			<a href="${ctx }/qywxCustomer/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">${customer.customerPidBookingRecord.vinCode}</a>
			<br>
			顾问：${customer.bussiStaff}（${customer.department.name}）<br>
			回访时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
		</div>
	</div>
	<div class="line"></div>
	<div class="title" align="left">
 			回访信息
			</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;" >
		<div style="color:#8a8a8a;padding-left: 5px; ">
		回访状态：
		<c:if test="${visitRecord.ssiStatus==1 }">
			<span style="color: blue;">SSI调研成功</span>
			<br>
				合格：<c:if test="${visitRecord.coreQualified==1 }">
					<span style="color: green">合格</span>
				</c:if>
				<c:if test="${visitRecord.coreQualified==2 }">
					<span style="color: red;">不合格</span>
				</c:if>
				<br>
				满意度：
				${visitRecord.comSat }
				<br>
				综合得分：${visitRecord.coreScore }
			<br>
		</c:if>
		<c:if test="${visitRecord.ssiStatus>1 }">
			<c:if test="${visitRecord.ssiStatus==2 }">
				<span style="color: green;">SSI调研失败</span>
			</c:if>
			<c:if test="${visitRecord.ssiStatus==3 }">
				<span style="color: green;">SSI未调研</span>
			</c:if>
			<br>
			再访原因：${visitRecord.aginReason.name }<br>
		</c:if>
		任务状态：	
			<c:if test="${visitRecord.taskStatus==2 }">
				<span style="color: blue;">处理中</span><br>
			</c:if>
			<c:if test="${visitRecord.taskStatus==3 }">
				<span style="color: green;">回访完成</span><br>
			</c:if>
			<c:if test="${visitRecord.taskStatus==4 }">
				<span style="color: red;">不再回访</span><br>
			</c:if>
		回访结果：
		<c:if test="${visitRecord.visitResultStatus==1 }">
			<span style="color: red;">失败</span><br>
		</c:if>
		<c:if test="${visitRecord.visitResultStatus==2 }">
			<span style="color: blue;">成功</span><br>
		</c:if>
		<c:if test="${visitRecord.visitResultStatus==3 }">
			<span style="color: green;">跟踪</span><br>
		</c:if>
		<c:if test="${visitRecord.visitResultStatus==4 }">
			<span style="color: red;">未提车</span><br>
		</c:if>	
	</div>
</div>
</div>
<c:if test="${visitRecord.ssiStatus==1 }">
<div class="orderContrac detail">
	<div class="title" align="left">
		回访明细
	</div>
	<c:forEach var="questBigType" items="${questBigTypes }" varStatus="bigIndex">
	<div class="line"></div>
	<div class="title" align="left">${questBigType.name }</div>
	<div class="line"></div>
	<!-- 标题 -->
	<c:forEach var="quest" items="${questBigType.quests }" varStatus="questIndex">
		<div style="margin: 0 auto;margin: 5px;" >
			<div style="color:#8a8a8a;padding-left: 5px; ">
				<!-- 判断一网客户的回访题，二网回访客户题 -->
				<c:set value="" var="visitRecordAnswerParam"></c:set>
				<c:forEach items="${visitRecordAnswers }" var="visitRecordAnswer">
					<c:if test="${visitRecordAnswer.quest.dbid==quest.dbid }">
						<c:set value="${visitRecordAnswer }" var="visitRecordAnswerParam"></c:set>
					</c:if>
				</c:forEach>
				<!-- 获取对于题目的答案 -->
				<c:if test="${empty(visitRecordAnswerParam) }">
						${bigIndex.index+1 }.${questIndex.index+1 }
							<c:if test="${quest.isBetweenNetOne==1 }">
								${quest.content }
							</c:if>
							<c:if test="${quest.isBetweenNetOne==2 }">
								${quest.content }
								<c:if test="${customer.customerType==2 }">
									${quest.contentNet }
								</c:if>
							</c:if>
							<br>
							${visitRecordAnswerParam.questAnswerItem.lableName }
							<br>
							${visitRecordAnswerParam.note }
				</c:if>
				<c:if test="${!empty(visitRecordAnswerParam) }">
					<c:if test="${visitRecordAnswerParam.questAnswerItem.assessmentState==2 }" var="status">
							<span style="color: red;">
								${bigIndex.index+1 }.${questIndex.index+1 }
								<c:if test="${quest.isBetweenNetOne==1 }">
									${quest.content }
								</c:if>
								<c:if test="${quest.isBetweenNetOne==2 }">
									${quest.content }
									<c:if test="${customer.customerType==2 }">
										${quest.contentNet }
									</c:if>
								</c:if>
							</span>
							<br>
							<span style="font-weight: bold;">结果：</span>${visitRecordAnswerParam.questAnswerItem.lableName }
							<br>
							<span style="font-weight: bold;">备注:</span>${visitRecordAnswerParam.note }
					</c:if>
						<c:if test="${status==false}">
									${bigIndex.index+1 }.${questIndex.index+1 }
								<c:if test="${quest.isBetweenNetOne==1 }">
									${quest.content }
								</c:if>
								<c:if test="${quest.isBetweenNetOne==2 }">
									<c:if test="${customer.customerType==1 }">
										${quest.content }
									</c:if>
									<c:if test="${customer.customerType==2 }">
										${quest.contentNet }
									</c:if>
								</c:if>
								<br>
								<span style="font-weight: bold;">结果：</span>${visitRecordAnswerParam.questAnswerItem.lableName }
								<br>
								<span style="font-weight: bold;">备注:</span>${visitRecordAnswerParam.note }
					</c:if>
				</c:if>
				</div>
			</div>
		</c:forEach>
</c:forEach>
</div>
</c:if>
<!-- 成交结果  -->
<div class="orderContrac detail">
	<div class="title" align="left">
		回访备注
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
	<div style="color:#8a8a8a;padding-left: 5px; ">
		<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
				<tr>
					<td id="" width="50%">
						车牌：${customer.customerLastBussi.carPlateNo}
				    </td>
					<td id="" width="50%">
						上传日期：
						<fmt:formatDate value="${visitRecord.uploadFileDate }"/>
				    </td>
				</tr>
				<tr>
					<td id="" colspan="2" >
						备注：${visitRecord.note }
				    </td>
				</tr>
			</table>
		</div>
	</div>
</div>
<!-- 成交结果结束 -->

<br>
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function showDecore(frameSrc,cssobj,cssifm,otitle){
	$("#NoPermissioniframe").attr("src", frameSrc);
	$("#exampleModal").modal();
	 var _scrollHeight = $(document).scrollTop();
     var wHeight = $(window).height();
     var this_height;
     if(cssobj&&cssobj["height"])
       this_height=cssobj["height"];
     else
       this_height="350";
     var this_top=(wHeight-this_height)/2+_scrollHeight+"px";
     var this_top=(wHeight-this_height)/2+"px";

     var myifmcss=cssifm||{};//iframe样式
     $('#exampleModal .modal-dialog').find('.modal-content').css({height: '100%',width: '100%'}).find('h4').html(otitle||"").end().find('.modal-body').css({height: '65%'}).find("#NoPermissioniframe").css(myifmcss);;
}
$(function () {
	var window_w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
	var window_h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
	if($('.go_top').length==0){
	    $('body').append('<a href="#" class="go_top"><img src="${ctx}/images/jm/icon_top.png" data-original=${ctx}/images/jm/icon_top.png" alt=""></a>');
	}
	$(window).scroll(function(e){
	    if(document.body.scrollTop+document.documentElement.scrollTop>window_h){
	        $('.go_top').show();
	    }
	    else{
	        $('.go_top').hide();
	    }
	});
	$('.go_top').click(function(){
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	    return false;
	})
})
</script>
</html>