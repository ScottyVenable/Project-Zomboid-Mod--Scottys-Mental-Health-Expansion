BipolarSystem = {}

-- Bipolar disorder subtypes
BipolarSystem.BIPOLAR_I = 1
BipolarSystem.BIPOLAR_II = 2
BipolarSystem.BIPOLAR_I_PSYCHOTIC = 3

-- Mood states
BipolarSystem.MOOD_STABLE = 0
BipolarSystem.MOOD_DEPRESSED = 1
BipolarSystem.MOOD_HYPOMANIC = 2
BipolarSystem.MOOD_MANIC = 3
BipolarSystem.MOOD_MIXED = 4

-- Initialize bipolar-specific data
function BipolarSystem.initBipolarData(player)
    local modData = player:getModData()
    if not modData.MentalHealth then return end

    if not modData.MentalHealth.bipolar then
        modData.MentalHealth.bipolar = {
            severity = 0,                    -- Overall bipolar severity 0-100
            subtype = 0,                     -- No bipolar initially
            currentMoodState = BipolarSystem.MOOD_STABLE,
            moodSeverity = 0,               -- Severity of current episode 0-100
            
            -- Episode tracking
            episodeStartTime = 0,
            lastEpisodeEnd = 0,
            episodeHistory = {},
            
            -- Mood tracking
            dailyMoods = {},               -- Last 30 days of mood ratings
            lastMoodCheck = 0,
            
            -- Triggers and patterns
            sleepDisruption = 0,
            stressLevel = 0,
            seasonalPattern = false,
            rapidCycling = false,
            
            -- Medication levels
            moodStabilizers = {
                lithizone = {level = 0, lastTaken = 0, bloodLevel = 0},
                valprex = {level = 0, lastTaken = 0},
                lamotrigex = {level = 0, lastTaken = 0}
            },
            
            -- Coping resources
            moodTrackingSkill = 0,
            episodePrevention = 0,
            crisisPlanning = 0
        }
    end

    -- Set subtype based on chosen traits
    if player:HasTrait("BipolarI") then
        modData.MentalHealth.bipolar.subtype = BipolarSystem.BIPOLAR_I
        modData.MentalHealth.bipolar.severity = 20
    elseif player:HasTrait("BipolarII") then
        modData.MentalHealth.bipolar.subtype = BipolarSystem.BIPOLAR_II
        modData.MentalHealth.bipolar.severity = 15
    elseif player:HasTrait("BipolarIPsychotic") then
        modData.MentalHealth.bipolar.subtype = BipolarSystem.BIPOLAR_I_PSYCHOTIC
        modData.MentalHealth.bipolar.severity = 25
    end
end

-- Update bipolar condition
function BipolarSystem.updateBipolar(player, mh, currentTime, timeDelta)
    if not mh.bipolar or mh.bipolar.subtype == 0 then return end
    
    local bipolar = mh.bipolar
    
    -- Process mood stabilizer medications
    BipolarSystem.processMoodStabilizers(player, bipolar, currentTime)
    
    -- Check for episode triggers
    BipolarSystem.checkEpisodeTriggers(player, bipolar, currentTime)
    
    -- Update current episode
    BipolarSystem.updateCurrentEpisode(player, bipolar, currentTime, timeDelta)
    
    -- Apply episode symptoms
    BipolarSystem.applyEpisodeSymptoms(player, bipolar)
    
    -- Update mood tracking
    BipolarSystem.updateMoodTracking(player, bipolar, currentTime)
    
    -- Check for mood state transitions
    BipolarSystem.checkMoodTransitions(player, bipolar, currentTime)
end

