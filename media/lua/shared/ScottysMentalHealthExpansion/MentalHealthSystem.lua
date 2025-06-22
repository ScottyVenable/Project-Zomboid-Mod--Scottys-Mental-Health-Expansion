MentalHealthSystem = {}

-- Initialize mental health data for a player
function MentalHealthSystem.initPlayer(player)
    local modData = player:getModData()
    if not modData.MentalHealth then
        modData.MentalHealth = {
            depression = 0,
            anxiety = 0,
            ptsd = 0,
            insomnia = 0,
            psychosis = 0,
            ocd = 0,
            lastUpdate = getGameTime():getWorldAgeHours(),
            triggers = {},
            medications = {
                serizon = {level = 0, lastTaken = 0, sideEffects = {}},
                kaletraxin = {level = 0, lastTaken = 0, sideEffects = {}},
                thresta = {level = 0, lastTaken = 0, sideEffects = {}}
            },
            symptoms = {},
            lastBloodSeen = 0,
            lastCorpseSeen = 0,
            lastZombieKill = 0,
            lastPanicAttack = 0,
            journalEntries = 0,
            comfortItems = 0
        }
        print("Mental Health System initialized for player")
    end
end

-- Update mental health based on various factors
function MentalHealthSystem.updateMentalHealth(player)
    local modData = player:getModData()
    local mh = modData.MentalHealth
    
    if not mh then 
        MentalHealthSystem.initPlayer(player)
        return 
    end
    
    local currentTime = getGameTime():getWorldAgeHours()
    local timeDelta = currentTime - mh.lastUpdate
    
    -- Only update if enough time has passed (performance optimization)
    if timeDelta < 0.1 then return end
    
    -- Process medications
    MentalHealthSystem.processMedications(player, mh, currentTime)
    
    -- Check environmental triggers
    MentalHealthSystem.checkEnvironmentalTriggers(player, mh, currentTime, timeDelta)
    
    -- Apply symptoms
    MentalHealthSystem.applySymptoms(player, mh)
    
    -- Natural recovery
    MentalHealthSystem.applyRecovery(player, mh, timeDelta)
    
    -- Apply dynamic global adjustments based on mental health
    MentalHealthSystem.applyDynamicGlobalAdjustments(player, mh)
    
    mh.lastUpdate = currentTime
end

-- Process medication effects
function MentalHealthSystem.processMedications(player, mh, currentTime)
    -- Serizon - SSRI antidepressant
    if mh.medications.serizon.level > 0 then
        local timeSinceTaken = currentTime - mh.medications.serizon.lastTaken
        if timeSinceTaken < 24 then -- Active for 24 hours
            mh.depression = math.max(0, mh.depression - 0.5)
            -- Side effect: drowsiness
            if ZombRand(100) < 10 then
                player:getStats():setFatigue(math.min(1.0, player:getStats():getFatigue() + 0.1))
            end
        else
            mh.medications.serizon.level = math.max(0, mh.medications.serizon.level - 1)
        end
    end
    
    -- Kaletraxin - Fast-acting anxiety relief
    if mh.medications.kaletraxin.level > 0 then
        local timeSinceTaken = currentTime - mh.medications.kaletraxin.lastTaken
        if timeSinceTaken < 4 then -- Active for 4 hours
            mh.anxiety = math.max(0, mh.anxiety - 2)
        else
            mh.medications.kaletraxin.level = math.max(0, mh.medications.kaletraxin.level - 1)
        end
    end
    
    -- Thresta - Antipsychotic treatment
    if mh.medications.thresta.level > 0 then
        local timeSinceTaken = currentTime - mh.medications.thresta.lastTaken
        if timeSinceTaken < 12 then -- Active for 12 hours
            mh.psychosis = math.max(0, mh.psychosis - 1)
        else
            mh.medications.thresta.level = math.max(0, mh.medications.thresta.level - 1)
        end
    end
end

-- Check environmental triggers
function MentalHealthSystem.checkEnvironmentalTriggers(player, mh, currentTime, timeDelta)
    -- Darkness and unsafe sleeping
    if player:isAsleep() and (player:isOutside() or not player:getSquare():getRoom()) then
        mh.anxiety = math.min(100, mh.anxiety + (timeDelta * 0.2))
        mh.insomnia = math.min(100, mh.insomnia + (timeDelta * 0.1))
    end
    
    -- High fatigue anxiety
    if player:getStats():getFatigue() > 0.8 then
        mh.anxiety = math.min(100, mh.anxiety + (timeDelta * 0.1))
    end
    
    -- Weather impact
    if RainManager.isRaining() and player:isOutside() then
        mh.depression = math.min(100, mh.depression + (timeDelta * 0.05))
    end
    
    -- Check for blood and corpses
    MentalHealthSystem.checkTraumaticExposure(player, mh, currentTime)
end

