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
<title>库龄等级</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/storeAgeLevel/queryList'">库龄等级</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(storeAgeLevel) }">添加库龄等级</c:if>
	<c:if test="${!empty(storeAgeLevel) }">编辑库龄等级</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="storeAgeLevel.dbid" id="dbid" value="${storeAgeLevel.dbid }">
		<input type="hidden" name="storeAgeLevel.createDate" id="createDate" value="${storeAgeLevel.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="storeAgeLevel.name" id="name"
					value="${storeAgeLevel.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">库龄周期:&nbsp;</td>
				<td ><input type="text" name="storeAgeLevel.cycleDate" id="cycleDate"
					value="${storeAgeLevel.cycleDate }" class="largex text" title="库龄周期"	checkType="string,1,50" tip="库龄周期不能为空">
					<span style="color: red;">*提示：请安如下格式进行填写{0_1}、{1_2}...{6_36}</span>
					
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">奖励金额:&nbsp;</td>
				<td ><input type="text" name="storeAgeLevel.rewardMoney" id="rewardMoney"
					value="${storeAgeLevel.rewardMoney }" class="largex text" title="奖励金额"	checkType="string,1,50" tip="奖励金额不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="storeAgeLevel.note" id="note">${storeAgeLevel.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="if(vlidate()){$.utile.submitForm('frmId','${ctx}/storeAgeLevel/save')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
	<script type="text/javascript">
		function vlidate(){
			var cycleDate=$("#cycleDate").val();
			if(null==cycleDate||cycleDate==''){
				alert("请输入库存周期");
				$("#cycleDate").focus();
				return false;
			}else{
				if(cycleDate.indexOf("-")>0){
					alert("请输入下划线");
					$("#cycleDate").focus();
					return false;
				}
				if(cycleDate.indexOf("_")>0){
					var min=parseInt(cycleDate.substring(0,cycleDate.indexOf("_")));
					var max=parseInt(cycleDate.substring(cycleDate.indexOf("_")+1,cycleDate.length));
					if(isNaN(min)||isNaN(max)){
						alert("库存周期开始时间和结束时间有误");
						return false;
					}
					if(min<0){
						alert("输入库存周期开始时间错误！");
						$("#cycleDate").focus();
						return false;
					}
					if(max<=min){
						alert("输入库存周期开始时间大于结束时间！");
						$("#cycleDate").focus();
						return false;
					}
					return true;
				}else{
					alert("输入库存周期格式错误！");
					return false;
				}
				
			}
			
		}
	</script>
</body>
</html>