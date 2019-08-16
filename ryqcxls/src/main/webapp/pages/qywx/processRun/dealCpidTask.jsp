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
<title>我的审批</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">审批【${customer.name }】合同流失</span>
    <a class="go_home" href="${ctx }/qywxProcessRun/queryWaitingTaskList">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：${customer.name }<br/>
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
				${carModel }${customer.carModelStr}
			</c:if>
			<br>
			<c:forEach var="customerPidCancel" items="${customerPidCancels }" varStatus="i">
				流失原因${i.index+1 }:&nbsp;${customerPidCancel.note }<br>
			</c:forEach>
		</div>
	</div>
</div>
<c:forEach var="processFrom" items="${processFroms }" varStatus="i">
	<div class="orderContrac">
	<div class="title" align="left">
		审批记录${i.index+1 }
	</div>
	<div class="line"></div>
		<div style="margin: 0 auto;margin: 5px;" >
		<div style="color:#8a8a8a;padding-left: 5px; ">
				任务名称：${processFrom.taskName }
				<br>
				创建时间：<fmt:formatDate value="${processFrom.createTime }" pattern="yyyy-MM-dd HHH:mm"/><br>
				上个任务：${processFrom.fromTaskName }<br>
				审批人：${processFrom.taskUserName } <br/>
				审批状态:
				<c:if test="${processFrom.status==1 }">
					<span style="color: red">待审批</span>
				</c:if>
				<c:if test="${processFrom.status==2 }">
					<span style="color: green">已审批</span>
				</c:if>
				<br>
				审批结果：
				<c:if test="${processFrom.approvalStatus==1 }">
						<span style="color: red">待审批</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==2 }">
						<span style="color: red">审批驳回</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==3 }">
						<span style="color: green;">通过</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==4 }">
						<span style="color: green;">提交上级审批</span>
					</c:if>
				<br>
				处理时间:
					<fmt:formatDate value="${processFrom.finishTime }"/><br>
				审批意见：
				${processFrom.comments }
				<br>
				用时(小时):(${processFrom.duringLong }小时)
			</div>
			</div>
	</div>
</c:forEach>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">审批</h4>
      </div>
      <div class="modal-body">
        <form id="frmId" name="frmId" method="post" >
        	<s:token></s:token>
				<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid}"/>
				<input type="hidden" id="processFromId" name="processFromId" value="${processFrom.dbid}"/>
				<input type="hidden" id="approvalStatus" name="approvalStatus" value=""/>
	          <div class="form-group">
	            <label for="message-text" class="control-label">意见:</label>
	            <textarea class="form-control" name="sugg" id="sugg" style="height: 120px;"></textarea>
	          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="submitAjaxForm('frmId','${ctx}/qywxProcessRun/saveDealTask')">提&nbsp;&nbsp;交</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
<br>
<div class="orderMenu">
	<ul>
		<c:if test="${!empty(user.parent) }">
         <li style="width: 33%">
             <a href="javascript:void(-1)" id="agreeActive"  data-toggle="modal" data-target="#exampleModal" onclick="setVal(4)">
             	提交上级审批
             </a>
         </li>
        </c:if>
        
         <li style="width: 33%">
             <a href="javascript:void(-1)"  data-toggle="modal" data-target="#exampleModal" onclick="setVal(2)">
             	不同意
             </a>
         </li>
		<c:if test="${user.approvalCpidStatus==2 }">
	         <li style="width: 33%">
	             <a href="javascript:void(-1)" id="agreeActive" data-toggle="modal" data-target="#exampleModal" onclick="setVal(3)">
	             	同意
	             </a>
	         </li>
	    </c:if>
      </ul>
</div>	
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
	function setVal(va){
		$("#approvalStatus").val(va);
		if(va==2){
			$('#exampleModal').find('.modal-title').text('审批（不同意） ');
		}
		if(va==3){
			$('#exampleModal').find('.modal-title').text('审批（同意） ');
		}
		if(va==4){
			$('#exampleModal').find('.modal-title').text('审批（提交上级审批） ');
		}
	}
</script>
</html>