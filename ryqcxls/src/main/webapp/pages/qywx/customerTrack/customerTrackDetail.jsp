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
<title>批阅登记回访明细</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.form-inline tr{
	height: 45px;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">批阅登记回访明细</span>
      <a class="go_home" href="${ctx }/qywxCustomerTrack/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<c:if test="${empty(customerTrack)}" var="status">
	您还未填写登记回访明细！
</c:if>
<c:if test="${status==false }">
		<c:set value="${customerTrack.customer }" var="customer"></c:set>
		<div class="orderContrac">
			<div class="title" align="left">
	  			客户：${customer.name }<br/>
	  			电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;" >
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
					顾问：${customer.bussiStaff}（${customer.department.name}）<br>
					意向级别：${customer.customerPhase.name}<br>
					登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
				</div>
			</div>
  			<div class="line"></div>
			<div class="title" align="left">
	  			跟踪信息
  			</div>
  			<div class="line"></div>
  			<div style="margin: 0 auto;margin: 5px;" >
				<div style="color:#8a8a8a;padding-left: 5px; ">
		  			<table width="100%">
						<tr>
							<td colspan="2" class="formTableTdLeft">跟进类型：
								<c:if test="${customerTrack.trackType==1 }">
									日常关系维护
								</c:if>
								<c:if test="${customerTrack.trackType==2 }">
									普通邀约到店
								</c:if>
								<c:if test="${customerTrack.trackType==3 }">
									活动邀约到店
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="formTableTdLeft">跟进日期：
								<fmt:formatDate value="${customerTrack.trackDate }" pattern="yyyy年MM月dd日" />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="formTableTdLeft">跟进方法：
							<c:if test="${customer.lastResult==1 }">
								电话
							</c:if>
							<c:if test="${customer.lastResult==2 }">
								到店
							</c:if>
							<c:if test="${customer.lastResult==3 }">
								短信
							</c:if>
							<c:if test="${customer.lastResult==4 }">
								上门
							</c:if>
							<c:if test="${customer.lastResult==5 }">
								微信
							</c:if>
							<c:if test="${customer.lastResult==6 }">
								QQ
							</c:if>
							</td>
						</tr>
						<tr>
							<td  colspan="2" class="formTableTdLeft">意向级别：
								${customerTrack.beforeCustomerPhase.name}
							</td>
						</tr>
						<tr>
							<td colspan="2" class="formTableTdLeft">下次预约：
								<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd HH:mm"/>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="formTableTdLeft">跟进内容：
								${customerTrack.trackContent }
							</td>
						</tr>
						<tr >
							<td colspan="2" class="formTableTdLeft">沟通结果：
								${customerTrack.result }
							</td>
						</tr>
						<tr >
							<td colspan="2" class="formTableTdLeft">反馈问题：
								${customerTrack.feedBackResult }
							</td>
						</tr>
						<tr >
							<td colspan="2" class="formTableTdLeft">对应措施：
								${customerTrack.dealMethod }
							</td>
						</tr>
						<tr >
							<td colspan="2" class="formTableTdLeft">经理意见：
								${customerTrack.showroomManagerSuggested } 
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="orderContrac">
			<div class="title" align="left">
	  			展厅经理意见
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;">
				<div style="color:#8a8a8a;padding-left: 5px; ">
					<form action="" id="frmId" name="frmId">
						<input type="hidden" value="${next.dbid }" id="nextId" name="nextId">
						<c:if test="${empty(next) }">
							<input type="hidden" value="2" id="type" name="type">
						</c:if>
						<c:if test="${!empty(next) }">
							<input type="hidden" value="1" id="type" name="type">
						</c:if>
						<input type="hidden" value="${customerTrack.dbid }" id="dbid" name="dbid">
						<textarea rows="" cols="" id="sugg" name="sugg" style="border: 1px solid #8a8a8a;width: 100%;margin-bottom: 8px;" placeholder="请填写意见"></textarea>
					</form>
				</div>
			</div>
		</div>
</c:if>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">审批</h4>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="submitAjaxForm('frmId','${ctx}/qywxOrderContract/saveApproval')">提&nbsp;&nbsp;交</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
<div class="oneMenu">
	<ul>
         <li>
             <a href="javascript:void(-1)" onclick="submitAjaxForm('frmId', '${ctx}/qywxCustomerTrack/saveReadCustomerTrack')">
             	保存并继续
             </a>
         </li>
      </ul>
</div>	
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
</html>