<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>经纪人</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">经纪人</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/agent/delete','searchPageForm')">删除</a>
		<a class="but butSave" href="javascript:void(-1);" onclick="exportExcel('searchPageForm')">导出EXCEL</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/agent/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
                <td>
                   推荐权限
                </td>
                 <td>
                 	<select id="agentStatus" name="agentStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.agentStatus==1?'selected="selected"':'' } >未开启</option>
						<option value="2" ${param.agentStatus==2?'selected="selected"':'' } >已开启</option>
					</select>
                </td>
                <td>
                    经纪人姓名：
                </td>
                <td>
                    <input name="name" type="text" id="name" value="${param.name }" class="text midea"/>
                </td>
                <td>
                   经纪人联系电话：
                </td>
                 <td>
                    <input name="mobilePhone" type="text" id="mobilePhone" value="${param.mobilePhone }"  class="text midea"/>
                </td>
               </tr>
               <tr>
               <td>
                  昵称：
                </td>
                 <td>
                    <input name="nickname" type="text" id="nickname" value="${param.nickname }"  class="text midea"/>
                </td>
                <td>
                   入会日期：
                </td>
                <td>
  					<input type="text" id="startDate" name="startDate" class="text small" value="${param.startDate}" onfocus="WdatePicker()"></input>
  				</td>
  				<td style="text-align:center; "><label>~</label></td>
  				<td>
  					<input type="text" id="endDate" name="endDate" class="text small" value="${param.endDate}" onfocus="WdatePicker()"></input>
				</td> 
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
			</tr>
		 </table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
		<tr>
			<td class="sn">
					<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
			</td>
			<td class="span2">名称</td>
			<td class="span2">联系电话</td>
			<td class="span3">省（直辖市）-市-区</td>
			<td class="span2">收款账户类型</td>
			<td class="span3">收款账户</td>
			<td class="span2">邮箱地址</td>
			<td class="span2">推荐人数</td>
			<td class="span2">成功人数</td>
			<td class="span2">入会时间</td>
			<td class="span2">创建日期</td>
			<td class="span2">推荐权限状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="agent">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${agent.dbid }">
				</td>
				<td >
				<a style="color:#2b7dbc " href="${ctx }/agent/agentFile?dbid=${agent.dbid}&type=1" onclick="">
					${agent.name }（${agent.sex }）
				</a>
				</td>
				<td >${agent.mobilePhone }</td>
				<td style="text-align: left;">
					${agent.province }
					${agent.city }
					${agent.areaStr }
				</td>
				<td>
					${agent.bank }
				</td>
				<td>
					${agent.bankNo }
				</td>
				<td>
					${agent.email }
				</td>
				<td>
					<a style="color:#2b7dbc " href="${ctx }/agent/agentFile?dbid=${agent.dbid}&type=2" onclick="">
						${agent.agentNum }
					</a>
				</td>
				<td>
					<span style="color: red;font-size: 14px;">${agent.agentSuccessNum }</span>
				</td>
				<td>
					${agent.applyDate }
				</td>
				<td>
					${agent.createDate }
				</td>
				<td>
					<c:if test="${agent.agentStatus==1 }">
						<span style="color: red">未开启</span>
					</c:if>
					<c:if test="${agent.agentStatus==2 }">
						<span style="color: green;">已开启</span>
					</c:if>
				</td>
				<td style="text-align: center;">
					<c:if test="${agent.agentStatus==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/agent/stopOrStart?dbid=${agent.dbid}','searchPageForm','您确定【${agent.name}】开启推荐权限吗')" title="启用">启用</a>
					</c:if>
					<c:if test="${agent.agentStatus==2 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/agent/stopOrStart?dbid=${agent.dbid}','searchPageForm','您确定【${agent.name}】停用推荐权限吗')" title="停用">停用</a>
					</c:if>
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/agent/delete?dbids=${agent.dbid}','searchPageForm')" title="删除">删除</a>
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
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/agent/download?'+params;
 }
</script>
</html>
