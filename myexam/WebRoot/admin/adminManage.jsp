<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线考试后台管理</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;

	//模糊查询
	function searchUser() {
		$("#dg").datagrid('load', {
			"aname" : $("#aname").val()
		});
	}

	function deleteUser() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length == 0) {
			$.messager.alert("系统提示", "请选择要删除的数据！");
			return;
		}
		var strIds = [];
		for (var i = 0; i < selectedRows.length; i++) {
			strIds.push(selectedRows[i].adminid);
		}
		var ids = strIds.join(",");
		$.messager.confirm("系统提示", "您确认要删除这<font color=red>"
				+ selectedRows.length + "</font>条数据吗？", function(r) {
			if (r) {
				$.post("${pageContext.request.contextPath}/Admins/delete", {
					ids : ids
				}, function(result) {
					if (result) {
						$.messager.alert("系统提示", "数据已成功删除！");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert("系统提示", "数据删除失败！");
					}
				}, "json");
			}
		});

	}

	//这里打开添加用户模态窗口
	function openUserAddDialog() {
		$("#dlg").dialog("open").dialog("setTitle", "添加用户信息");
		//处理增加操作的url地址 控制器的访问路径
		url = "${pageContext.request.contextPath}/Admins/add";
	}

	//这个方法具体添加(也可能是修改)动作
	function saveUser() {
		$("#fm").form("submit", {
			url : url,
			onSubmit : function() {
				if ($("#adminsex").val() == "") {
					$.messager.alert("系统提示", "请选择性别");
					return false;
				}
				return $(this).form("validate");
			},
			success : function(result) {
				console.log("result :" + result);
				//这个方法的判断 最好再优化一下;
				if (result=="true") {
					$.messager.alert("系统提示", "保存成功");
					resetValue();
					$("#dlg").dialog("close");
					//重新加载数据到datagrid
					$("#dg").datagrid("reload");
				} else {
					$.messager.alert("系统提示", "保存失败");
					return;
				}
			}
		});
	}

	//弹出修改用户的对话框
	function openUserModifyDialog() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "编辑管理员信息");
		$("#adminname").val(row.adminname); 
		$("#adminphone").val(row.adminphone); //这里要一致
		$("#adminsex").val(row.adminsex);
		
		//个url就是我们呀欧完成修改的那个控制器中url地址
		url = "${pageContext.request.contextPath}/Admins/update/" + row.adminid;
	}

	//重置 表单元素还原到初始化状态
	function resetValue() {
		$("#adminname").val("");
		$("#adminphone").val("");
		$("#adminsex").val("");
	}

	//关闭窗口
	function closeUserDialog() {
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="管理员管理" class="easyui-datagrid" fitColumns="true"
		pagination="true" rownumbers="true"
		data-options="url:'${pageContext.request.contextPath}/Admins/query',method:'get'"
		fit="true" toolbar="#tb">
		<thead>
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				
				<th field="adminid" width="50" align="center">管理员编号</th>
				<th field="adminname" width="100" align="center">管理员姓名</th>
				<th field="adminphone" width="100" align="center">管理员电话</th>
				<th field="adminsex" width="100" align="center">管理员性别</th>
				
			</tr>
		</thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openUserAddDialog()" class="easyui-linkbutton"
				iconCls="icon-add" plain="true">添加</a> 
			<a	href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true">修改</a> 
			<a	href="javascript:deleteUser()" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;管理员姓名：&nbsp;<input type="text" id="aname" size="20"
				onkeydown="if(event.keyCode==13) searchUser()" /> <a
				href="javascript:searchUser()" class="easyui-linkbutton"
				iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 570px;height:300px;padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="8px">
				<tr>
					<td>管理员姓名</td>
					<td><input type="text" id="adminname" name="adminname"
						class="easyui-validatebox" required="true" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>管理员电话</td>
					<td><input type="text" id="adminphone" name="adminphone"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td>管理员性别</td>
					<td><input type="text" id="adminsex" name="adminsex"
						class="easyui-validatebox" required="true" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
			</table>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:saveUser()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>