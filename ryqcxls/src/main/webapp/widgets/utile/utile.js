var userAgent = navigator.userAgent.toLowerCase();
var isSafari = userAgent.indexOf("Safari")>=0;
var is_opera = userAgent.indexOf('opera') != -1 && opera.version();
var is_moz = (navigator.product == 'Gecko') && userAgent.substr(userAgent.indexOf('firefox') + 8, 3);
var is_ie = (userAgent.indexOf('msie') != -1 && !is_opera) && userAgent.substr(userAgent.indexOf('msie') + 5, 3);
//日期格式函数alert(new Date().Format("yyyy年MM月dd日")); alert(new Date().Format("MM/dd/yyyy"));alert(new Date().Format("yyyyMMdd"));alert(new Date().Format("yyyy-MM-dd hh:mm:ss"));
Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 

	if(/(y+)/.test(format)) { 
	format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
	if(new RegExp("("+ k +")").test(format)) { 
	format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
	} 
	} 
	return format; 
}
$(function() {
	var xOffset = -20; // x distance from mouse
	var yOffset = 20; // y distance from mouse
	$(".tip").hover(
			function(e) {
				if ($(this).attr('tip') != undefined) {
					var top = (e.pageY + yOffset);
					var left = (e.pageX + xOffset);
					$('body').append(
							'<p id="vtip2">'
									+ $(this).attr('tip') + '</p>');
					$('p#vtip2').css("top", top + "px").css("left",
							left + "px");
				}
			}, function() {
				if ($(this).attr('tip') != undefined) {
					$("p#vtip2").remove();
				}
			}).mousemove(
			function(e) {
				if ($(this).attr('tip') != undefined) {
					var top = (e.pageY + yOffset);
					var left = (e.pageX + xOffset);
					$("p#vtip2").css("top", top + "px").css("left",
							left + "px");
				}
			});
});


(function($) {
	$.utile = {};
})(jQuery);

/**
 * Iframe的底层应用，短暂提示
 * 
 * @param {String}
 *            提示内容
 * @param {Number}
 *            显示时间 (默认1.5秒)
 */
$.utile.tips = function(content, time) {
	return window.top.art.dialog({
		id : 'Tips',
		title : false,
		cancel : false,
		lock : true,
		fixed : true
	}).content('<div style="padding: 0 1em;">' + content + '</div>').time(
			time || 1);
}
$.utile.MessageBox=function(content,v){
	art.dialog({
	    id: 'msg'+v,
	    title: '系统信息提示',
	    content: ''+content,
	    width: 320,
	    height: 120,
	    left: '100%',
	    top: '100%',
	    fixed: true,
	    drag: false,
	    resize: false
	})
}
/*******************************************************************************
 * 添加提交Ajax表单 1、验证表单数据 2、获取页面表单数据 3、提交表单数据 4、处理返回数据页面跳转target标识
 * 保存数据时页面跳转表示，如果是弹窗页面保存成功页面跳转到父页面 如果数据是新开页面保存数据成功后页面跳转到原页面
 ******************************************************************************/
