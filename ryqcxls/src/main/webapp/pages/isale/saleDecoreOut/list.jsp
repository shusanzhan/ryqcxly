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
<title>装饰销售</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">装饰销售</a>
</div>
 <!--location end-->
<div class="line"></div>
<br>
<div class="alert alert-info">
		<p>
			装饰业务模式:
			<c:if test="${isaleDecoreType.decoreType==1 }">
				自有装饰部，装饰出库流程：采购商品入库->采购商品出库（先进先出原则，如果商品无库存，则不能出库）
			</c:if>
			<c:if test="${isaleDecoreType.decoreType==2 }">
				装饰外包三方公司，装饰出库流程：打印出库单出库
			</c:if>
		</p>
		<p>
			账务装饰收业务模式:
			<c:if test="${isaleDecoreType.finStatus==1 }">
				未开启装饰财务收银
			</c:if>
			<c:if test="${isaleDecoreType.finStatus==2 }">
				开启装饰账务收银模式，装饰出库流程：装饰部填写零售装饰->财务收款->装饰出库
			</c:if>
		</p>
</div>
<div class="listOperate">
	<div class="operate">
		<c:if test="${isaleDecoreType.decoreType==1 }">
			<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/saleDecoreOut/edit'">装饰零售</a>
			<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/saleDecoreOut/preEdit'">缺货零售</a>
		</c:if>
		<c:if test="${isaleDecoreType.decoreType==2 }">
			<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/saleDecoreOut/preEdit'">装饰零售</a>
		</c:if>
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/saleDecoreOut/queryCancelList'">作废单</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/saleDecoreOut/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户类型：</label></td>
  				<td>
					<select id="type" name="type" class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.type==1?'selected="selected"':'' }>自有客户</option>
						<option value="2" ${param.type==2?'selected="selected"':'' }>零售客户</option>
					</select>
				</td>
  				<td><label>销售类型：</label></td>
  				<td>
					<select id="correctStatus" name="correctStatus" class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.correctStatus==1?'selected="selected"':'' }>正常销售</option>
						<option value="2" ${param.correctStatus==2?'selected="selected"':'' }>缺货销售</option>
					</select>
				</td>
  				<td><label>出库状态：</label></td>
  				<td>
					<select id="status" name="status" class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.status==1?'selected="selected"':'' }>待出库</option>
						<option value="2" ${param.status==2?'selected="selected"':'' }>已出库</option>
					</select>
				</td>
  				<td><label>客户姓名：</label></td>
  				<td>
  					<input type="text" id="customerName" name="customerName" value="${param.customerName }" class="text small">
				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input type="text" id="saler" name="saler" value="${param.saler }" class="text small">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无装饰销售
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">销售单号</td>
			<td class="span2">销售日期</td>
			<td class="span2">客户类型</td>
			<td class="span2">客户</td>
			<td class="span2">销售顾问</td>
			<td class="span2">实收金额</td>
			<td class="span2">销售金额</td>
			<td class="span1">折扣率</td>
			<td class="span1">销售类型</td>
			<c:if test="${isaleDecoreType.finStatus==2 }">
				<td class="span2">收银状态</td>
			</c:if>
			<td class="span1">出库状态</td>
			<td class="span2">说明</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="decoreOut" items="${page.result }">
		<c:set value="${decoreOut.customer }" var="customer"></c:set>
		<c:set value="${decoreOut.customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${decoreOut.dbid }"/></td>
			<td style="text-align: center;"> 
				${decoreOut.outNo }
			</td>			
			<td style="text-align: center;"> 
				<fmt:formatDate value="${decoreOut.createDate }"/> 
			</td>			
			<td style="text-align: center;"> 
				<c:if test="${decoreOut.type==1 }">
					自有客户
				</c:if>
				<c:if test="${decoreOut.type==2 }">
					零售客户 
				</c:if>
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.customerName }
				${decoreOut.customer.mobilePhone }
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.saler }
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.acturePrice }
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.decoreSaleTotalPrce }
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.zkl}%
			</td>			
			<td style="text-align: center;"> 
				<c:if test="${decoreOut.correctStatus==1 }">
					<span style="color: green;">正常销售</span>
				</c:if>
				<c:if test="${decoreOut.correctStatus==2 }">
					<c:if test="${decoreOut.type==1 }">
						<span style="color: red;">二次销售</span>
					</c:if>
					<c:if test="${decoreOut.type==2 }">
						<span style="color: red;">缺货销售</span>
					</c:if>
				</c:if>
			</td>	
			<c:if test="${isaleDecoreType.finStatus==2 }">
				<td style="text-align: center;"> 
					<c:if test="${decoreOut.cashierStatus==1||empty(decoreOut.cashierStatus) }">
						<span style="color: red;">待收</span>
					</c:if>
					<c:if test="${decoreOut.cashierStatus==2 }">
						<span style="color: green;">已收</span>
					</c:if>
				</td>
			</c:if>
			<td>
				<c:if test="${decoreOut.status==1 }">
					<span style="color: red;">等待出库</span>
				</c:if>
				<c:if test="${decoreOut.status==2 }">
					<span style="color: green;">已经出库</span>
				</c:if>
			</td>		
			<td style="text-align: center;">
				${decoreOut.note }
			</td>
			<td>
				<c:if test="${decoreOut.correctStatus==1 }">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/viewSale?dbid=${decoreOut.dbid}&type=2'">查看</a>
					 |
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/printSale?dbid=${decoreOut.dbid}&type=1'">打印</a>
					|
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/printCustDecore?dbid=${decoreOut.dbid}&type=1'">打印客户销售单</a>
					|
					<a href="#" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/saleDecoreOut/cancelDecore?dbid=${decoreOut.dbid }','searchPageForm','确定将【${decoreOut.outNo }】作废吗？作废成功将恢复商品库存信息，请慎重操作！')">作废</a>
				</c:if>
				<c:if test="${decoreOut.correctStatus==2 }">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/preViewSale?dbid=${decoreOut.dbid}&type=2'">查看</a> 
					|
					<%-- <a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/printCustDecore?dbid=${decoreOut.dbid}&type=1'">打印客户销售单</a>
					| --%>
					<c:if test="${decoreOut.status==1 }">
						<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/prePrintSale?dbid=${decoreOut.dbid}&type=1'">打印</a>
						|
						<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/preWashed?dbid=${decoreOut.dbid}&type=1'">出库</a>
					</c:if>
					<c:if test="${decoreOut.status==2 }">
						<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/printSale?dbid=${decoreOut.dbid}&type=1'">打印</a>
						|
						<a href="#" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/saleDecoreOut/cancelDecore?dbid=${decoreOut.dbid }','searchPageForm','确定将【${decoreOut.outNo }】作废吗？作废成功将恢复单品出库状态、商品未出库数量，请慎重操作！')">作废</a>
					</c:if>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
	 
	 function sendMms(){
		window.location.href="${ctx}/sms/add";
	 }
</script>
</html>