-- Process mood stabilizer medications
function BipolarSystem.processMoodStabilizers(player, bipolar, currentTime)
    -- Lithizone (Lithium) - requires regular dosing
    if bipolar.moodStabilizers.lithizone.level > 0 then
        local timeSinceTaken = currentTime - bipolar.moodStabilizers.lithizone.lastTaken
        
        -- Update blood level (half-life simulation)
        if timeSinceTaken > 0 then
            bipolar.moodStabilizers.lithizone.bloodLevel =
                bipolar.moodStabilizers.lithizone.bloodLevel * math.pow(0.5, timeSinceTaken / 24)
        end
        local stats = player:getStats()
        stats:setThirst(math.min(1.0, stats:getThirst() + bipolar.moodStabilizers.lithizone.bloodLevel * 0.002))
        
        -- Check therapeutic range
        if bipolar.moodStabilizers.lithizone.bloodLevel >= 0.6 and 
           bipolar.moodStabilizers.lithizone.bloodLevel <= 1.2 then
            -- Therapeutic effect
            bipolar.moodSeverity = math.max(0, bipolar.moodSeverity - 0.5)
        elseif bipolar.moodStabilizers.lithizone.bloodLevel > 1.2 then
            -- Toxicity effects
            player:getStats():setFatigue(math.min(1.0, player:getStats():getFatigue() + 0.2))
            if ZombRand(100) < 5 then
                player:Say("I feel shaky and nauseous... too much lithium?")
            end
        end

        -- Heavy toxicity
        if bipolar.moodStabilizers.lithizone.bloodLevel > 1.5 then
            player:getStats():setFatigue(math.min(1.0, player:getStats():getFatigue() + 0.1))
            player:getStats():setStress(math.min(1.0, player:getStats():getStress() + 0.05))
            if ZombRand(100) < 10 then
                player:Say("I'm really sick from all this Lithizone...")
            end
        end
        
        -- Decrease level over time
        bipolar.moodStabilizers.lithizone.level = 
            math.max(0, bipolar.moodStabilizers.lithizone.level - (timeSinceTaken / 12))
    end
    
    -- Valprex (Valproate) - broader spectrum
    if bipolar.moodStabilizers.valprex.level > 0 then
        local timeSinceTaken = currentTime - bipolar.moodStabilizers.valprex.lastTaken
        if timeSinceTaken < 12 then
            -- Effective for mixed episodes and rapid cycling
            if bipolar.currentMoodState == BipolarSystem.MOOD_MIXED then
                bipolar.moodSeverity = math.max(0, bipolar.moodSeverity - 1.0)
            else
                bipolar.moodSeverity = math.max(0, bipolar.moodSeverity - 0.3)
            end
            local stats = player:getStats()
            stats:setFatigue(math.min(1.0, stats:getFatigue() + 0.005))
        else
            bipolar.moodStabilizers.valprex.level =
                math.max(0, bipolar.moodStabilizers.valprex.level - 1)
        end
    end
    
    -- Lamotrigex (Lamotrigine) - depression prevention
    if bipolar.moodStabilizers.lamotrigex.level > 0 then
        local timeSinceTaken = currentTime - bipolar.moodStabilizers.lamotrigex.lastTaken
        if timeSinceTaken < 24 then
            -- Particularly effective for bipolar depression
            if bipolar.currentMoodState == BipolarSystem.MOOD_DEPRESSED then
                bipolar.moodSeverity = math.max(0, bipolar.moodSeverity - 0.8)
            end
            local mh = player:getModData().MentalHealth
            if mh then
                mh.insomnia = math.min(100, mh.insomnia + 0.1)
            end
            if ZombRand(1000) < 1 then
                player:Say("My skin feels irritated from Lamotrigex...")
            end
        else
            bipolar.moodStabilizers.lamotrigex.level =
                math.max(0, bipolar.moodStabilizers.lamotrigex.level - 1)
        end
    end
end

