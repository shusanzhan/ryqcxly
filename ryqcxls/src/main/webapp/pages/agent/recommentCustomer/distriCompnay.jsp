<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车型 添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	#carSeriyId{
		width: 240px;
	}
	select{
		    height: 36px;
	    	line-height: 36px;
	    	font-size: 14px;
	        width: 160px;
	        border: 1px solid #e3e3ee;
    		background-color: #FFF;
	}
</style>
</head>
<body>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId" target="_parent">
		<input type="hidden" value="${recommendCustomer.dbid }" id="dbid" name="dbid">
		<input type="hidden" id="currentPage" name="currentPage" value='${param.currentPage}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${param.pageSize}'>
		<input type="hidden" id="type" name="type" value='${param.type}'>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">客户姓名：</td>
					<td>
						${recommendCustomer.name }（<span style="color: red;">${recommendCustomer.sex }</span>)
					</td>
					<td class="formTableTdLeft">联系电话：</td>
					<td>
						${recommendCustomer.mobilePhone }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">推荐人：</td>
					<td colspan="">
						${recommendCustomer.agentName }
					</td>
					<td class="formTableTdLeft">推荐人电话：</td>
					<td>
						${recommendCustomer.agentPhone }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">推荐车型：</td>
					<td colspan="">
						${recommendCustomer.brand.name }
						${recommendCustomer.carSeriy.name }
						${recommendCustomer.carModel.name }
					</td>
					<td class="formTableTdLeft">省（直辖市）-市-区：</td>
					<td colspan="">
						${recommendCustomer.province }
						${recommendCustomer.city }
						${recommendCustomer.areaStr }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">经销商：</td>
					<td id="companyDiv">
						 <input class="mideaX text" id="companyId" name="companyId" value="${recommendCustomer.enterpriseId }" type="hidden"></input>
						 <input class="mideaX text" id="enterpriseName" name="enterpriseName" value="${enterprise.name }" readonly="readonly"></input>
					</td>
					<td class="formTableTdLeft">销售顾问：</td>
					<td>
					      	<input type="hidden" name="salerId" id="salerId" value="" >
							<input type="text" name="saler" onfocus="autoUser('saler')" id="saler" value=""  placeholder="请输入销售人员的拼音" class="mideaX text" title="销售人员"	checkType="string,1" tip="销售人员不能为空">
							<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">奖励金额：</td>
					<td>
						<c:if test="${agentSet.agentRewardStatus==1 }">
						     <input class="mideaX text" id="rewardMoney" name="rewardMoney" value="${agentSet.agentRewardNum }" checkType="float,0" error="奖励金额"></input>
						</c:if>
						<c:if test="${agentSet.agentRewardStatus==2 }">
						     <input class="mideaX text" id="rewardMoney" readonly="readonly" name="rewardMoney" value="0" checkType="float,0" error="奖励金额"></input>
						</c:if>
					</td>
					<td class="formTableTdLeft">奖励积分：</td>
					<td>
					     <input class="mideaX text" id="point" name="point" value="0" checkType="float,0" error="奖励积分"></input>
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/recommendCustomer/saveDistriCompnay')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close();" class="but butCancle">关&nbsp;&nbsp;闭</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
function ajaxCity(sel){
	var value=$(sel).val();
	$.post("${ctx}/custRecCustFactWechat/ajaxCity?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			var da=$.parseJSON(data);
			$("#cityDiv").text("");
			$("#cityDiv").append(data.city);
			$("#areaDiv").text("");
			$("#areaDiv").append(data.area);
			$("#companyDiv").text("");
			$("#companyDiv").append(data.company);
			$("#rewardMoney").val(data.rewardMoney);
			$("#point").val(data.point);
		}
	});
}
function ajaxArea(sel){
	var value=$(sel).val();
	$.post("${ctx}/custRecCustFactWechat/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			var da=$.parseJSON(data);
			$("#areaDiv").text("");
			$("#areaDiv").append(data.area);
			
			$("#companyDiv").text("");
			$("#companyDiv").append(data.company);
			
			$("#rewardMoney").val(data.rewardMoney);
			$("#point").val(data.point);
		}
	});
}
function ajaxCompanyArea(sel){
	$.post("${ctx}/custRecCustFactWechat/ajaxCompanyArea?dbid="+sel+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#rewardMoney").val(data.rewardMoney);
			$("#point").val(data.point);
		}
	});
}

function autoUser(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/user/ajaxUser",{
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect2);
	//计算总金额
}

function onRecordSelect2(event, data, formatted) {
		$("#saler").val(data.name);
		$("#salerId").val(data.dbid);
}
</script>
</html>
