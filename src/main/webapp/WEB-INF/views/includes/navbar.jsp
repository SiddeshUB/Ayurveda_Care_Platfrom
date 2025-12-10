<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Navbar -->
<nav class="navbar">
    <div class="container nav-container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">Ayurveda Wellness</a>
        <button class="mobile-menu-btn">
            <i class="fas fa-bars"></i>
        </button>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/hospitals">Find Centers</a></li>
            <li><a href="${pageContext.request.contextPath}/doctors">Find Doctors</a></li>
            <li><a href="${pageContext.request.contextPath}/products"><i class="fas fa-shopping-bag"></i> Products</a></li>
            <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            <c:choose>
                <c:when test="${not empty currentUser}">
                    <li class="user-menu-container">
                        <a href="#" class="user-name-link" id="userMenuToggle">
                            <i class="fas fa-user-circle"></i>
                            <span>${currentUser.fullName}</span>
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="user-dropdown" id="userDropdown">
                            <a href="${pageContext.request.contextPath}/user/dashboard">
                                <i class="fas fa-th-large"></i> Dashboard
                            </a>
                            <a href="${pageContext.request.contextPath}/user/profile">
                                <i class="fas fa-user"></i> Your Profile
                            </a>
                            <a href="${pageContext.request.contextPath}/user/enquiries">
                                <i class="fas fa-envelope"></i> My Enquiries
                            </a>
                            <a href="${pageContext.request.contextPath}/user/saved-centers">
                                <i class="fas fa-heart"></i> Saved Centers
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/user/logout">
                                <i class="fas fa-sign-out-alt"></i> Sign Out
                            </a>
                        </div>
                    </li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/user/login">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/register" class="nav-cta">Sign Up</a></li>
                    <li><a href="${pageContext.request.contextPath}/hospital/register" class="nav-cta">For Centers</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