-- Check for traumatic exposure
function MentalHealthSystem.checkTraumaticExposure(player, mh, currentTime)
    local square = player:getSquare()
    if not square then return end
    
    -- Check for blood on current square
    if square:haveBlood() then
        if currentTime - mh.lastBloodSeen > 1 then -- Cooldown to prevent spam
            mh.ptsd = math.min(100, mh.ptsd + ZombRand(2, 5))
            mh.anxiety = math.min(100, mh.anxiety + ZombRand(1, 3))
            mh.lastBloodSeen = currentTime
        end
    end
end

-- Apply symptoms based on mental health conditions
function MentalHealthSystem.applySymptoms(player, mh)
    local stats = player:getStats()
    
    -- Depression effects
    if mh.depression > 30 then
        stats:setFatigue(math.min(1.0, stats:getFatigue() + 0.1))
    end
    
    -- Anxiety effects
    if mh.anxiety > 40 then
        stats:setPanic(math.min(100, stats:getPanic() + 5))
        if mh.anxiety > 70 and ZombRand(1000) < 1 then
            MentalHealthSystem.triggerPanicAttack(player, mh)
        end
    end
    
    -- PTSD effects
    if mh.ptsd > 50 then
        if ZombRand(100) < 2 then
            stats:setPanic(math.min(100, stats:getPanic() + 10))
        end
    end
    
    -- Insomnia effects
    if mh.insomnia > 50 then
        stats:setFatigue(math.min(1.0, stats:getFatigue() + 0.2))
        if player:isAsleep() and ZombRand(100) < 5 then
            player:setAsleep(false) -- Wake up randomly
        end
    end
    
    -- Psychosis effects
    if mh.psychosis > 60 then
        if ZombRand(1000) < 1 then
            MentalHealthSystem.triggerHallucination(player, mh)
        end
    end
end

-- Apply natural recovery
function MentalHealthSystem.applyRecovery(player, mh, timeDelta)
    -- Comfort items help
    local inventory = player:getInventory()
    mh.comfortItems = 0
    
    if inventory:contains("TeddyBear") then mh.comfortItems = mh.comfortItems + 1 end
    if inventory:contains("TherapyJournal") then mh.comfortItems = mh.comfortItems + 1 end
    
    local recoveryRate = 0.01 + (mh.comfortItems * 0.005)
    
    -- Slow natural recovery when resting
    if player:isAsleep() or (player:getStats():getFatigue() < 0.3 and not player:isOutside()) then
        mh.anxiety = math.max(0, mh.anxiety - (timeDelta * recoveryRate))
        mh.depression = math.max(0, mh.depression - (timeDelta * recoveryRate * 0.5))
    end
end

-- Trigger panic attack
function MentalHealthSystem.triggerPanicAttack(player, mh)
    local currentTime = getGameTime():getWorldAgeHours()
    if currentTime - mh.lastPanicAttack > 4 then -- Cooldown
        player:getStats():setPanic(100)
        player:getStats():setStress(1.0)
        player:Say("I can't breathe...")
        mh.lastPanicAttack = currentTime
    end
end

