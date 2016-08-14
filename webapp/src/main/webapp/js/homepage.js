$(document).ready(function(){
	$("#msg").html("");
	$("#login").submit(function(e){
		e.preventDefault();
		var id=$("#id").val();
		var passwd=$("#passwd").val();
		
		dbhost = sessionStorage.getItem('dbhost');
		dbport=sessionStorage.getItem('dbport');
		dbname=sessionStorage.getItem('dbname');
		dbuser=sessionStorage.getItem('dbuser');
		dbpasswd=sessionStorage.getItem('dbpasswd');
		
		if(dbhost == null){
			dbhost=$("#dbhost").val();
			dbport=$("#dbport").val();
			dbname=$("#dbname").val();
			dbuser=$("#dbuser").val();
			dbpasswd=$("#dbpasswd").val();

			sessionStorage.setItem('dbhost',dbhost); 
			sessionStorage.setItem('dbport',dbport);
			sessionStorage.setItem('dbname',dbname);
			sessionStorage.setItem('dbuser',dbuser);
			sessionStorage.setItem('dbpasswd',dbpasswd);

		}
		
		if(id == "1" && passwd == "admin"){
			window.location.href="adminpage.html";
		}else{
			$.post("../LoginServlet", {'id':id,'passwd':passwd, 'dbhost':dbhost, 'dbport':dbport ,'dbname':dbname ,'dbuser':dbuser , 'dbpasswd':dbpasswd}, function(result){
				if(result == 1){
					sessionStorage.setItem('id',id);
					window.location.href="emppage.html";
				}else{
					$("#msg").html("Wrong credentials");
				}
		    });
		}
		
	});
	
});
