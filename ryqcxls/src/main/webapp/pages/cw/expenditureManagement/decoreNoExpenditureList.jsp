<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<style type='text/css'>
		.fixcol { position: relative ; LEFT: expression(this.parentElement.offsetParent.parentElement.scrollLeft);
	white-space: nowrap; left:0;
	}
	</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>装饰成本支出(无装饰部)</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/expenditureManagement/queryList'">支出管理</a>-
	<a href="javascript:void(-1);" onclick="">装饰成本支出(无装饰部)</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		 <a  href="javascript:;" class="but button"  onclick="batchExpenditure()">批量支出</a> 
		<%--  ${ctx}/advancePayment/queryCustList --%>
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/expenditureManagement/decoreNoExpenditureList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable"  style="width:100%">
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>销售单号：</label></td>
  				<td><input type="text" id="outNo" name="outNo" class="text small" value="${param.outNO}"></input></td>
  				<td><label>销售日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty decoreOuts }">
	<div class="alert alert-error">
		无装饰支出(无装饰部)
	</div>
</c:if>
<c:if test="${!empty decoreOuts}">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" onchange="sum()" /></td>
			<td class="span3 fixcol" >出库单号</td>
			<td class="span3">客户姓名</td>
			<td class="span3">客户电话</td>
			<td class="span3">客户类型</td>
			<td class="span4">总成本</td>
			<!-- <td class="span4">挂账单位</td> -->
			<td class="span3">订单状态</td>
		</tr>
	</thead>
	<c:forEach var="decoreOut" items="${decoreOuts}">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id"  id="${decoreOut.dbid }" value="${decoreOut.dbid }" onchange="sum()"/></td>
			<td style="text-align:lcenter;" class="fixcol">
				${decoreOut.outNo }
			</td>
			<td style="text-align:lcenter;">
				${decoreOut.customerName }
			</td>
			<td style="text-align:lcenter;">
				${decoreOut.customer.mobilePhone}
			</td>
			<td style="text-align:lcenter;">
				<c:if test="${decoreOut.type eq 1}">
					保有客户销售
				</c:if>
				<c:if test="${decoreOut.type eq 2 }">
					零售客户
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				${decoreOut.costTotalPrice}
			</td>
			<td style="text-align:lcenter;">
				<c:choose>
					<c:when test="${decoreOut.cashierStatus eq 1}">
						未收款
					</c:when>
					<c:when test="${decoreOut.cashierStatus eq 2}">
						已收款
					</c:when>
				</c:choose>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<p id="total" style="display:none;font-size:20px;color:red;cursor:hand">总额:<span id="totals"></span></p>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
function batchExpenditure(){
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择批量支出数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
		// 为true等价于function(){}
		});
		return false;
	}
	var dbids=getCheckBox();
	window.top.art.dialog({
		content : '确定对【'+length+'】客户,总金额<span style="color:red;">【￥'+sum()+'】</span>进行批量支出吗?',
		icon : 'question',
		width:"250px",
		height:"80px",
		lock : true,
		ok : function() {
			window.location.href="${ctx }/expenditureManagement/decoreNoBatchExpenditure?dbids="+dbids;
		},
		cancel : true
	});
}
//支付方式的文本的显示和实收总额的计算
function payMent(s){	
	if($("input[type='checkbox']").is(':checked')){
		$("#zf").show();
		if($(s).css("display")=="none"){
			$(s).css("display","");
		}else{
			$(s).css("display","none");
			if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
				var total = parseFloat($("#totalMoney").val())-parseFloat($(s).children().eq(0).val());
				$("#totalMoney").val(total);
				$(s).children().eq(0).val("");
			}	
		}
	}else{
		$("#zf").hide();
		$(s).css("display","none");
		if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
			var total = parseFloat($("#totalMoney").val())-parseFloat($(s).children().eq(0).val());
			$("#totalMoney").val(total);
			$(s).children().eq(0).val("");
		}	
	}	
}
//单个支出
//计算实收总额
function totalAmount(s){
	var lis = $(s).parent().siblings();
	var total=0;
	for(var i=0;i<lis.size();i++){
		if(lis.eq(i).children().eq(0).val()!=null && lis.eq(i).children().eq(0).val()!=''){
			total = total + parseFloat(lis.eq(i).children().eq(0).val()); 
		}
	}
		if($(s).val()!=null && $(s).val()!=''){
			total = total + parseFloat($(s).val());
		}	
		$("#totalMoney").val(total);
}
///////////////////批量收银/////////////////////////////批量收银////////////////////////
		function plsy(){		
			var checkList = new Array();
			var totalMoney = $("#totalMoney").val();
			var total = $("#totals").text();
			var engName = new Array();
			var moneyS = new Array();
			var ss = $("#paymetMoney").children("td");
			var payTypes = document.getElementsByName("payType");
			for(var i=0;i<ss.length;i++){
				if(isNaN(ss.eq(i).children().eq(0).val())==false && ss.eq(i).children().eq(0).val()!=null && ss.eq(i).children().eq(0).val()!=""){
					engName.push(ss.eq(i).children().eq(0).attr("name"));
					moneyS.push(ss.eq(i).children().eq(0).val());
				}
			}
			$("input[name='id']:checked").each(function(){
				checkList.push($(this).val());
			});
			if(checkList.length==0){
				alert("未选中操作行,请选中！");
				return ;
			}
			var num = 0;
			for(var i=0;i<payTypes.length;i++){
				if(payTypes[i].checked){
					num = num +1;
				}
			}
			if(num<=0){
				alert("请选择支付方式！");
				return ;
			}
			if(totalMoney!=total){
				alert("付款总额有误！");
				return ;
			}
			if($("#expenditureNo").val()==null || $("#expenditureNo").val()==""){
				alert("请输入支出单号！");
				return ;
			}
			 if(confirm("确认要执行此操作吗?")){
				 var expenditureNo = $("#expenditureNo").val();
				 var total = $("#totals").text();
				 $.ajax({
						type:"POST",
						url:"/expenditureManagement/batchCashDecoreNo",
						data:{
							"dbids":JSON.stringify(checkList),
							"expenditureNo":expenditureNo,
							"total":total, 
							"engName":JSON.stringify(engName),
				 			"moneyS":JSON.stringify(moneyS)
						},
						success:function(result){
							var url = result[0]["url"];
							window.location.href=url;
						}
					});
			} 
		}
		function sum(){
			var len = $("input[name='id']:checked");
			var sum = 0;
			for(var i=0;i<len.size();i++){
				var check = len.eq(i);
				var tds = check.parent().siblings();
				if(tds.eq(4).text()!=null && tds.eq(4).text()!=''){
					sum = sum + parseFloat(tds.eq(4).text());
				}
			}
			$("#total").css("display","");
			$("#totals").text(sum);
			return sum;
		}
		/////////////////单个项目收银///////////////////////
		function cash(dbid){
		if(confirm("确定要执行此操作吗？")){
			$.ajax({
				type:"POST",
				url:"/cashInsurance/batchCash",
				data:{
					"dbids":dbid
				},
				success:function(result){
					var url = result[0]["url"];
					window.location.href=url;
				}
			});
			}
		}
</script>
</html>