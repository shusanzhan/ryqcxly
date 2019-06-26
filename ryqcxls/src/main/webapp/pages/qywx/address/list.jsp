<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common2.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/depCom.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/ztree/css/demo.css" type="text/css">
<link rel="stylesheet" href="${ctx }/widgets/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.all-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.core-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.excheck-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.exedit-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.exhide-3.4.min.js"></script>
<SCRIPT type="text/javascript">
		<!--
		var zTree, rMenu;
		var setting = {
				view: {
					dblClickExpand: false,
					fontCss: setFontCss
				},
				data: {
					simpleData: {
						enable: true
					}
				}
,
			check: {
				enable: false
			},
			callback: {
				onClick: onClick
			}
		};

		function onClick(event, treeId, treeNode, clickFlag) {
			if(null!=treeNode&&treeNode!=undefined){
				if(treeNode.level>0){
					$("#departmentId").val(treeNode.id);
					$('#searchPageForm')[0].submit();
				}
			}
		}
		function setFontCss(treeId, treeNode) {
			var departmentId=$("#departmentId").val();
			if(null!=departmentId&&departmentId!=undefined&&departmentId!=''){
				var obj={'color':'red','border':'1px #FFB951 solid','background-color':'#FFE6B0'} ;
				  return treeNode.id==departmentId ? obj : {};
			}
		}
		function dblClickExpand(treeId, treeNode) {
			return treeNode.level > 0;
		}
		function onBodyMouseDown(event){
			if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
				rMenu.css({"visibility" : "hidden"});
			}
		}
		var addCount = 1;
		
		function resetTree() {
			hideRMenu();
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		}
		function expandLevel(treeObj,node)  
        {  
			var parent=node.getParentNode();
			if(null!=parent){
                expandLevel(treeObj,parent);  
	            treeObj.expandNode(node, true, false, false);  
			}else{
	            treeObj.expandNode(node, true, false, false);  
			}
        }  
		$(document).ready(function(){
				//异步获取部门信息，每当点击右边功能菜单是自动刷新获取部门信息
				$.post("${ctx}/department/editResourceJson?timeStamp="+new Date(), { } ,function callback(json){  
				if(null!=json&&json!=1){
					$.fn.zTree.init($("#treeDemo"), setting, json);
					zTree = $.fn.zTree.getZTreeObj("treeDemo");
					var departmentId=$("#departmentId").val();
					var node2=zTree.getNodesByParam("id", departmentId, null);
					if(null!=node2&&node2!=undefined){
						var node=node2[0];
						if(node!=undefined){
							var id=node.id;
							if(id!=''&&id!=undefined){
								expandLevel(zTree,node);
							}
							zTree.updateNode(node);  
						}
					}
					rMenu = $("#rMenu");
				}else{
					var zNodes =[];
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					zTree = $.fn.zTree.getZTreeObj("treeDemo");
					rMenu = $("#rMenu");
					$("#treeDemo").append("<li>暂无部门信息！<br>点击右键添加部门信息！</li>");
				}
			});
		});
		//-->
	</SCRIPT>
	<style type="text/css">
	a{
		text-decoration: none;
	}
	.ztree li span.button.switch.level0 {visibility:hidden; width:1px;line-height: 24px;}
	.ztree li ul.level0 {padding:0; background:none;}
	  ul, li{
		margin: 0;padding: 0;border: 0;outline: 0;line-height: 32px;
	}
	div#rMenu {position:absolute; visibility:hidden; top:0; background-color: #4786C6;text-align: left;padding: 2px;}
	div#rMenu ul li{
		padding: 0;border: 0;outline: 0;
		margin: 1px 0;
		padding: 0 5px;
		cursor: pointer;
		list-style: none outside none;
		background-color: #66A0DF;
		color: white;
	}
	</style>
<title>部门维护</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);">微信通讯录</a>
</div>
 <!--location end-->
<div class="line2"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="synDataDepart()" style="float: left;">同步数据</a>
		<a class="but button" href="javascript:void();" onclick="synDataUserAttention()" style="float: left;">同步用户关注状态</a>
		<div id="errorMess1" style="float: left;display: none;" class="alert alert-error">正在同步数据，请稍后再试.....</div>
		<div id="errorMess2" style="float: left;display: none;" class="alert alert-error">请勿重复提交数据，正在同步数据，请稍后再试.....</div>
   </div>
	<div class="seracrhOperate">
	  		 <form name="searchPageForm" id="searchPageForm" action="${ctx}/address/queryList" method="post">
			<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<input type="hidden" id="departmentId" name="departmentId" value='${departmentId}'>
	  		<table cellpadding="0" cellspacing="0" class="searchTable" >
	  			<tr>
	  				<td class="formTableTdLeft" >同步状态:&nbsp;</td>
					<td>
						<select id="sysWeixinStatus" name="sysWeixinStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
							<option value="0">请选择...</option>
							<option value="1" ${param.sysWeixinStatus==1?'selected="selected"':'' } >未同步</option>
							<option value="2" ${param.sysWeixinStatus==2?'selected="selected"':'' } >已同步</option>
						</select>
					</td>
	  				<td class="formTableTdLeft" >关注状态:&nbsp;</td>
					<td>
						<select id="attentionStatus" name="attentionStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
							<option value="0">请选择...</option>
							<option value="1" ${param.attentionStatus==1?'selected="selected"':'' } >未关注</option>
							<option value="2" ${param.attentionStatus==2?'selected="selected"':'' } >已关注</option>
							<option value="3" ${param.attentionStatus==3?'selected="selected"':'' } >已禁用</option>
						</select>
					</td>
	  				<td><label>名称：</label></td>
	  				<td><input type="text" id="userName" name="userName" class="text small" value="${param.userName}"></input></td>
	  				<td><label>用户ID：</label></td>
	  				<td><input type="text" id="userId" name="userId" class="text small" value="${param.userId}"></input></td>
	  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
	   			</tr>
	   		</table>
	   		</form>
	   	</div>
	   <div style="clear: both;"></div>
	</div>
