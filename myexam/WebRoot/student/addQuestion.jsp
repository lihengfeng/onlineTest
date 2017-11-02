<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>试卷</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
	//刷新页面实现考试类别加载
	$(function() {
		$.get("ExaType/selecttype", null, function(data, status) {
         var info="<option value='-1'>请先选择科目...</option>";
         $.each(data,function(index,exa){
         info+="<option value='"+exa.exid+"'>"+exa.exatype+"</option>";
        
         });
          $("#etype").append(info);
		});
		
		
			/* 类别联动，选择对应考试类别，进行联动，显示对应考题类型的题目数，使用下拉框显示 */
	$("#etype").change(function(){
    //单选
	$.ajax({
	url:"${pageContext.request.contextPath}/question/selectQTypeCount",
	type:"post",
	data:{Exid:$("#etype").val(),Typeid:1},
	success:function(data){
   showType(data,"type1");
	}});
	//多选
	$.ajax({
	url:"${pageContext.request.contextPath}/question/selectQTypeCount",
	data:{Exid:$("#etype").val(),Typeid:2},
	type:"post",
	success:function(data){
   showType(data,"type2");
	}});
		
		//判断
	$.ajax({
	url:"${pageContext.request.contextPath}/question/selectQTypeCount",
	data:{Exid:$("#etype").val(),Typeid:3},
	type:"post",
	success:function(data){
    showType(data,"type3");
	}});	

	});
	
	
	
});
   //显示0-data的下拉框数量的题目数
   function showType(data,name){
   var info="";
   var i;
   for(i=0;i<=data;i++){
     info+="<option value='"+i+"'>"+i+"</option>";
    }
    
    $("#"+name).append(info);
   }

</script>
</head>
<body>
<jsp:include flush="true" page="../top.jsp"></jsp:include>
<center>



	<div class="main-content">
		<div class="breadcrumbs" id="breadcrumbs">
			<script type="text/javascript">
				try {
					ace.settings.check('breadcrumbs', 'fixed')
				} catch (e) {
				}
			</script>

			<ul class="breadcrumb">
				<li><i class="icon-home home-icon"></i> <a
					href="<%=request.getContextPath()%>/student/index">首页</a></li>
				<li class="active">在线考试</li>
			</ul>
			<!-- .breadcrumb -->
		</div>

		<div class="page-content">
			<div class="page-header center">
				<h1>在线考试</h1>
			</div>
		

			<div class="row">
				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->
					<div class="message"></div>
					<div class="table-header">诚信考试,请勿作弊!</div>
					<div class="table-responsive">


	<form action="${pageContext.request.contextPath}/question/addQuestions" method="get" id="fm">
	<table id="tb" border="1" class="table table-striped table-bordered table-hover">
	<tr><td>科目</td>
        <td><select id="etype" name="etype">
		</select></td>	
	</tr>
	
	<tr><td>单选题</td>
        <td><select id="type1" name="type1" >
		</select></td>	
	</tr>
	
	<tr><td>多选题</td>
        <td><select id="type2"  name="type2">
		</select></td>	
	</tr>
	
	<tr><td>判断题</td>
        <td><select id="type3"  name="type3">
		</select></td>	
	</tr>
	
	<tr><td><input id="add" type="submit" value="确定添加"
			> </td>
        <td><input id="return"
			type="button" value="返      回" /></td>	
	</tr>
	</table>
</form>
</div>
				</div>
			</div>
			<!-- PAGE CONTENT ENDS -->
		</div>
	</div>


</center>

<jsp:include flush="true" page="/student/studentbottom.jsp"></jsp:include>
</body>
</html>
