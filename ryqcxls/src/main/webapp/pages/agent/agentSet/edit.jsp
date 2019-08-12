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
<title>经纪人奖励设置</title>
<style type="text/css">
	.leval{
		float: left;
		margin-right: 12px;
		width: 80px;
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" >经纪人奖励设置</a>-
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="type" id="type" value="${param.type }">
		<input type="hidden" name="agentSet.dbid" id="dbid" value="${agentSet.dbid==1?'':agentSet.dbid}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">经纪人权限状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="authAgentStatus" id="authAgentStatus"   ${agentSet.authAgentStatus==1?'checked="checked"':'' }>开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="authAgentStatus" id="authAgentStatus"   ${agentSet.authAgentStatus==2?'checked="checked"':'' }>关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<span>说明：经纪人权限默认注册就开启【开启】，反之则关闭</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">推荐经纪人注册上级奖励状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="regParentRewardStatus" id="parentRewardStatus"   ${agentSet.regParentRewardStatus==1?'checked="checked"':'' } onclick="parentReward(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="regParentRewardStatus" id="parentRewardStatus"   ${agentSet.regParentRewardStatus==2?'checked="checked"':'' } onclick="parentReward(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">推荐经纪人注册上级奖励金额${agentSet.regParentRewardNum } :&nbsp;</td>
				<td >
					<c:if test="${agentSet.regParentRewardStatus==1 }">
						<input type="text" class="text large" id="regParentRewardNum" value="${agentSet.regParentRewardNum }" name="agentSet.regParentRewardNum">
					</c:if>
					<c:if test="${agentSet.regParentRewardStatus==2 }">
						<input type="text" class="text large" readonly="readonly" id="regParentRewardNum" value="${agentSet.regParentRewardNum  }" name="agentSet.regParentRewardNum">
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">经纪人注册奖励状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="regRewardStatus" id="regRewardStatus"   ${agentSet.regRewardStatus==1?'checked="checked"':'' } onclick="regReward(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="regRewardStatus" id="regRewardStatus"   ${agentSet.regRewardStatus==2?'checked="checked"':'' } onclick="regReward(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">经纪人注册奖励状金额:&nbsp;</td>
				<td >
					<c:if test="${agentSet.regRewardStatus==1 }">
						<input type="text" class="text large" id="regRewardNum" value="${agentSet.regRewardNum }" name="agentSet.regRewardNum">
					</c:if>
					<c:if test="${agentSet.regRewardStatus==2 }">
						<input type="text" class="text large" readonly="readonly"  id="regRewardNum" value="${agentSet.regRewardNum }" name="agentSet.regRewardNum">
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">经纪人推荐客户奖励状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="agentRewardStatus" id="agentRewardStatus"   ${agentSet.agentRewardStatus==1?'checked="checked"':'' } onclick="agentReward(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="agentRewardStatus" id="agentRewardStatus"   ${agentSet.agentRewardStatus==2?'checked="checked"':'' } onclick="agentReward(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42" id="agentRewardModelTr"  style="${agentSet.agentRewardStatus==1?'':'display: none;' }">
				<td class="formTableTdLeft" style="width: 160px;">经纪人推荐奖励开启模式:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="agentRewardModel" id="agentRewardModel"   ${agentSet.agentRewardModel==1?'checked="checked"':'' } onclick="agentRewardDD(this.value)">固定奖励&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="agentRewardModel" id="agentRewardModel"   ${agentSet.agentRewardModel==2?'checked="checked"':'' } onclick="agentRewardDD(this.value)">梯度奖励&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr id="agentRewardLevelTr" style="${(agentSet.agentRewardStatus==1&&agentSet.agentRewardModel==2)?'':'display: none;' }">
				<td>
					梯度设置
				</td>
				<td>
					<a href="javascript:void(-1)" class="adeit" style="color: #2b7dbc;" onclick="createRewardLevel()">
						<c:if test="${empty(agentSetLevels) }">
							添加
						</c:if>
						<c:if test="${!empty(agentSetLevels) }">
							编辑
						</c:if>
					</a><br>
					<div style="border:1px solid #e3e3ee;width: 320px;padding: 5px 12px;">
						<div style=";line-height: 30px;">
							<div class="leval">名称 </div>
							<div class="leval">成交区间</div>
							<div class="leval">奖励金额</div>
							<div style="clear: both;"></div>
						</div>
						<div id="contentLevel" >
							<c:forEach var="agentSetLevel" items="${agentSetLevels }" varStatus="i">
								<div style=";line-height: 30px;">
									<div class="leval">等级${i.index+1 }</div>
									<div class="leval">${agentSetLevel.beginNum }&lt;X&lt;=${agentSetLevel.endNum }</div>
									<div class="leval">${agentSetLevel.rewardMoney }</div>
									<div style="clear: both;"></div>
								</div>
							</c:forEach>
						</div>
					</div>
				</td>				
			</tr>
			<tr height="42" id="agentRewardNumTr" style="${(agentSet.agentRewardStatus==1&&agentSet.agentRewardModel==1)?'':'display: none;' }">
				<td class="formTableTdLeft" style="width: 160px;">经纪人推荐客户奖励金额:&nbsp;</td>
				<td >
					<c:if test="${agentSet.agentRewardStatus==1 }">
						<input type="text" class="text large" id="agentRewardNum" value="${agentSet.agentRewardNum }" name="agentSet.agentRewardNum" checkType="integer,0" tip="经纪人推荐客户奖励金额必须大于等于0">
					</c:if>
					<c:if test="${agentSet.agentRewardStatus==2 }">
						<input type="text" class="text large" readonly="readonly" id="agentRewardNum" value="${agentSet.agentRewardNum }" name="agentSet.agentRewardNum" checkType="integer,0" tip="经纪人推荐客户奖励金额必须大于等于0">
					</c:if>
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr height="42" >
				<td class="formTableTdLeft" style="width: 160px;">经纪人推荐客户上级奖励状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="agentRewardParentStatus" id="agentRewardParentStatus"   ${agentSet.agentRewardParentStatus==1?'checked="checked"':'' } onclick="agentRewardParent(this.value)">开启&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="agentRewardParentStatus" id="agentRewardParentStatus"   ${agentSet.agentRewardParentStatus==2?'checked="checked"':'' } onclick="agentRewardParent(this.value)">关闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 160px;">经纪人推荐客户上级奖励金额:&nbsp;</td>
				<td >
					<c:if test="${agentSet.agentRewardParentStatus==1 }">
						<input type="text" class="text large" id="agentRewardParentNum" value="${agentSet.agentRewardParentNum }" name="agentSet.agentRewardParentNum" checkType="integer,0" tip="经纪人推荐客户上级奖励金额必须大于等于0">
					</c:if>
					<c:if test="${agentSet.agentRewardParentStatus==2 }">
						<input type="text" class="text large" readonly="readonly" id="agentRewardParentNum" value="${agentSet.agentRewardParentNum }" name="agentSet.agentRewardParentNum" checkType="integer,0" tip="经纪人推荐客户上级奖励金额必须大于等于0">
					</c:if>
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/agentSet/save')"	class="but butSave">保&nbsp;&nbsp;存</a>
			 <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a> 
		</div>
	</form>
	</div>
</body>
<script type="text/javascript">
	function agentReward(value){
		if(value==1){
			$("#agentRewardModelTr").show();
			$("#agentRewardLevelTr").show();
			$("#agentRewardNumTr").show();
		}
		if(value==2){
			$("#agentRewardModelTr").hide();
			$("#agentRewardLevelTr").hide();
			$("#agentRewardNumTr").hide();
		}
	}
	function agentRewardDD(value){
		if(value==1){
			$("#agentRewardLevelTr").hide();
			$("#agentRewardNumTr").show();
		}
		if(value==2){
			$("#agentRewardLevelTr").show();
			$("#agentRewardNumTr").hide();
		}
		
	}
	function agentRewardParent(value){
		if(value==1){
			$("#agentRewardParentNum").removeAttr("readonly");
		}
		if(value==2){
			$("#agentRewardParentNum").attr("readonly","readonly");
			$("#agentRewardParentNum").val("0");
		}
	}
	function parentReward(value){
		if(value==1){
			$("#parentRewardNum").removeAttr("readonly");
		}
		if(value==2){
			$("#parentRewardNum").attr("readonly","readonly");
			$("#parentRewardNum").val("0");
		}
	}
	function regReward(value){
		if(value==1){
			$("#regRewardNum").removeAttr("readonly");
		}
		if(value==2){
			$("#regRewardNum").attr("readonly","readonly");
			$("#regRewardNum").val("0");
		}
	}
	function createRewardLevel(){
		art.dialog.open('/agentSetLevel/edit?agentSetId=${agentSet.dbid}', {
		    title: '设置梯度奖励',
		    width:"760px",height:"320px",
		    init: function () {
		    	var iframe = this.iframe.contentWindow;
		    	var top = art.dialog.top;// 引用顶层页面window对象
		    },
		    ok: function () {
		    	var iframe = this.iframe.contentWindow;
		    	if (!iframe.document.body) {
		        	alert('iframe还没加载完毕呢')
		        	return false;
		        };
		        var frmId=iframe.document.getElementById('frmId');
		        var begins=$(frmId).find("#begin");
		        var ends=$(frmId).find("#end");
		        var rewardMoneys=$(frmId).find("#rewardMoney");
		        for(var i=0;i<begins.length;i++){
		        	if(!checkInt($(begins[i]).val())){
		        		alert("第["+(i+1)+"]条奖励设置错误，开始值必须为数字");
		        		$(begins[i]).focus();
		        		return false;
			        }
		        	if(!checkInt($(ends[i]).val())){
		        		alert("第["+(i+1)+"]条奖励设置错误，结束值必须为数字");
		        		$(ends[i]).focus();
		        		return false;
			        }
		        	if(!checkFloat($(rewardMoneys[i]).val())){
		        		alert("第["+(i+1)+"]条奖励设置错误，奖励金额必须为数字");
		        		$(rewardMoneys[i]).focus();
		        		return false;
			        }
		        	var begin=parseInt($(begins[i]).val());
		        	var end=parseInt($(ends[i]).val());
		        	var rewardMoney=parseInt($(rewardMoneys[i]).val());
		        	if(begin>end){
			        	alert("第["+(i+1)+"]条奖励设置错误，开始值大于后值");
			        	$(begins[i]).foucs();
			        	return false;
			        }
			        if(i<(begins.length-1)){
			        	var nextBegin=parseInt($(begins[i+1]).val());
			        	if(end!=nextBegin){
			        		alert("第["+(i+2)+"]条开始值设置错误，开始值必须等于["+(i+1)+"]条的后值");
			        		$(begins[i+1]).foucs();
			        		return false;
				        }
				    }
			     }
		        var text="";
		        var beginNums=new Array(),endNums=new Array(),rewardMoneyNums=new Array();
		        for(var i=0;i<begins.length;i++){
			        text=text+'<div style="line-height: 30px;">'+
			        '<div class="leval">等级'+(i+1)+'</div>'+
			        '<div class="leval">'+$(begins[i]).val()+'&lt;X&lt;='+$(ends[i]).val()+'</div>'+
			        '<div class="leval">'+$(rewardMoneys[i]).val()+'</div>'+
					'<div style="clear: both;"></div>'+
					'</div>';
			        beginNums.push($(begins[i]).val());
			        endNums.push($(ends[i]).val());
			        rewardMoneyNums.push($(rewardMoneys[i]).val());
			     }
		        $.post("${ctx}/agentSetLevel/save",{agentSetId:'${agentSet.dbid}',beginNums:beginNums.toString(),endNums:endNums.toString(),rewardMoneyNums:rewardMoneyNums.toString()},function(data){
			        if(data=='success'){
					     $("#contentLevel").text("");
					     $("#contentLevel").append(text);
				    }else{
					     $("#contentLevel").text("");
				    	 $("#contentLevel").append("<div style='color：red'>梯度奖励设置失败，请重新设置</div>");
					}
			     })
		    },
		    cancel: true,
		});
	}
	function checkInt(value) {
		if (!(/^([-]){0,1}([0-9]){1,}$/.test(value))) {
			return false;
		}
		return true;
	}
	function checkFloat(value)
	{	
		if(!(/^([-]){0,1}([0-9]){1,}([.]){0,1}([0-9]){0,}$/.test(value)))
		{
			return false;
		}
		return true;
	}
</script>
</html>