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
<title>推荐人档案</title>
</head>
<body class="bodycolor">
<c:if test="${empty(param.from) }">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">推荐人档案</a>
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
			${member.name }
			(
				<c:if test="${member.sex=='男' }">
					<span style="color: #56a845">${member.sex }</span>
				</c:if>
				<c:if test="${member.sex=='女' }">
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
		<td class="formTableTdLeft" align="right" width="12%">推荐客户：</td>
		<td width="38%" align="left">
			<span style="color: red;font-size: 16px;">${member.agentNum }</span>
		</td>
		<td class="formTableTdLeft" width="12%" align="right">推荐成功客户：</td>
		<td width="38%" align="left">
			<span style="color: green;font-size: 16px;">${member.agentSuccessNum }</span>
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
		  	<li class="active"><a href="#carTransfer" role="tab" data-toggle="tab">推荐客户</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carTransfer" role="tab" data-toggle="tab">推荐客户</a></li>
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
							<td >
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
		  <c:if test="${param.type==2 }" var="sta">
			  <div class="tab-pane active" id="carTransfer" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carTransfer" >
			</c:if>
				<c:if test="${fn:length(hisRecommendCustomers)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无推荐客户
					</div>
				</c:if>
				<c:if test="${status==false}">
					<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-bottom: 32px;">
						<thead>
							<tr>
								<td style="width: 40px;">
									序号		
								</td>
								<td class="span2">名称</td>
								<td class="span2">联系电话</td>
								<td class="span3">省（直辖市）-市-区</td>
								<td class="span3">车型</td>
								<td class="span2">日期</td>
								<td class="span2">审核</td>
								<td class="span2">分配</td>
								<td class="span2">状态</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${hisRecommendCustomers}" var="recommentCustomer" varStatus="i">
							<tr >
								<td style="text-align: center;">
									${i.index+1 }
								</td>
								<td >${recommentCustomer.name }（${recommentCustomer.sex }）</td>
								<td >
									${fn:substring(recommentCustomer.mobilePhone,0,3)  }
									****
									${fn:substring(recommentCustomer.mobilePhone,6,10)  }
								</td>
								<td style="text-align: left;">
									${recommentCustomer.province }
									${recommentCustomer.city }
									${recommentCustomer.areaStr }
								</td>
								<td>
									${recommentCustomer.brand.name }
									${recommentCustomer.carSeriy.name }
									${recommentCustomer.carModel.name }
								</td>
								<td>${recommentCustomer.recommendDate }</td>
								<td>
									<c:if test="${recommentCustomer.approvalStatus==1}">
										<span style="color:#e50541;">待审批</span>
									</c:if>
									<c:if test="${recommentCustomer.approvalStatus==2}">
										<span style="color:green;">已审批</span>
									</c:if>
								</td>
								<td>
									<c:if test="${recommentCustomer.distStatus==1}">
										<span style="color:#e50541;">待分配</span>
									</c:if>
									<c:if test="${recommentCustomer.distStatus==2}">
										<span style="color:green;">已分配</span>
									</c:if>
								</td>
								<td>
									<c:if test="${recommentCustomer.tradeStatus==1}">
										<span style="color:#e50541;">交易中</span>
									</c:if>
									<c:if test="${recommentCustomer.tradeStatus==2}">
										<span style="color: green;">交易成功</span>
									</c:if>
									<c:if test="${recommentCustomer.tradeStatus==3}">
										<span style="color: red;">交易失败</span>
									</c:if>
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
