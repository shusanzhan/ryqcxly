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
<title>会员管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">会员管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
     </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/memMember/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>会员级别：</label></td>
  				<td>
  					<select class="text midea" id="memberShipLevelId" name="memberShipLevelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="memberShipLevel" items="${memberShipLevels }">
							<option value="${memberShipLevel.dbid }" ${param.memberShipLevelId==memberShipLevel.dbid?'selected="selected"':'' } >${memberShipLevel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>有车情况：</label></td>
  				<td>
  					<select class="text midea" id="hasCar" name="hasCar"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
							<option value="1" ${param.hasCar==1?'selected="selected"':'' } >我有奇瑞汽车</option>
							<option value="2" ${param.hasCar==2?'selected="selected"':'' } >我没车</option>
							<option value="3" ${param.hasCar==3?'selected="selected"':'' } >我有车</option>
					</select>
  				</td>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text midea" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text midea" value="${param.mobilePhone}"></input></td>
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
			<td class="span2">姓名</td>
			<td class="span2">级别</td>
			<td class="span2">常用手机号</td>
			<td class="span2">有车情况</td>
			<td class="span2">创建日期</td>
			<td class="span2">可用积分</td>
			<td class="span2">优惠券(张)</td>
			<td class="span2">余额</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="member" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${member.dbid }"/></td>
			<td>
					<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memMember/information?dbid=${member.dbid}&type=1'" >${member.name }</a>
			</td>
			<td>${member.memberShipLevel.name }</td>
			<td>${member.mobilePhone }</td>
			<td>
				<c:if test="${member.hasCar==1 }">
					我有奇瑞汽车
				</c:if>
				<c:if test="${member.hasCar==2 }">
					我没车
				</c:if>
				<c:if test="${member.hasCar==3 }">
					我有车
				</c:if>
			</td>
			<td><fmt:formatDate value="${member.createTime }" pattern="yyyy年MM月dd日 HH:mm"/> </td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memMember/information?dbid=${member.dbid}&type=4'" >${member.overagePiont }</a>
			</td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memMember/information?dbid=${member.dbid}&type=3'" >
					<ystech:couponMemberCountTag memberId="${member.dbid }"/>
				</a>
			</td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memMember/information?dbid=${member.dbid}&type=2'" >
					<ystech:urlEncrypt enCode="${member.balance}"/> 
				</a>
			</td>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/pointRecord/add?memberId=${member.dbid }&directType=1','调整积分',900,500)">调整积分</a>|
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/storeMoneyRecord/add?dbid=${member.dbid }&directType=1','会员储值',1024,520)">储值</a>
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
</script>
</html>