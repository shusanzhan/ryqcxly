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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>支出管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">支出管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<label style="color:black">支出</label>
	<select class="text middle" id="addExpenditure" name="addExpenditure" onchange="window.location.href=this.value">
		<option value="0">请选择...</option>
		<option value="${ctx}/expenditureManagement/addExpenditure?val=1">预收支出</option>
		<c:if test="${isaleDecoreType.decoreType eq 1}">
			<option value="${ctx}/expenditureManagement/decoreHasExpenditureList">装饰成本支出(有装饰部)</option>
		</c:if>
		<c:if test="${isaleDecoreType.decoreType eq 2}">
			<option value="${ctx}/expenditureManagement/decoreNoExpenditureList">装饰成本支出(无装饰部)</option>
		</c:if>
	</select>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/expenditureManagement/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>支出名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
				<td><label>支出类别：</label></td>
  				<td>
					<select class="text small" id="expenditureItemId" name="expenditureItemId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1"  ${param.expenditureItemId==1?'selected="selected"':'' }>购车定金</option>
						<option value="2"  ${param.expenditureItemId==2?'selected="selected"':'' }>预收款礼券</option>
						<option value="3"  ${param.expenditureItemId==3?'selected="selected"':'' }>会员充值</option>
						<option value="4"  ${param.expenditureItemId==4?'selected="selected"':'' }>押金(二网按揭押金)</option>
						<option value="5"  ${param.expenditureItemId==5?'selected="selected"':'' }>预收保费</option>
						<c:if test="${isaleDecoreType.decoreType eq 1}">
							<option value="8"  ${param.expenditureItemId==8?'selected="selected"':'' }>装饰成本(有装饰部)</option>
						</c:if>									
						<c:if test="${isaleDecoreType.decoreType eq 2}">
							<option value="7"  ${param.expenditureItemId==7?'selected="selected"':'' }>装饰成本(无装饰部)</option>
						</c:if>
					</select>
  				</td>
  				<td><label>支出日期：</label></td>
  				<td>
  					<input class="text small" id="startDate" name="startDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endDate" name="endDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无支出管理
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span3">支出信息</td>
			<td class="span2">客户电话号码</td>
			<td class="span3">支出单号</td>
			<td class="span2">支出金额</td>
			<td class="span2">支出项目类型</td>
			<td class="span2">支款人</td>
			<td class="span2">备注</td>
			<td class="span2">支出时间</td>
			<td class="span2">明细查询</td>
		</tr>
	</thead>
	<c:forEach var="expenditure" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align:lcenter;">
				${expenditure.custNames}
			</td>
			<td style="text-align:center;">
				${expenditure.custTel}
			</td>
			<td style="text-align:center;">
				${expenditure.expenditureSingleNumber}
			</td>
			<td style="text-align:center;">
				${expenditure.expenditureAmount }
			</td>
			<td style="text-align:center;">
				<c:choose>
					<c:when test="${expenditure.expenditureItemId eq 1}">
						购车定金
					</c:when>
					<c:when test="${expenditure.expenditureItemId eq 2}">
						预收款礼券
					</c:when>
					<c:when test="${expenditure.expenditureItemId eq 3}">
						会员充值
					</c:when>
					<c:when test="${expenditure.expenditureItemId eq 4}">
						押金（二网按揭押金）
					</c:when>
					<c:when test="${expenditure.expenditureItemId eq 5}">
						预收保费
					</c:when>
					<c:when test="${expenditure.expenditureItemId eq 6}">
						金融车辆成本
					</c:when>
					<c:when test="${expenditure.expenditureItemId eq  7}">
						装饰成本（无装饰部）
					</c:when>
					<c:when test="${expenditure.expenditureItemId eq 8}">
						装饰成本（有装饰部）
					</c:when>
				</c:choose>
			</td>
			<td style="text-align:lcenter;">
				${expenditure.payee}
			</td>
			<td style="text-align:center;">
				${expenditure.remarks}
			</td>
			<td style="text-align:center;">
				<fmt:formatDate value="${expenditure.expenditureDate }" />
			</td>
			<td style="text-align:center;">
				<a href="${ctx}/expenditureManagement/expenditureDetail?expenditureId=${expenditure.dbid}" style="color: #2b7dbc;">明细查询</a>
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
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/advanceMangement/exportExcel?'+params;
}
</script>
</html>