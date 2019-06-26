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
<title>特殊预约管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">特殊预约管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/specialMotorPool/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.operatorDataByDbids('${ctx }/specialMotorPool/delete','searchPageForm','删除选择数据将把交车记录删除，同时释放对应的车架号？')">删除</a>
   </div>
  
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/specialMotorPool/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text samll" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text samll" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text samll" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>颜色：</label></td>
  				<td>
  					<select class="text midea" id="carColorId" name="carColorId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carColor" items="${carColors }">
							<option value="${carColor.dbid }" ${param.carColorId==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车源状态：</label></td>
  				<td>
  					<select id="hasCarOrder" name="hasCarOrder"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.hasCarOrder==1?'selected="selected"':''  }>现车订单</option>
						<option value="2" ${param.hasCarOrder==2?'selected="selected"':''  }>在途订单</option>
						<option value="3" ${param.hasCarOrder==3?'selected="selected"':''  }>无车订单</option>
					</select>
  				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text small">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
 </div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">提车人</td>
			<td class="span1">提车时间</td>
			<td class="span1">车源情况</td>
			<td class="span4">车型</td>
			<td class="span2">车架号</td>
			<td class="span2">创建时间</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="specialMotorPool" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${specialMotorPool.dbid }"/></td>
			<td ">${specialMotorPool.reserveDep }</td>
			<td >${specialMotorPool.reserveDate }</td>
			<td >
				<c:if test="${specialMotorPool.hasCarOrder==1 }">
					<span style="color: blue;">现车订单</span>
				</c:if>
				<c:if test="${specialMotorPool.hasCarOrder==2 }">
					<span style="color:green;">在途订单</span>
				</c:if>
				<c:if test="${specialMotorPool.hasCarOrder==3 }">
					<span style="color: red;">无车订单</span>
				</c:if>
			 </td>
			<c:set value="${specialMotorPool.brand.name}${specialMotorPool.carSeriy.name}${ specialMotorPool.carModel.name }${specialMotorPool.carColor.name }" var="carModel"></c:set>
			<td style="text-align: left;">
				${carModel} ${customer.carModelStr} &nbsp;&nbsp;
			</td>
			<td >
				${specialMotorPool.vinCode }
			 </td>
			<td>
				${specialMotorPool.createDate }
			 </td>
			<td>
					<c:if test="${empty(specialMotorPool.vinCode)&&fn:length(specialMotorPool.vinCode)<=0 }" var="status">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/specialMotorPool/edit?dbid=${specialMotorPool.dbid }'">绑车架号</a>
					</c:if>
					<c:if test="${status==false }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/specialMotorPool/cancelVinCode?dbid=${specialMotorPool.dbid}','searchPageForm','确定释放【${specialMotorPool.vinCode }】车架号码？释放后该订单将转为无车订单状态，如需分配车辆请重新绑定！')">释放车架号</a>
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/specialMotorPool/edit?dbid=${specialMotorPool.dbid }'">更新备注</a>
					</c:if>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/specialMotorPool/delete?dbids=${specialMotorPool.dbid}','searchPageForm','删除选择数据将把交车记录删除，同时释放对应的车架号？')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>