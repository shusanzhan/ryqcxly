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
<title>证件类型管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">证件类型管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/storeMoneyRecord/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
		   		<tr>
	  				<td><label>操作员：</label></td>
	  				<td>
	  					<input type="text" id="creator" name="creator" class="text midea" value="${param.creator}"></input>
	  				</td>
	  				<td><label>储值时间：</label></td>
	  				<td>
	  					<input class="midea text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
					</td>
	  				<td>结束：</td>
	  				<td>
	  					<input class="midea text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
	  				</td>
	  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
		   		</tr>
   			</table>
   		</form>
   	</div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-error">
		<strong>提示!</strong> 会员无储值记录
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span1">会员</td>
			<td class="span1">实际缴费</td>
			<td class="span1">储值金额</td>
			<td class="span1">付款方式</td>
			<td class="span3">储值说明</td>
			<td class="span3">备注</td>
			<td class="span1">储值时间</td>
			<td class="span1">创建人</td>
			<td class="span1">状态</td>
			<td class="span1">操作</td>
		</tr>
	</thead>
	<c:forEach var="storeMoneyRecord" items="${page.result }">
			<tr>
				<td>
					${storeMoneyRecord.member.name }
			    </td>
				<td>
					<ystech:urlEncrypt enCode="${storeMoneyRecord.actMoney}"/> 
			    </td>
				<td style="text-align: center;">
					<ystech:urlEncrypt enCode="${storeMoneyRecord.rechargeMoney }"/> 
				</td>
				<td style="text-align: center;">
					<c:if test="${storeMoneyRecord.payWay==1 }">
						现金充值							
					</c:if>
					<c:if test="${storeMoneyRecord.payWay==2 }">
						刷卡储值
					</c:if>
				</td>
				<td>
					${storeMoneyRecord.rechargeExplain }
				</td>
			    <td style="text-align: center;">
					${storeMoneyRecord.note }
				</td>
				<td style="text-align: center;">
					<fmt:formatDate value="${storeMoneyRecord.createTime}" pattern="yyyy-MM-dd"/>
				</td>
			    <td style="text-align: center;">
					${storeMoneyRecord.user.realName }
				</td>
				<td style="text-align: center;">
					<c:if test="${storeMoneyRecord.status==1 }">
						<span style="color: green;">成功</span>							
					</c:if>
					<c:if test="${storeMoneyRecord.status==2 }">
						<span style="color: red;">作废</span>
					</c:if>
				</td>
			    <td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/storeMoneyRecord/print?dbid=${storeMoneyRecord.dbid }&type=2'">查看</a>&nbsp;|
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/storeMoneyRecord/print?dbid=${storeMoneyRecord.dbid }&type=1'">打印</a>
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
	window.location.href='${ctx}/storeMoneyRecord/exportExcel?'+params;
}
</script>
</html>