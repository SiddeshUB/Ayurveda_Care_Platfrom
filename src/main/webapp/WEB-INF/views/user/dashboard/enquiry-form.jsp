<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("pageTitle", "Send Enquiry");
%>
<%@include file="../layouts/user-dashboard-base.jsp" %>

<div class="dashboard-content">
    <div class="page-header">
        <h1><i class="fas fa-envelope"></i> Send Enquiry to ${hospital.centerName}</h1>
        <p>Get in touch with the hospital about your wellness needs</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <div class="card">
        <div class="card-body">
            <div style="background: var(--neutral-sand); padding: var(--spacing-lg); border-radius: var(--radius-md); margin-bottom: var(--spacing-xl);">
                <h3>${hospital.centerName}</h3>
                <p><i class="fas fa-map-marker-alt"></i> ${hospital.city}, ${hospital.state}</p>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" 
                   target="_blank" class="btn btn-outline btn-sm">
                    <i class="fas fa-external-link-alt"></i> View Full Profile
                </a>
            </div>

            <form action="${pageContext.request.contextPath}/user/enquiry/${hospital.id}" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Your Name *</label>
                        <input type="text" name="name" class="form-control" 
                               value="${user.fullName}" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Email *</label>
                        <input type="email" name="email" class="form-control" 
                               value="${user.email}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Phone *</label>
                        <input type="tel" name="phone" class="form-control" 
                               value="${user.phone}" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Country *</label>
                        <input type="text" name="country" class="form-control" 
                               value="${user.country}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Preferred Start Date</label>
                        <input type="date" name="preferredStartDate" class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Preferred End Date</label>
                        <input type="date" name="preferredEndDate" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Medical Condition</label>
                    <textarea name="condition" class="form-control" rows="3" 
                              placeholder="Please mention any health conditions or concerns..."></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Therapy Required *</label>
                    <input type="text" name="therapyRequired" class="form-control" 
                           placeholder="e.g., Panchakarma, Detox, Yoga, Healing..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Additional Message</label>
                    <textarea name="message" class="form-control" rows="4" 
                              placeholder="Tell the hospital more about your requirements, expectations, or any questions..."></textarea>
                </div>

                <div style="display: flex; gap: var(--spacing-md); margin-top: var(--spacing-xl);">
                    <a href="${pageContext.request.contextPath}/user/hospitals" 
                       class="btn btn-outline">
                        <i class="fas fa-arrow-left"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane"></i> Send Enquiry
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="../layouts/user-dashboard-footer.jsp" %>

