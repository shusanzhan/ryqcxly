<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="Keywords" content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<!-- 最新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="${ctx }/css/bootstrap/bootstrap.min.css">
<link  type="text/css" href="${ctx }/css/common.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.tableContent{
	width: 100%;
}
.tableContent tr{
	height: 32px;
}
.table-c{
}
.table-c table{border: 0}
.table-c table td{border-left:1px solid #767474;border-bottom: 1px solid #767474;}
.table-c table td:FIRST-CHILD{border-left:0;}
.table-c table td:nth-last-child(0){border-right:0;border-left:0;}
.table-c table tr:nth-last-child(0) td{border-right:0;border-left:0;border: 0;}
.tabletr{
	border: 0;
}
.tabletr td{
	
}
</style>
<title>贷款客户档案</title>
</head>
<body class="bodycolor">
<c:if test="${empty(param.from) }">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户档案</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.history.go(-1)">返回</a>
   </div>
   <div style="clear: both;"></div>
</div>
</c:if>
<c:if test="${!empty(param.from) }">
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.close()">关闭</a>
   </div>
</div>
</c:if>
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e5e5e5 ;">
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">姓名：</td>
		<td width="38%" align="left">
			${recommendCustomer.name }
			(
				<c:if test="${recommendCustomer.sex=='男' }">
					<span style="color: #56a845">${recommendCustomer.sex }</span>
				</c:if>
				<c:if test="${recommendCustomer.sex=='女' }">
					<span style="color: #ff6700">${recommendCustomer.sex }</span>
				</c:if>
			)
		</td>
		<td class="formTableTdLeft" width="12%" align="right">联系电话：</td>
		<td width="38%" align="left">
			${recommendCustomer.mobilePhone }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">车型：</td>
		<td width="38%" align="left">
			${recommendCustomer.brand.name }
			${recommendCustomer.carSeriy.name }
			${recommendCustomer.carModel.name }
			（
				<c:if test="${recommendCustomer.carriageType==1 }">
					手动变速箱
				</c:if>
				<c:if test="${recommendCustomer.carriageType==2 }">
					自动变速箱
				</c:if>
			）
		</td>
		<td class="formTableTdLeft" width="12%" align="right">推荐人：</td>
		<td width="38%" align="left">
			${recommendCustomer.agentName }【${recommendCustomer.agentPhone }】
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">审批状态：</td>
		<td width="38%" align="left">
			<c:if test="${recommendCustomer.approvalStatus==1 }">
				<span style="color:maroon;">待审批</span>
			</c:if>
			<c:if test="${recommendCustomer.approvalStatus==2 }">
				<span style="color: green;">已审批</span>
			</c:if>
		</td>
		<td class="formTableTdLeft" width="12%" align="right">推荐时间：</td>
		<td width="38%" align="left">
			${recommendCustomer.createDate }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">购车预算：</td>
		<td><span style="color: red">${recommendCustomer.budgetMoney }</span></td>
	</tr>
	<tr>
			<td class="formTableTdLeft" align="right" width="12%">分配状态：</td>
			<td width="38%" align="left">
				<c:if test="${recommendCustomer.distStatus==1}">
					<span style="color:#e50541;">待分配</span>
				</c:if>
				<c:if test="${recommendCustomer.distStatus==2}">
					<span style="color:green;">已分配</span>
				</c:if>
			</td>
			<td class="formTableTdLeft" align="right" width="12%">交易状态：</td>
			<td width="38%" align="left">
				<c:if test="${recommendCustomer.tradeStatus==1}">
					<span style="color:#e50541;">交易中...</span>
				</c:if>
				<c:if test="${recommendCustomer.tradeStatus==2}">
					<span style="color: green;">交易成功</span>
				</c:if>
				<c:if test="${recommendCustomer.tradeStatus==3}">
					<span style="color: red;">交易失败</span>
				</c:if>
			</td>
		</tr>
</table>
<div class="containerLeft" style="width: 100%">
	<div style="margin: 5px 12px;border-buttom:1px solid rgb( 222, 222, 222 ); margin-top: 30px;">
		<ul class="nav nav-tabs" role="tablist">
		  	<c:if test="${param.type==1 }" var="sta">
				  <li class="active">
				  	<a href="#factoryOrder" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  	<c:if test="${sta==false }">
				  <li>
				  	<a href="#factoryOrder" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  <c:if test="${param.type==2 }" var="sta">
		  	<li class="active">
		  		<a href="#installItem" role="tab" data-toggle="tab">推荐人信息</a>
		  	</li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#installItem" role="tab" data-toggle="tab">推荐人信息</a></li>
		  </c:if>
		   <c:if test="${param.type==4 }" var="sta">
		  	<li  class="active"><a href="#carOperateLog" role="tab" data-toggle="tab">操作日志</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carOperateLog" role="tab" data-toggle="tab">操作日志</a></li>
		  </c:if>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content" >
			<c:if test="${param.type==1 }" var="sta">
			  <div class="tab-pane active" id="factoryOrder" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="factoryOrder" >
			</c:if>
		  		<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
		  			<tr>
						<td class="formTableTdLeft" >地址：</td>
						<td width="38%" align="left">
							${recommendCustomer.province }
							${recommendCustomer.city }
							${recommendCustomer.areaStr }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" >推荐人：</td>
						<td width="38%" align="left">
							${recommendCustomer.agentName }
						</td>
						<td class="formTableTdLeft" >推荐人电话：</td>
						<td width="38%" align="left">
							${recommendCustomer.agentPhone }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" >审批状态：</td>
						<td>
							<c:if test="${recommendCustomer.approvalStatus==1 }">
								<span style="color:maroon;">待审批</span>
							</c:if>
							<c:if test="${recommendCustomer.approvalStatus==2 }">
								<span style="color: green;">已审批</span>
							</c:if>
						</td>
						<td>推荐时间：</td>
						<td>
							${recommendCustomer.createDate }
						</td>
					</tr>
					<c:if test="${recommendCustomer.approvalStatus==2 }">
					<tr>
						<td class="formTableTdLeft" >审批人：</td>
						<td>
							${recommendCustomer.approvalUser}
						</td>
						<td>审批时间：</td>
						<td>
							${recommendCustomer.approvalDate}
						</td>
					</tr>
					</c:if>
					<tr>
						<td class="formTableTdLeft" >分配状态：</td>
						<td colspan="1">
							<c:if test="${recommendCustomer.distStatus==1}">
								<span style="color:#e50541;">待分配</span>
							</c:if>
							<c:if test="${recommendCustomer.distStatus==2}">
								<span style="color:green;">已分配</span>
							</c:if>
						</td>
						<td class="formTableTdLeft" >分配销售顾问：</td>
						<td colspan="1">
							${recommendCustomer.saler.realName }
						</td>
					</tr>
					<c:if test="${recommendCustomer.distStatus==2}">
						<tr>
							<td class="formTableTdLeft" >分配操作人：</td>
							<td>
								${recommendCustomer.distUser}
							</td>
							<td>分配时间：</td>
							<td>
								${recommendCustomer.distDate}
							</td>
						</tr>
					</c:if>
				</table>
		  </div>
		  	<c:if test="${param.type==2 }" var="sta">
			   <div class="tab-pane active" id="installItem" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="installItem">
			</c:if>
				<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
		  			<tr>
						<td class="formTableTdLeft" align="right" width="12%">姓名：</td>
						<td width="38%" align="left">
							${member.name }
							(
								<c:if test="${agent.sex=='男' }">
									<span style="color: #56a845">${member.sex }</span>
								</c:if>
								<c:if test="${agent.sex=='女' }">
									<span style="color: #ff6700">${member.sex }</span>
								</c:if>
							)
						</td>
						<td class="formTableTdLeft" width="12%" align="right">联系电话：</td>
						<td width="38%" align="left">
							${member.mobilePhone }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" align="right" width="12%">所在区域：</td>
						<td width="38%" align="left">
						<c:set value="${member.weixinGzuserinfo }" var="weixinGzuserinfo"></c:set>
							${weixinGzuserinfo.province }
							${weixinGzuserinfo.city }
						</td>
						<td class="formTableTdLeft" width="12%" align="right">申请时间：</td>
						<td width="38%" align="left">
							${member.agentDate }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" align="right" width="12%">支付账号类型：</td>
						<td width="38%" align="left">
							<c:if test="${member.payType==1 }">
								微信支付
							</c:if>
							<c:if test="${member.payType==2 }">
								支付宝
							</c:if>
						</td>
						<td class="formTableTdLeft" width="12%" align="right">账号：</td>
						<td width="38%" align="left">
							${member.accountNo }
						</td>
					</tr>
				</table>
		  </div>
		  <c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="carOperateLog" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carOperateLog">
			</c:if>
		  		<c:if test="${fn:length(agentOperatorLogs)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>车辆操作日志
					</div>
				</c:if>
				<c:if test="${status==false}">
					<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-bottom: 32px;">
						<thead>
							<tr>
								<td style="width: 40px;">
									序号		
								</td>
								<td style="width: 120px;">操作类型</td>
								<td style="width: 80px;">操作时间</td>
								<td style="width: 80px;">操作人</td> 
								<td style="width: 120px;">备注</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${agentOperatorLogs}" var="finOperatorLog" varStatus="i">
							<tr >
								<td style="text-align: center;">
									${i.index+1 }
								</td>
								<td>
									${finOperatorLog.type }
								</td>
								<td>
									<fmt:formatDate value="${finOperatorLog.operateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>	 
								</td>
								<td>
									${finOperatorLog.operator}
								</td>
								<td style="text-align: left;">
									${finOperatorLog.note}
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
		  </div>
		  
		</div>
	</div>
</div>
</body>
<script type='text/javascript'  src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script type='text/javascript'  src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
