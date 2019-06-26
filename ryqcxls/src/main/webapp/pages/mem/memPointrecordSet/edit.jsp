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
<title>经纪人设置</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" >经纪人设置</a>-
</div>
<div class="line"></div>
<div class="frmContent">
	<div class="alert alert-error">
		<strong>提示:</strong>
	</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="memPointrecordSet.dbid" id="dbid" value="${memPointrecordSet.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">注册赠送积分状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="rigPointStatus" id="rigPointStatus"   ${memPointrecordSet.rigPointStatus==1?'checked="checked"':'' } onclick="parentReward(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="rigPointStatus" id="rigPointStatus"   ${memPointrecordSet.rigPointStatus==2?'checked="checked"':'' } onclick="parentReward(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">注册赠送积分数:&nbsp;</td>
				<td >
					<c:if test="${memPointrecordSet.rigPointStatus==1 }">
						<input type="text" class="text large" id="rigPointNum" value="${memPointrecordSet.rigPointNum }" name="memPointrecordSet.rigPointNum">
					</c:if>
					<c:if test="${memPointrecordSet.rigPointStatus==2 }">
						<input type="text" class="text large" readonly="readonly" id="rigPointNum" value="${memPointrecordSet.rigPointNum  }" name="memPointrecordSet.rigPointNum">
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">注册赠送上级积分状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="rigParentStatus" id="rigParentStatus"   ${memPointrecordSet.rigParentStatus==1?'checked="checked"':'' } onclick="regReward(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="rigParentStatus" id="rigParentStatus"   ${memPointrecordSet.rigParentStatus==2?'checked="checked"':'' } onclick="regReward(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">注册赠送上级积分数:&nbsp;</td>
				<td >
					<c:if test="${memPointrecordSet.rigParentStatus==1 }">
						<input type="text" class="text large" id="rigParentNum" value="${memPointrecordSet.rigParentNum }" name="memPointrecordSet.rigParentNum">
					</c:if>
					<c:if test="${memPointrecordSet.rigParentStatus==2 }">
						<input type="text" class="text large" readonly="readonly"  id="rigParentNum" value="${memPointrecordSet.rigParentNum }" name="memPointrecordSet.rigParentNum">
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">推荐客户成交赠送积分状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="agentSuccessStatus" id="agentSuccessStatus"   ${memPointrecordSet.agentSuccessStatus==1?'checked="checked"':'' } onclick="agentReward(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="agentSuccessStatus" id="agentSuccessStatus"   ${memPointrecordSet.agentSuccessStatus==2?'checked="checked"':'' } onclick="agentReward(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">推荐客户成交赠送积分数:&nbsp;</td>
				<td >
					<c:if test="${memPointrecordSet.agentSuccessStatus==1 }">
						<input type="text" class="text large" id="agentSuccessNum" value="${memPointrecordSet.agentSuccessNum }" name="memPointrecordSet.agentSuccessNum" checkType="integer,0" tip="经纪人推荐客户奖励金额必须大于等于0">
					</c:if>
					<c:if test="${memPointrecordSet.agentSuccessStatus==2 }">
						<input type="text" class="text large" readonly="readonly" id="agentSuccessNum" value="${memPointrecordSet.agentSuccessNum }" name="memPointrecordSet.agentSuccessNum" checkType="integer,0" tip="经纪人推荐客户奖励金额必须大于等于0">
					</c:if>
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">推荐客户成交上级赠送积分状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="agentParentSuccessStatus" id="agentParentSuccessStatus"   ${memPointrecordSet.agentParentSuccessStatus==1?'checked="checked"':'' } onclick="agentRewardParent(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="agentParentSuccessStatus" id="agentParentSuccessStatus"   ${memPointrecordSet.agentParentSuccessStatus==2?'checked="checked"':'' } onclick="agentRewardParent(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">经纪人推荐客户上级奖励金额:&nbsp;</td>
				<td >
					<c:if test="${memPointrecordSet.agentParentSuccessStatus==1 }">
						<input type="text" class="text large" id="agentParentSuccessNum" value="${memPointrecordSet.agentParentSuccessNum }" name="memPointrecordSet.agentParentSuccessNum" checkType="integer,0" tip="经纪人推荐客户上级奖励金额必须大于等于0">
					</c:if>
					<c:if test="${memPointrecordSet.agentParentSuccessStatus==2 }">
						<input type="text" class="text large" readonly="readonly" id="agentParentSuccessNum" value="${memPointrecordSet.agentParentSuccessNum }" name="memPointrecordSet.agentParentSuccessNum" checkType="integer,0" tip="经纪人推荐客户上级奖励金额必须大于等于0">
					</c:if>
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">车主认证赠送积分状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="customerSuccessStatus" id="customerSuccessStatus"   ${memPointrecordSet.customerSuccessStatus==1?'checked="checked"':'' } onclick="customerSuccessStatus(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="customerSuccessStatus" id="customerSuccessStatus"   ${memPointrecordSet.customerSuccessStatus==2?'checked="checked"':'' } onclick="customerSuccessStatus(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">车主认证赠送积分数:&nbsp;</td>
				<td >
					<c:if test="${memPointrecordSet.customerSuccessStatus==1 }">
						<input type="text" class="text large" id="customerSuccessNum" value="${memPointrecordSet.customerSuccessNum }" name="memPointrecordSet.customerSuccessNum" checkType="integer,0" tip="经纪人推荐客户上级奖励金额必须大于等于0">
					</c:if>
					<c:if test="${memPointrecordSet.customerSuccessStatus==2 }">
						<input type="text" class="text large" readonly="readonly" id="customerSuccessNum" value="${memPointrecordSet.customerSuccessNum }" name="memPointrecordSet.customerSuccessNum" checkType="integer,0" tip="经纪人推荐客户上级奖励金额必须大于等于0">
					</c:if>
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/memPointrecordSet/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		</div>
	</form>
	</div>
</body>
<script type="text/javascript">
	function agentReward(value){
		if(value==1){
			$("#agentSuccessNum").removeAttr("readonly");
		}
		if(value==2){
			$("#agentSuccessNum").attr("readonly","readonly");
			$("#agentSuccessNum").val("0");
		}
	}
	function agentRewardParent(value){
		if(value==1){
			$("#agentParentSuccessNum").removeAttr("readonly");
		}
		if(value==2){
			$("#agentParentSuccessNum").attr("readonly","readonly");
			$("#agentParentSuccessNum").val("0");
		}
	}
	function customerSuccessNum(value){
		if(value==1){
			$("#customerSuccessNum").removeAttr("readonly");
		}
		if(value==2){
			$("#customerSuccessNum").attr("readonly","readonly");
			$("#customerSuccessNum").val("0");
		}
	}
	function parentReward(value){
		if(value==1){
			$("#rigPointNum").removeAttr("readonly");
		}
		if(value==2){
			$("#rigPointNum").attr("readonly","readonly");
			$("#rigPointNum").val("0");
		}
	}
	function regReward(value){
		if(value==1){
			$("#rigParentNum").removeAttr("readonly");
		}
		if(value==2){
			$("#rigParentNum").attr("readonly","readonly");
			$("#rigParentNum").val("0");
		}
	}
</script>
</html>