<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Create'} Prescription - Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .medicine-item {
            background: #f8fafc;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .medicine-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .medicine-item-header h4 {
            margin: 0;
            color: var(--primary-forest);
        }
        
        .remove-medicine {
            background: var(--error);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            cursor: pointer;
        }
        
        .add-medicine-btn {
            background: var(--primary-sage);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            cursor: pointer;
            font-weight: 600;
            margin-bottom: 20px;
        }
        
        .medicine-search {
            position: relative;
        }
        
        .medicine-search-results {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 100;
            display: none;
        }
        
        .medicine-search-result {
            padding: 12px;
            cursor: pointer;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .medicine-search-result:hover {
            background: #f8fafc;
        }
    </style>
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
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item active">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>${isEdit ? 'Edit' : 'Create'} Prescription</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Appointment
            </a>

            <div class="form-card">
                <div style="background: #e0f2fe; padding: 15px; border-radius: 10px; margin-bottom: 25px; border-left: 4px solid #0284c7;">
                    <strong>Patient:</strong> ${consultation.patientName} | 
                    <strong>Date:</strong> 
                    <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                    <fmt:formatDate value="${parsedDate}" pattern="dd MMMM yyyy"/>
                </div>

                <form action="${pageContext.request.contextPath}/doctor/prescriptions/create/${consultation.id}" method="post" id="prescriptionForm">
                    <h3><i class="fas fa-stethoscope"></i> Diagnosis & Assessment</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Chief Complaints</label>
                        <textarea name="chiefComplaints" class="form-textarea" rows="3" placeholder="Patient's main complaints...">${prescription.chiefComplaints}</textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Diagnosis</label>
                            <textarea name="diagnosis" class="form-textarea" rows="3" placeholder="Diagnosis...">${prescription.diagnosis}</textarea>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Dosha Imbalance</label>
                            <select name="doshaImbalance" class="form-select">
                                <option value="">Select Dosha</option>
                                <option value="Vata" ${prescription.doshaImbalance == 'Vata' ? 'selected' : ''}>Vata</option>
                                <option value="Pitta" ${prescription.doshaImbalance == 'Pitta' ? 'selected' : ''}>Pitta</option>
                                <option value="Kapha" ${prescription.doshaImbalance == 'Kapha' ? 'selected' : ''}>Kapha</option>
                                <option value="Vata-Pitta" ${prescription.doshaImbalance == 'Vata-Pitta' ? 'selected' : ''}>Vata-Pitta</option>
                                <option value="Vata-Kapha" ${prescription.doshaImbalance == 'Vata-Kapha' ? 'selected' : ''}>Vata-Kapha</option>
                                <option value="Pitta-Kapha" ${prescription.doshaImbalance == 'Pitta-Kapha' ? 'selected' : ''}>Pitta-Kapha</option>
                                <option value="Tridosha" ${prescription.doshaImbalance == 'Tridosha' ? 'selected' : ''}>Tridosha</option>
                            </select>
                        </div>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-pills"></i> Medicines</h3>
                    
                    <div id="medicinesContainer">
                        <!-- Medicines will be added here dynamically -->
                    </div>
                    
                    <button type="button" class="add-medicine-btn" onclick="addMedicineRow()">
                        <i class="fas fa-plus"></i> Add Medicine
                    </button>

                    <h3 style="margin-top: 30px;"><i class="fas fa-leaf"></i> Lifestyle & Diet Guidelines</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Diet Guidelines</label>
                        <textarea name="dietGuidelines" class="form-textarea" rows="4" placeholder="Diet recommendations (what to eat, what to avoid)...">${prescription.dietGuidelines}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Lifestyle Guidelines</label>
                        <textarea name="lifestyleGuidelines" class="form-textarea" rows="4" placeholder="Lifestyle recommendations (sleep, exercise, daily routine)...">${prescription.lifestyleGuidelines}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Yoga & Pranayama</label>
                        <textarea name="yogaPranayama" class="form-textarea" rows="3" placeholder="Recommended yoga asanas and breathing exercises...">${prescription.yogaPranayama}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Other Instructions</label>
                        <textarea name="otherInstructions" class="form-textarea" rows="3" placeholder="Any other instructions...">${prescription.otherInstructions}</textarea>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-calendar-check"></i> Follow-up</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Follow-up Date</label>
                            <input type="date" name="followUpDate" class="form-input" value="${prescription.followUpDate}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Follow-up After (Days)</label>
                            <input type="number" name="followUpDays" class="form-input" value="${prescription.followUpDays}" min="1" placeholder="e.g., 7, 14, 30">
                        </div>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 30px;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${isEdit ? 'Update' : 'Create'} Prescription
                        </button>
                        <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="btn btn-secondary" style="text-decoration: none;">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script>
        let medicineCount = 0;
        const medicines = [
            <c:forEach var="medicine" items="${medicines}" varStatus="status">
            {id: ${medicine.id}, name: "${medicine.name}", category: "${medicine.category}", dosage: "${medicine.dosage}"}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        function addMedicineRow() {
            medicineCount++;
            const container = document.getElementById('medicinesContainer');
            const medicineItem = document.createElement('div');
            medicineItem.className = 'medicine-item';
            medicineItem.id = 'medicine-' + medicineCount;
            
            medicineItem.innerHTML = `
                <div class="medicine-item-header">
                    <h4>Medicine ${medicineCount}</h4>
                    <button type="button" class="remove-medicine" onclick="removeMedicineRow(${medicineCount})">
                        <i class="fas fa-times"></i> Remove
                    </button>
                </div>
                <div class="form-row">
                    <div class="form-group" style="flex: 1;">
                        <label class="form-label">Medicine Name</label>
                        <div class="medicine-search">
                            <input type="text" name="medicineNames" class="form-input medicine-search-input" 
                                   placeholder="Search or type medicine name" 
                                   onkeyup="searchMedicines(this, ${medicineCount})" 
                                   autocomplete="off">
                            <input type="hidden" name="medicineIds" class="medicine-id-input">
                            <div class="medicine-search-results" id="search-results-${medicineCount}"></div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Dosage</label>
                        <input type="text" name="dosages" class="form-input" placeholder="e.g., 1 teaspoon, 2 tablets">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Frequency</label>
                        <select name="frequencies" class="form-select">
                            <option value="">Select Frequency</option>
                            <option value="Once daily">Once daily</option>
                            <option value="Twice daily">Twice daily</option>
                            <option value="Thrice daily">Thrice daily</option>
                            <option value="Four times daily">Four times daily</option>
                            <option value="As needed">As needed</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Timing</label>
                        <select name="timings" class="form-select">
                            <option value="">Select Timing</option>
                            <option value="Morning">Morning</option>
                            <option value="Afternoon">Afternoon</option>
                            <option value="Evening">Evening</option>
                            <option value="Night">Night</option>
                            <option value="Before food">Before food</option>
                            <option value="After food">After food</option>
                            <option value="With food">With food</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Duration (Days)</label>
                        <input type="number" name="durationDays" class="form-input" min="1" placeholder="e.g., 7, 14, 30">
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Special Instructions</label>
                    <textarea name="medicineInstructions" class="form-textarea" rows="2" placeholder="Any special instructions for this medicine..."></textarea>
                </div>
            `;
            
            container.appendChild(medicineItem);
        }

        function removeMedicineRow(id) {
            const medicineItem = document.getElementById('medicine-' + id);
            if (medicineItem) {
                medicineItem.remove();
            }
        }

        function searchMedicines(input, rowId) {
            const query = input.value.trim();
            const resultsDiv = document.getElementById('search-results-' + rowId);
            
            if (query.length < 2) {
                resultsDiv.style.display = 'none';
                return;
            }
            
            // Simple client-side search
            const filtered = medicines.filter(m => 
                m.name.toLowerCase().includes(query.toLowerCase()) ||
                (m.category && m.category.toLowerCase().includes(query.toLowerCase()))
            );
            
            if (filtered.length > 0) {
                resultsDiv.innerHTML = filtered.slice(0, 10).map(m => 
                    `<div class="medicine-search-result" onclick="selectMedicine('${m.name}', ${m.id}, ${rowId})">
                        <strong>${m.name}</strong><br>
                        <small>${m.category || ''}</small>
                    </div>`
                ).join('');
                resultsDiv.style.display = 'block';
            } else {
                resultsDiv.innerHTML = '<div class="medicine-search-result">No medicines found</div>';
                resultsDiv.style.display = 'block';
            }
        }

        function selectMedicine(name, id, rowId) {
            const row = document.getElementById('medicine-' + rowId);
            const nameInput = row.querySelector('.medicine-search-input');
            const idInput = row.querySelector('.medicine-id-input');
            const resultsDiv = document.getElementById('search-results-' + rowId);
            
            nameInput.value = name;
            idInput.value = id;
            resultsDiv.style.display = 'none';
        }

        // Close search results when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.medicine-search')) {
                document.querySelectorAll('.medicine-search-results').forEach(div => {
                    div.style.display = 'none';
                });
            }
        });

        // Add first medicine row on page load
        window.onload = function() {
            addMedicineRow();
        };
    </script>
</body>
</html>