$.utile.submitForm = function(frmId, url, state) {
	var target = $("#" + frmId).attr("target") || "_self";
	try {
		if (undefined != frmId && frmId != "") {
			var validata = validateForm(frmId);
			if (validata == true) {
				var params = getParam(frmId, state);
				$.post(url,params,function callBack(data) {
					if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
						$.utile.tips(data[0].message);
						if (target == "_self") {
							setTimeout(
									function() {
										window.location.href = data[0].url
									}, 1000);
						}
						if (target == "_parent") {
							// 同时关闭弹出窗口
							var parent = window.parent;
							window.parent.frames["contentUrl"].location=data[0].url;
						}
						// 保存数据成功时页面需跳转到列表页面
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
						$.utile.tips(data[0].message);
						// 保存失败时页面停留在数据编辑页面
					}
					return;
				});
			} else {
				return;
			}
		} else {
			return;
		}
	} catch (e) {
		$.utile.tips(e);
		return;
	}
}
$.utile.submitAjaxForm = function(frmId, url, state) {
	var target = $("#" + frmId).attr("target") || "_self";
	try {
		if (undefined != frmId && frmId != "") {
			var validata = validateForm(frmId);
			if (validata == true) {
				var params = getParam(frmId, state);
				var url2="";
				$.ajax({	
					url : url, 
					data : params, 
					async : false, 
					timeout : 20000, 
					dataType : "json",
					type:"post",
					success : function(data, textStatus, jqXHR){
						//alert(data.message);
						var obj;
						if(data.message!=undefined){
							obj=$.parseJSON(data.message);
						}else{
							obj=data;
						}
						if(obj[0].mark==1){
							//错误
							$.utile.tips(obj[0].message);
							$(".butSave").attr("onclick",url2);
							return ;
						}else if(obj[0].mark==0){
							$.utile.tips(data[0].message);
							if (target == "_self") {
								setTimeout(
										function() {
											window.location.href = obj[0].url
										}, 1000);
							}
							if (target == "_parent") {
								// 同时关闭弹出窗口
								var parent = window.parent;
								window.parent.frames["contentUrl"].location=obj[0].url;
							}
							// 保存数据成功时页面需跳转到列表页面
						}
					},
					complete : function(jqXHR, textStatus){
						$(".butSave").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".butSave").attr("onclick");
						$(".butSave").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
							$.utile.tips("系统请求超时");
							$(".butSave").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
		} else {
			return;
		}
	} catch (e) {
		$.utile.tips(e);
		return;
	}
}


function goBack(){
	window.history.go(-1);
}
function getParam(frmId, state) {
	// 富文本编辑器取数据
	var ckeditorState = state || false;
	if (ckeditorState == true) {
		$('#content').val(CKEDITOR.instances.content.getData());
	}
	var params = $("#" + frmId).serialize();
	return params;
}
// 删除数据前验证选择数据
function checkBefDel() {
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择操作数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
		// 为true等价于function(){}
		});
		return false;
	} else {
		return true;
	}
}
// 删除数据前验证选择数据
function checkOperateSingal() {
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择操作数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
			// 为true等价于function(){}
		});
		return false;
	} else if(length >= 2) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '只能选择一条数据，进行阅读记录查看！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
			// 为true等价于function(){}
		});
		return false;
	}else{
		return true;
	}
}
function getTabID(windowParent) {
	var center = windowParent.getElementById("center");
	var divSelect = $(center).children();
	for ( var i = 0; i < divSelect.length; i++) {
		var hel = $(divSelect[i]).attr("class");
		if (hel != undefined && hel != "") {
			if (hel == "tabs-panel selected") {
				var tabId = $(divSelect[i]).children()[0];
				return $(tabId).attr("id");
			}
		}
	}
}
/** 弹窗关闭* */
$.utile.close = function() {
	// 同时关闭弹出窗口
	var dd = window.parent.parent.document;
	var tabId = getTabID(dd);
	var win = parent.document.getElementById(tabId).contentWindow;
	win.document.location.reload();
}
/** 获取checkBox的value* */
function getCheckBox() {
	var array = new Array();
	var checkeds = $("input[type='checkbox'][name='id']");
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			array.push(checkbox.value);
		}
	});
	return array.toString();
}

/**
 * 将选择的用户自动赋值到 列表中
 */
$.utile.showChooseUser = function() {
	var array = new Array();
	var checkeds = $("input[type='checkbox'][name='id']");
	var users = getCheckBox();
	var userValues = $('#users').val();
	if (userValues == null || userValues == "") {
		$('#users').val(users);
		return;
	} else if (userValues != null) {
		var temp = userValues.substring(userValues.length - 1,
				userValues.length);

		if (temp != ",") {
			$('#users').val(userValues + ',');
		}

		$.each(checkeds, function(i, checkbox) {
			if (checkbox.checked) {
				if (userValues.indexOf(checkbox.value) == -1) {
					array.push(checkbox.value);
				}
			}
		});
	}

	$('#users').val($('#users').val() + array.toString());
	return;

}

