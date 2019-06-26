 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>背景音乐</title>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type"
			content="text/html; charset=utf-8" />
		<link href="${ctx }/css/common.css" type="text/css"
			rel="stylesheet" />
	</head>
<body>
<input type="hidden" name="backGroudMusicId" id="backGroudMusicId">
<br>
<c:if test="${empty(bakcBackGroundMusics)||bakcBackGroundMusics==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
		<tr>
			<td class="span4">歌名</td>
			<td  class="span2">歌手</td>
			<td class="span2">时长</td>
			<td class="span2">大小</td>
			<td class="span2">人气</td>
			<td class="span2"></td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${bakcBackGroundMusics }" var="backGroundMusic">
			<tr>
				<td style="text-align: left;">
					<label>
						<audio class='audio' id="myaudio${backGroundMusic.dbid }" src="${backGroundMusic.url}" controls="controls" loop="false" hidden="true" ></audio>
						<input type="radio"   name="id" id="id1" value="${backGroundMusic.dbid }" onclick="getBackGroudMusicId()" tips="${backGroundMusic.name }" ${bussiCard.backGroundMusic.dbid==backGroundMusic.dbid?'checked="checked"':'' }>
						&nbsp;&nbsp;
						${backGroundMusic.name }
					</label>
				</td>
				<td >${backGroundMusic.singer }</td>
				<td>
					<fmt:formatNumber value="${backGroundMusic.duration/60 }" pattern="0"/>:<fmt:formatNumber value="${backGroundMusic.duration%60 }" pattern="0"/>
				</td>
				<td>
					<fmt:formatNumber value="${backGroundMusic.size/(1024*1024) }" pattern="0.00"/>MB
				</td>
				<td>
					${backGroundMusic.useNum }
				</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit play" onclick="start(${backGroundMusic.dbid })" id='a${backGroundMusic.dbid }'>播放</a>
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
<script>
	/** 获取checkBox的value* */
	function getBackGroudMusicId() {
		var array = new Array();
		var arrayNames = new Array();
		var checkeds = $("input[type='radio'][name='id']");
		var j=0;
		$.each(checkeds, function(i, checkbox) {
			if (checkbox.checked) {
				array.push(checkbox.value);
				arrayNames.push($(checkbox).attr("tips"));
				j=j+1;
			}
		});
		if(j>1){
			alert("车架号只能选择一个");
			return;
		}
		$("#backGroudMusicId").val(array.toString()+"|"+arrayNames.toString());
	}
	function start(dbid){
		$("audio").each(function(i){
			this.currentTime = 0;
		 });
		$(".play").each(function(i){
			if($(this).attr("id")!="a"+dbid){
				$(this).text("播放");
			}
		 });
		var text=$("#a"+dbid).text();
		if(text.indexOf("播放")!=-1){
			$("#a"+dbid).text("停止");
			$('#myaudio'+dbid)[0].play();
		}else {
			$("#a"+dbid).text("播放");
			$('#myaudio'+dbid)[0].pause();
		}
	}
</script>
</html>
