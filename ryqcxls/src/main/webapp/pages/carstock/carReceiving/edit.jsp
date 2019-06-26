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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">
	#storeAreaId{
		width: 80px;
	}
	#storeRoomId{
		width: 80px;
	}
	#storageId{
		width: 80px;
	}
</style>
<title>车辆入库收车</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="factoryOrderId" id="factoryOrderId" value="${factoryOrder.dbid}">
		<input type="hidden" name="carReceiving.dbid" id="dbid" value="${carReceiving.dbid}">
		<input type="hidden" name="storeCompanyId" id="storeCompanyId" value="${factoryOrder.storeCompany.dbid}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
				<tr  height="42" >
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
						${factoryOrder.brand.name }
						${factoryOrder.carSeriy.name }
						${factoryOrder.carModel.name }
						${factoryOrder.carColor.name }
					</td>
					<td class="formTableTdLeft">物料号:&nbsp;</td>
					<td id="carColorLable">
						${factoryOrder.materialNumber }
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">进货商:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.sourceCompany.name }
					</td>
					<td class="formTableTdLeft">管理公司:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.storeCompany.name }
					</td>
				</tr> 
				<tr height="42">
					<td class="formTableTdLeft">指导价:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.factoryPrice }
					</td>
					<td class="formTableTdLeft">执行价:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.marketPrice}
					</td>
					
				</tr> 
				<tr height="42">
					<td class="formTableTdLeft">订单性质:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.orderAttr }
					</td>
					<td class="formTableTdLeft">订单种类:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.orderType}
					</td>
					
				</tr> 
				<tr height="42">
				<td class="formTableTdLeft">入库日期:&nbsp;</td>
					<c:if test="${empty(carReceiving) }">
						<td >
							<input type="text" id="stockInDate" class="text midea" name="carReceiving.stockInDate" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>' title="入库日期" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});"	checkType="string,1,50" tip="入库日期不能为空"><span style="color: red;">*</span>
						</td>
					</c:if>
					<c:if test="${!empty(carReceiving) }">
						<td >
							<input readonly="readonly" type="text" id="stockInDate" class="text midea" name="carReceiving.stockInDate" value='<fmt:formatDate value="${carReceiving.stockInDate }" pattern="yyyy-MM-dd"/>' title="入库日期" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});"	checkType="string,1,50" tip="入库日期不能为空"><span style="color: red;">*</span>
						</td>
					</c:if>
				<c:if test="${empty(carReceiving) }">
					<td class="formTableTdLeft">区域:&nbsp;</td>
					<td colspan="3" id="storeRoomLabel">
						<select id="storeAreaId" name="storeAreaId" class="midea text" onchange="ajaxStoreRoom(this.value)" checkType="string,1" tip="请选择车型...">
							<option value="">请选择...</option>
							<c:forEach var="storeArea" items="${storeAreas }">
								<option value="${storeArea.dbid }" ${carReceiving.storeArea.dbid==storeArea.dbid?'selected="selected"':'' } >${storeArea.name }</option>
							</c:forEach>
						</select>
					</td>
				</c:if>
				<c:if test="${!empty(carReceiving) }">
					<td class="formTableTdLeft">区域:&nbsp;</td>
					<td colspan="3" id="storeRoomLabel">
						<select id="storeAreaId" name="storeAreaId" class="midea text" onchange="ajaxStoreRoom(this.value)" checkType="string,1" tip="请选择车型...">
							<option value="">请选择...</option>
							<c:forEach var="storeArea" items="${storeAreas }">
								<option value="${storeArea.dbid }" ${carReceiving.storeArea.dbid==storeArea.dbid?'selected="selected"':'' } >${storeArea.name }</option>
							</c:forEach>
						</select>
						<c:if test="${fn:length(storeRooms)>0 }">
							<select id="storeRoomId" name="storeRoomId" class="midea text" onchange="" checkType="string,1" tip="请选择车型...">
								<option value="">请选择...</option>
								<c:forEach var="storeRoom" items="${storeRooms }">
									<option value="${storeRoom.dbid }" ${carReceiving.storeRoom.dbid==storeRoom.dbid?'selected="selected"':'' } >${storeRoom.name }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${fn:length(storages)>0 }">
							<select id="storageId" name="storageId" class="midea text" onchange="" checkType="string,1" tip="请选择车型...">
								<option value="">请选择...</option>
								<c:forEach var="storage" items="${storages }">
									<option value="${storage.dbid }" ${carReceiving.storage.dbid==storage.dbid?'selected="selected"':'' } >${storage.name }</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
				</c:if>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/carReceiving/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close(-1)"	class="but butCancle">关闭</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function showDialog(){
		window.top.art.dialog({
			content : '请确认收车信息是否正确，提交后将不可更改！',
			icon : 'question',
			width:"250px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.utile.submitAjaxForm(frmId,url);
			},
			cancel : true
		});
	}	
	function ajaxStoreRoom(val){
		if(null==val||val==''){
			$("#storeRoomId").remove();
			$("#storageId").remove();
			return false;
		}
		$("#storeRoomId").remove();
		$("#storageId").remove();
		$.post("${ctx}/storeRoom/ajaxStoreRoom?storeAreaId="+val+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#storeRoomLabel").append(data);
			}
		});
	}
	function ajaxStorage(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		if(value==''||value<=0){
			$("#storageId").remove();
			return;
		}
		$("#storageId").remove();
		$.post("${ctx}/storage/ajaxStorage?storeRoomId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#storeRoomLabel").append(data);
			}
		});
	}
</script>
</html>