/** 删除封装提示信息方法* */
$.utile.deleteIds = function(url,searchFrm) {
	var checkBef = checkBefDel();
	var params=$("#"+searchFrm).serialize();
	try {
		if (checkBef == true) {
			window.top.art.dialog({
				content : '您确定删除选择数据吗？',
				icon : 'question',
				width:"250px",
				height:"80px",
				lock : true,
				ok : function() {// 点击去定按钮后执行方法
					var param = getCheckBox();
					$.post(url + "?dbids=" + param + "&datetime=" + new Date(),params,	callBack);
					function callBack(data) {
						if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面

							window.top.art.dialog({
								content : data[0].message,
								icon : 'warning',
								window : 'top',
								lock : true,
								width:"200px",
								height:"80px",
								ok : function() {// 点击去定按钮后执行方法

									$.utile.close();
									return;
								}
							});

						}

						if (data[0].mark == 1) {// 删除数据失败时提示信息
							$.utile.tips(data[0].message);
						}
						if (data[0].mark == 0) {// 删除数据成功提示信息
							$.utile.tips(data[0].message);
						}
						// 页面跳转到列表页面
						setTimeout(function() {
							window.location.href = data[0].url
						}, 1000);
					}
				},
				cancel : true
			});
		} else {
			return;
		}
	} catch (e) {
		return;
	}
}

/*
 * 1、删除一条数据 2、url格式为：${ctx}/user/deleteById?dbid=1
 */
$.utile.deleteById = function(url,searchFrm) {
	var param;
	if(undefined==searchFrm||null==searchFrm||searchFrm.length<=0){
		
	}else{
		param=$("#"+searchFrm).serialize();
	}
	window.top.art.dialog({
		content : '您确删除选择数据吗？',
		icon : 'question',
		width:"250px",
		height:"80px",
		window : 'top',
		lock : true,
		ok : function() {// 点击去定按钮后执行方法
			$.post(url + "&datetime=" + new Date(),param,function callBack(data) {
				if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
					window.top.art.dialog({
						content : data[0].message,
						icon : 'warning',
						window : 'top',
						width:"250px",
						height:"80px",
						lock : true,
						ok : function() {// 点击去定按钮后执行方法

							$.utile.close();
							return;
						}
					});
				}
				if (data[0].mark == 1) {// 删除数据失败时提示信息
					/* $.cqtaUtile.errMessage(data[0].message); */
					$.utile.tips(data[0].message);
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					/* $.cqtaUtile.okDeleteMessage(data[0].message); */
					$.utile.tips(data[0].message);
				}
				// 页面跳转到列表页面
				setTimeout(function() {
					window.location.href = data[0].url
				}, 1000);
			});
		},
		cancel : true
	});
}

/** 删除封装提示信息方法* */
$.utile.operatorDataByDbids = function(url,searchFrm,conf) {
	var content="您确定删除选择数据吗？";
	if(null!=conf&&conf!=undefined){
		content=conf;
	}
	var checkBef = checkBefDel();
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	try {
		if (checkBef == true) {
			window.top.art.dialog({
				content : content,
				icon : 'question',
				width:"250px",
				height:"80px",
				lock : true,
				ok : function() {// 点击去定按钮后执行方法
					var param = getCheckBox();
					$.post(url + "?dbids=" + param + "&datetime=" + new Date(),params,callBack);
					function callBack(data) {
						if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
							window.top.art.dialog({
								content : data[0].message,
								icon : 'warning',
								window : 'top',
								width:"250px",
								height:"80px",
								lock : true,
								ok : function() {// 点击去定按钮后执行方法
									$.utile.close();
									return;
								}
							});

						}

						if (data[0].mark == 1) {// 删除数据失败时提示信息
							$.utile.tips(data[0].message);
							return ;
						}
						if (data[0].mark == 0) {// 删除数据成功提示信息
							// 页面跳转到列表页面
							$.utile.tips(data[0].message);
							setTimeout(function() {
								window.location.href = data[0].url
							}, 1000);
							return ;
						}
						
					}
				},
				cancel : true
			});
		} else {
			return;
		}
	} catch (e) {
		return;
	}
}
/*
 * 1、删除一条数据 2、url格式为：${ctx}/user/deleteById?dbid=1
 */
