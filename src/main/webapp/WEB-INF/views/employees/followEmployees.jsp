<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="actEmp" value="${ForwardConst.ACT_EMP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commFAdd" value="${ForwardConst.CMD_FOLLOW_ADD.getValue()}" />
<c:set var="commFDestroy"
    value="${ForwardConst.CMD_FOLLOW_DELETE.getValue()}" />
<c:set var="commFollowIdx"
    value="${ForwardConst.CMD_FOLLOW_INDEX.getValue()}" />
<c:set var="count" value="0" />

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>フォロー可能な従業員一覧</h2>
        <table id="employee_list">
            <tbody>
                <tr>
                    <th>氏名</th>
                    <th>フォロー</th>
                </tr>
                <c:forEach var="employee" items="${employees}" varStatus="status">

                    <c:if
                        test="${sessionScope.login_employee.code != employee.code && employee.deleteFlag != AttributeConst.DEL_FLAG_TRUE.getIntegerValue()}">
                        <c:set var="followed" value="0" />
                        <c:forEach var="follow" items="${follows}">
                            <c:if test="${follow.followCode.code == employee.code}">
                                <c:set var="followed" value="1" />
                                <c:set var="followId" value="${follow.id}" />
                            </c:if>
                        </c:forEach>
                        <tr class="row${status.count % 2}">
                            <td><c:out value="${employee.name}" /></td>

                            <td><c:choose>
                                    <c:when test="${followed == 1}">
                                      フォロー済み   <a
                                            href="<c:url value='?action=${actEmp}&command=${commFDestroy}&id=${followId}' />">【解除する】</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a
                                            href="<c:url value='?action=${actEmp}&command=${commFAdd}&id=${employee.code}' />">フォローする</a>
                                    </c:otherwise>
                                </c:choose></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${employees_count} 件）<br />
            <c:forEach var="i" begin="1"
                end="${((employees_count - 1) / maxRow) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a
                            href="<c:url value='?action=${actEmp}&command=${commFollowIdx}&page=${i}' />"><c:out
                                value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p>
            <a href="<c:url value='?action=Top&command=index'/>">Topに戻る</a>
        </p>
    </c:param>
</c:import>