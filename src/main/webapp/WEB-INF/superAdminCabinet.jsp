<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<html lang="en">
<head>
  <title>Кабінет</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

    <style>
            .btn{
                float: left;
                width: 200px;
                height: 30px;
                font-size: 15px;
            }.facBtn{
                float: left;
                width: 200px;
                height: 30px;
                font-size: 15px;
            }.menu{
                width: 100%;
                justify-content: center;
                display: flex;
            }th{
                border: 1px solid black;
                border-bottom: 2px solid black;
            }td{
                border: 1px solid black;
                font-family: sans-serif;

            }table{
                border: 2px solid black;
            }.info{
                position: absolute;
                background-color: lightgray;
                width: 600px;
                height: 330px;
                border-radius: 10px;
                border: 2px solid black;
            }.infoHolder{
                position: absolute;
                width: 100%;
                height: 100%;
                display: flex;
                justify-content: center;
                margin-left: 20px;
            }.mainInfoHolder{
                width: 56%;
                margin-left: 22%;
            }.studentPhoto{
                height: 120px;
            }
        </style>
</head>
<body>
   <jsp:include page="header.jsp"></jsp:include>

   <div class="menu">
    <form action="/superAdminCabinet/Faculties" method ="get">
        <input class="btn" type="submit" value="Факультети">
    </form>
    <form action="/superAdminCabinet/Admins" method ="get">
        <input class="btn" type="submit" value="Адміністратори">
    </form>
    <form action="/superAdminCabinet/Entrants" method ="get">
        <input class="btn" type="submit" value="Вступники">
    </form>
    <form action="/superAdminCabinet/theEnd" method ="get">
        <input type="submit" value="Кінець" style="background-color: red; font-weight: 900; float: left; width: 90px; height: 30px; font-size: 18px; border-radius: 50px;">
    </form>

   </div>
   <c:choose>
   <c:when test="${choose == 'admins'}">
       <div class="mainInfoHolder">
        <table>
            <p style="font-size: 30px">Адміністратори:</p>
            <form action="/superAdminCabinet/addAdmin" method ="get">
                <input class="btn" type="submit" value="Додати адміністратора"  style="background-color: lightgreen; border-radius: 5px;">
            </form>
            <br>
            <br>
            <br>
             <tr>
                <th style="width: 50px;">№</th>
                <th style="width: 300px;">Пошта</th>
                <th style="width: 150px;">Пароль</th>
                <th style="width: 150px;">Роль</th>
                <th style="width: 150px;"></th>
                <th style="width: 150px;"></th>
             </tr>
             <c:forEach var="admin" items="${admins}" varStatus="сounter">
                  <tr>
                      <td class ="number">${сounter.count}</td>
                      <td>${admin.email}</td>
                      <td>${admin.password}</td>
                      <td>${admin.role}</td>
                      <td><a href="/superAdminCabinet/editAdmin?id=${admin.id}" style="color: blue">Редагувати</a></td>
                      <td><a href="/superAdminCabinet/deleteAdmin?id=${admin.id}" style="color: red">Видалити</a></td>
                  </tr>
             </c:forEach>
        </table>
       </div>
    </c:when>
    <c:when test="${choose == 'entrants'}">
       <div class="mainInfoHolder">
        <table>
        <p style="font-size: 30px">Вступники:</p>
             <tr>
                <th style="width: 30px;">№</th>
                <th style="width: 180px;">Прізвище та ім'я</th>
                <th style="width: 150px;">Електронна пошта</th>
                <th style="width: 50px;">Детальніше</th>
                <th style="width: 150px;">Статус</th>
                <th style="width: 150px;"></th>
             </tr>

             <c:forEach var="entrant" items="${entrants}" varStatus="сounter">
                  <tr>
                      <td class ="number">${сounter.count}</td>
                      <td>${entrant.surname} ${entrant.name}</td>
                      <td>${entrant.email}</td>

                      <td>
                      <input class="facBtn" type="button" value="Детальніше" onClick="showEntrant('${entrant.id}','${entrant.surname} ${entrant.name}', '${entrant.email}', '${entrant.schoolGPA}')">

                        <c:forEach var="grade" items="${grades}">
                            <c:if test="${entrant.id == grade.entrant.id}">
                                <input type="hidden" class="${entrant.id}subName" value="${grade.subject.ukrainianName}">
                                <input type="hidden" class="${entrant.id}subGrade" value="${grade.grade}">
                            </c:if>
                        </c:forEach>

                        <c:forEach var="application" items="${applications}">
                            <c:if test="${entrant.id == application.entrant.id}">
                                <input type="hidden" class="${entrant.id}appName" value="${application.faculty.name}">
                                <input type="hidden" class="${entrant.id}appGrade" value="${application.GPA}">
                                <input type="hidden" class="${entrant.id}facId" value="${application.faculty.id}">
                                <input type="hidden" class="${entrant.id}priority" value="${application.priority}">
                            </c:if>
                        </c:forEach>
                      </td>

                      <c:if  test="${entrant.role == 'NOT_VERIFIED_ENTRANT'}">
                          <td><a href="/cabinet/admin/activateEntrant?id=${entrant.id}" style="color: green">Підтвердити</a></td>
                      </c:if>
                      <c:if  test="${entrant.role == 'NOT_VERIFIED_EMAIL_ENTRANT'}">
                          <td>Емейл не підтверджено</td>
                      </c:if>
                      <c:if  test="${entrant.role == 'ENTRANT'}">
                          <td>Підтверджено</td>
                      </c:if>
                      <c:if  test="${entrant.role == 'PAST'}">
                           <td>Пройшов</td>
                      </c:if>
                      <c:if  test="${entrant.role == 'NOT_PAST'}">
                           <td>Не пройшов</td>
                      </c:if>
                      <td><a href="/cabinet/admin/deleteEntrant?id=${entrant.id}" style="color: red">Відхилити</a></td>
                  </tr>
             </c:forEach>
        </table>
        </div>
    </c:when>
    <c:when test="${choose == 'faculties'}">
       <div class="mainInfoHolder">
        <table>
            <p style="font-size: 30px">Факультети:</p>

            <form action="/superAdminCabinet/addFaculty" method ="get">
                <input class="btn" type="submit" value="Додати факультет"  style="background-color: lightgreen; border-radius: 5px;">
            </form>
            <br>
            <br>
            <br>

             <tr>
                <th style="width: 50px;">№</th>
                <th style="width: 300px;">Факультет</th>
                <th style="width: 100px;">Описання</th>
                <th style="width: 150px;"></th>
                <th style="width: 130px;"></th>

             </tr>
             <c:forEach var="faculty" items="${faculties}" varStatus="сounter">
                  <tr>
                      <td class ="number">${сounter.count}</td>
                      <td><a href="/faculty?id=${faculty.id}">${faculty.name}</a></td>
                      <td><input class="facBtn" type="button" value="Детальніше" onClick="showFaculty('${faculty.id}','${faculty.name}', '${faculty.places}', '${faculty.description}')"></td>
                      <td><a href="/superAdminCabinet/editFaculty?id=${faculty.id}" style="color: blue">Редагувати</a></td>
                      <td><a href="/superAdminCabinet/deleteFaculty?id=${faculty.id}" style="color: red">Видалити</a></td>

                      <c:forEach var="coef" items="${coefs}">
                        <c:if test="${faculty.id == coef.faculty.id}">
                            <input type="hidden" class="${faculty.id}Name" value="${coef.subject.ukrainianName}">
                            <input type="hidden" class="${faculty.id}Coef" value="${coef.coefficient}">
                        </c:if>
                      </c:forEach>
                  </tr>
             </c:forEach>
        </table>
        </div>
    </c:when>
    </c:choose>
    <script src="/js/superAdminCabinet.js"></script>
</body>
</html></html>