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
//创建二维码
function editSpreadDetail(dbid){
	var url='/spreadDetail/edit';
	if(null!=dbid&&undefined!=dbid){
		url='/spreadDetail/edit?dbid='+dbid;
	}
	var d = dialog({
	    title: '创建二维码',
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
		    	$.post("${ctx}/spreadDetail/save",params,function callBack(data) {
		    		if(null!=dbid&&undefined!=dbid){
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var obj=data[0].url; 
		    				obj=$.parseJSON(obj);
		    				$("#rule-name"+dbid).text(obj.name);
		    				$("#spreadDetailSpread"+dbid).text("渠道："+obj.groupName);
		    				$("#spreadDetailspreadGroup"+dbid).text("分组："+obj.spreadName);
		    				showMessage(data[0].message);
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage("更新数据失败");
		    			}
		    		}else{
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var html=data[0].url; 
		    				$("#js-rule-container").prepend(html);
		    				showMessage(data[0].message);
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage("添加数据失败");
		    			}
		    		}
				});
			}else{
				return false;
			}
	    	 return true;
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
function setAvailable(dbid,status){
	var content="";
	if(status==1){
		content="确定将该二维码设置为无效吗？";
	}
	if(status==2){
		content="确定启用该二维码吗？";
	}
	var d = dialog({
	    title: '提示',
	    content: content,
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post("/spreadDetail/available?dbids="+dbid+"&datetime=" + new Date(),{},function callBack(data) {
    			if (data[0].mark == 1) {// 删除数据失败时提示信息
    				showMessage("操作失败");
    			}
    			if (data[0].mark == 0) {// 删除数据成功提示信息
    				showMessage("操作成功")
    				if(status==1){
    					$("#rule-body"+dbid).hide();
    					$("#operatorIn"+dbid).hide();
    					$("#operatorNot"+dbid).show();
    				}
    				if(status==2){
    					$("#rule-body"+dbid).show();
    					$("#operatorIn"+dbid).show();
    					$("#operatorNot"+dbid).hide();
    				}
    			}
	    	})
	    	return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	if(status==1){
		d.show(document.getElementById('js-disable-rule'+dbid));
	}
	if(status==2){
		d.show(document.getElementById('js-disable-rule2'+dbid));
	}
}

//创建编辑关键词
function editKey(dbid,spreadDetailId){
	var url='/weixinKeyWordRole/editSpread?spreadDetailId='+spreadDetailId;
	if(null!=dbid&&undefined!=dbid&&dbid!=''){
		url='/weixinKeyWordRole/editSpread?dbid='+dbid+"&spreadDetailId="+spreadDetailId;
	}
	var d = dialog({
		fixed: false,
	    url: url,
	    width:'340px',
	    okValue: '确定',
	    ok: function () {
	    	var iframeWindow = this.iframeNode.contentWindow; 
	    	var frmObj=$(iframeWindow.document.getElementById('frmId'));
	    	var params=$(frmObj).serialize();
			var validata = validateFormObj(frmObj);
			var keyword=iframeWindow.document.getElementById('keyword').value;
			var matchingType=getRadioBoxValue(iframeWindow);
			if (validata == true) {
		    	$.post("${ctx}/weixinKeyWordRole/saveEditSpread",params,function callBack(data) {
		    		if(null!=dbid&&undefined!=dbid&&dbid!=''){
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var obj=data[0].url; 
		    				var span=$("#keyword"+spreadDetailId+""+dbid).find("span");
		    				$(span[0]).text(keyword);
		    				if(matchingType=="1"){
		    					$(span[1]).text("全匹配");
		    				}
		    				if(matchingType=="2"){
		    					$(span[1]).text("模糊匹配");
		    				}
		    				showMessage(data[0].message);
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage(data[0].message);
		    			}
		    		}else{
		    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
		    				var html=data[0].url; 
		    				$("#keyword-list"+spreadDetailId).append(html);
		    				showMessage(data[0].message);
		    			}
		    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
		    				showMessage(data[0].message);
		    			}
		    		}
				});
			}else{
				return false;
			}
	    	 return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	if(null!=dbid&&undefined!=dbid&&dbid!=''){
		d.show(document.getElementById('keyword'+spreadDetailId+dbid));
	}else{
		d.show(document.getElementById('editKey'+spreadDetailId+dbid));
	}
}
//删除
function deleteKey(dbid,spreadDetailId){
	var d = dialog({
	    title: '提示',
	    content: '确定删除关键词吗？',
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post("/weixinKeyWordRole/deleteKeyWord?dbids="+dbid+"&datetime=" + new Date(),{},function callBack(data) {
	    		if (data[0].mark == 1) {// 删除数据失败时提示信息
	    			dialog({
	    			    content: '删除数据失败'
	    			}).show();
	    			return false;
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					showMessage("删除数据成功");
					$("#keyword"+spreadDetailId+""+dbid).remove();
					return false;
				}
	    	})
	       
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('keyword'+spreadDetailId+dbid));
}

//////////////////////////////设置等级////////////////////////////
//编辑渠道
function editMemberShipLevel(dbid){
	$.post("${ctx}/spreadDetail/ajaxMemberShipLevel?dbid="+dbid+"&date="+new Date(),{},function(data){
		var text='<div class="frmContent" >'+
			'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
			'<input type="hidden" name="spreadDetail.dbid" id="dbid" value="'+dbid+'">'+
			'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
				'<tr height="42">'+
					'<td class="formTableTdLeft">等级:&nbsp;</td>'+
					'<td>'+data+'</td>'+
				'</tr>'+
			'</table>'+
		'</form>'+
		'</div>';
		var d = dialog({
		    title: '设置渠道',
		    fixed: false,
		    content: text,
		    okValue: '确定',
		    ok: function () {
		    	var frmId="frmIdN";
		    	if (undefined != frmId && frmId != "") {
					var validata = validateForm(frmId);
					if (validata == true) {
						var params = getParam(frmId);
				    	$.post("${ctx}/spreadDetail/saveMemberShipLevel",params,function callBack(data) {
							if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
								var message=data[0].url; 
								$("#level-containerinfo"+dbid).hide();
								$("#level-list"+dbid).text("");
								$("#level-list"+dbid).append(message);
								showMessage("编辑数据成功");
							}
							if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
								showMessage("编辑数据失败");
							}
						});
					}
		    	}
		    	 return true;
		    },
		    cancelValue: '取消',
		    cancel: function () {}
		});
		d.show(document.getElementById('js-edit-level'+dbid));
	})
}

function deleteMemberShipLevel(dbid){
	var d = dialog({
	    title: '提示',
	    content: '确定删除会员等级吗？',
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post("/spreadDetail/deleteMemberShipLevel?dbid="+dbid+"&datetime=" + new Date(),{},function callBack(data) {
	    		if (data[0].mark == 1) {// 删除数据失败时提示信息
	    			showMessage('删除数据失败');
	    			return false;
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					showMessage("删除数据成功");
					$("#level-list"+dbid).text("");
					$("#level-containerinfo"+dbid).show();
					return false;
				}
	    	})
	       
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('level-list'+dbid));
}
//////////////////////////////渠道操作//////////////////////////
//添加渠道
function addSpread(){
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
		'<input type="hidden" name="spread.dbid" id="dbid" value="">'+
		'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
			'<tr height="42">'+
				'<td class="formTableTdLeft">名称:&nbsp;</td>'+
				'<td ><input type="text" name="spread.name" id="name" value="" class="largex text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>'+
			'</tr>'+
			'<tr height="32">'+
			'	<td class="formTableTdLeft">备注:&nbsp;</td>'+
			'	<td>'+
			'		<textarea class="text textarea"  name="spread.note" id="note" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内"></textarea>'+
			'	</td>'+
		'	</tr>'+
		'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
	    title: '创建渠道',
	    fixed: false,
	    content: text,
	    okValue: '确定',
	    width:500,
	    ok: function () {
	    	var frmId="frmIdN";
	    	if (undefined != frmId && frmId != "") {
				var validata = validateForm(frmId);
				if (validata == true) {
					var params = getParam(frmId);
			    	$.post("${ctx}/memSpread/save",params,function callBack(data) {
						if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
							var message=data[0].message; 
							$("#spreadDiv").append(message);
							showMessage("添加数据成功");
						}
						if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
							showMessage("添加数据失败");
						}
					});
				}
	    	}
	    	 return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show();
}
//编辑渠道
function editSpread(dbid){
	$.post("${ctx}/memSpread/ajaxEdit?dbid="+dbid+"&date="+new Date(),{},function(data){
		var text='<div class="frmContent" >'+
			'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
			'<input type="hidden" name="spread.dbid" id="dbid" value="'+data.dbid+'">'+
			'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
				'<tr height="42">'+
					'<td class="formTableTdLeft">名称:&nbsp;</td>'+
					'<td ><input type="text" name="spread.name" id="name" value="'+data.name+'" class="largex text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>'+
				'</tr>'+
				'<tr height="32">'+
				'	<td class="formTableTdLeft">备注:&nbsp;</td>'+
				'	<td>'+
				'		<textarea class="text textarea"  name="spread.note" id="note" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">'+data.note+'</textarea>'+
				'	</td>'+
			'	</tr>'+
			'</table>'+
		'</form>'+
		'</div>';
		var d = dialog({
		    title: '编辑渠道',
		    fixed: false,
		    content: text,
		    okValue: '确定',
		    width:500,
		    ok: function () {
		    	var frmId="frmIdN";
		    	if (undefined != frmId && frmId != "") {
					var validata = validateForm(frmId);
					if (validata == true) {
						var params = getParam(frmId);
				    	$.post("${ctx}/memSpread/save",params,function callBack(data) {
							if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
								var message=data[0].message; 
								$("#spread"+dbid).text(message);
								showMessage("编辑数据成功");
							}
							if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
								showMessage("编辑数据失败");
							}
						});
					}
		    	}
		    	 return true;
		    },
		    cancelValue: '取消',
		    cancel: function () {}
		});
		d.show();
	})
}
//删除分组
function deleteSpread(url,id){
	var d = dialog({
	    title: '提示',
	    content: '确定删除该渠道吗？',
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post(url + "&datetime=" + new Date(),{},function callBack(data) {
	    		if (data[0].mark == 1) {// 删除数据失败时提示信息
	    			var d=dialog({
	    			    content: data[0].message
	    			}).show();
	    			setTimeout(function () {
	    			    d.close().remove();
	    			}, 2000);
	    			return false;
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					showMessage("删除数据成功");
					$("#spreadDiv"+id).remove();
					return false;
				}
	    	})
	       
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show();
}
//////////////////////////////分组操作//////////////////////////
//添加分组
function addSpreadGroup(spreadId){
	var em=$("#divSpreadGroupId");
	$("#spreadGroupName").val("");
	$("#spreadGroupNote").val("");
	clearClass("spreadGroupId");
	var d = dialog({
		align: 'bottom',
	    title: '创建分组',
	    fixed: false,
	    content: em,
	    okValue: '确定',
	    ok: function () {
	    	var spreadGroupNote=$("#spreadGroupNote").val();
	    	var frmId="frmId2";
	    	if (undefined != frmId && frmId != "") {
				var validata = validateForm(frmId);
				if (validata == true) {
					var spreadGroupName=$("#spreadGroupName").val();
					var params = getParam(frmId)+"&spreadId="+spreadId;
					$.post("${ctx}/memSpread/saveSpreadGroup",params,function callBack(data) {
						if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
							var groupStr='<div class="keyword input-append" id="'+data[0].params+'">'+
									'<a href="javascript:;" class="close--circle" onclick="deleteSpreadGroup(\'${ctx}/memSpread/deleteSpreadGroup?dbids='+data[0].params2+'\','+data[0].params+')">×</a>'+
									'<span style="color: #000;font-size:12px;">'+spreadGroupName+'</span>'+
									'</div>';
							$("#spreadDetail"+spreadId).append(groupStr);
							showMessage("添加数据成功");
						}
						if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
							showMessage("添加数据失败");
						}
					});
				} else {
				}
			} 
	        return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show();
}
//编辑分组
function eidtSpreadGroup(spreadId,groupId){
	var em=$("#spreadGroupId"+spreadId+groupId);
	clearClass("spreadGroupId");
	var d = dialog({
		align: 'bottom',
	    title: '编辑分组',
	    fixed: false,
	    content: em,
	    okValue: '确定',
	    ok: function () {
	    	var frmId="frmId"+spreadId+groupId;
	    	if (undefined != frmId && frmId != "") {
				var validata = validateForm(frmId);
				if (validata == true) {
					var params = getParam(frmId);
					var spreadGroupName=$("#spreadGroupName"+spreadId+groupId).val();
					$.post("${ctx}/memSpread/saveSpreadGroup",params,function callBack(data) {
						if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
							$("#"+spreadId+groupId+"Name").text("");
							$("#"+spreadId+groupId+"Name").text(spreadGroupName);
							showMessage("编辑数据成功");
						}
						if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
							showMessage("编辑数据失败");
						}
					});
				} else {
				}
			} 
	        return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show();
}

//删除分组
function deleteSpreadGroup(url,id){
	var d = dialog({
	    title: '提示',
	    content: '确定删除该分组吗？',
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post(url + "&datetime=" + new Date(),{},function callBack(data) {
	    		if (data[0].mark == 1) {// 删除数据失败时提示信息
	    			dialog({
	    			    content: '删除数据失败'
	    			}).show();
	    			return false;
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					showMessage("删除数据成功");
					$("#"+id).remove();
					return false;
				}
	    	})
	       
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show();
}

////////////////////////////////自动回复////////////////////////////
var d=null;
//设置回复
function message(dbid){
	$("#weixinKeyWordRoleId").val(dbid);
	$("#js-txta").show();
	$("#js-txta").val("");
	$("#msgdbid").val("");
	$(".complex-backdrop").hide();
	$("#js-complex-content").hide();
	$("#submitFm input").each(function(i){
		if($(this).attr("id")!='weixinKeyWordRoleId'){
			$(this).val("");
		}
	})
	$("#msgtype").val(1);
	var content=$("#popover-inner");
	d = dialog({
		content: content,
		quickClose: true,
		align: 'right'
	});
	d.show(document.getElementById('js-add-reply'+dbid));
}
//编辑
function editMessage(weixinKeyWordRoleId,dbid){
	$("#weixinKeyWordRoleId").val(weixinKeyWordRoleId);
	$("#weixinKeyAutoresponseDbid").val(dbid);
	$.post("/weixinKeyWordRole/ajaxEditweixinKeyAutoresponse?weixinKeyAutoresponseDbid="+dbid+"&date="+new Date(),{},function(data){
		if(data.type=="1"){
			$("#msgtext").val("");
			$("#js-txta").val("");
			$("#js-txta").show();
			$(".complex-backdrop").hide();
			$("#js-complex-content").hide();
			$("#js-txta").val(data.value);
			$("#msgtype").val(1);
			$("#msgtext").val(data.value);
		}
		if(data.type=="2"||data.type=="3"){
			$("#js-txta").hide();
			$(".complex-backdrop").show();
			$("#js-complex-content").show();
			$("#msgtype").val(data.type);
			$("#msgdbid").val(data.dbid);
			$("#js-complex-content").text("");
			$("#js-complex-content").append(data.value);
			var height=$("#js-complex-content").height();
			if(height>120){
				$(".content-wrapper").css("min-height",height+20);
			}else{
				$(".content-wrapper").css("min-height",120);
			}
		}
		var content=$("#popover-inner");
		d = dialog({
			content: content,
			quickClose: true,
			align: 'right'
		});
		d.show(document.getElementById('js-add-reply'+weixinKeyWordRoleId+""+dbid));
	} )
}
/**
* 功能描述：选择文本
*/
function selectText(){
	$("#msgtype").val(2);
	$("#js-txta").val("");
	var url='/weixinTexttemplate/selectText';
	var d = dialog({
		title: '选择文本',
		fixed: false,
	    url: url,
	    width:'760px',
  	onclose: function () {
			var value=this.returnValue;
			$.post("${ctx}/weixinTexttemplate/ajaxTempt?weixinTexttemplateId="+value+"&date="+new Date(),{},function(data){
				$("#js-txta").hide();
				$(".complex-backdrop").show();
				$("#js-complex-content").show();
				$("#js-complex-content").text("");
				$("#msgdbid").val("");
				$("#js-complex-content").append(data.value);
				$("#msgdbid").val(data.dbid);
				var height=$("#js-complex-content").height();
				if(height>120){
					$(".content-wrapper").css("min-height",height+20);
				}else{
					$(".content-wrapper").css("min-height",120);
				}
			})
		},
		oniframeload: function () {
		}
	});
	d.show();
}
/**
* 功能描述：选择文本
*/
function selectNewsItem(){
	$("#msgtype").val(3);
	$("#js-txta").val("");
	var url='/weixinNewsItem/selectNewsItem';
	var d = dialog({
		title: '选择图文',
		fixed: false,
		url: url,
		width:'760px',
		onclose: function () {
			var value=this.returnValue;
			$.post("${ctx}/weixinNewsItem/ajaxTempt?weixinTexttemplateId="+value+"&date="+new Date(),{},function(data){
				$("#js-txta").hide();
				$(".complex-backdrop").show();
				$("#js-complex-content").show();
				$("#js-complex-content").text("");
				$("#msgdbid").val("");
				$("#js-complex-content").append(data.value);
				$("#msgdbid").val(data.dbid);
				var height=$("#js-complex-content").height();
				if(height>120){
					$(".content-wrapper").css("min-height",height+20);
				}else{
					$(".content-wrapper").css("min-height",120);
				}
			})
		},
		oniframeload: function () {
		}
	});
	d.show();
}
function countWordNum(){
	var jstxta=$("#js-txta").val();
	var length=jstxta.length;
	if(length>300){
		$("#js-txta").val(jstxta.substring(0,300));
	}
	$(".word-counter i").text(300-length);
}
/**
* 功能描述：删除选择文本
*/
function removeSelectText(obj){
	$(obj).parent().remove();
	$("#msgtype").val(1);
	$("#js-txta").show();
	$("#msgdbid").val("");
	$(".complex-backdrop").hide();
	$("#js-complex-content").hide();
}
/**
* 功能描述：选择文本输入
*/
function choiceText(){
	$("#msgtype").val(1);
	$("#js-txta").show();
	$(".complex-backdrop").hide();
	$("#js-complex-content").hide();
}
/**
* 提交选择图文
*/
function submitForm(){
	var jstxta=$("#js-txta").val();
	var weixinKeyAutoresponseDbid=$("#weixinKeyAutoresponseDbid").val();
	$("#msgtext").val(jstxta);
	var param=$("#submitFm").serialize();
	var weixinKeyWordRoleId=$("#weixinKeyWordRoleId").val();
	$.post("${ctx}/weixinKeyWordRole/saveAjaxResult?date="+new Date(),param,function(data){
		if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
			if(null==weixinKeyAutoresponseDbid||weixinKeyAutoresponseDbid==''||weixinKeyAutoresponseDbid==undefined){
				$("#reply-list"+weixinKeyWordRoleId).append(data[0].url);
				d.remove();
				var info=$("#reply-container"+weixinKeyWordRoleId+" .info");
				info.hide();
				showMessage("设置自动回复成功");
			}else{
				$("#reply-list"+weixinKeyWordRoleId+""+weixinKeyAutoresponseDbid).text("");
				$("#reply-list"+weixinKeyWordRoleId+""+weixinKeyAutoresponseDbid).append(data[0].url);
				d.remove();
			}
		}
		if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
			showMessage(data[0].message);
			// 保存失败时页面停留在数据编辑页面
		}
		
	})
}
/**
* 删除自动回复
* @param weixinKeyWordRoleId
* @param dbid
*/
function deleteAutoResponse(weixinKeyWordRoleId,dbid){
	var d = dialog({
	    title: '提示',
	    content: '确定删除回复吗？',
	    okValue: '确定',
	    width: 240,
	    ok: function () {
	    	$.post("/weixinKeyWordRole/deleteAutoResponse?dbids="+dbid+"&datetime=" + new Date(),{},function callBack(data) {
	    		if (data[0].mark == 1) {// 删除数据失败时提示信息
	    			showMessage('删除数据失败');
	    			return false;
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					showMessage("删除数据成功");
					$("#reply-list"+weixinKeyWordRoleId+dbid).remove();
					var li=$("#reply-list"+weixinKeyWordRoleId).find("li");
					if(li.length<=0){
						 var info=$("#reply-container"+weixinKeyWordRoleId+" .info");
						 info.show();
					}
					return false;
				}
	    	})
	       
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('reply-list'+weixinKeyWordRoleId+dbid));
}


/**
 * 设置参数二维码标签
 * @param spreadDetailId
 */
function setSpreadDetailTags(spreadDetailId){
	var url='/memTag/spreadDetailTag';
	var title="设置会员标签";
	if(null!=spreadDetailId&&undefined!=spreadDetailId){
		url='/memTag/spreadDetailTag?spreadDetailId='+spreadDetailId;
		title="设置会员标签";
	}
	var d = dialog({
	    title: title,
	    fixed: false,
	    url: url,
	    width:'460px',
	    height:'160px',
	    okValue: '确定',
	    ok: function () {
	    	var iframeWindow = this.iframeNode.contentWindow; 
	    	var spreadDetailId=$(iframeWindow.document.getElementById('spreadDetailId')).val();
	    	var memTagIds=$(iframeWindow.document.getElementById('memTagIds'));
	    	var tagIds="";
	    	var tagNames="";
	    	$(memTagIds).find("option:selected").each(function(i){
	    		tagIds=tagIds+this.value+",";
	    		tagNames=tagNames+this.text+",";
	    	});
	    	var params={"memTagIds":tagIds,"tagNames":tagNames,"spreadDetailId":spreadDetailId};
	    	$.post("${ctx}/memTag/saveSpreadTags",params,function callBack(data) {
    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
    				var obj=data[0].url; 
    				showMessage(data[0].message);
    				$("#tag-list"+spreadDetailId).text("");
    				$("#tag-list"+spreadDetailId).append(obj);
    				var info=$("#tag-container"+spreadDetailId+" .info");
    				info.hide();
    			}
    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
    				showMessage(data[0].message);
    			}
			});
	    	 return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('js-edit-tag'+spreadDetailId));
}