-- Check for episode triggers
function BipolarSystem.checkEpisodeTriggers(player, bipolar, currentTime)
    local stats = player:getStats()
    
    -- Sleep disruption trigger
    local sleepHours = BipolarSystem.calculateSleepHours(player)
    if sleepHours < 4 then
        bipolar.sleepDisruption = math.min(100, bipolar.sleepDisruption + 10)
    elseif sleepHours > 10 then
        bipolar.sleepDisruption = math.min(100, bipolar.sleepDisruption + 5)
    else
        bipolar.sleepDisruption = math.max(0, bipolar.sleepDisruption - 2)
    end
    
    -- Stress level accumulation
    local currentStress = stats:getStress()
    if currentStress > 0.7 then
        bipolar.stressLevel = math.min(100, bipolar.stressLevel + 2)
    else
        bipolar.stressLevel = math.max(0, bipolar.stressLevel - 0.5)
    end
    
    -- Trigger episode if thresholds met
    if bipolar.currentMoodState == BipolarSystem.MOOD_STABLE then
        if bipolar.sleepDisruption > 60 or bipolar.stressLevel > 80 then
            BipolarSystem.triggerMoodEpisode(player, bipolar, currentTime)
        end
    end
end

-- Calculate sleep hours (simplified)
function BipolarSystem.calculateSleepHours(player)
    -- This would need actual sleep tracking implementation
    local fatigue = player:getStats():getFatigue()
    if fatigue < 0.2 then
        return 8 -- Well rested
    elseif fatigue < 0.5 then
        return 6 -- Moderately rested
    elseif fatigue < 0.8 then
        return 4 -- Tired
    else
        return 2 -- Exhausted
    end
end

-- Trigger a new mood episode
function BipolarSystem.triggerMoodEpisode(player, bipolar, currentTime)
    if bipolar.currentMoodState ~= BipolarSystem.MOOD_STABLE then return end
    
    local episodeType = BipolarSystem.MOOD_DEPRESSED -- Default
    
    -- Determine episode type based on triggers and history
    if bipolar.sleepDisruption > 70 then
        -- Sleep deprivation more likely to trigger mania
        if bipolar.subtype == BipolarSystem.BIPOLAR_I or 
           bipolar.subtype == BipolarSystem.BIPOLAR_I_PSYCHOTIC then
            episodeType = BipolarSystem.MOOD_MANIC
        else
            episodeType = BipolarSystem.MOOD_HYPOMANIC
        end
    elseif bipolar.stressLevel > 90 then
        -- High stress can trigger mixed episodes
        episodeType = BipolarSystem.MOOD_MIXED
    end
    
    -- Start episode
    bipolar.currentMoodState = episodeType
    bipolar.moodSeverity = ZombRand(30, 60) -- Starting severity
    bipolar.episodeStartTime = currentTime
    
    -- Add to history
    table.insert(bipolar.episodeHistory, {
        type = episodeType,
        startTime = currentTime,
        severity = bipolar.moodSeverity
    })
    
    -- Player notification
    BipolarSystem.announceEpisodeStart(player, episodeType)
end

-- Announce episode start to player
function BipolarSystem.announceEpisodeStart(player, episodeType)
    if episodeType == BipolarSystem.MOOD_DEPRESSED then
        player:Say("I feel like I'm sinking into darkness again...")
    elseif episodeType == BipolarSystem.MOOD_MANIC then
        player:Say("I feel incredible! Like I can do anything!")
    elseif episodeType == BipolarSystem.MOOD_HYPOMANIC then
        player:Say("I'm feeling really energetic and productive today.")
    elseif episodeType == BipolarSystem.MOOD_MIXED then
        player:Say("I feel agitated and restless... nothing feels right.")
    end
end

