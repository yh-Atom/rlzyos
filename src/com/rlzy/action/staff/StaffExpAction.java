package com.rlzy.action.staff;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.rlzy.domain.DO.rlzy_staffexp;
import com.rlzy.domain.VO.showStaffExpVO;
import com.rlzy.service.staff.StaffExpService;

public class StaffExpAction {
	private StaffExpService staffExpService;

	public StaffExpService getStaffExpService() {
		return staffExpService;
	}

	public void setStaffExpService(StaffExpService staffExpService) {
		this.staffExpService = staffExpService;
	}
	
	//增加工作履历信息
	public void addStaffExp(){
		
	}	
	//删除一个工作履历信息
	public void deleteStaffExp(){
		
	}
	//修改工作履历信息
	public void updataStaffExp() throws IOException{
		System.out.println("修改履历");
		staffExp.setRlzy_staffExp_id(rlzy_staffExp_id);
		System.out.println(rlzy_staffExp_id);
		staffExpService.upadteStaffExp(staffExp);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write("updataExpSuccess");
		pw.flush();
		pw.close();
	}
	//得到个人工作履历信息
	public void getStaffExpByExpId() throws IOException{
		rlzy_staffexp rs = staffExpService.getStaffExpById(rlzy_staffExp_id);
		HttpServletResponse response = ServletActionContext.getResponse();
		System.out.println(rlzy_staffExp_id);
		response.setContentType("text/html;charset=utf-8");
		Gson gson = new Gson();
		String result = gson.toJson(rs);
		PrintWriter pw =response.getWriter();
		pw.write(result);
		pw.flush();
		pw.close();
	}
	//得到所有员工的工作履历信息
	public void getAllStaffExpByPage() throws IOException{
		staffExpService.getStaffExpByPage(staffExpVO);
		System.out.println("测试进入员工履历");
		System.out.println(staffExpVO.getStaffExp_staff());
		Gson gson = new Gson();
		String result = gson.toJson(staffExpVO);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		System.out.println(result);
		PrintWriter pw =response.getWriter();
		pw.write(result);
		pw.flush();
		pw.close();
	}
	
	private rlzy_staffexp staffExp;
	private showStaffExpVO staffExpVO;
	private String rlzy_staffExp_id;


	public String getRlzy_staffExp_id() {
		return rlzy_staffExp_id;
	}

	public void setRlzy_staffExp_id(String rlzy_staffExp_id) {
		this.rlzy_staffExp_id = rlzy_staffExp_id;
	}

	public rlzy_staffexp getStaffExp() {
		return staffExp;
	}

	public void setStaffExp(rlzy_staffexp staffExp) {
		this.staffExp = staffExp;
	}

	public showStaffExpVO getStaffExpVO() {
		return staffExpVO;
	}

	public void setStaffExpVO(showStaffExpVO staffExpVO) {
		this.staffExpVO = staffExpVO;
	}

	
}
