ProfessionalSkills = {}

-- Initialize professional skills for mental health workers
function ProfessionalSkills.initProfessionalSkills(player)
    local modData = player:getModData()
    local profession = player:getDescriptor():getProfession()
    
    if not modData.ProfessionalSkills then
        modData.ProfessionalSkills = {
            psychology = 0,
            socialWork = 0,
            mentalHealthLiteracy = 0,
            prescriptionAuthority = false,
            professionalCredibility = 0,
            specializations = {},
            continuingEducation = 0
        }
    end
    
    -- Set initial professional skills based on occupation
    if profession == "pharmacist" then
        modData.ProfessionalSkills.mentalHealthLiteracy = 3
        modData.ProfessionalSkills.professionalCredibility = 3
        modData.ProfessionalSkills.specializations = {"medication_management", "drug_interactions"}
        
    elseif profession == "psychologist" then
        modData.ProfessionalSkills.psychology = 3
        modData.ProfessionalSkills.mentalHealthLiteracy = 4
        modData.ProfessionalSkills.professionalCredibility = 4
        modData.ProfessionalSkills.specializations = {"therapy", "assessment", "crisis_intervention"}
        
    elseif profession == "psychiatrist" then
        modData.ProfessionalSkills.psychology = 2
        modData.ProfessionalSkills.mentalHealthLiteracy = 4
        modData.ProfessionalSkills.professionalCredibility = 5
        modData.ProfessionalSkills.prescriptionAuthority = true
        modData.ProfessionalSkills.specializations = {"medication_management", "therapy", "medical_assessment"}
        
    elseif profession == "bhp" then
        modData.ProfessionalSkills.psychology = 2
        modData.ProfessionalSkills.socialWork = 2
        modData.ProfessionalSkills.mentalHealthLiteracy = 3
        modData.ProfessionalSkills.professionalCredibility = 3
        modData.ProfessionalSkills.specializations = {"case_management", "crisis_intervention", "community_resources"}
        
    elseif profession == "dsp" then
        modData.ProfessionalSkills.psychology = 1
        modData.ProfessionalSkills.socialWork = 2
        modData.ProfessionalSkills.mentalHealthLiteracy = 2
        modData.ProfessionalSkills.professionalCredibility = 2
        modData.ProfessionalSkills.specializations = {"behavioral_support", "adaptive_skills", "communication"}
    end
end

-- Enhanced therapy effectiveness for professionals
function ProfessionalSkills.provideProfessionalTherapy(therapist, patient, therapyType)
    local therapistSkills = therapist:getModData().ProfessionalSkills
    local patientMH = patient:getModData().MentalHealth
    
    if not therapistSkills or not patientMH then return end
    
    local effectivenessBonus = 1.0
    
    -- Base professional bonus
    effectivenessBonus = effectivenessBonus + (therapistSkills.professionalCredibility * 0.1)
    
    -- Skill-specific bonuses
    if therapyType == "CBT" and therapistSkills.psychology >= 3 then
        effectivenessBonus = effectivenessBonus + 0.3
    elseif therapyType == "crisis_intervention" and 
           ProfessionalSkills.hasSpecialization(therapistSkills, "crisis_intervention") then
        effectivenessBonus = effectivenessBonus + 0.5
    elseif therapyType == "group_therapy" and therapistSkills.socialWork >= 2 then
        effectivenessBonus = effectivenessBonus + 0.2
    end
    
    -- Apply enhanced therapy benefits
    local baseReduction = 5 -- Base therapy benefit
    local enhancedReduction = baseReduction * effectivenessBonus
    
    if therapyType == "depression" then
        patientMH.depression = math.max(0, patientMH.depression - enhancedReduction)
    elseif therapyType == "anxiety" then
        patientMH.anxiety = math.max(0, patientMH.anxiety - enhancedReduction)
    elseif therapyType == "ptsd" then
        patientMH.ptsd = math.max(0, patientMH.ptsd - enhancedReduction)
    end
    
    therapist:Say("As a professional, I can provide more effective treatment.")
    patient:Say("This therapy session was really helpful.")
end

-- Professional medication management
function ProfessionalSkills.manageMedication(professional, patient, medicationType)
    local professionalSkills = professional:getModData().ProfessionalSkills
    local patientMH = patient:getModData().MentalHealth
    
    if not professionalSkills or not patientMH then return end
    
    -- Only certain professionals can prescribe
    if medicationType == "prescription" and not professionalSkills.prescriptionAuthority then
        professional:Say("I can't prescribe medications, but I can help you understand them.")
        return
    end
    
    -- Enhanced medication effectiveness
    if ProfessionalSkills.hasSpecialization(professionalSkills, "medication_management") then
        -- Reduce side effects
        local sideEffectReduction = 0.3
        
        -- Optimize dosing
        if patientMH.medications then
            for medName, medData in pairs(patientMH.medications) do
                if medData.level > 0 then
                    -- Professional management reduces side effects
                    medData.sideEffectReduction = sideEffectReduction
                end
            end
        end
        
        professional:Say("Let me optimize your medication regimen.")
    end