-- Update current episode progression
function BipolarSystem.updateCurrentEpisode(player, bipolar, currentTime, timeDelta)
    if bipolar.currentMoodState == BipolarSystem.MOOD_STABLE then return end
    
    local episodeDuration = currentTime - bipolar.episodeStartTime
    
    -- Natural episode progression
    if bipolar.currentMoodState == BipolarSystem.MOOD_DEPRESSED then
        -- Depression tends to last longer
        if episodeDuration > 336 then -- 2 weeks
            bipolar.moodSeverity = math.max(0, bipolar.moodSeverity - 1)
        end
    elseif bipolar.currentMoodState == BipolarSystem.MOOD_MANIC then
        -- Mania episodes are shorter but intense
        if episodeDuration > 168 then -- 1 week
            bipolar.moodSeverity = math.max(0, bipolar.moodSeverity - 2)
        end
    elseif bipolar.currentMoodState == BipolarSystem.MOOD_HYPOMANIC then
        -- Hypomania is milder and shorter
        if episodeDuration > 96 then -- 4 days
            bipolar.moodSeverity = math.max(0, bipolar.moodSeverity - 3)
        end
    end
    
    -- End episode if severity drops to zero
    if bipolar.moodSeverity <= 0 then
        BipolarSystem.endCurrentEpisode(player, bipolar, currentTime)
    end
end

