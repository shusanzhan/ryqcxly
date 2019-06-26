<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>工厂返利批量收银</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">工厂返利收银</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
		<div class="operate">
		 <a  href="javascript:void(-1)" class="but button"  onclick="batchCash()">批量收银</a> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/rebateManagement/queryFactoryRebateList" method="post" >
		<input type="hidden" id="query" name="query" value="1">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				 <td><label>返利项目：</label></td>
  				<td>
  					<select class="text middle" id="rebateTypeDbid" name="rebateTypeDbid" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<c:forEach var="childrenRebateType" items="${childrenRebateTypes }">
  							<option value="${childrenRebateType.dbid}"  ${param.rebateTypeDbid==childrenRebateType.dbid?'selected="selected"':''}>${childrenRebateType.name}</option>
  						</c:forEach>
  					</select>
  				</td> 
  				<td><label>期限：</label></td>
  				<td><input type="text" id="rebateTerm" name="rebateTerm" class="text small" value="${param.rebateTerm }"></td>
  			</tr>
  			<tr>
  				 <td><label>期限状态：</label></td>
  				 <td>
  				 	<select class="text middle" id="termStatus" name="termStatus" onchange="$('#searchPageForm')[0].submit()">
  				 		<option value="0" ${param.termStatus==0?'selected="selected"':''}>请选择...</option>
  				 		<option value="1" ${param.termStatus==1?'selected="selected"':''}>未超时</option>
  				 		<option value="2" ${param.termStatus==2?'selected="selected"':''}>已超时</option>
  				 	</select>
  				 </td>
  				<td><label>创建日期：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td style="text-align: center;">
  					~
				</td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty rebates}" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${!empty rebates }">
	<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 20px;">
				<div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id'),sum()"></span>
				</div>
			</td>
			<td style="width: 150px;">车辆信息</td> 
			<td style="width: 80px;">vin码</td>
			<td style="width: 100px;">返利名称</td>
			<td style="width: 100px;">工厂价</td>
			<td style="width: 80px;">返利比例</td>
			<td style="width: 80px;">返利金额</td>
			<td style="width: 70px;">返利付款期限</td>
			<td style="width: 50px;">返利状态</td>
			<td style="width:70px;">返利录入人</td>
			<td style="width:70px;">返利录入时间</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${rebates }" var="rebate">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" value="${rebate.dbid }" onchange="sum()" />
			</td>
			<td style="text-align:left; ">
				<span style="text-align: left;">
				${rebate.factoryOrder.carSeriy.name }
				${rebate.factoryOrder.carModel.name }
				${rebate.factoryOrder.carColor.name }
				</span>
			</td>
			<td>
				${rebate.factoryOrder.vinCode}
			</td>
			<td>
				${rebate.name }
			</td>
			<td>
				${rebate.factoryOrder.factoryPrice }
			</td>
			<td>
				<c:if test="${empty rebate.rebateRatio }">
					无
				</c:if>
				<c:if test="${!empty rebate.rebateRatio }">
					${rebate.rebateRatio}%
				</c:if>
			</td>
			<td>
				${rebate.rebateMoney}
			</td>
			<td >
				${rebate.rebateTerm }
			</td>
			<td>
				<span style="color:red">未收银</span>
			</td>
			<td>
				${rebate.entryPerson}
			</td>
			<td>
				<fmt:formatDate value="${rebate.createTime}" pattern="yyyy-MM-dd"/> 
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<p id="total" style="display:none;font-size:20px;color:red;cursor:hand">总额:<span id="totals"></span></p>
</body>
<script type="text/javascript">
function batchCash(){
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择批量收银数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
		// 为true等价于function(){}
		});
		return false;
	}
	var dbids=getCheckBox();
	window.top.art.dialog({
		content : '确定对【'+length+'】客户,总金额<span style="color:red;">【￥'+sum()+'】</span>进行批量收银吗?',
		icon : 'question',
		width:"250px",
		height:"80px",
		lock : true,
		ok : function() {
			window.location.href="${ctx }/rebateManagement/batchFactoryRebateCash?dbids="+dbids;
		},
		cancel : true
	});
}
function sum(){
	var len = $("input[name='id']:checked");
	var sum = 0;
	for(var i=0;i<len.size();i++){
		var check = len.eq(i);
		var tds = check.parent().siblings();
		if(tds.eq(5).text()!=null && tds.eq(5).text()!=''){
			sum = sum + parseFloat(tds.eq(5).text());
		}
	}
	$("#total").css("display","");
	$("#totals").text(sum);
	return sum;
}
</script>
</html>
