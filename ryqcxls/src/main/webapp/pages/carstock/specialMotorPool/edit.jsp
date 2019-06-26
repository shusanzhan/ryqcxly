<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>特殊预约管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/specialMotorPool/queryList'">特殊预约管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(specialMotorPool) }">交车预约</c:if>
	<c:if test="${!empty(specialMotorPool) }">交车预约</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="specialMotorPool.dbid" id="dbid" value="${specialMotorPool.dbid }">
		<input type="hidden" name="specialMotorPool.createDate" id="createDate" value="${specialMotorPool.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			
			<tr height="42">
				<td class="formTableTdLeft">提车人:&nbsp;</td>
				<td colspan="3">
					<input type="text" name="specialMotorPool.reserveDep" id="reserveDep" value="${specialMotorPool.reserveDep }" class="mideaX text" checkType="string,1" tip="请填写提车单位"/>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">提车时间:&nbsp;</td>
				<td colspan="3">
					<input type="hidden" id="nowDay" value="${now }">
					<input type="text" name="specialMotorPool.reserveDate" id="reserveDate" value="${specialMotorPool.reserveDate }"  class="mideaX text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" checkType="string,10" tip="请选择预约交车日期"/>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车源情况:&nbsp;</td>
				<td colspan="3">
					<select id="hasCarOrder" name="specialMotorPool.hasCarOrder" class="mediaX text" checkType="string,1" tip="请选择车源情况" onchange="onchage(this.value)">
						<option value="" >请选择车源情况</option>
						<option value="1" ${specialMotorPool.hasCarOrder==1?'selected="selected"':'' } >现车订单</option>
						<option value="2" ${specialMotorPool.hasCarOrder==2?'selected="selected"':'' } >在途订单</option>
						<option value="3" ${specialMotorPool.hasCarOrder==3?'selected="selected"':'' } >无车订单</option>
					</select>
				</td>
			</tr>
			<c:if test="${empty(specialMotorPool.hasCarOrder)}" var="status">
				<tr height="42" id="vinCodeTr" style="display: none;">
					<td class="formTableTdLeft">车架号:&nbsp;</td>
					<td colspan="3">
						<input type="hidden" class="mediaX text" name="vinCodeId" id="vinCodeId" readonly="readonly"  />
						<input type="text" class="mediaX text" name="vinCode" id="vinCode" value="${specialMotorPool.vinCode }" readonly="readonly" checkType="string,1,200000" tip="接受会员不能为空！"/>
						<a href="javascript:void(-1)" class="aedit" onclick="choice()">选择车辆</a>
					</td>
				</tr>
				<tr  height="42" id="carSeriyTr" style="display: none;">
					<td class="formTableTdLeft">购买车型:&nbsp;</td>
					<td id="carModelLabel">
						<select id="brandId" name="brandId" class="small text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${specialMotorPool.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
						<select id="carSeriyId" name="carSeriyId" class="small text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${specialMotorPool.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
						<select id="carModelId" name="carModelId" class="small text" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${specialMotorPool.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
							</c:forEach>
						</select>
						
					</td>
				</tr>
				<tr id="carColorTr" style="display: none;">
					<td class="formTableTdLeft">购车颜色:&nbsp;</td>
						<td id="carColorLable">
							<select id="carColor" name="carColor" class="midea text"  checkType="string,1,10" tip="请选择购车颜色">
								<option value="">请选择...</option>
								<c:forEach var="carColor" items="${carColors }">
									<option value="${carColor.dbid }" ${specialMotorPool.carColor.dbid==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
								</c:forEach>
							</select>
							<span style="color: red">*</span>
						</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<c:if test="${specialMotorPool.hasCarOrder==3 }" var="sta">
					<c:set value="${specialMotorPool.brand.name}${specialMotorPool.carSeriy.name}${ specialMotorPool.carModel.name }${specialMotorPool.carColor.name }" var="carModel"></c:set>
					<c:if test="${empty(carModel) }">
						<tr  height="42" id="carSeriyTr" >
							<td class="formTableTdLeft">购买车型:&nbsp;</td>
							<td id="carModelLabel">
								<select id="brandId" name="brandId" class="small text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
									<option value="">请选择...</option>
									<c:forEach var="brand" items="${brands }">
										<option value="${brand.dbid }" ${specialMotorPool.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
									</c:forEach>
								</select>
								<select id="carSeriyId" name="carSeriyId" class="small text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
									<option value="">请选择...</option>
									<c:forEach var="carSeriy" items="${carSeriys }">
										<option value="${carSeriy.dbid }" ${specialMotorPool.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
									</c:forEach>
								</select>
								<select id="carModelId" name="carModelId" class="small text" checkType="integer,1" tip="请选择意向车型！">
									<option value="">请选择...</option>
									<c:forEach var="carModel" items="${carModels }">
										<option value="${carModel.dbid }" ${specialMotorPool.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
									</c:forEach>
								</select>
								
							</td>
						</tr>
						<tr id="carColorTr" >
							<td class="formTableTdLeft">购车颜色:&nbsp;</td>
								<td id="carColorLable">
									<select id="carColor" name="carColor" class="midea text"  checkType="string,1,10" tip="请选择购车颜色">
										<option value="">请选择...</option>
										<c:forEach var="carColor" items="${carColors }">
											<option value="${carColor.dbid }" ${specialMotorPool.carColor.dbid==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
										</c:forEach>
									</select>
									<span style="color: red">*</span>
								</td>
						</tr>
					</c:if>
					<c:if test="${!empty(carModel) }">
						<tr height="42">
							<td class="formTableTdLeft">车辆信息:&nbsp;</td>
							<td colspan="3">
									${carModel} ${customer.carModelStr}
							</td>
						</tr>
					</c:if>
					<tr height="42" id="vinCodeTr" style="display: none;">
						<td class="formTableTdLeft">车架号:&nbsp;</td>
						<td colspan="3">
							<input type="hidden" class="mediaX text" name="vinCodeId" id="vinCodeId" readonly="readonly"  />
							<input type="text" class="mediaX text" name="vinCode" id="vinCode" value="${specialMotorPool.vinCode }" readonly="readonly" checkType="string,1,200000" tip="接受会员不能为空！"/>
							<a href="javascript:void(-1)" class="aedit" onclick="choice()">选择车辆</a>
						</td>
					</tr>
				</c:if>
				<c:if test="${sta==false }">
					<tr height="42" id="vinCodeTr" >
						<td class="formTableTdLeft">车架号:&nbsp;</td>
						<td colspan="3">
							<input type="hidden" class="mediaX text" name="vinCodeId" id="vinCodeId" readonly="readonly"  />
							<input type="text" class="mediaX text" name="vinCode" id="vinCode" value="${specialMotorPool.vinCode }" readonly="readonly" checkType="string,1,200000" tip="vin码不能为空！"/>
							<a href="javascript:void(-1)" class="aedit" onclick="choice()">选择车辆</a>
						</td>
					</tr>
				</c:if>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">物流备注:&nbsp;</td>
				<td colspan="3"><textarea   name="specialMotorPool.note" id="note"	 class="textarea largeXXX text" title="备注">${specialMotorPool.note }</textarea></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/specialMotorPool/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function onchage(value){
	if(value!=3){
		$("#vinCodeTr").show();
		$("#carSeriyTr").hide();
		$("#carColorTr").hide();
	}else{
		$("#vinCodeTr").hide();
		$("#carSeriyTr").show();
		$("#carColorTr").show();
	}
	
	
}
function choice(){
	var hasCarOrder=$('#hasCarOrder').val();
	var url="${ctx}/factoryOrder/choiceVinCode?hasCarOrder="+hasCarOrder;
	commonSelect('请选择车辆信息',url,'vinCodeId','vinCode','vinCode',1224,450)
}
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelId").remove();
	$("#carSeriyId").remove();
	$.post("${ctx}/carSeriy/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}

function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	$("#carColorLable").children().remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
	$.post("${ctx}/carColor/ajaxCarColor?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carColorLable").append(data);
		}
	});
}
</script>
</body>
</html>