-- End current mood episode
function BipolarSystem.endCurrentEpisode(player, bipolar, currentTime)
    local previousState = bipolar.currentMoodState
    
    bipolar.currentMoodState = BipolarSystem.MOOD_STABLE
    bipolar.moodSeverity = 0
    bipolar.lastEpisodeEnd = currentTime
    
    -- Update episode history
    if #bipolar.episodeHistory > 0 then
        bipolar.episodeHistory[#bipolar.episodeHistory].endTime = currentTime
        bipolar.episodeHistory[#bipolar.episodeHistory].duration = 
            currentTime - bipolar.episodeStartTime
    end
    
    player:Say("I'm starting to feel more like myself again...")
    
    -- Check for rapid cycling pattern
    BipolarSystem.checkRapidCycling(bipolar)
end

-- Check for rapid cycling pattern
function BipolarSystem.checkRapidCycling(bipolar)
    if #bipolar.episodeHistory >= 4 then
        local recentEpisodes = 0
        local currentTime = getGameTime():getWorldAgeHours()
        
        for i = #bipolar.episodeHistory, 1, -1 do
            local episode = bipolar.episodeHistory[i]
            if currentTime - episode.startTime <= 8760 then -- Within 1 year
                recentEpisodes = recentEpisodes + 1
            else
                break
            end
        end
        
        if recentEpisodes >= 4 then
            bipolar.rapidCycling = true
        end
    end
end

-- Apply symptoms based on current mood state
function BipolarSystem.applyEpisodeSymptoms(player, bipolar)
    local stats = player:getStats()
    
    if bipolar.currentMoodState == BipolarSystem.MOOD_DEPRESSED then
        -- Depressive episode symptoms
        stats:setFatigue(math.min(1.0, stats:getFatigue() + (bipolar.moodSeverity * 0.01)))
        -- Reduced movement speed during severe depression
        if bipolar.moodSeverity > 70 then
            -- This would need movement speed modification
        end
        
    elseif bipolar.currentMoodState == BipolarSystem.MOOD_MANIC then
        -- Manic episode symptoms
        stats:setFatigue(math.max(0, stats:getFatigue() - (bipolar.moodSeverity * 0.008)))
        
        -- Increased recklessness and poor judgment
        if bipolar.moodSeverity > 60 and ZombRand(1000) < 5 then
            player:Say("I feel invincible! Nothing can stop me!")
        end
        
        -- Psychotic features for Bipolar I with psychotic features
        if bipolar.subtype == BipolarSystem.BIPOLAR_I_PSYCHOTIC and bipolar.moodSeverity > 80 then
            if ZombRand(2000) < 1 then
                BipolarSystem.triggerPsychoticSymptom(player)
            end
        end
        
    elseif bipolar.currentMoodState == BipolarSystem.MOOD_HYPOMANIC then
        -- Hypomanic episode symptoms
        stats:setFatigue(math.max(0, stats:getFatigue() - (bipolar.moodSeverity * 0.005)))
        
        -- Mild productivity boost
        if bipolar.moodSeverity > 40 then
            -- This could provide XP bonuses for certain activities
        end
        
    elseif bipolar.currentMoodState == BipolarSystem.MOOD_MIXED then
        -- Mixed episode symptoms - most dangerous
        stats:setPanic(math.min(100, stats:getPanic() + (bipolar.moodSeverity * 0.1)))
        stats:setStress(math.min(1.0, stats:getStress() + (bipolar.moodSeverity * 0.01)))
        
        if bipolar.moodSeverity > 70 and ZombRand(5000) < 1 then
            player:Say("I can't sit still... everything feels wrong...")
        end
    end
end

-- Trigger psychotic symptom during manic episode
function BipolarSystem.triggerPsychoticSymptom(player)
    local psychoticSymptoms = {
        "I can hear the cosmic energy speaking to me...",
        "I have been chosen for a special mission...",
        "I can see the connections others can't see...",
        "The government is definitely monitoring this area..."
    }
    
    if ZombRand(2) == 0 then
        -- Auditory hallucination
        player:getEmitter():playSound("ZombieHit")
        player:Say("Did you hear that voice?")
    else
        -- Delusional thought
        player:Say(psychoticSymptoms[ZombRand(#psychoticSymptoms) + 1])
    end
end

-- Medication taking functions for mood stabilizers
function BipolarSystem.takeLithizone(player)
    local bipolar = player:getModData().MentalHealth.bipolar
    if bipolar then
        bipolar.moodStabilizers.lithizone.level = 
            math.min(3, bipolar.moodStabilizers.lithizone.level + 1)
        bipolar.moodStabilizers.lithizone.lastTaken = getGameTime():getWorldAgeHours()
        bipolar.moodStabilizers.lithizone.bloodLevel = 
            bipolar.moodStabilizers.lithizone.bloodLevel + 0.4
        player:Say("Taking my lithium... need to stay consistent.")
    end
end

function BipolarSystem.takeValprex(player)
    local bipolar = player:getModData().MentalHealth.bipolar
    if bipolar then
        bipolar.moodStabilizers.valprex.level = 
            math.min(2, bipolar.moodStabilizers.valprex.level + 1)
        bipolar.moodStabilizers.valprex.lastTaken = getGameTime():getWorldAgeHours()
        player:Say("This should help with the mood swings...")
    end
end

function BipolarSystem.takeLamotrigex(player)
    local bipolar = player:getModData().MentalHealth.bipolar
    if bipolar then
        bipolar.moodStabilizers.lamotrigex.level = 
            math.min(2, bipolar.moodStabilizers.lamotrigex.level + 1)
        bipolar.moodStabilizers.lamotrigex.lastTaken = getGameTime():getWorldAgeHours()
        player:Say("This helps prevent the depression episodes...")
    end
end

-- Unlock mood tracking after reading workbook
function BipolarSystem.useMoodTracking(player)
    local bipolar = player:getModData().MentalHealth.bipolar
    if bipolar then
        bipolar.moodTrackingSkill = 1
        player:Say("I can start keeping track of my moods now.")
    end
end

-- Mood tracking function
function BipolarSystem.trackMood(player, moodRating)
    local bipolar = player:getModData().MentalHealth.bipolar
    if bipolar then
        local currentTime = getGameTime():getWorldAgeHours()
        local daysSinceStart = math.floor(currentTime / 24)
        
        bipolar.dailyMoods[daysSinceStart] = moodRating
        bipolar.lastMoodCheck = currentTime
        
        -- Remove old mood data (keep last 30 days)
        for day, mood in pairs(bipolar.dailyMoods) do
            if daysSinceStart - day > 30 then
                bipolar.dailyMoods[day] = nil
            end
        end
        
        player:Say("Tracking my mood helps me see patterns...")
    end
end

-- Integration with main mental health system
Events.OnCreatePlayer.Add(function(playerIndex, player)
    BipolarSystem.initBipolarData(player)
end)
