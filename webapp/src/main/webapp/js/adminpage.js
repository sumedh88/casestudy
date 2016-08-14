$(document).ready(function(){
	$("#list").hide();
	$("#reg_emp_form").hide();
	dbhost = sessionStorage.getItem('dbhost');
	dbport=sessionStorage.getItem('dbport');
	dbname=sessionStorage.getItem('dbname');
	dbuser=sessionStorage.getItem('dbuser');
	dbpasswd=sessionStorage.getItem('dbpasswd');
	
	$("#late_stay_list").click(function(e){
		e.preventDefault();
		$("#msg").html("");
		$.post("../EmpListServlet", {'dbhost':dbhost, 'dbport':dbport ,'dbname':dbname ,'dbuser':dbuser , 'dbpasswd':dbpasswd}, function(result){
			$("#list").show();
			$("#reg_emp_form").hide();
	        $("#list").html(result);
	    });
	});
	$("#reg_emp").click(function(e){
		e.preventDefault();
		$("#msg").html("");
		$("#list").hide();
		$("#reg_emp_form").show();
	});
	
	$("#reg_emp_form").submit(function(e){
		e.preventDefault();
		var name=$("#name").val();
		var passwd=$("#passwd").val();
		var id=$("#id").val();
		$.post("../RegEmpServlet", {'name':name,'passwd':passwd,'id':id, 'dbhost':dbhost, 'dbport':dbport ,'dbname':dbname ,'dbuser':dbuser , 'dbpasswd':dbpasswd}, function(result){
			if(result == 1){
				$("#list").hide();
				$("#reg_emp_form").hide();
		        $("#msg").html("Employee Successfully Registered");
			}else{
				$("#msg").html("Employee ID already registered");
			}
	    });
	});
	
	$("#logout").click(function(e){
		window.location.href="homepage.html";
		
	});
});
