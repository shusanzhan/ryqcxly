//清除样式
function clearClass(divId){
	$("#"+divId).find(".error").each(function(i){
		$(this).removeClass("error");
	})
	$("#"+divId).find(".success").each(function(i){
		$(this).removeClass("success");
	})
}
//操作提示信息
function showMessage(message){
	var d = dialog({
	    content: message
	});
	d.show();
	setTimeout(function () {
	    d.close().remove();
	}, 2000);
}
//radio取值
function  getRadioBoxValue(ifram) 
{ 
    var obj = ifram.document.getElementsByName("weixinKeyWordRole.matchingType");  //这个是以标签的name来取控件
         for(i=0; i<obj.length;i++)    {
          if(obj[i].checked)    { 
              return   obj[i].value; 
          } 
      }         
     return undefined;       
}
function bindClick(){
	//关注状态选择
	$(".js-filter-quickday li").each(function(index){
		  $(this).click(function(){
			  var cla=$(this).attr("class");
			  //点击选择
			  if(cla==undefined||cla==''){
				  $(".js-filter-quickday .active").removeClass("active");
				  var data_tag=$(this).attr("data-tag");
				  $("#quickday").val(data_tag);
				  $(this).addClass("active");
			  }else{
				//移除样式
				$(this).removeClass("active");
				$("#quickday").val("-1m");
			  }
		  })
	})
}
//创建
function edit(url,title,dbid){
	var d = dialog({
	    title:title==undefined?'添加':title,
	    fixed: false,
	    url: url,
	    width:'640px',
	    okValue: '确定',
	    ok: function () {
	    	var iframeWindow = this.iframeNode.contentWindow; 
	    	var frmObj=$(iframeWindow.document.getElementById('frmId'));
	    	var params=$(frmObj).serialize();
			var validata = validateFormObj(frmObj);
			if (validata == true) {
		    	$.post("${ctx}/staAssessmentIndex/save",params,function callBack(data) {
		    		if(null!=dbid&&undefined!=dbid){
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var html=data[0].url; 
		    				$("#rule-group"+dbid).text("");
		    				$("#rule-group"+dbid).prepend(html);
		    				showMessage(data[0].message);
		    				d.close();
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage("更新数据失败");
		    			}
		    		}else{
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var html=data[0].url; 
		    				$("#js-rule-container").prepend(html);
		    				showMessage(data[0].message);
		    				d.close();
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage("添加数据失败");
		    			}
		    			var ruleLength=$(".rule-id").length;
		    			$(".rule-id").foreach(function (i){
		    				$(this).text(i+1);
		    			})
		    		}
				});
			}else{
				return false;
			}
	    	 return false;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show();
}
/**
 * 启用或停用
 * @param dbid
 * @param status
 */
function deleteSta(dbid){
	var content="确定删除该指标吗？";
	var d = dialog({
	    title: '提示',
	    content: content,
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post("/staAssessmentIndex/delete?dbids="+dbid+"&datetime=" + new Date(),{},function callBack(data) {
    			if (data[0].mark == 1) {// 删除数据失败时提示信息
    				showMessage(data[0].message);
    			}
    			if (data[0].mark == 0) {// 删除数据成功提示信息
    				showMessage("操作成功");
					$("#rule-group"+dbid).remove();
    			}
	    	})
	    	return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('js-disable-rule'+dbid));
}

//创建编辑关键词
function editStaLevel(staAssessmentIndexId,dbid,title){
	var url='/staAssessmentIndexLevel/edit?staAssessmentIndexId='+staAssessmentIndexId;
	if(null!=dbid&&undefined!=dbid&&dbid!=''){
		url=url+"&dbid="+dbid;
	}
	var d = dialog({
		title:title==undefined?'添加':title,
		fixed: false,
	    url: url,
	    width:'760px',
	    okValue: '确定',
	    ok: function () {
	    	var iframeWindow = this.iframeNode.contentWindow; 
	    	var frmObj=$(iframeWindow.document.getElementById('frmId'));
	    	var params=$(frmObj).serialize();
			var validata = validateFormObj(frmObj);
			if (validata == true) {
				var beginNum=iframeWindow.document.getElementById('beginNum').value;
				var endNum=iframeWindow.document.getElementById('endNum').value;
				beginNum=parseInt(beginNum);
				endNum=parseInt(endNum);
				if(beginNum>endNum){
					showMessage("初始值大于结束值，请确认");
					return false;
				}
		    	$.post("${ctx}/staAssessmentIndexLevel/save",params,function callBack(data) {
		    		if(null!=dbid&&undefined!=dbid&&dbid!=''){
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var html=data[0].url; 
		    				$("#reply-list"+staAssessmentIndexId+""+dbid).text("");
		    				$("#reply-list"+staAssessmentIndexId+""+dbid).append(html);
		    				showMessage(data[0].message);
		    				d.close();
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage(data[0].message);
		    			}
		    		}else{
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var html=data[0].url; 
		    				$("#reply-list"+staAssessmentIndexId).append(html);
		    				$("#info"+staAssessmentIndexId).hide();
		    				showMessage(data[0].message);
		    				d.close();
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage(data[0].message);
		    			}
		    			var li=$("#reply-list"+staAssessmentIndexId).find("li");
		    			var length=li.length;
						if(length<=0){
							 var info=$("#info"+staAssessmentIndexId+" .info");
							 info.show();
						}
						if(length<3){
							$("#js-add-reply"+staAssessmentIndexId).show();
							$("#disable-opt"+staAssessmentIndexId).hide();
						}
						if(length>=3){
							$("#js-add-reply"+staAssessmentIndexId).hide();
							$("#disable-opt"+staAssessmentIndexId).show();
						}
		    		}
				});
			}else{
				return false;
			}
	    	return false;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('js-add-reply'));
}
/**
* 删除自动回复
* @param weixinKeyWordRoleId
* @param dbid
*/
function deleteStaLevel(staAssessmentIndexId,dbid){
	var d = dialog({
	    title: '提示',
	    content: '确定删除指标等级吗？',
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post("/staAssessmentIndexLevel/delete?dbids="+dbid+"&datetime=" + new Date(),{},function callBack(data) {
	    		if (data[0].mark == 1) {// 删除数据失败时提示信息
	    			showMessage('删除数据失败');
	    			return false;
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					showMessage("删除数据成功");
					$("#reply-list"+staAssessmentIndexId+dbid).remove();
					var li=$("#reply-list"+staAssessmentIndexId).find("li");
	    			var length=li.length;
					if(length<=0){
						 var info=$("#info"+staAssessmentIndexId+" .info");
						 info.show();
					}
					if(length<3){
						$("#js-add-reply"+staAssessmentIndexId).show();
						$("#disable-opt"+staAssessmentIndexId).hide();
					}
					if(length>=3){
						$("#js-add-reply"+staAssessmentIndexId).show();
						$("#disable-opt"+staAssessmentIndexId).hide();
					}
					return false;
				}
	    	})
	       
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('js-delete-reply'+staAssessmentIndexId+dbid));
}