$.utile.operatorDataByDbid = function(url,searchFrm,conf) {
	var content="您确定删除选择数据吗？";
	if(null!=conf&&conf!=undefined){
		content=conf;
	}
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.top.art.dialog({
		content : content,
		icon : 'question',
		width:"250px",
		height:"80px",
		window : 'top',
		lock : true,
		ok : function() {// 点击去定按钮后执行方法
			$.post(url + "&datetime=" + new Date(),params,function callBack(data) {
				if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
					
					window.top.art.dialog({
						content : data[0].message,
						icon : 'warning',
						window : 'top',
						width:"250px",
						height:"80px",
						lock : true,
						ok : function() {// 点击去定按钮后执行方法
							
							$.utile.close();
							return;
						}
					});
					
				}
				if (data[0].mark == 1) {// 删除数据失败时提示信息
					/* $.cqtaUtile.errMessage(data[0].message); */
					$.utile.tips(data[0].message);
					return ;
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					/* $.cqtaUtile.okDeleteMessage(data[0].message); */
					$.utile.tips(data[0].message);
					setTimeout(function() {
						window.location.href = data[0].url
					}, 1000);
					return ;
				}
				// 页面跳转到列表页面
				
			});
		},
		cancel : true
	});
}

$.utile.openDialog = function(url, title, swidth, sheight) {
	var width = swidth || 550;
	var heigth = sheight || 200;
	art.dialog.open(url, {
		title : title,
		width : width,
		height : heigth,
		lock : true
	});
}
/*******************************************************************************
 * 系统弹出封装，待考虑一个问题就系统提交出现错误时 页面不能停留在提交页面，还是会跳转到list页面
 * 
 * $.utile.openDialog=function(url,title,sfrmId,tegartUrl,swidth,sheight){ //var
 * width=swidth>0?swidth:550; //var heigth=sheight>0?sheight:200; var
 * width=swidth || 550; var heigth=sheight||200; art.dialog.open(url, {title:
 * title,width:width,height:heigth, init: function () { var iframe =
 * this.iframe.contentWindow; var top = art.dialog.top;// 引用顶层页面window对象 }, ok:
 * function () { var iframe = this.iframe.contentWindow; var
 * frmId=iframe.document.getElementById(sfrmId); if (!iframe.document.body) {
 * alert('iframe还没加载完毕呢') return false; }; if(validateForm(frmId)==false){
 * return false; } var params=$(frmId).serialize(); var
 * po=$.post(tegartUrl,params,function (data){ /*var top = art.dialog.top;
 * if(data[0].mark==0){//返回标志为0表示添加数据成功 $.utile.tips(data[0].message);
 * setTimeout(function(){window.location.href=data[0].url},1000); }
 * if(data[0].mark==1){ $.utile.tips(data[0].message); } } ); }, cancel: true
 * }); }
 ******************************************************************************/

/**
 * 显示人员选择器 list页面，checkBox选择数据
 */
function selectAll(checkbox, domname) {
	var doms = document.getElementsByName(domname);
	for ( var i = 0; i < doms.length; i++) {
		if (doms[i].type == "checkbox") {
			doms[i].checked = checkbox.checked;
			if(checkbox.checked){
				$(doms[i]).parent().addClass("checked");
			}else{
				$(doms[i]).parent().removeClass("checked");
			}
		}
	}
}
/**
 * 功能描述：弹出人员选择对话框
 * @returns
 *//*
function showUserSelector(){
	//项目的contextPath,如果有必要，请修改
	var path="";
	var obj = new Object();
	obj.name = "title";
	var rv = window.showModalDialog(path+"/compoent/userSelect",obj,'dialogWidth=520px;dialogHeight=420px,center=yes,help=1,resizable=0,status=0,scroll=2,edge=sunken,unadorned=yes,dialogHide=0');
	if(rv!=undefined){ 
		if($("#personId").val()!=undefined){
			$("#personId").val(rv.split("|")[0]);
		//	alert($("#personId").val());
		}
		return rv;
	}
	return "";
}
function getSelectedUser(userIds,userNames){
	var result= showUserSelector();
	if($.trim(result).length>0){
		$('#'+userIds).val(result.split("|")[0]);
		$('#'+userNames).val(result.split("|")[1]);
	}
}*/
function getSelectedUser(userIds,userNames){
	art.dialog.open('/compoent/userSelect', {
	    title: '选择用户',
	    width:"720px",height:"400px",
	    init: function () {
	    	var iframe = this.iframe.contentWindow;
	    	var top = art.dialog.top;// 引用顶层页面window对象
	    },
	    ok: function () {
	    	var iframe = this.iframe.contentWindow;
	    	if (!iframe.document.body) {
	        	alert('iframe还没加载完毕呢')
	        	return false;
	        };
	        var options=$(iframe.document.getElementById('resultSelected'))[0];
	        var resultIds="";
			var resultNames="";
			if(options.length>0){
				for(var i=0;i<options.length;i++){
					var removeSelected =options[i];
					resultIds+=removeSelected.value+",";
					resultNames+=removeSelected.text+",";
				}
			}
			var param="resultIds="+resultIds+"&resultNames="+encodeURIComponent(resultNames);
			$.post("${ctx}/compoent/analyticSelectedData?&data="+new Date(),param,function callback(data){
				if($.trim(data).length>0){
					$('#'+userIds).val(data.split("|")[0]);
					$('#'+userNames).val(data.split("|")[1]);
				 	return true;
				}else{
					 return false;
				}
			});
	    },
	    cancel: true,
	});
}


