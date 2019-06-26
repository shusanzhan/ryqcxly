<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>工厂订单</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
.mainTable tbody tr:hover {
  background:#D7E9F9;
  border: 1px solid #03476F;
  }
</style>
<script type="text/javascript">
/** 获取checkBox的value* */
function getCheckBoxMember(companyName) {
	var array = new Array();
	var arrayNames = new Array();
	var checkeds = $("input[type='radio'][name='id']");
	var state=true;
	var state2=true;
	var j=0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			state=$(checkbox).attr("state");
			state2=$(checkbox).attr("state2");
			array.push(checkbox.value);
			arrayNames.push($(checkbox).attr("tip"));
			j=j+1;
		}
	});
	if(j>1){
		alert("车架号只能选择一个");
		return;
	}
	$("#vinCode").val(array.toString()+"|"+arrayNames.toString()+"|"+state+"|"+companyName+"|"+state2);
}
</script>
</head>
<body class="bodycolor">
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/factoryOrder/choiceVinCode" method="post" >
  		<input type="hidden" name="vinCode" id="vinCode">
  		<c:if test="${empty(param.hasCarOrder) }">
	  		<input type="hidden" id="hasCarOrder" name="hasCarOrder" value="${hasCarOrder }">
	  		<input type="hidden" id="pidDbid" name="pidDbid" value="${pidDbid }">
  		</c:if>
  		<c:if test="${!empty(param.hasCarOrder) }">
  			<input type="hidden" id="hasCarOrder" name="hasCarOrder" value="${param.hasCarOrder }">
  			<input type="hidden" id="pidDbid" name="pidDbid" value="${param.pidDbid }">
  		</c:if>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>进货商：</label></td>
  				<td>
  					<select class="text small" id=sourceCompanyId name="sourceCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="enterprise" items="${enterprises }">
							<option value="${enterprise.dbid }" ${param.sourceCompanyId==enterprise.dbid?'selected="selected"':'' } >${enterprise.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>加装：</label></td>
  				<td>
  					<select id="isInstall" name="isInstall"  class="text midea" onchange="$('#searchPageForm')[0].submit();">
						<option value="">请选择...</option>
						<option value="1" ${param.isInstall==1?'selected="selected"':'' } >未加装</option>
						<option value="2" ${param.isInstall==2?'selected="selected"':'' } >加装</option>
					</select>
				</td>
  				<td><label>预定：</label></td>
  				<td>
  					<select id="reserveStatus" name="reserveStatus"  class="text midea" onchange="$('#searchPageForm')[0].submit();">
						<option value="">请选择...</option>
						<option value="1" ${param.reserveStatus==1?'selected="selected"':'' } >未预定</option>
						<option value="2" ${param.reserveStatus==2?'selected="selected"':'' } >已绑定</option>
						<option value="3" ${param.reserveStatus==3?'selected="selected"':'' } >已预定</option>
					</select>
				</td>
				<td><label>vin码：</label></td>
  				<td><input type="text" id="vinCode1" name="vinCode1" class="text small" value="${param.vinCode1}"></input></td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>


<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 100px;">
				vin码
			</td>
			<td style="width: 200px;">名称</td>
			<td style="width:50px;">进货商</td>
			<td style="width:50px;">惠民</td>
			<td style="width:60px;">性质</td>
			<td style="width:60px;">种类</td>
			<td style="width:60px;">库龄等级</td>
			<td style="width:60px;">是否加装</td>
			<td style="width:60px;">管理公司</td>
			<td style="width:60px;">库房</td>
			<td style="width:60px;">奖励金额</td>
			<td style="width:60px;">预定状态</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${factoryOrders }" var="factoryOrder">
		<tr >
			<c:if test="${factoryOrder.enterprise.dbid==enterprise.dbid }" var="status">
			</c:if>
			<c:if test="${factoryOrder.storeCompany.dbid==enterprise.dbid }" var="status2">
			</c:if>
			<td style="text-align: left;">
				<c:if test="${factoryOrder.reserveStatus==1 }">
					<label>
						<input type="radio"   name="id" id="id1" value="${factoryOrder.dbid }" tip="${factoryOrder.vinCode }" state="${status}" state2="${status2 }" onclick="getCheckBoxMember('${factoryOrder.enterprise.name}')">
						&nbsp;&nbsp;
						${factoryOrder.vinCode}
					</label>
				</c:if>
				<c:if test="${factoryOrder.reserveStatus==2 }">
					<label>
						<input type="radio"  disabled="disabled" name="id" id="id1" value="${factoryOrder.dbid }" tip="${factoryOrder.vinCode }" state="${status}" onclick="getCheckBoxMember('${factoryOrder.enterprise.name}')">
						&nbsp;&nbsp;
						${factoryOrder.vinCode}
					</label>
				</c:if>
				<c:if test="${factoryOrder.reserveStatus==3 }">
					<label>
						<input type="radio"  disabled="disabled" name="id" id="id1" value="${factoryOrder.dbid }" tip="${factoryOrder.vinCode }" state="${status}" onclick="getCheckBoxMember('${factoryOrder.enterprise.name}')">
						&nbsp;&nbsp;
						${factoryOrder.vinCode}
					</label>
				</c:if>
			</td>
			<td class="tip" >
				<a href="javascript:void(-1)" class="" style="color: #46A0DE;" onclick="window.open('${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1&from=1')">
					${factoryOrder.carSeriy.name }
					${factoryOrder.carModel.name }
					${factoryOrder.carColor.name }
					<c:if test="${factoryOrder.enterprise.dbid==enterprise.dbid }" var="status">
						<span style="color: green;">(自有)</span>
					</c:if>
					<c:if test="${factoryOrder.enterprise.dbid!=enterprise.dbid }" var="status">
						<span style="color: red">(分店)</span>
					</c:if>
				</a>
			</td>
			<td >
				${factoryOrder.sourceCompany.name }
			</td>
			<td >
				${factoryOrder.huimin }
			</td>
			<td>
				${factoryOrder.orderAttr }
			</td>
			<td>
				${factoryOrder.orderType }
			</td>
			<td>
				${factoryOrder.storeAgeLevel.name }
			</td>
			<td>
				<c:if test="${factoryOrder.isInstall==1 }">
					<span style="color: red;">未加装</span>
				</c:if>
				<c:if test="${factoryOrder.isInstall==2 }">
					<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=2&from=1" class="" style="color: #46A0DE;"><span style="color: green;">加装</span></a>
				</c:if>
			</td>
			<td>
				${factoryOrder.storeCompany.name }
			</td>
			<td>
				${factoryOrder.carReceiving.storeRoom.name }&nbsp;&nbsp;${factoryOrder.carReceiving.storage.name }
			</td>
			<td>
					<span style="color: red;font-size: 14px;"><fmt:formatNumber value="${factoryOrder.totalRewardMoney }" pattern="#.##"></fmt:formatNumber> </span>元
			</td>
			<td>
				<c:if test="${factoryOrder.reserveStatus==1 }">
					<span style="color: red;">未预定</span>
				</c:if>
				<c:if test="${factoryOrder.reserveStatus==2 }">
					<a href="javascript:void(-1)" onclick="window.open('${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=6&from=1')">
						<span style="color:blue;">已绑定</span>
					</a>
				</c:if>
				<c:if test="${factoryOrder.reserveStatus==3 }">
					<a href="javascript:void(-1)" onclick="window.open('${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=6&from=1')">
						<span style="color:blue;">已预定</span>
					</a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>
