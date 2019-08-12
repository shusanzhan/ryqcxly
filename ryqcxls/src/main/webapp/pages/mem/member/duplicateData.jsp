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
  		<a class="but butCancle" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   	</div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">姓名</td>
			<td class="span2">微信Id</td>
			<td class="span1">性别</td>
			<td class="span2">生日</td>
			<td class="span2">常用手机号</td>
			<td class="span2">有车情况</td>
			<td class="span2">创建日期</td>
			<td class="span2">当前积分</td>
			<td class="span2">已消费积分</td>
			<td class="span2">可用积分</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="member" items="${members}">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${member.dbid }"/></td>
			<td>
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${member.name }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memMember/pointRecordDetail?memberId=${member.dbid}&selectType=0'">会员积分明细</a></li>
					      <li><a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/memMember/edit?dbid=${member.dbid}'">编辑</a></li>
					      
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/memberTrack/add?memberId=${member.dbid }','添加跟进记录',900,500)">添加跟进记录</a> </li>
					     <!--  <li><a href="javascript:void(-1)">追踪记录</a></li> -->
					    </ul>
					  </div>
				</div>
			</td>
			<td>${member.microId }</td>
			<td>${member.sex }</td>
			<td><fmt:formatDate value="${member.birthday }" pattern="yyyy年MM月dd日"/> </td>
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
				${member.totalPoint }
			</td>
			<td>
				${member.consumpiontPoint }
			</td>
			<td>
				${member.overagePiont }
			</td>
			<td>
				<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.deleteById('${ctx }/memMember/delete?dbids=${member.dbid}&type=2')">删除</a>
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
</script>
</html>