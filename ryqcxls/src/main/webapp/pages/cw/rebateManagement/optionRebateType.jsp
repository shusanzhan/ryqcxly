<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>返利类型选择</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
     	
		<c:if test="${type eq 1}">
			<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/queryPresaleEntreyList'">工厂售前返利录入列表</a>-
		</c:if>
		<c:if test="${type eq 2}">
			<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/queryAfterEntryList'">工厂售后返利录入列表</a>-
		</c:if>
		<a href="javascript:void(-1);" onclick="">返利项目选择</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
	<input type="hidden" name="dbids" id="dbids" value="${dbids }">
	<input type="hidden" name="type" id="type" value="${type }">
		<s:token></s:token>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">返利项目类型</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr height="42">
				<td class="formTableTdLeft" style="font-size: 18px;" width="20%">返利项目类型：&nbsp;</td>
				<td style="font-size: 18px;line-height: 40px;" colspan="3" width="80%">
					<c:forEach var="rebateType" items="${rebateTypes }">
						<label><input type="checkbox" name="rebateType" id="rebateType${rebteType.dbid }" onclick="chooseRebate('#rebateType1${rebateType.dbid}')" value="${rebateType.dbid }" tip="返利项目类型至少选中一项"/>${rebateType.name }</label>
					</c:forEach>
				</td>
				<span style="color:red">*</span>
			</tr>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">返利项目</div>
		<span style="color:red">请选择返利项目类型！</span>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<c:forEach var="rebateType" items="${rebateTypes }">		
				<tr height="42" id="rebateType1${rebateType.dbid }" style="display:none ">
					<td class="formTableTdLeft" style="font-size: 18px;" width="20%">${rebateType.name }：&nbsp;</td>
					<td style="font-size: 18px;line-height: 40px;" colspan="3" width="80%">
						<c:forEach var="childrenRebateType" items="${rebateType.childrenRebateType}">
							<label><input type="checkbox" name="childRebateType" id="childRebateType${childrenRebateType.dbid }" value="${childrenRebateType.dbid }"/>${childrenRebateType.name }</label>
						</c:forEach>
					</td>
				</tr>
			</c:forEach>	
			</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="rebateEntry()"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function chooseRebate(s){
	if($(s).css("display")=="none"){
		$(s).css("display","");
	}else{
		$(s).css("display","none");
	}
}
function rebateEntry(){ 
	var dbids = $("#dbids").val();
	var type = $("#type").val();
	var checkeds = $("input[type='checkbox'][name='childRebateType']");
	var length = 0;
	var childRebateTypeDbids = "";
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			childRebateTypeDbids = childRebateTypeDbids + checkbox.value+",";
			length++;
		}
	}) 
	if(length<=0){
		alert("请选择返利项目");
		return ;
	}
	window.top.art.dialog({
		content : '请确认返利类型项目?',
		icon : 'question',
		width:"250px",
		height:"80px",
		lock : true,
		ok : function() {
			window.location.href="${ctx }/rebateManagement/rebateTypeEntry?dbids="+dbids+"&type="+type+"&childRebateTypeDbids="+childRebateTypeDbids;
		},
		cancel : true
	});
}
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	var childRebateType = document.getElementsByName("childRebateType");
	var flag = false;
	if (validata == true) {
		window.top.art.dialog({
			content : '请确认费用信息无误，点击【确定】保存数据！',
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
}
</script>
</html>