function uploadFile(fileUrl,imgeUrl){
	var path="";
	art.dialog.open(path+'/compoent/uploadConpent', {
	    title: '上传图片',
	    width:"720px",height:"400px",
	    init: function () {
	    	var iframe = this.iframe.contentWindow;
	    	var top = art.dialog.top;// 引用顶层页面window对象
	    },
	    ok: function () {
	    	var iframe = this.iframe.contentWindow;
	    	if (!iframe.document.body) {
	        	alert('iframe还没加载完毕呢')
	        	return false;
	        };
	       var fileUpload= iframe.document.getElementById('fileUpload').value;
	       if(null!=fileUpload&&fileUpload.length>0){
		        $("#"+fileUrl).val(fileUpload);
		        if(null!=imgeUrl&&imgeUrl!=undefined){
		        	$("#"+imgeUrl).attr("src",fileUpload);
		        }
		       	return true;
	       }else{
	    	   return false;
	       }
	    },
	    cancel: true
	});
}
/**
 * 生成部门信息列表
 * @param departDiv
 * @param depIds
 * @param depNames
 */
function crateDepart(departDiv,depIds,depNames){
	var reasultHtml="";
	var depId=depIds.split(",");
	var depName=depNames.split(",");
	if($.trim(depId).length>0){
		$.each(depId,function(i,value){
			reasultHtml=reasultHtml+ '<div class="fillAddr" id="div'+value+'">'+
			'<b nid="'+value+'">'+depName[i]+'</b>'+
			'<a href="javascript:void(-1);" class="addrDel" ck="delSelectedItem" id="a'+value+'" onclick="deleteDep('+value+')"></a>'+
			'<input type="hidden" id="di'+value+'" name="departmentIds" value="'+value+'">'+
			'<input type="hidden" id="dn'+value+'" name="departmentNames" value="'+depName[i]+'">'+
			'</div>';

		})
		$("#"+departDiv).text("");
		$("#"+departDiv).append(reasultHtml);
	}
}
/**
 * 生成部门信息列表
 * @param departDiv
 * @param depIds
 * @param depNames
 */
function getSelectedDepartment(departDiv){
	art.dialog.open('/compoent/departmentSelect', {
	    title: '选择部门',
	    width:"720px",height:"400px",
	    init: function () {
	    	var iframe = this.iframe.contentWindow;
	    	var top = art.dialog.top;// 引用顶层页面window对象
	    },
	    ok: function () {
	    	var iframe = this.iframe.contentWindow;
	    	if (!iframe.document.body) {
	        	alert('iframe还没加载完毕呢')
	        	return false;
	        };
	        var departments= iframe.document.getElementById('departments').value;
	       if(null!=departments&&departments.length>0){
	    	    var deparement=departments.split("|");
	   			var depIds=deparement[0];
	   			var depNames=deparement[1];
	   			crateDepart(departDiv,depIds,depNames)
		       	return true;
	       }else{
	    	   return false;
	       }
	    },
	    cancel: true
	});
}
/**
 * 删除部门信息
 * @param id
 */
