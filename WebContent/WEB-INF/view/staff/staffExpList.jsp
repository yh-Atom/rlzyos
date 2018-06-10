<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>员工履历信息表</title>
<%-- <link rel="stylesheet" href="<%=basePath%>css/Staff/Staff.css"> --%>
<link rel="stylesheet" href="<%=basePath%>css/user/userIndex.css">
<script type="text/javascript" src="<%=basePath%>js/staff/staffExp.js"></script>
<script src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<style type="text/css">
#bottomPage:hover {
	cursor: pointer;
}
</style>
</head>
<body>
	<s:action name="user_implements_navbar" namespace="/user" executeResult="true" />
<!----------------------------------------------- 隐藏信息开始 --------------------------------------------------->
	<input id="hideQueryString" type="text" class="hideDiv" />
	<input id="hideCurrPage" type="text" class="hideDiv" />
	
	<div style="margin: 80px 0 0 0; float: left; width: 100%;">
		<div class="panel" style="width: 95%; margin: 20px auto;" id="allPage">
			<!--  -->
			<div class="panel-heading">
				<h3 class="panel-title">员工履历表</h3>
			</div>
			<div class="panel-body">
				<div class="operation" style="margin: 0 0 6px 50px;">
					<button style="margin-left: 15px;" type="button"
						class="btn btn-default"
						onclick="javascript:location.href='/rlzyos/staff/staff_page_AddStaff'">
						<i class="fa fa-plus-square"></i> 新增履历
					</button>
					<input type="text" id="searchInput" class="form-control"
						style="width: 250px; display: inline-block; float: right;"
						oninput="changeName(this)" placeholder="请输入搜索内容">
				</div>
				<div class="col-md-12">
					<div id="loadingLayer" style="margin: 0 auto; width: 45px;">
						<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
					</div>
					<div class="panel" id="mainPanel" style="display: none;">
						<div class="panel-heading">
							<h3 class="panel-title staff_title">履历表</h3>
						</div>
						<div class="panel-body">
							<table class="table table-hover table-condensed staff_table_info">
								<thead>
									<tr>
										<th>员工工号</th>
										<th>工作地址</th>
										<th>开始时间</th>
										<th>结束时间</th>
										<th>备注</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									 <tr v-for="staffExp in staffExps" style="text-align: center;"> 
										<td>
										<a :id="staffExp.staffExp_staff" onclick="skipToDetails(this)">
										<span v-html="staffExp.staffExp_staff"></span></a>
										</td>
										<td>{{ staffExp.staffExp_address }}</td>
										<td>{{ staffExp.staffExp_startTime }}</td>
										<td>{{ staffExp.staffExp_overTime }}</td>
										<td>{{ staffExp.staffExp_remark }}</td>
										<td><button onclick="createConfirmUpdata(this)" 
												:id="staffExp.rlzy_staffExp_id" data-toggle='modal' data-target='#updateStaffExp' class='btn btn-primary'><i class="fa fa-pencil-square-o"></i>修改</button>
											<button onclick="createConfirmDelete(this)"
												:id="staffExp.rlzy_staffExp_id" class="btn btn-danger"><i class="fa fa-trash-o"></i>删除</button></td>
									</tr>
								</tbody>
							</table>
							<div id="bottomPage" style="padding: 20px;">
								<span>当前页数:<span id="currPage">{{ currPage }}</span></span> <span>共:<span
									id="totalPage">{{ totalPage }}</span>页<span>共:<span
									id="totalPage">{{ totalCount }}</span>条记录数
								</span> <span onclick="firstPage()" id="indexPage"
									class="pageOperation">首页</span> <span onclick="prePage()"
									id="previousPage" class="pageOperation">上一页</span> <span
									onclick="nextPage()" id="nextPage" class="pageOperation">下一页</span>
								<span onclick="endPage()" id="lastPage" class="pageOperation">末页</span>
								<span> <input id="skipPage" class="form-control"
									type="text"
									style="display: inline-block; text-align: center; width: 60px; height: 30px;"
									class="queryInput">
									<button onclick="jumpPage()" class="btn btn-default"
										style="height: 30px;">跳转</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
		
<!---------------------updateStaffExp--------------------------------------------修改模态框----------------------------------------------------  -->
	<div class="modal fade" id="updateStaffExp" tabindex="-1" role="dialog"	aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="width: 900px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改员工履历</h4>
				</div>
				<div class="modal-body">
 					<%-- <div id="updateLoadingDiv" class="hideDiv" 
						style="width: 319px; margin: 0 auto;"> 
						<img alt="" src="<%=basePath%>img/loading.gif">
				</div>  --%>
					<div id="updateContent">
						<form id="updatestaffExpForm">
							<table class="table" style="margin: 0 auto;">
								<tr>
									<td><label>工号：</label></td>
									<td><input id="staffExp_staff" name="staffExp_staff"
										type="text" class="form-control" readonly="readonly"></td>
									<td><label>姓名：</label></td>
									<td><input id="staff_name" name="staff_name"
										type="text" class="form-control" readonly="readonly"></td>
								</tr>
								<tr>
									<td><label>工作地点：</label></td>
									<td><input id="staffExp_address" name="staffExp_address"
										type="text" class="form-control" placeholder="请输入工作地点"></td>
									<td><label>开始时间：</label></td>
									<td><input id="staffExp_startTime" name="staffExp_startTime"
										type="text" class="form-control" placeholder="请输入开始时间"></td>
								</tr>
								<tr><td><label>结束时间：</label></td>
									<td><input id="staffExp_overTime" name="staffExp_overTime"
										type="text" class="form-control" placeholder="请输入结束时间"></td>
									<td><label>备注：</label></td>
									<td><input id="staffExp_remark" name="staffExp_remark"
										type="text" class="form-control" placeholder="请输入备注"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button onclick="loadData()" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="updateBtn"  onclick="updateStaffExp(this)" 
					:id="staffExp.rlzy_staffExp_id" type="button" class="btn btn-primary">修改</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
</body>
</html>