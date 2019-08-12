<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>${customerRecord.name } 线索信息</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${customerRecord.name }线索信息</span>
    <c:if test="${param.type==1 }">
      <a class="go_home" href="${ctx }/qywxCustomer/index">
	    	<img src="${ctx }/images/jm/go_home.png" alt="">
	    </a>
    </c:if>
    <c:if test="${param.type==2 }">
      <a class="go_home" href="${ctx }/qywxCustomerTrack/index">
	    	<img src="${ctx }/images/jm/go_home.png" alt="">
	    </a>
    </c:if>
</div>
<br>
<br>
<br>
<div class="orderContrac detail">
	<div class="title" align="left">
	 		<c:if test="${empty(customerRecord.name) }">
				客户：	
				<c:if test="${empty(customerRecord.customer.name) }">
					无
				</c:if>
				<c:if test="${!empty(customerRecord.customer.name) }">
					${customerRecord.customer.name }
				</c:if>
				
			</c:if>
 			<c:if test="${!empty(customerRecord.name) }">
 				<br/>
				客户：	${customerRecord.name }<br>
				联系电话：<a href="tel:${customerRecord.mobilePhone }">${customerRecord.mobilePhone }</a><br>
				<c:if test="${!empty(customerRecord.address) }">
					所在区域：${customerRecord.address }
				</c:if>
			</c:if>
			</div>
			<div class="line"></div>
		<div style="margin: 0 auto;margin: 5px;">
			<div style="color:#8a8a8a;padding-left: 5px; ">
				登记日期：<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd"/><br/>
				线索类型：
	  			${customerRecord.customerType.name }
				<br>
				<c:if test="${customerRecord.customerType.dbid==1 }">
					进店线索类型：
					<c:if test="${customerRecord.comeInType==1 }">
						展厅到店
					</c:if>
					<c:if test="${customerRecord.comeInType==2 }">
						网销到店
					</c:if>
					<c:if test="${empty(customerRecord.comeInType) }">
						-
					</c:if>
					<br>
				</c:if>
				备注：
				${customerRecord.note }
				<br>
				车型：
				<c:if test="${empty(customerRecord.brand) }">
					<c:if test="${empty(customerRecord.carModels)}">
						-
					</c:if>
					<c:if test="${!empty(customerRecord.carModels)}">
						${customerRecord.carModels }
					</c:if>
				</c:if>
				${customerRecord.brand.name }
				${customerRecord.carSeriy.name }
				${customerRecord.carModel.name }${customerRecord.carModelStr}
				<br>
				进店/来电时间：
				<c:if test="${customerRecord.customerType.dbid!=1 }">
					<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
				</c:if>
				<c:if test="${customerRecord.customerType.dbid==1 }">
					${customerRecord.comeInTime}
				</c:if>
				<br>
				进店/来电目的：
				${customerRecord.customerRecordTarget.name}
				<br>
				进店人数：
					<c:if test="${customerRecord.customerType.dbid!=1 }">
						?
					</c:if>
					<c:if test="${customerRecord.customerType.dbid==1 }">
						${customerRecord.customerNum}
						人
					</c:if>
				<br>
				信息来源：${customerRecord.customerInfrom.name }
				<br>
				线索状态：
				<c:if test="${customerRecord.resultStatus==2 }">
					<span style="color: green;">转为登记</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==1 }">
					<span style="color: pink;">等待...</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==3 }">
					<span style="color: red;">无效</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==4 }">
					<span style="color: green;">已绑定</span>
				</c:if><br>
				来店次数：
				<c:if test="${customerRecord.comeinNum==0 }">
					未到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==1 }">
					初次到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==2 }">
					二次来店
				</c:if>
				<br>
			</div>
	</div>
	<c:if test="${customerRecord.status==1 }">
		<div class="line"></div>
		<div class="title" align="left">
	 			处理结果
		</div>
		<div class="line"></div>
		<div style="margin: 0 auto;margin: 5px;">
			<div style="color:#8a8a8a;padding-left: 5px; ">
				线索状态：
				<c:if test="${customerRecord.resultStatus==2 }">
					<span style="color: green;">转为登记</span>
					<a href="${ctx}/qywxCustomer/customerDetail?customerId=${customerRecord.customer.dbid }&type=${param.type}">客户档案</a>
				</c:if>
				<c:if test="${customerRecord.resultStatus==1 }">
					<span style="color: pink;">等待...</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==3 }">
					<span style="color: red;">无效</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==4 }">
					<span style="color: green;">已绑定</span>
				</c:if>
				<br>
				顾问：${customerRecord.saler.realName}（${customerRecord.saler.department.name}）
				<br>
				处理时间：
				<fmt:formatDate value="${customerRecord.resultDate }" pattern="yyyy-MM-dd HH:mm"/>
				<br>
				无效原因：
				${customerRecord.customerRecordClubInvalidReason.name }
				<br>
				备注：
				${customerRecord.invalidNote}
				<br>
			</div>
		</div>
	</c:if>
</div>
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
</html>