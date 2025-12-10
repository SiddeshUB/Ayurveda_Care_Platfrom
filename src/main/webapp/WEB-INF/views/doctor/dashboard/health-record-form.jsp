<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${record.id != null ? 'Edit' : 'Create'} Health Record - Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-user-md"></i>
                <span>Doctor<span class="highlight">Portal</span></span>
            </a>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/health-records" class="nav-item active">
                <i class="fas fa-file-medical"></i>
                <span>Health Records</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>${record.id != null ? 'Edit' : 'Create'} Health Record</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/health-records" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Health Records
            </a>

            <div class="form-card">
                <form action="${pageContext.request.contextPath}/doctor/health-records/${record.id != null ? record.id : 'create'}/${record.id != null ? 'update' : ''}" method="post" id="healthRecordForm">
                    <h3><i class="fas fa-user"></i> Patient Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Patient Name</label>
                            <input type="text" name="patientName" class="form-input" value="${record.patientName}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="patientEmail" class="form-input" value="${record.patientEmail}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Phone</label>
                            <input type="tel" name="patientPhone" class="form-input" value="${record.patientPhone}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-input" value="${record.dateOfBirth}">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select">
                                <option value="">Select Gender</option>
                                <option value="MALE" ${record.gender == 'MALE' ? 'selected' : ''}>Male</option>
                                <option value="FEMALE" ${record.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                                <option value="OTHER" ${record.gender == 'OTHER' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Blood Group</label>
                            <select name="bloodGroup" class="form-select">
                                <option value="">Select Blood Group</option>
                                <option value="A+" ${record.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                                <option value="A-" ${record.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                                <option value="B+" ${record.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                                <option value="B-" ${record.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                                <option value="AB+" ${record.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                                <option value="AB-" ${record.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                                <option value="O+" ${record.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                                <option value="O-" ${record.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                            </select>
                        </div>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-heartbeat"></i> Vital Signs</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Height (cm)</label>
                            <input type="number" name="height" class="form-input" value="${record.height}" step="0.1" min="0">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Weight (kg)</label>
                            <input type="number" name="weight" class="form-input" value="${record.weight}" step="0.1" min="0">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Blood Pressure</label>
                            <input type="text" name="bloodPressure" class="form-input" value="${record.bloodPressure}" placeholder="e.g., 120/80">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Temperature (°C)</label>
                            <input type="number" name="temperature" class="form-input" value="${record.temperature}" step="0.1" min="0">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Pulse Rate (bpm)</label>
                            <input type="number" name="pulseRate" class="form-input" value="${record.pulseRate}" min="0">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Respiratory Rate (bpm)</label>
                            <input type="number" name="respiratoryRate" class="form-input" value="${record.respiratoryRate}" min="0">
                        </div>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-history"></i> Medical History</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Allergies</label>
                        <textarea name="allergies" class="form-textarea" rows="3" placeholder="List any known allergies...">${record.allergies}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Chronic Conditions</label>
                        <textarea name="chronicConditions" class="form-textarea" rows="3" placeholder="Chronic diseases or conditions...">${record.chronicConditions}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Past Surgeries</label>
                        <textarea name="pastSurgeries" class="form-textarea" rows="3" placeholder="Past surgical history...">${record.pastSurgeries}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Family History</label>
                        <textarea name="familyHistory" class="form-textarea" rows="3" placeholder="Family medical history...">${record.familyHistory}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Current Medications</label>
                        <textarea name="currentMedications" class="form-textarea" rows="3" placeholder="Current medications being taken...">${record.currentMedications}</textarea>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-leaf"></i> Ayurvedic Assessment</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Prakriti (Constitution)</label>
                            <select name="prakriti" class="form-select">
                                <option value="">Select Prakriti</option>
                                <option value="Vata" ${record.prakriti == 'Vata' ? 'selected' : ''}>Vata</option>
                                <option value="Pitta" ${record.prakriti == 'Pitta' ? 'selected' : ''}>Pitta</option>
                                <option value="Kapha" ${record.prakriti == 'Kapha' ? 'selected' : ''}>Kapha</option>
                                <option value="Vata-Pitta" ${record.prakriti == 'Vata-Pitta' ? 'selected' : ''}>Vata-Pitta</option>
                                <option value="Vata-Kapha" ${record.prakriti == 'Vata-Kapha' ? 'selected' : ''}>Vata-Kapha</option>
                                <option value="Pitta-Kapha" ${record.prakriti == 'Pitta-Kapha' ? 'selected' : ''}>Pitta-Kapha</option>
                                <option value="Tridosha" ${record.prakriti == 'Tridosha' ? 'selected' : ''}>Tridosha</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Vikriti (Imbalance)</label>
                            <input type="text" name="vikriti" class="form-input" value="${record.vikriti}" placeholder="Current dosha imbalance">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Agni (Digestive Fire)</label>
                            <select name="agni" class="form-select">
                                <option value="">Select Agni Status</option>
                                <option value="Sama Agni" ${record.agni == 'Sama Agni' ? 'selected' : ''}>Sama Agni (Balanced)</option>
                                <option value="Vishama Agni" ${record.agni == 'Vishama Agni' ? 'selected' : ''}>Vishama Agni (Irregular)</option>
                                <option value="Tikshna Agni" ${record.agni == 'Tikshna Agni' ? 'selected' : ''}>Tikshna Agni (Sharp)</option>
                                <option value="Manda Agni" ${record.agni == 'Manda Agni' ? 'selected' : ''}>Manda Agni (Slow)</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Ama (Toxins)</label>
                            <select name="ama" class="form-select">
                                <option value="">Select Ama Status</option>
                                <option value="No Ama" ${record.ama == 'No Ama' ? 'selected' : ''}>No Ama</option>
                                <option value="Mild Ama" ${record.ama == 'Mild Ama' ? 'selected' : ''}>Mild Ama</option>
                                <option value="Moderate Ama" ${record.ama == 'Moderate Ama' ? 'selected' : ''}>Moderate Ama</option>
                                <option value="Severe Ama" ${record.ama == 'Severe Ama' ? 'selected' : ''}>Severe Ama</option>
                            </select>
                        </div>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-running"></i> Lifestyle Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Diet Type</label>
                            <select name="dietType" class="form-select">
                                <option value="">Select Diet Type</option>
                                <option value="Vegetarian" ${record.dietType == 'Vegetarian' ? 'selected' : ''}>Vegetarian</option>
                                <option value="Non-Vegetarian" ${record.dietType == 'Non-Vegetarian' ? 'selected' : ''}>Non-Vegetarian</option>
                                <option value="Vegan" ${record.dietType == 'Vegan' ? 'selected' : ''}>Vegan</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Stress Level</label>
                            <select name="stressLevel" class="form-select">
                                <option value="">Select Stress Level</option>
                                <option value="Low" ${record.stressLevel == 'Low' ? 'selected' : ''}>Low</option>
                                <option value="Medium" ${record.stressLevel == 'Medium' ? 'selected' : ''}>Medium</option>
                                <option value="High" ${record.stressLevel == 'High' ? 'selected' : ''}>High</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Sleep Pattern</label>
                            <input type="text" name="sleepPattern" class="form-input" value="${record.sleepPattern}" placeholder="e.g., 7-8 hours, good quality">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Occupation</label>
                            <input type="text" name="occupation" class="form-input" value="${record.occupation}">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Exercise Routine</label>
                        <textarea name="exerciseRoutine" class="form-textarea" rows="3" placeholder="Exercise habits and routine...">${record.exerciseRoutine}</textarea>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 30px;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${record.id != null ? 'Update' : 'Create'} Health Record
                        </button>
                        <a href="${pageContext.request.contextPath}/doctor/health-records" class="btn btn-secondary" style="text-decoration: none;">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script>
        // Fix form action based on whether it's create or update
        const form = document.getElementById('healthRecordForm');
        const recordId = '${record.id}';
        if (recordId && recordId !== 'null' && recordId !== '') {
            form.action = '${pageContext.request.contextPath}/doctor/health-records/' + recordId + '/update';
        } else {
            form.action = '${pageContext.request.contextPath}/doctor/health-records/create';
        }
    </script>
</body>
</html>