end

-- Check if professional has specific specialization
function ProfessionalSkills.hasSpecialization(professionalSkills, specialization)
    if not professionalSkills.specializations then return false end
    
    for _, spec in ipairs(professionalSkills.specializations) do
        if spec == specialization then
            return true
        end
    end
    return false
end

-- Professional crisis intervention
function ProfessionalSkills.handleCrisis(professional, patient)
    local professionalSkills = professional:getModData().ProfessionalSkills
    local patientMH = patient:getModData().MentalHealth
    
    if not professionalSkills or not patientMH then return end
    
    -- Check if it's a mental health crisis
    local inCrisis = false
    local crisisType = ""
    
    if patientMH.depression > 80 then
        inCrisis = true
        crisisType = "severe_depression"
    elseif patientMH.anxiety > 80 then
        inCrisis = true
        crisisType = "panic_crisis"
    elseif patientMH.psychosis > 70 then
        inCrisis = true
        crisisType = "psychotic_episode"
    end
    
    if inCrisis and ProfessionalSkills.hasSpecialization(professionalSkills, "crisis_intervention") then
        -- Professional crisis intervention is more effective
        local crisisReduction = 15 + (professionalSkills.psychology * 2)
        
        if crisisType == "severe_depression" then
            patientMH.depression = math.max(0, patientMH.depression - crisisReduction)
            professional:Say("Let's work through this crisis together. You're not alone.")
            
        elseif crisisType == "panic_crisis" then
            patientMH.anxiety = math.max(0, patientMH.anxiety - crisisReduction)
            patient:getStats():setPanic(math.max(0, patient:getStats():getPanic() - 20))
            professional:Say("Focus on your breathing. Let's use grounding techniques.")
            
        elseif crisisType == "psychotic_episode" then
            patientMH.psychosis = math.max(0, patientMH.psychosis - crisisReduction)
            professional:Say("I'm here to help you stay connected to reality.")
        end
        
        patient:Say("Having a professional here makes me feel safer.")
        return true
    end
    
    return false
end

-- Professional assessment abilities
function ProfessionalSkills.assessMentalHealth(professional, patient)
    local professionalSkills = professional:getModData().ProfessionalSkills
    local patientMH = patient:getModData().MentalHealth
    
    if not professionalSkills or not patientMH then return end
    
    if professionalSkills.psychology >= 2 then
        -- Professionals can provide detailed assessments
        local assessment = "Mental Health Assessment:\n"
        
        assessment = assessment .. "Depression: " .. math.floor(patientMH.depression) .. "% "
        if patientMH.depression > 70 then
            assessment = assessment .. "(Severe - requires immediate intervention)\n"
        elseif patientMH.depression > 40 then
            assessment = assessment .. "(Moderate - therapy recommended)\n"
        else
            assessment = assessment .. "(Mild)\n"
        end
        
        assessment = assessment .. "Anxiety: " .. math.floor(patientMH.anxiety) .. "% "
        if patientMH.anxiety > 70 then
            assessment = assessment .. "(Severe - crisis risk)\n"
        elseif patientMH.anxiety > 40 then
            assessment = assessment .. "(Moderate)\n"
        else
            assessment = assessment .. "(Mild)\n"
        end
        
        if patientMH.ptsd > 30 then
            assessment = assessment .. "PTSD: " .. math.floor(patientMH.ptsd) .. "% (Trauma history present)\n"
        end
        
        professional:Say(assessment)
        return assessment
    end
end

-- Train other survivors in mental health skills
function ProfessionalSkills.trainSurvivor(professional, student, skillType)
    local professionalSkills = professional:getModData().ProfessionalSkills
    local studentSkills = student:getModData().ProfessionalSkills or {}
    
    if not professionalSkills then return end
    
    -- Professionals can train others more effectively
    local trainingEffectiveness = 1 + (professionalSkills.professionalCredibility * 0.1)
    
    if skillType == "basic_mental_health" and professionalSkills.mentalHealthLiteracy >= 3 then
        studentSkills.mentalHealthLiteracy = (studentSkills.mentalHealthLiteracy or 0) + trainingEffectiveness
        professional:Say("Let me teach you about mental health basics.")
        student:Say("This professional training is really valuable.")
        
    elseif skillType == "crisis_response" and 
           ProfessionalSkills.hasSpecialization(professionalSkills, "crisis_intervention") then
        studentSkills.crisisResponse = (studentSkills.crisisResponse or 0) + trainingEffectiveness
        professional:Say("Here's how to recognize and respond to mental health crises.")
    end
    
    student:getModData().ProfessionalSkills = studentSkills
end

-- Initialize professional skills on character creation
Events.OnCreatePlayer.Add(function(playerIndex, player)
    ProfessionalSkills.initProfessionalSkills(player)
end)
