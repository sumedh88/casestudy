package com.devops.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devops.DAO.DBClass;
import com.devops.BO.Employee;

@SuppressWarnings("serial")
public class EmpListServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String dbHost = request.getParameter("dbhost");
		String dbPort = request.getParameter("dbport");
		String dbName = request.getParameter("dbname");
		String dbUser = request.getParameter("dbuser");
		String dbPasswd = request.getParameter("dbpasswd");
		
		Employee[] emp_list=new DBClass(dbHost ,dbPort ,dbName ,dbUser ,dbPasswd).getLateStayList();
		PrintWriter out = response.getWriter();
		String str="<tr><th>Employee ID</th><th>Employee Name</th><th>Drop Point</th></tr>";
		if(emp_list!=null){
			for(int i=0;i<emp_list.length;i++)
				str+="<tr><td>"+emp_list[i].getEmp_id()+"</td><td>"+emp_list[i].getEmp_name()+"</td><td>"+emp_list[i].getEmp_location()+"</td></tr>";	
		}
		else
		{
			str=dbHost  + ":" +    dbPort  + ":" +    dbName  + ":" +    dbUser  + ":" +    dbPasswd;
		}
		out.println(str);
		out.close();
	}

}
