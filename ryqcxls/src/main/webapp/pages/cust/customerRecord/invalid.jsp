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
<title>线索无效</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="type" id="type" value="${param.type}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
			<c:if test="${param.type==1 }">
				<input type="hidden" name="dbid" id="dbid" value="${customerRecord.dbid}">
				<tr  height="42" >
					<td class="formTableTdLeft">登记时间:&nbsp;</td>
					<td >
						<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
					</td>
					<td class="formTableTdLeft">进店时间:&nbsp;</td>
					<td id="carModelLabel">
						${customerRecord.comeInTime}
					</td>
				</tr>
				<tr  height="42" >
					<td class="formTableTdLeft">类型:&nbsp;</td>
					<td >
						${customerRecord.customerType.name }
					</td>
					<td class="formTableTdLeft">随行人数:&nbsp;</td>
					<td id="carModelLabel">
						${customerRecord.customerNum}人
					</td>
				</tr>
			</c:if>
			<c:if test="${param.type==2 }">
				<input type="hidden" name="dbids" id="dbids" value="${param.dbids}">
				<tr  height="42" >
					<td class="formTableTdLeft">无效客户:&nbsp;</td>
					<td colspan="3">
						${names }
					</td>
				</tr>
			</c:if>
				<tr  height="42" >
					<td class="formTableTdLeft">无效原因:&nbsp;</td>
					<td colspan="3">
						<select id="customerRecordClubInvalidReasonId" name="customerRecordClubInvalidReasonId" class="largeX text" checkType="integer,1" tip="请选择无效原因">
							<option value="">请选择...</option>
							<c:forEach items="${customerRecordClubInvalidReasons }" var="customerRecordClubInvalidReason">
									<option value="${customerRecordClubInvalidReason.dbid }"  >${customerRecordClubInvalidReason.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="3">
						<textarea  name="note" id="note" class="textarea largeXXX text" style="height: 80px;width: 500px;" title="" checkType="string,2" tip="请填写一点备注吧">${repaymentInfo.note }</textarea>	
						<span style="color: red">*</span>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerRecord/saveInvalid')"	class="but butSave">保存</a>
		<a  href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取消</a>  
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