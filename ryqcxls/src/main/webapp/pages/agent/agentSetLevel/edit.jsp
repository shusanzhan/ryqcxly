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
<title>梯度奖励设置</title>
<style type="text/css">
	.leval{
		float: left;
		margin-right: 12px;
	}
	.item{
		line-height: 30px;margin-bottom: 12px;
	}
</style>
</head>
<body class="bodycolor" style="background: #f8f8f8">
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="agentSet.dbid" id="dbid" value="${agentSet.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;margin-top: 20px;">
			<tr id="agentRewardLevelTr" >
				<td>
					梯度设置
				</td>
				<td id="settr">
					<c:if test="${empty(agentSetLevels) }">
						<div class="item" id="first">
							<div class="leval">成交客户开始></div>
							<div class="leval">
								<input type="text" class="text small" id="begin" name="begin" value="0" checkType="integer,0">
							</div>
							<div class="leval">
								结束>=
							</div>
							<div class="leval">
								<input type="text" class="text small" id="end" name="end" value="1" checkType="integer,0">
							</div>
							<div class="leval">
								奖励金额
							</div>
							<div class="leval">
								<input type="text" class="text small" id="rewardMoney" name="rewardMoney" value="300" checkType="integer,0">
							</div>
							<div class="leval delete" style="display: none;"><a href="javascript:void(-1)" class="adeit" style="color: #2b7dbc;" onclick="deleteNew(this)">删除</a></div>
							<div class="leval add"><a href="javascript:void(-1)" class="adeit" style="color: #2b7dbc;" onclick="createNew()">新增</a></div>
							<div style="clear: both;"></div>
						</div>
					</c:if>
					<c:if test="${!empty(agentSetLevels) }">
						<c:forEach var="agentSetLevel" items="${agentSetLevels }" varStatus="i">
							<div class="item" id="first">
								<div class="leval">成交客户开始></div>
								<div class="leval">
									<input type="text" class="text small" id="begin" name="begin" value="${agentSetLevel.beginNum }" checkType="integer,0">
								</div>
								<div class="leval">
									结束>=
								</div>
								<div class="leval">
									<input type="text" class="text small" id="end" name="end" value="${agentSetLevel.endNum }" checkType="integer,0">
								</div>
								<div class="leval">
									奖励金额
								</div>
								<div class="leval">
									<input type="text" class="text small" id="rewardMoney" name="rewardMoney" value="${agentSetLevel.rewardMoney }" checkType="integer,0">
								</div>
								<c:if test="${fn:length(agentSetLevels)==1}" var="status">
									<div class="leval delete" style="display: none;"><a href="javascript:void(-1)" class="adeit" style="color: #2b7dbc;" onclick="deleteNew(this)">删除</a></div>
									<div class="leval add"><a href="javascript:void(-1)" class="adeit" style="color: #2b7dbc;" onclick="createNew()">新增</a></div>
								</c:if>
								<c:if test="${status==false }">
										<div class="leval delete"><a href="javascript:void(-1)" class="adeit" style="color: #2b7dbc;" onclick="deleteNew(this)">删除</a></div>
										<div class="leval add" style=" ${fn:length(agentSetLevels)==(i.index+1)?'':'display: none;' }"><a href="javascript:void(-1)" class="adeit" style="color: #2b7dbc;" onclick="createNew()">新增</a></div>
								</c:if>
								<div style="clear: both;"></div>
							</div>
						</c:forEach>
					</c:if>
				</td>				
			</tr>
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
    var setep=2;
    var setepMoney=100;
	function createNew(){
		var newDiv=$("#first").clone();
		$("#settr").append(newDiv);
		$("#settr").find(".add").each(function(i){
			$(this).hide();
		})
		$("#settr").find(".delete").each(function(i){
			$(this).show();
		})
		$("#settr").find(".add").last().show();
		var items=$("#settr").find(".item");
		for(var i=0;i<items.length;i++){
			if(i<(items.length-1)){
				var preEnd=$(items[i]).find("#end").val();
				var rewardMoney=$(items[i]).find("#rewardMoney").val();
				if(null!=preEnd&&preEnd!=''&&preEnd!=undefined){
					preEnd=parseInt(preEnd);
					$(items[i+1]).find("#begin").val(preEnd);
					$(items[i+1]).find("#end").val(preEnd+setep);
				}
				if(null!=rewardMoney&&rewardMoney!=''&&rewardMoney!=undefined){
					rewardMoney=parseInt(rewardMoney);
					$(items[i+1]).find("#rewardMoney").val(rewardMoney+setepMoney);
				}
			}
		}
	}
	function deleteNew(val){
		$(val).parent().parent().remove();
		var items=$("#settr").find(".item");
		if(items.length<=1){
			$("#settr").find(".delete").each(function(i){
				$(this).hide();
			})
		}
		$("#settr").find(".add").last().show();
	}
</script>
</html>