function deleteDep(id){
	$("#div"+id).remove();
}
/**
 * 生成岗位信息列表
 * @param departDiv
 * @param depIds
 * @param depNames
 */
function cratePosition(departDiv,depIds,depNames){
	var reasultHtml="";
	var depId=depIds.split(",");
	var depName=depNames.split(",");
	if($.trim(depId).length>0){
		$.each(depId,function(i,value){
			reasultHtml=reasultHtml+ '<div class="fillAddr" id="position'+value+'">'+
			'<b nid="'+value+'">'+depName[i]+'</b>'+
			'<a href="javascript:void(-1);" class="addrDel" ck="delSelectedItem" id="a'+value+'" onclick="deletePosition('+value+')"></a>'+
			'<input type="hidden" id="pi'+value+'" name="positionIds" value="'+value+'">'+
			'<input type="hidden" id="pn'+value+'" name="positionNames" value="'+depName[i]+'">'+
			'</div>';
			
		})
		$("#"+departDiv).text("");
		$("#"+departDiv).append(reasultHtml);
	}
}
/**
 * 生成岗位信息列表
 * @param departDiv
 * @param depIds
 * @param depNames
 */
function getSelectedPosition(departDiv){
	art.dialog.open('/compoent/positionSelect', {
		title: '选择部门',
		width:"720px",height:"400px",
		init: function () {
			var iframe = this.iframe.contentWindow;
			var top = art.dialog.top;// 引用顶层页面window对象
		},
		ok: function () {
			var iframe = this.iframe.contentWindow;
			if (!iframe.document.body) {
				alert('iframe还没加载完毕呢')
				return false;
			};
			var departments= iframe.document.getElementById('positions').value;
			if(null!=departments&&departments.length>0){
				var deparement=departments.split("|");
				var depIds=deparement[0];
				var depNames=deparement[1];
				cratePosition(departDiv,depIds,depNames)
				return true;
			}else{
				return false;
			}
		},
		cancel: true
	});
}
/**
 * 删除岗位信息
 * @param id
 */
function deletePosition(id){
	$("#position"+id).remove();
}

