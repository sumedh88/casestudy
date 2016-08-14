package com.devops.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devops.DAO.DBClass;

@SuppressWarnings("serial")
public class LSCheckServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String dbHost = request.getParameter("dbhost");
		String dbPort = request.getParameter("dbport");
		String dbName = request.getParameter("dbname");
		String dbUser = request.getParameter("dbuser");
		String dbPasswd = request.getParameter("dbpasswd");
		
		// TODO Auto-generated method stub
		int ret_status=new DBClass(dbHost ,dbPort ,dbName ,dbUser ,dbPasswd).lsCheck(Integer.parseInt(request.getParameter("id")));
		PrintWriter out=response.getWriter();
		out.println(ret_status);
		out.close();
	}

}