-- Trigger hallucination
function MentalHealthSystem.triggerHallucination(player, mh)
    local hallucinationType = ZombRand(3)
    if hallucinationType == 0 then
        -- Auditory hallucination
        local subtleSounds = {
            "IndistinctWhisper", -- faint whispering
            "FaintKnock", -- gentle knocking
            "SoftFootsteps", -- footsteps in another room
            "DistantCrying", -- crying far away
            "RadioStatic", -- static or radio tuning
            "EchoedName", -- faint echo of player's name
        }
        local chosenSound = subtleSounds[ZombRand(#subtleSounds) + 1]
        player:playSound(chosenSound)

        -- More realistic internal responses (not always verbalized, sometimes confusion or checking)
        local response_audio_mild = {
            "Did I hear something?",
            "Maybe it's just my imagination.",
            "That was odd...",
            "I must be tired.",
            "Was that a voice?",
            "I think I heard something.",
            "Is someone there?",
            "It's so quiet... or is it?"
        }
        local response_audio_mod = {
            "Who's there?",
            "I keep hearing things...",
            "Am I being followed?",
            "That sounded close.",
            "Something's not right.",
            "Whispering... I hear whispering.",
            "Why won't it stop?",
            "Did someone call my name?"
        }
        local response_audio_severe = {
            "They're talking about me.",
            "Why won't the voices stop?",
            "I can't trust what I hear.",
            "Are they real?",
            "They're inside my head.",
            "I can't take this anymore.",
            "Please, leave me alone.",
            "I know they're here."
        }

        -- Choose response based on psychosis level
        local sayText = ""
        if mh.psychosis < 50 then
            sayText = response_audio_mild[ZombRand(#response_audio_mild) + 1]
        elseif mh.psychosis < 80 then
            sayText = response_audio_mod[ZombRand(#response_audio_mod) + 1]
        else
            sayText = response_audio_severe[ZombRand(#response_audio_severe) + 1]
        end

        -- Player sometimes only thinks (not always says out loud)
        if ZombRand(100) < 60 then
            player:Say(sayText)
        end

        -- Occasionally play a random ambiguous in-game sound to simulate misperception
        if ZombRand(100) < 20 then
            local ambiguousSounds = {
                "DoorCreak",
                "WindowRattle",
                "WindHowl",
                "FloorboardCreak",
                "DistantDogBark"
            }
            player:playSound(ambiguousSounds[ZombRand(#ambiguousSounds) + 1])
        end

        -- Less frequent shouting; more likely to freeze or whisper
        if mh.psychosis > 80 and ZombRand(100) < 20 then
            player:getEmitter():playSound("PlayerWhisper")
            player:Say("Shh... did you hear that?")
        end

        -- Increase psychosis slightly after a severe hallucination
        if mh.psychosis > 80 then
            mh.psychosis = math.min(100, mh.psychosis + 1)
            mh.anxiety = math.min(100, mh.anxiety + 1)
        end

        -- Chance to trigger panic or stress, but not always
        if mh.psychosis > 60 and ZombRand(100) < 10 then
            player:getStats():setPanic(math.min(100, player:getStats():getPanic() + 5))
            player:getStats():setStress(math.min(1.0, player:getStats():getStress() + 0.05))
        end

        return
    elseif hallucinationType == 1 then
        local visualHallucinationType = {
            "shadow", "figure", "creature", "zombie", "car"
        }
        -- Pick a random visual hallucination
        if ZombRand(2) == 0 then
            -- Visual hallucination of yourself dead on the ground
            local deadSprite = player:getSprite() -- Get the model of the player and have it appear dead on the ground
            deadSprite:setFrame(0) -- Set to the dead frame
            local deadObj = IsoObject.new(player:getCell(), x, y, z)
            deadObj:setSprite(deadSprite)
            player:getCell():addToProcess(deadObj)
            player:Say("Is that me? Am I dead?")
        else
            player:Say("Did you see that?!")
        end
        -- Visual hallucination
        local x, y, z = player:getX(), player:getY(), player:getZ()
        local sprite = visualHallucinationType[ZombRand(#visualHallucinationType) + 1]
        local obj = IsoObject.new(player:getCell(), x, y, z)
        obj:setSprite(sprite)
        player:getCell():addToProcess(obj)
        player:Say("What was that?!")


    else
        -- Text hallucination based on psychosis level
        mh.psychosis = math.min(100, mh.psychosis + 1) -- Increase psychosis level by 1
        local hallucinations = {
            "Did you hear that?",
            "Something moved in the shadows...",
            "They're watching me.",
            "I swear I saw someone.",
            ""
        }
        player:Say(hallucinations[ZombRand(#hallucinations) + 1])
    end
end

-- Medication taking functions
function MentalHealthSystem.takeSerizon(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.medications.serizon.level = math.min(3, mh.medications.serizon.level + 1)
        mh.medications.serizon.lastTaken = getGameTime():getWorldAgeHours()
        player:Say("Taking Serizon...")
    end
end

function MentalHealthSystem.takeKaletraxin(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.medications.kaletraxin.level = math.min(2, mh.medications.kaletraxin.level + 1)
        mh.medications.kaletraxin.lastTaken = getGameTime():getWorldAgeHours()
        player:Say("Taking Kaletraxin...")
    end
end

function MentalHealthSystem.takeThresta(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.medications.thresta.level = math.min(2, mh.medications.thresta.level + 1)
        mh.medications.thresta.lastTaken = getGameTime():getWorldAgeHours()
        player:Say("Taking Thresta...")
    end
end

-- Journal writing therapy
function MentalHealthSystem.writeJournal(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.journalEntries = mh.journalEntries + 1
        mh.depression = math.max(0, mh.depression - 2)
        mh.anxiety = math.max(0, mh.anxiety - 1)
        mh.ptsd = math.max(0, mh.ptsd - 1)
        player:Say("Writing helps me process these feelings...")
    end
end

-- Event listeners
Events.OnCreatePlayer.Add(MentalHealthSystem.initPlayer)
Events.OnPlayerUpdate.Add(MentalHealthSystem.updateMentalHealth)

-- Kill zombie trigger
Events.OnZombieDead.Add(function(zombie)
    local player = getPlayer()
    if player then
        local mh = player:getModData().MentalHealth
        if mh then
            local currentTime = getGameTime():getWorldAgeHours()
            if currentTime - mh.lastZombieKill > 0.5 then -- Prevent spam
                mh.ptsd = math.min(100, mh.ptsd + ZombRand(1, 3))
                mh.lastZombieKill = currentTime
            end
        end
    end
end)