/**
 * 内容编辑页面删除文件
 * filePath:删除文件链接
 * divId：生成附件的div
 * 功能描述：通过链接删除文件，
 * 1、删除成功，移除div
 * 2、删除失败，提示失败
*/
function deleteFileByPath(filePath,divId){
	$.post('${ctx}/swfUpload/deleteFile?fileUrl='+encodeURI(encodeURI(filePath))+"&timeStamp="+new Date(),function(data){
		if(data=="success"){
			$.utile.tips("删除附件成功！");
			$("#"+divId).remove();
		}if(data=="failed"){
			$.utile.tips("删除附件失败！");
		}
	});
}
/**绑定保存按钮的 enter 事件**/
$(function(){
	 $('#sbmId').keydown(function(e){
		 if(e.keyCode==13){
			 //$('#frmId')[0].submit(); //处理事件
			 $('#sbmId').onclick();
		 }
	});
})
function memberSelect(memberIds,memberNames){
	var path="";
	art.dialog.open(path+'/member/memberSelect', {
	    title: '选择会员',
	    width:"720px",height:"400px",
	    init: function () {
	    	var iframe = this.iframe.contentWindow;
	    	var top = art.dialog.top;// 引用顶层页面window对象
	        top.document.title = '选择会员';
	    },
	    ok: function () {
	    	var iframe = this.iframe.contentWindow;
	    	if (!iframe.document.body) {
	        	alert('iframe还没加载完毕呢')
	        	return false;
	        };
	        var members= iframe.document.getElementById('members').value;
	       if(null!=members&&members.length>0){
	    	   $('#'+memberIds).val(members.split("|")[0]);
	   			$('#'+memberNames).val(members.split("|")[1]);
		       	return true;
	       }else{
	    	   return false;
	       }
	    },
	    cancel: true
	});
}
function smsTemplateSelect(smsIds,smsNames){
	var path="";
	art.dialog.open(path+'/smsTemplate/smsTemplateSelect', {
		title: '选择短信模板',
		width:"720px",height:"400px",
		init: function () {
			var iframe = this.iframe.contentWindow;
			var top = art.dialog.top;// 引用顶层页面window对象
			top.document.title = '选择短信模板';
		},
		ok: function () {
			var iframe = this.iframe.contentWindow;
			if (!iframe.document.body) {
				alert('iframe还没加载完毕呢')
				return false;
			};
			var members= iframe.document.getElementById('smsTemplates').value;
			if(null!=members&&members.length>0){
				$('#'+smsIds).val(members.split("|")[0]);
				$('#'+smsNames).val(members.split("|")[1]);
				return true;
			}else{
				return false;
			}
		},
		cancel: true
	});
}
function commonSelect(title,url,smsIds,smsNames,targetId,swidth,sheight,status){
	var width = swidth || 720;
	var heigth = sheight || 400;
	var stat = status || false;
	var path="";
	art.dialog.open(path+url, {
		title: title,
		width:width,height:heigth,
		fixed: true,
		lock : true,
	    drag: false,
	    resize: false,
		init: function () {
			var iframe = this.iframe.contentWindow;
			var top = art.dialog.top;// 引用顶层页面window对象
		},
		ok: function () {
			var iframe = this.iframe.contentWindow;
			if (!iframe.document.body) {
				alert('iframe还没加载完毕呢')
				return false;
			};
			var members= iframe.document.getElementById(targetId).value;
			if(null!=members&&members.length>0){
					if(stat==true){
						var smsIdsValue=$('#'+smsIds).val();
						if(null==smsIdsValue||smsIdsValue==''){
							smsIdsValue=""
						}else{
							smsIdsValue=smsIdsValue+","
						}
						var smsNamesValue=$('#'+smsNames).val();
						if(null==smsNamesValue||smsNamesValue==''){
							smsNamesValue=""
						}else{
							smsNamesValue=smsNamesValue+","
						}
						$('#'+smsIds).val(smsIdsValue+members.split("|")[0]);
						$('#'+smsNames).val(smsNamesValue+members.split("|")[1]);
					}else{
						$('#'+smsIds).val(members.split("|")[0]);
						$('#'+smsNames).val(members.split("|")[1]);
					}
				return true;
			}else{
				alert("请选择数据！");
				return false;
			}
		},
		cancel: true
	});
}
function customerSelect(customerIds,customerNames,userId){
	if(null==userId||userId==''){
		alert("请先选择原销售人员");
		return ;
	}
	var path="";
	art.dialog.open(path+'/turnCustomerRecord/customerSelect?userId='+userId, {
	    title: '选择客户',
	    width:"720px",height:"400px",
	    init: function () {
	    	var iframe = this.iframe.contentWindow;
	    	var top = art.dialog.top;// 引用顶层页面window对象
	    },
	    ok: function () {
	    	var iframe = this.iframe.contentWindow;
	    	if (!iframe.document.body) {
	        	alert('iframe还没加载完毕呢')
	        	return false;
	        };
	        var members= iframe.document.getElementById('customerIds').value;
	       if(null!=members&&members.length>0){
	    	   $('#'+customerIds).val(members.split("|")[0]);
	   			$('#'+customerNames).val(members.split("|")[1]);
		       	return true;
	       }else{
	    	   return false;
	       }
	    },
	    cancel: true
	});
}
//客户管理文档相关
function operator(url){
	// 删除数据前验证选择数据
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if(length >1){
		warm("一次只能选择一条数据！");
		return ;
	}
	
	if(length<=1) {
		var dbid=getCheckBox();
		url=url+"?dbid="+dbid;
		window.open(url)
	}
}
//客户管理文档相关
function operatorLocation(url){
	// 删除数据前验证选择数据
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if(length >1){
		warm("一次只能选择一条数据！");
		return ;
	}
	if(length<=0){
		warm("请先选择操作数据！");
		return ;
	}
	if(length<=1) {
		var dbid=getCheckBox();
		url=url+"?dbid="+dbid;
		window.location.href=url;
	}
}
function warm(content){
	window.top.art.dialog({
		icon : 'warning',
		title : '警告',
		content : content,
		cancelVal : '关闭',
		lock : true,
		time : 3,
		width:"250px",
		height:"80px",
		cancel : true
	});
}
function ajaxArea(sel){
	var value=$(sel).val();
	$("#areaId").val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#areaLabel").append(data);
		}
	});
}

