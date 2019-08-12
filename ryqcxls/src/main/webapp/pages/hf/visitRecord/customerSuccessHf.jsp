<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>成交客户管理-领导管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
document.onkeydown=function(event){ 
	 e = event ? event :(window.event ? window.event : null); 
	 if(e.keyCode==13){ 
		 if(e.keyCode==13){
			 $('#searchPageForm')[0].submit(); //处理事件
		 }
	 } 
}  
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">成交管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/visitRecord/exportExcelUrl'">导出excel</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/visitRecord/customerSuccessHf" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				
	  			<td><label>部门：</label></td>
  				<td>
  					<select id="departmentId" name="departmentId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						${departmentSelect }
					</select>
				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="userName" name="userName"  value="${param.userName }">
				</td>
	  				<td><label>任务状态：</label></td>
	  				<td>
	  					<select id="taskStatus" name="taskStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
							<option value="">请选择...</option>
							<option value="2" ${param.taskStatus==2?'selected="selected"':'' } >处理中</option>
							<option value="3" ${param.taskStatus==3?'selected="selected"':'' } >回访完成</option>
							<option value="4" ${param.taskStatus==4?'selected="selected"':'' } >不再回访</option>
						</select>
					</td>
	  				<td><label>SSI状态：</label></td>
	  				<td>
	  					<select id="ssiStatus" name="ssiStatus" class="text small" onchange="$('#searchPageForm')[0].submit()">
							<option value="">请选择...</option>
							<option value="1" ${param.ssiStatus==1?'selected="selected"':'' }>成功</option>
							<option value="2" ${param.ssiStatus==2?'selected="selected"':'' }>失败</option>
							<option value="3" ${param.ssiStatus==3?'selected="selected"':'' }>未调研</option>
						</select>
					</td>
	  				<td><label>回访结果：</label></td>
	  				<td>
	  					<select id="visitResultStatus" name="visitResultStatus" class="text small" onchange="$('#searchPageForm')[0].submit()">
							<option value="">请选择...</option>
							<option value="1" ${param.visitResultStatus==1?'selected="selected"':'' } >失败</option>
							<option value="2" ${param.visitResultStatus==2?'selected="selected"':'' }>成功</option>
							<option value="3" ${param.visitResultStatus==3?'selected="selected"':'' }>跟踪</option>
							<option value="4" ${param.visitResultStatus==4?'selected="selected"':'' }>未提车</option>
						</select>
					</td>
  				</tr>
  				<tr>
	  				<td><label>常用手机号：</label></td>
	  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
	  				<td><label>vin码：</label></td>
	  				<td><input type="text" id="vinCode" name="vinCode" class="text small" value="${param.vinCode}"></input></td>
	  				<td><label>姓名：</label></td>
	  				<td><input type="text" id="customerName" name="customerName" class="text small" value="${param.customerName}"></input></td>
	  				<td><label>归档日期开始：</label></td>
	  				<td colspan="3">
	  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >~
	  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
					</td>
	  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
		
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			 <td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 80px;">客户</td>
			<td style="width:140px;">车型</td>
			<td style="width: 60px;">所属公司</td>
			<td style="width: 60px;">顾问</td>
			<td style="width: 80px;">成交时间</td>
			<td style="width: 60px;">任务状态</td>
			<td style="width: 60px;">SSI状态</td>
			<td style="width: 60px;">回访结果</td>
			<td style="width: 60px;">回访日期</td>
			<td style="width: 80px;">再访原因</td>
			<td style="width: 80px;">合格</td>
			<td style="width: 30px;">得分</td>
			<td style="width: 60px;">满意度</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="visitRecord">
		<c:set value="${visitRecord.customer }" var="customer"></c:set>
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td> 
			<td>
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
					</c:if>
						（
						<c:if test="${customer.customerType==1}">
							一网
						</c:if>
						<c:if test="${customer.customerType==2}">
							二网
						</c:if>
						）
					${customer.mobilePhone}
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${customer.orderContract.dbid }')">补打合同</a> </li>
					      <li>	<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${customer.orderContract.dbid }'">查看订单</a> </li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/outboundOrder/viewIndex?customerId=${customer.dbid}'">查看出库</a> </li>
					       <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }${customer.customerPidBookingRecord.carColor.name}" var="carModel"></c:set>
			<td style="text-align: left;" title="${carModel} ${customer.carModelStr}">
				<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">
					${customer.customerPidBookingRecord.vinCode }
				</a>
				<br>
				 ${fn:length(carModel)>16?fn:substring(carModel,0,16):carModel }<br>
			</td>
			<td>
				${customer.enterprise.name}
			</td>
			<td>
				${customer.bussiStaff}
				<br>
				(${customer.department.name })
			</td>
			<td>
				<fmt:formatDate value="${visitRecord.fileDate }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<c:if test="${visitRecord.taskStatus==2 }">
					<span style="color: blue;">处理中</span><br>
				</c:if>
				<c:if test="${visitRecord.taskStatus==3 }">
					<span style="color: green;">回访完成</span><br>
				</c:if>
				<c:if test="${visitRecord.taskStatus==4 }">
					<span style="color: red;">不再回访</span><br>
				</c:if>
			</td>
			<td>
				<c:if test="${visitRecord.ssiStatus==1 }">
					<span style="color: blue;">成功</span><br>
				</c:if>
				<c:if test="${visitRecord.ssiStatus==2 }">
					<span style="color: red;">失败</span><br>
				</c:if>
				<c:if test="${visitRecord.ssiStatus==3 }">
					<span style="color: red;">未调研</span><br>
				</c:if>
			</td>
			<td>
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
			</td>
			<td>
				<fmt:formatDate value="${visitRecord.createTime }" pattern="yyyy-MM-dd HH:mm"/>
				
			</td>
			<td >
				<c:if test="${empty(visitRecord.aginReason) }">
					-
				</c:if>
				<c:if test="${!empty(visitRecord.aginReason) }">
					${visitRecord.aginReason.name }
				</c:if>
			</td>
			<c:if test="${visitRecord.ssiStatus==1 }">
				<td>
					<c:if test="${visitRecord.coreQualified==1 }">
						<span style="color: green">合格</span>
						<br>
						<c:if test="${visitRecord.returnNumber==1 }">
							一次
						</c:if>
					</c:if>
					<c:if test="${visitRecord.coreQualified==2 }">
						<span style="color: red;">两次及以上</span>
					</c:if>
				</td>
				<td>
					${visitRecord.coreScore }
				</td>
				<td>
					${visitRecord.comSat }
				</td>
			</c:if>
			<c:if test="${visitRecord.ssiStatus>1 }">
				<td>
					-
				</td>
				<td>
					-
				</td>
				<td>
					-
				</td>
			</c:if>
			<td>
				<a style="color: #2b7dbc" href="#" class="aedit" onclick="window.location.href='${ctx }/visitRecord/add?customerId=${customer.dbid}&directType=2'">回访记录</a>
				<br>
				<a style="color: #2b7dbc" href="#" class="aedit" onclick="$.utile.openDialog('${ctx}/visitRecord/updateCustomer?customerId=${customer.dbid }&directType=2','修改客户信息',800,350)">修改客户信息</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
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
	 /* function exportExcel(searchFrm){
	 	var params;
	 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
	 		params=$("#"+searchFrm).serialize();
	 	}
	 	window.location.href='${ctx}/visitRecord/exportExcel?'+params;
	 } */
	 function exportExcel(searchFrm){
			top.art.dialog({
			    title: '导出EXCEL数据',
			    content: document.getElementById('templateId'),
			    lock : true,
				fixed : true,
				width:'580px',
				height:'320px',
			    ok: function () {
			    	var params;
				 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
				 		params=$("#"+searchFrm).serialize();
				 	}
				 	window.location.href='${ctx}/visitRecord/exportExcel?'+params;
					return true;
			    },
			    cancel:function(){
					return true;
			    }
			});
		}
</script>
</html>
