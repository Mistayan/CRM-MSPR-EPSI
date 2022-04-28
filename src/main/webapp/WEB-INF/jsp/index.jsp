<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JAVA</title>
</head>
<body>
<h1><c:out value="${title}"/></h1>
<div> Vive le python !</div>
<button onclick="print_test()"> CLICK</button>
</body>

<script>
    console.log("test");
    var i = 0;

    function print_test() {
        console.log("test", i++);
    }
</script>

</html>