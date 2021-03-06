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
<title>备案经纪人</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">备案经纪人</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/memMember/add'">添加</a> --%>
		<c:if test="${sessionScope.user.userId=='admin' }">
			<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/memMember/duplicateData'">重复数据</a>
		</c:if>
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/memMember/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/memMember/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>经纪人权限：</label></td>
  				<td>
  					<select class="text small" id="agentStatus" name="agentStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.agentStatus==1?'selected="selected"':'' } >未开启</option>
						<option value="2" ${param.agentStatus==2?'selected="selected"':'' } >已开启</option>
					</select>
  				</td>
  				<td><label>昵称：</label></td>
  				<td><input type="text" id="nickName" name="nickName" class="text small" value="${param.nickName}"></input></td>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td><label>注册日期：</label></td>
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
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span3">姓名</td>
			<td class="span2">微信</td>
			<td class="span2">级别</td>
			<td class="span2">当前积分</td>
			<td class="span2">经销商</td>
			<td class="span1">推荐人</td>
			<td class="span1">推荐量</td>
			<td class="span1">成功量</td>
			<td class="span1">经纪人权限</td>
			<td class="span1">经纪人类型</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="member" items="${page.result }">
		<c:set value="${member.weixinGzuserinfo }" var="weixinGzuserinfo"></c:set>
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${member.dbid }"/></td>
			<td>
				<img alt="" src="${weixinGzuserinfo.headimgurl }" height="50" width="50" style="float: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)" style="float: left;">
					${member.name }（${member.sex }）
					<br>
					${member.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li><a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memMember/information?dbid=${member.dbid}&type=1'" >经纪人明细</a></li>
					      <li><a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/memMember/edit?dbid=${member.dbid}'">编辑</a></li>
					    </ul>
					  </div>
				</div>
			</td>
			<td style="text-align:left;">
				${weixinGzuserinfo.nickname }
				<c:if test="${weixinGzuserinfo.eventStatus==1 }">
					<span style="color: green">关注</span>
				</c:if>
				<c:if test="${weixinGzuserinfo.eventStatus==2 }">
					<span style="color: red;">取消</span>
				</c:if>
				<c:if test="${member.memType==1 }">
					<span style="color: red;">员工</span>
				</c:if>
				<br>
				<fmt:formatDate value="${member.createTime }" pattern="yyyy-MM-dd hh:mm"/>
			</td>
			<td>${member.memberShipLevel.name }</td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memMember/information?dbid=${member.dbid}&type=4'" >${member.totalPoint }</a>
			</td>
			<td>
				${member.enterprise.name }
			</td>
			<td>
				<c:if test="${empty(member.parent) }">
					无推荐人
				</c:if>
				<c:if test="${!empty(member.parent)}">
					${member.parent.name }
				</c:if>
			</td>
			<td>
				${member.agentNum }
			</td>
			<td>
				${member.agentSuccessNum }
			</td>
			<td>
				<c:if test="${member.agentStatus==1||empty(member.agentStatus) }">
					<span style="color: red;">未开启</span>|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/memMember/stopOrStartAgent?memberId=${member.dbid}','searchPageForm','您确定【${member.name}】开启推荐权限吗')" title="启用">启用</a>
				</c:if>
				<c:if test="${member.agentStatus==2 }">
					<span style="color: green">已开启</span>|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/memMember/stopOrStartAgent?memberId=${member.dbid}','searchPageForm','您确定【${member.name}】停用推荐权限吗')" title="停用">停用</a>
				</c:if>
				<br>
				层级:${member.level } 引流:${member.totalNum } 
			</td>
			<td>
				${member.spread.name }
			</td>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/pointRecord/add?memberId=${member.dbid }&directType=3','调整积分',900,500)">调整积分</a>|
				<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.deleteById('${ctx }/memMember/delete?dbids=${member.dbid}&type=1')">删除</a>
			</td>
		</tr>
	</c:forEach>
</table>
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
	 function exportExcel(searchFrm){
			var params;
			if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
				params=$("#"+searchFrm).serialize();
			}
			window.location.href='${ctx}/memMember/exportExcel?'+params;
		}
</script>
</html>