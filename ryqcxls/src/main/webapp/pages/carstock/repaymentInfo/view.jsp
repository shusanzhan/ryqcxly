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
<title>车辆入库收车</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="factoryOrderId" id="factoryOrderId" value="${factoryOrder.dbid}">
		<input type="hidden" name="repaymentInfo.dbid" id="dbid" value="${repaymentInfo.dbid}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
				<tr  height="42" >
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
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
					<td class="formTableTdLeft">工厂日期:&nbsp;</td>
					<td colspan="1">
						<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/>
					</td>
					<td class="formTableTdLeft">出库状态:&nbsp;</td>
					<td >
						<c:if test="${factoryOrder.repaymentStatus==2 }">
							<span style="color: red;">未还款</span>
						</c:if>
						<c:if test="${factoryOrder.repaymentStatus==3 }">
							<span style="color: green;">已还款</span>
						</c:if>
					</td>
				</tr> 
				<tr height="42">
					<td class="formTableTdLeft">工厂价:&nbsp;</td>
					<td colspan="1">
						<span style="color: red;font-size: 14px;">${factoryOrder.factoryPrice}</span>
					</td>
					<td class="formTableTdLeft">执行价:&nbsp;</td>
					<td >
						${factoryOrder.marketPrice}
					</td>
				</tr> 
				<tr>
					<td class="formTableTdLeft">还款日期:&nbsp;</td>
					<td colspan="3">
							${factoryOrder.repaymentInfo.repayDate}
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="3">
						${factoryOrder.repaymentInfo.note }
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a  href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取消</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
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