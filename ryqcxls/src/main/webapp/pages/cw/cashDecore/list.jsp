<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>装饰收银</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">装饰收银</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cashDecore/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户类型：</label></td>
  				<td>
					<select id="type" name="type" class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.type==1?'selected="selected"':'' }>自有客户</option>
						<option value="2" ${param.type==2?'selected="selected"':'' }>零售客户</option>
					</select>
				</td>
  				<td><label>销售类型：</label></td>
  				<td>
					<select id="correctStatus" name="correctStatus" class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.correctStatus==1?'selected="selected"':'' }>正常销售</option>
						<option value="2" ${param.correctStatus==2?'selected="selected"':'' }>缺货销售</option>
					</select>
				</td>
  				<td><label>出库状态：</label></td>
  				<td>
					<select id="status" name="status" class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.status==1?'selected="selected"':'' }>待出库</option>
						<option value="2" ${param.status==2?'selected="selected"':'' }>已出库</option>
					</select>
				</td>
  				<td><label>客户姓名：</label></td>
  				<td>
  					<input type="text" id="customerName" name="customerName" value="${param.customerName }" class="text small">
				</td>
			</tr>
			<tr>
				<td><label>客户电话：</label></td>
				<td>
					<input type="text" id="custTel" name="custTel" value="${param.custTel }" class="text small">
				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input type="text" id="saler" name="saler" value="${param.saler }" class="text small">
				</td>
				<td><label>销售日期：</label></td>
				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td style="text-align: center;">
  					~
				</td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无装饰销售
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">出库单号</td>
			<td class="span2">销售日期</td>
			<td class="span2">客户类型</td>
			<td class="span2">客户</td>
			<td class="span2">销售顾问</td>
			<td class="span2">实收金额</td>
			<td class="span2">销售金额</td>
			<td class="span1">折扣率</td>
			<td class="span1">销售类型</td>
			<td class="span1">结算状态</td>
			<td class="span1">出库状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="decoreOut" items="${page.result }">
		<c:set value="${decoreOut.customer }" var="customer"></c:set>
		<c:set value="${decoreOut.customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
		<tr height="32" align="center">
			<td style="text-align: center;"> 
				${decoreOut.outNo }
			</td>			
			<td style="text-align: center;"> 
				<fmt:formatDate value="${decoreOut.modifyDate }"/>
			</td>			
			<td style="text-align: center;"> 
				<c:if test="${decoreOut.type==1 }">
					自有客户
				</c:if>
				<c:if test="${decoreOut.type==2 }">
					零售客户 
				</c:if>
			</td>			
			<td style="text-align: center;"> 
				<c:if test="${empty decoreOut.customerName }">
					零售客户
				</c:if>
				<c:if test="${!empty decoreOut.customerName }">
					${decoreOut.customerName }
					${decoreOut.customer.mobilePhone }
				</c:if>
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.saler }
			</td>			
			<td style="text-align: center;"> 
				<span style="color:red">${decoreOut.acturePrice }</span>
			</td>			
			<td style="text-align: center;"> 
				<span style="color:red">${decoreOut.decoreSaleTotalPrce }</span>
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.zkl}%
			</td>			
			<td style="text-align: center;"> 
				<c:if test="${decoreOut.correctStatus==1 }">
					<span style="color: green;">正常销售</span>
				</c:if>
				<c:if test="${decoreOut.correctStatus==2 }">
					<c:if test="${decoreOut.type==1 }">
						<span style="color: red;">二次销售</span>
					</c:if>
					<c:if test="${decoreOut.type==2 }">
						<span style="color: red;">缺货销售</span>
					</c:if>
				</c:if>
			</td>	
			<td>
				<c:if test="${decoreOut.cashierStatus==1 }">
					<span style="color: red;">未收</span>
				</c:if>
				<c:if test="${decoreOut.cashierStatus==2 }">
					<span style="color: green;">已收</span>
				</c:if>
			</td>	
			<td>
				<c:if test="${decoreOut.status==1 }">
					<span style="color: red;">等待出库</span>
				</c:if>
				<c:if test="${decoreOut.status==2 }">
					<span style="color: green;">已经出库</span>
				</c:if>
			</td>		
			<td>
				<a href="${ctx}/cashDecore/add?decoreOutId=${decoreOut.dbid}" style="color: #2b7dbc;">收银</a>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
	 
	 function sendMms(){
		window.location.href="${ctx}/sms/add";
	 }
</script>
</html>