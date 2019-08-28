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
<script type="text/javascript">
	$(document).ready(function (){
		var result=null;
		$.post("${ctx}/userBussi/userRoleJson?dbid=${user2.dbid}&timeStamp="+new Date(), { } ,function callback(json){
			if(null!=json&&json.length>0){
				var length=json.length;
				for(var i=0;i<length;i++){
					var obj=json[i];
					var append="<tr height='32' align='left'>";
					if(obj.checked==true){
						append=append+"<td style='text-align: left;padding-left:12px;'><input type='checkbox' name='id' id='id1' value='"+obj.dbid+"' checked='checked'/></td>"
					}else{
						append=append+"<td style='text-align: left;padding-left:12px;'><input type='checkbox' name='id' id='id1' value='"+obj.dbid+"'/></td>"
					}
					append=append+"<td style='text-align: left;'>"+obj.name+"</td></tr>"
					result=result+append;	
				}
				$("#TableBody").append(result);
			}
		});
	});
</script>
<title>角色赋权限</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/userBussi/queryBussiList'">账号管理</a>-
	<a href="javascript:void(-1);" onclick="">分配权限</a>
</div>
<div class="line"></div>
<div id="result">
	<form name="frmId" id="frmId" method="post" target="_self">
	<s:token></s:token>
	<input type="hidden" name="dbid" value="${user2.dbid }" id="dbid">
	<input type="hidden" name="type" value="2" id="type">
	<div class="frmTitle" onclick="showOrHiden('contactTable')">角色权限</div>
	<table width="100%" class="mainTable" border="0" id="TableList" style="margin: 0 auto;">
		<thead class="TableHeader" id="TableHeader">
			<tr>
				<td class="sn" style="text-align: left;padding-left:12px;"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" />全选</td>
				<td class="span5">角色名称</td>
			</tr>
		</thead>
		<tbody id="TableBody">
		</tbody>
	</table>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">查询数据权限</div>
	<table width="100%" class="mainTable" border="0" id="TableList" style="margin: 0 auto;">
		<thead class="TableHeader" id="TableHeader">
			<tr>
				<td class="sn" style="text-align: left;padding-left:12px;"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'companyId')" />全选</td>
				<td class="span5">公司名称</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="enterprise" items="${enterprises }">
				<tr height='32' align='left'>
					<c:set value="false" var="status"></c:set>
					<c:forEach var="dbid" items="${compnayArrarys }">
						<c:if test="${enterprise.dbid==dbid }">
							<c:set var="status" value="true"></c:set>
						</c:if>
					</c:forEach>
					<c:if test="${status==true }">
						<td style='text-align: left;padding-left:12px;'><input type='checkbox' name='companyId' id='id1' value='${enterprise.dbid}' checked='checked'/></td>
					</c:if>
					<c:if test="${status==false }">
						<td style='text-align: left;padding-left:12px;'><input type='checkbox' name='companyId' id='id1' value='${enterprise.dbid}'/></td>
					</c:if>
					<td style='text-align: left;'>${enterprise.name}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">其他权限</div>
	<table width="100%" class="mainTable" border="0" id="TableList" style="margin: 0 auto;">
		<tbody>
			<tr height='32'>
				<td style="text-align: left;">
					<label>是否拥有合同流失权限:<input type="checkbox" id="approvalCpidStatus"  name="approvalCpidStatus" ${user2.approvalCpidStatus==2?'checked="checked"':'' }  value="2"></label>
				</td>
			</tr>
			<tr height='32'>
				<td style="text-align: left;">
					<label>查询其他公司数据权限:<input type="checkbox" id="queryOtherDataStatus"  name="queryOtherDataStatus" ${user2.queryOtherDataStatus==2?'checked="checked"':'' }  value="2"></label>
				</td>
			</tr>
			<tr height='32'>
				<td style="text-align: left;">
					<label>自我审批权限:<input type="checkbox" id="selfApproval"  name="selfApproval" ${user2.selfApproval==2?'checked="checked"':'' }  value="2"></label>
				</td>
			</tr>
			<c:if test="${systemInfo.grofitAprovalStatus==2 }">
				<tr height='32'>
					<td style="text-align: left;">
						<label>申请权限金额：<input  type="text" id="approvalMoney" name="approvalMoney" value="${user2.approvalMoney }" class="text large"></label><span style="color: red;">-1</span>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>	
	</form>
</div>
<div class="formButton">
    <a class="but butSave" href="javascript:void();" onclick="$.utile.submitForm('frmId','${ctx}/userBussi/saveUserRole')">保存并继续</a>
 	<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
</div>
</body>
</html>