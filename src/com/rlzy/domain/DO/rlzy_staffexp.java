package com.rlzy.domain.DO;
//工作经历表
public class rlzy_staffexp {
	private String rlzy_staffExp_id;//工作经历id(uuid)
	private String staffExp_staff;//外键，员工工号
	private String staffExp_address;//工作地址
	private String staffExp_startTime;//开始时间
	private String staffExp_overTime;//结束时间
	private String staffExp_remark;//备注


	public String getRlzy_staffExp_id() {
		return rlzy_staffExp_id;
	}
	public void setRlzy_staffExp_id(String rlzy_staffExp_id) {
		this.rlzy_staffExp_id = rlzy_staffExp_id;
	}
	public String getStaffExp_staff() {
		return staffExp_staff;
	}
	public void setStaffExp_staff(String staffExp_staff) {
		this.staffExp_staff = staffExp_staff;
	}
	public String getStaffExp_address() {
		return staffExp_address;
	}
	public void setStaffExp_address(String staffExp_address) {
		this.staffExp_address = staffExp_address;
	}
	public String getStaffExp_startTime() {
		return staffExp_startTime;
	}
	public void setStaffExp_startTime(String staffExp_startTime) {
		this.staffExp_startTime = staffExp_startTime;
	}
	public String getStaffExp_overTime() {
		return staffExp_overTime;
	}
	public void setStaffExp_overTime(String staffExp_overTime) {
		this.staffExp_overTime = staffExp_overTime;
	}
	public String getStaffExp_remark() {
		return staffExp_remark;
	}
	public void setStaffExp_remark(String staffExp_remark) {
		this.staffExp_remark = staffExp_remark;
	}
	
	
	
}