<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>有效线索</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">有效线索</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butSave" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出EXCEL</a>
   </div>
  	<div class="seracrhOperate" >
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerRecord/queryLeaderValidList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text small" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text small" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text small" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>意向级别：</label></td>
  				<td>
  					<select class="text small" id="customerPhaseId" name="customerPhaseId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }" end="3">
							<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>类型：</label></td>
  				<td>
  					<select class="text small" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<option value="1" ${param.type==1?'selected="selected"':'' } >前台[进店]</option>
						<option value="2" ${param.type==2?'selected="selected"':'' } >前台[来电]</option>
						<option value="3" ${param.type==3?'selected="selected"':'' } >网销录入线索</option>
						<option value="4" ${param.type==4?'selected="selected"':'' } >展厅录入线索</option>
					</select>
  				</td>
  				<td><label>处理结果：</label></td>
  				<td>
  					<select class="small text" id="resultStatus" name="resultStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="2" ${param.resultStatus==2?'selected="selected"':'' } >转为登记</option>
						<option value="3" ${param.resultStatus==3?'selected="selected"':'' } >已回访</option>
					</select>
				</td>
  				<td><label>来店次数：</label></td>
  				<td>
  					<select class="small text" id="comeinNum" name="comeinNum" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.comeinNum==1?'selected="selected"':'' } >初次来店</option>
						<option value="2" ${param.comeinNum==2?'selected="selected"':'' } >二次来店</option>
					</select>
				</td>
				<td><label>互动次数：</label></td>
  				<td>
  					<select class="small text" id="trackNum" name="trackNum" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.trackNum==1?'selected="selected"':'' } >1次</option>
						<option value="2" ${param.trackNum==2?'selected="selected"':'' } >2次</option>
						<option value="3" ${param.trackNum==3?'selected="selected"':'' } >3次</option>
						<option value="4" ${param.trackNum==4?'selected="selected"':'' } >4次</option>
						<option value="5" ${param.trackNum==5?'selected="selected"':'' } >5次</option>
						<option value="6" ${param.trackNum==6?'selected="selected"':'' } >6次以上</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><label>进店次数：</label></td>
  				<td>
  					<select class="small text" id="comeShopNum" name="comeShopNum" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.comeShopNum==1?'selected="selected"':'' } >1次</option>
						<option value="2" ${param.comeShopNum==2?'selected="selected"':'' } >2次</option>
						<option value="3" ${param.comeShopNum==3?'selected="selected"':'' } >3次</option>
						<option value="4" ${param.comeShopNum==4?'selected="selected"':'' } >4次</option>
						<option value="5" ${param.comeShopNum==5?'selected="selected"':'' } >5次</option>
						<option value="6" ${param.comeShopNum==6?'selected="selected"':'' } >6次以上</option>
					</select>
				</td>
				<td><label>客户姓名：</label></td>
  				<td>
  					<input class="small text" id="custName" name="custName" value="${param.custName }">
				</td>
				<td><label>联系电话：</label></td>
  				<td>
  					<input class="small text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }">
				</td>
				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="saler" name="saler" value="${param.saler }">
				</td>
			</tr>
			<tr>
				<td><label>登记开始：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${param.startTime }" >
  				</td>
				<td><label>登记结束：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${param.endTime }">
  				</td>
				<td><label>处理开始：</label></td>
  				<td>
  					<input class="small text" id="resultStartTime" name="resultStartTime" onFocus="WdatePicker({isShowClear:true})" value="${param.resultStartTime }" >
  				</td>
				<td><label>处理结束：</label></td>
  				<td>
  					<input class="small text" id="resultEndTime" name="resultEndTime" onFocus="WdatePicker({isShowClear:true})" value="${param.resultEndTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 12px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 100px;">登记日期</td>
			<td style="width: 100px;">类型</td>
			<td style="width: 100px;">客户姓名</td>
			<td style="width: 160px;">车型</td>
			<td style="width: 100px;">时间</td>
			<td style="width: 60px">进店次数</td>
			<td style="width: 60px">互动次数</td>
			<td style="width: 60px;">意向级别</td>
			<td style="width: 80px;">销售顾问</td>
			<td style="width:80px;">处理结果</td>
			<td style="width: 80px;">来店次数</td>
			<td style="width: 80px;">超时状态</td>
			<td style="width: 60px;">登记人</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customerRecord">
		<c:set value="${customerRecord.customer }" var="customer"></c:set>
		<tr>
			<td style="text-align: left;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/customerRecord/view?dbid=${customerRecord.dbid}'">
					<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/>
					<c:if test="${!empty(customerRecord.agentUser) }">
						<br>${customerRecord.agentUser.realName}[代办]
					</c:if>
				</a> 
			</td>
			<td>
				${customerRecord.customerType.name }
			</td>
			<td style="text-align: left;">
				<c:if test="${empty(customerRecord.name) }">
					无
				</c:if>
				<c:if test="${!empty(customerRecord.name) }">
					 <c:if test="${!empty(customerRecord.customer) }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customerRecord.customer.dbid}&type=1'">${customerRecord.name } 
							<br>
							${customerRecord.mobilePhone }
						</a>
					</c:if>
					 <c:if test="${empty(customerRecord.customer) }">
							${customerRecord.name } 
							<br>
							${customerRecord.mobilePhone }
					</c:if>
				</c:if>
			</td>
			<td style="text-align: left;">
				<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
				${carModel}  ${customer.carModelStr}
			</td>
			<td>
				${customerRecord.comeInTime}
			</td>
			<td>
				${customer.comeShopNum }
			</td>
			<td>
				${customer.trackNum }
			</td>
			<td>
				${customer.customerPhase.name }
			</td>
			<td>
				<c:if test="${empty(customerRecord.saler) }">
					-
				</c:if>
				<c:if test="${!empty(customerRecord.saler) }">
					${customerRecord.saler.realName }
				</c:if>
			</td>
			<td>
				<c:if test="${customerRecord.resultStatus==2 }">
					<span style="color: green;">转为登记</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==1 }">
					<span style="color: pink;">等待...</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==3 }">
					<span style="color: green;">已回访</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==4 }">
					<span style="color: red;">无效</span>
				</c:if>
				<br>
				<fmt:formatDate value="${customerRecord.resultDate}"/>
			</td>
			<td>
				<c:if test="${customerRecord.comeinNum==0 }">
					未到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==1 }">
					初次到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==2 }">
					二次来店
				</c:if>
			</td>
			<td>
					<c:if test="${customerRecord.overtimeStatus==1 }">
						<span>未超时</span>
					</c:if>
					<c:if test="${customerRecord.overtimeStatus==2 }">
						<span style="color: red">已超时</span>
					</c:if>
			</td>
			<td style="text-align: center;">
				${customerRecord.creator }
			</td> 
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/customerRecord/downCustomerExcel?'+params;
 }
</script>
</body>
</html>
