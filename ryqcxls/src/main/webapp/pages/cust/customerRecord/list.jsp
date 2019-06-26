<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>线索管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.staltalbe{
		width: 98%;background-color:#63BA79;line-height: 40px;color:white;border: 0px;margin: 0 auto;margin-top: 10px;
	}
	.staltalbe td{
		border-bottom: 1px solid #FFF;
	}
	.staltalbe td:last-child{ 
		border-right: 0px;
	}
	.staltalbe td{
		border-right: 1px solid #FFF;text-align: center;
	}
	.staltalbe tr:last-child td{
		border-bottom:0px;
	}
	.staltalbe .label{
		text-align: center;font-weight: bold;
	}
</style>
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">流量管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="line"></div>
	<table class="staltalbe" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td  class="label" colspan="7"><fmt:formatDate value="${now }"/>来店线索统计</td>
		</tr>
		<tr>
			<td class="label">项目</td>
			<td class="label">今日线索</td>
			<td class="label">今日留资</td>
			<td class="label">今日留资率</td>
			<td class="label">本月累计线索</td>
			<td class="label">本月累计留资</td>
			<td class="label">本月留资率</td>
		</tr>
		<c:forEach items="${statCustomerRecords }" var="statCustomerRecord">
			<tr>
				<td>${statCustomerRecord.name }</td>
				<td>${statCustomerRecord.todayNum }</td>
				<td>${statCustomerRecord.todayCreateFolderNum}</td>
				<td>
					<c:if test="${statCustomerRecord.todayNum>0 }">
						<fmt:formatNumber value="${statCustomerRecord.todayCreateFolderNum/statCustomerRecord.todayNum*100 }" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${statCustomerRecord.todayNum<=0 }">
						0
					</c:if>
				</td>
				<td>
					${statCustomerRecord.monthNum }
				</td>
				<td>
					${statCustomerRecord.monthCreateFolderNum }
				</td>
				<td>
					<c:if test="${statCustomerRecord.monthNum>0 }">
						<fmt:formatNumber value="${statCustomerRecord.monthCreateFolderNum/statCustomerRecord.monthNum*100 }" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${statCustomerRecord.monthNum<=0 }">
						0
					</c:if>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="7" style="color: red;text-align: left">说明：来店指有效看车数据，来电指来电咨询购车</td>
		</tr>
	</table>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)" class="but butSave" onclick="window.location.href='${ctx}/customerRecord/add'">流量登记</a>
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerRecord/queryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>来源类型：</label></td>
  				<td>
  					<select class="text midea" id="customerTypeId" name="customerTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<c:forEach var="customerType" items="${customerTypes }">
							<option value="${customerType.dbid }" ${param.customerTypeId==customerType.dbid?'selected="selected"':'' } >${customerType.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>有效状态：</label></td>
  				<td>
  					<select class="small text" id="status" name="status" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						
						<option value="1" ${param.status==1?'selected="selected"':'' } >有效</option>
						<option value="2" ${param.status==2?'selected="selected"':'' } >无效</option>
					</select>
				</td>
  				<td><label>处理结果：</label></td>
  				<td>
  					<select class="small text" id="resultStatus" name="resultStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.resultStatus==1?'selected="selected"':'' } >待处理</option>
						<option value="2" ${param.resultStatus==2?'selected="selected"':'' } >转为登记</option>
						<option value="3" ${param.resultStatus==3?'selected="selected"':'' } >已回访</option>
						<option value="4" ${param.resultStatus==4?'selected="selected"':'' } >无效</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><label>线索类型：</label></td>
  				<td>
  					<select class="text small" id="customerType" name="customerType"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<option value="1" ${param.customerType==1?'selected="selected"':'' } >展厅来店</option>
						<option value="2" ${param.customerType==2?'selected="selected"':'' } >网销来店</option>
					</select>
  				</td>
				<td><label>超时状态：</label></td>
  				<td>
  					<select class="small text" id="overtimeStatus" name="overtimeStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.overtimeStatus==1?'selected="selected"':'' } >未超时</option>
						<option value="2" ${param.overtimeStatus==2?'selected="selected"':'' } >已超时</option>
					</select>
				</td>
  				<td><label>来店次数：</label></td>
  				<td>
  					<select class="small text" id="comeinNum" name="comeinNum" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="0" ${param.comeinNum==0?'selected="selected"':'' } >未到店</option>
						<option value="1" ${param.comeinNum==1?'selected="selected"':'' } >初次来店</option>
						<option value="2" ${param.comeinNum==2?'selected="selected"':'' } >二次来店</option>
					</select>
				</td>
			</tr>
			<tr>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="saler" name="saler" value="${param.saler }">
				</td>
				<td><label>登记人：</label></td>
  				<td>
  					<input class="small text" id="creator" name="creator" value="${param.creator }">
				</td>
				<td><label>客户姓名：</label></td>
  				<td>
  					<input class="small text" id="name" name="name" value="${param.name }">
				</td>
   			</tr>
			<tr>
				<td><label>联系电话：</label></td>
  				<td>
  					<input class="small text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }">
				</td>
				<td><label>登记时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${param.startTime }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${param.endTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 12px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 100px;">登记日期</td>
			<td style="width: 60px;">登记人</td>
			<td style="width: 100px;">类型</td>
			<td style="width: 100px;">客户姓名</td>
			<td style="width: 100px;">来店/电目的</td>
			<td style="width: 100px;">时间</td>
			<td style="width: 100px;">随行人数</td>
			<td style="width: 100px;">状态</td>
			<td style="width: 100px;">销售顾问</td>
			<td style="width: 100px;">处理结果</td>
			<td style="width: 100px;">来店次数</td>
			<td style="width: 100px;">超时状态</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customerRecord">
		<tr>
			<td style="text-align: left;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/customerRecord/view?dbid=${customerRecord.dbid}'">
					<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/>
					<c:if test="${!empty(customerRecord.agentUser) }">
						<br>${customerRecord.agentUser.realName}[代办]
					</c:if>
				</a> 
				<c:if test="${customerRecord.resultStatus==1 }">
					<c:if test="${sessionScope.user.dbid==customerRecord.user.dbid}">
						| <a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/customerRecord/salerEdit?dbid=${customerRecord.dbid}'">编辑</a> 
					</c:if>
				</c:if>
			</td>
			<td>
				${customerRecord.creator }
			</td>
			<td>
				${customerRecord.customerType.name }
			</td>
			<td>
				<c:if test="${empty(customerRecord.name) }">
					无
				</c:if>
				<c:if test="${!empty(customerRecord.name) }">
					${customerRecord.name } ${customerRecord.mobilePhone }
				</c:if>
			</td>
			<td>
				${customerRecord.customerRecordTarget.name}
			</td>
			<td>
				${customerRecord.comeInTime}
			</td>
			<td>
				${customerRecord.customerNum}人
			</td>
			<td>
				<c:if test="${customerRecord.status==2 }">
					<span style="color: red;">无效</span>
				</c:if>
				<c:if test="${customerRecord.status==1 }">
					<span style="color: green;">有效</span>
				</c:if>
			</td>
			<td>
				<c:if test="${empty(customerRecord.saler) }">
					-
				</c:if>
				<c:if test="${!empty(customerRecord.saler) }">
					${customerRecord.saler.realName }
				</c:if>
			</td>
			<td>
				<c:if test="${customerRecord.resultStatus==2 }">
					<span style="color: green;">转为登记</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==1 }">
					<span style="color: pink;">等待...</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==3 }">
					<span style="color: green;">已回访</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==4 }">
					<span style="color: red;">无效</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customerRecord.comeinNum==0 }">
					未到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==1 }">
					初次到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==2 }">
					二次来店
				</c:if>
			</td>
			<td>
				<c:if test="${customerRecord.overtimeStatus==1 }">
					<span>未超时</span>
				</c:if>
				<c:if test="${customerRecord.overtimeStatus==2 }">
					<span style="color: red">已超时</span>
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${customerRecord.resultStatus==1 }">
					<c:if test="${customerRecord.customerType.dbid==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/customerRecord/editComeShop?dbid=${customerRecord.dbid}'">编辑</a> 
					</c:if>
					<c:if test="${customerRecord.customerType.dbid==2 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/customerRecord/editPhone?dbid=${customerRecord.dbid}'">编辑</a> 
					</c:if>
					|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/customerRecord/delete?dbids=${customerRecord.dbid}&type=1','searchPageForm')" title="删除">删除</a>
				</c:if>
			</td> 
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>