<div class="content_wrap"  style="margin-top: 20px;height: 450px;width: 100%;background-color: #F8F8F8">
	<div class="zTreeDemoBackground leftZ" style="position: absolute;bottom: 0;top: 100px;width: 240px;" >
		<ul id="treeDemo" class="ztree" style="width: 200px;"></ul>
	</div>
	<div style="left: 215px;position: absolute;width: 82%;bottom: 0;top: 105px;">
		<c:if test="${empty(page.result)||page.result==null }" var="status">
				<div class="alert alert-info">
					<strong>提示!</strong> 无用户信息！请点击“添加”按钮进行添加数据操作
				</div>
			</c:if>
			<c:if test="${status==false }">
			<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
			<thead class="TableHeader">
				<tr>
					<td class="span2">用户Id</td>
					<td class="span2">名字</td>
					<td class="span2">部门</td>
					<td class="span2">手机</td>
					<td class="span2">邮箱</td>
					<td class="span2">微信Id</td>
					<td class="span2">同步状态</td>
					<td class="span2">关注状态</td>
					<td class="span2">操作</td>
				</tr>
			</thead>
			<c:forEach var="user" items="${page.result }">
				<tr height="32" align="center">
					<td>${user.userId }</td>
					<td align="left" style="text-align: left;">${user.realName }&nbsp;&nbsp; ${user.staff.sex }</td>
					<td align="left" style="text-align: left;">${user.department.name }</td>
					<td align="left">${user.mobilePhone }</td>
					<td align="left">${user.email }</td>
					<td align="left">${user.wechatId }</td>
					<td align="left">
						<c:if test="${user.sysWeixinStatus==1}">
							<span style="color: red;">未同步</span>
						</c:if>
						<c:if test="${user.sysWeixinStatus==2}">
							<span style="color: green;">已同步</span>
						</c:if>
					</td>
					<td align="left">
						<c:if test="${user.attentionStatus==1}">
							<span style="color: red;">未关注</span>
						</c:if>
						<c:if test="${user.attentionStatus==2}">
							<span style="color: green;">已关注</span>
						</c:if>
						<c:if test="${user.attentionStatus==3}">
							<span style="color: red;">已禁用</span>
						</c:if>
					</td>
					<td>
						<c:if test="${!empty(user.wechatId) }">
							<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/address/synSingleUser?dbid=${user.dbid }','searchPageForm','确定同步用户资料信息吗？')">同步</a>
							<c:if test="${user.sysWeixinStatus==2}">
								|
								<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/address/synSingleAtt?dbid=${user.dbid }','searchPageForm','确定更新关注状态？')">更新状态</a>
							</c:if>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</table>
			<div id="fanye">
				<%@ include file="../../commons/commonPagination.jsp" %>
			</div>
			</c:if>
	</div>
</div>
</body>
<script type="text/javascript">
    var status=1;
	function synDataDepart(){
		if(status==2){
			$("#errorMess1").hide();
			return ;
		}
		status=2;
		$("#errorMess1").show();
		$.post('${ctx}/address/synDataDepartment',{},function (data){
			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
				$.utile.tips(data[0].message+",正在同步用户数据！");
				$.post('${ctx}/address/synUser',{},function (data){
					if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
						$.utile.tips(data[0].message+"");
						status=1;
						location.reload() 
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
						$.utile.tips(data[0].message);
						status=1;
						$("#errorMess1").hide();
						location.reload() 
					}
				})
			}
			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
				$.utile.tips(data[0].message);
				// 保存失败时页面停留在数据编辑页面
			}
		})
	}
	function synDataUserAttention(){
		if(status==2){
			$("#errorMess2").show();
			$("#errorMess1").hide();
			return ;
		}
		status=2;
		$("#errorMess1").show();
		$.post('${ctx}/address/synDataUserAttention',{},function (data){
			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
				$.utile.tips(data[0].message+",同步数据成功！");
				$("#errorMess2").hide();
				$("#errorMess1").hide();
				location.reload();
			}
			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
				$.utile.tips(data[0].message);
				$("#errorMess2").hide();
				$("#errorMess1").hide();
				location.reload() 
				// 保存失败时页面停留在数据编辑页面
			}
		})
	}
</script>
</html>