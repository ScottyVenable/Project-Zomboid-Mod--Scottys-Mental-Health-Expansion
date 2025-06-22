HallucinationSystem = {}

-- Hallucination types
HallucinationSystem.AUDIO = 1
HallucinationSystem.VISUAL = 2
HallucinationSystem.TACTILE = 3
HallucinationSystem.MEDIA = 4

-- Initialize hallucination data
function HallucinationSystem.initHallucinationData(player)
    local modData = player:getModData()
    if not modData.MentalHealth then return end
    
    if not modData.MentalHealth.hallucinations then
        modData.MentalHealth.hallucinations = {
            recentHallucinations = {},
            mediaHallucinationCooldown = 0,
            personalizedMessages = {},
            hallucinationIntensity = 0,
            lastMediaHallucination = 0
        }
    end
end

-- Media hallucination messages based on mental state
HallucinationSystem.MediaMessages = {
    -- Bipolar Manic Messages
    bipolarManic = {
        "Breaking news: Local survivor {PlayerName} discovers revolutionary zombie cure!",
        "You're listening to {PlayerName} FM, the frequency of greatness!",
        "We interrupt this broadcast with urgent news about {PlayerName}'s incredible abilities...",
        "The government wants to recruit {PlayerName} for a top-secret mission.",
        "Scientists worldwide are studying {PlayerName}'s unique immunity.",
        "You are the chosen one, {PlayerName}. The world needs your genius.",
        "Congratulations {PlayerName}, you've won the apocalypse lottery!",
        "This is God speaking directly to you, {PlayerName}. You have a divine purpose.",
        "Emergency broadcast: {PlayerName} is humanity's last hope for survival."
    },
    
    -- Bipolar Depressive Messages
    bipolarDepressed = {
        "In other news, {PlayerName} continues to be a disappointment to everyone.",
        "This program is brought to you by {PlayerName}'s complete failure at life.",
        "Breaking: {PlayerName} ruins everything they touch, scientists confirm.",
        "You're worthless, {PlayerName}. Even the zombies don't want you.",
        "The world would be better off without {PlayerName}, experts agree.",
        "Static... no one cares about you, {PlayerName}... static...",
        "Why do you even try, {PlayerName}? You always fail anyway.",
        "Your family is ashamed of what you've become, {PlayerName}.",
        "Everyone you've ever loved regrets knowing you, {PlayerName}."
    },
    
    -- Psychosis Paranoid Messages
    psychosisParanoid = {
        "We see you, {PlayerName}. We know where you're hiding.",
        "The surveillance network has located {PlayerName}. Initiating capture protocol.",
        "Attention {PlayerName}: Your every move is being monitored.",
        "They're coming for you, {PlayerName}. Run while you still can.",
        "The zombies aren't the real enemy, {PlayerName}. We are.",
        "Your location has been compromised, {PlayerName}. They know everything.",
        "The other survivors can't be trusted, {PlayerName}. They're working with them.",
        "Your food supply is contaminated, {PlayerName}. Don't eat anything.",
        "The radio signals are tracking you, {PlayerName}. Destroy all electronics."
    },
    
    -- Psychosis Grandiose Messages
    psychosisGrandiose = {
        "You have been chosen, {PlayerName}. The cosmic forces await your command.",
        "Your telepathic abilities are awakening, {PlayerName}. Use them wisely.",
        "The zombie virus cannot touch you, {PlayerName}. You are pure energy.",
        "Ancient prophecies speak of {PlayerName}, the one who will reshape reality.",
        "You can control time itself, {PlayerName}. Bend it to your will.",
        "The spirits of the universe whisper secrets only to you, {PlayerName}.",
        "You are the reincarnation of a great leader, {PlayerName}. Claim your throne.",
        "The matrix recognizes you as an anomaly, {PlayerName}. You can see the code.",
        "Your DNA contains alien technology, {PlayerName}. Activate your powers."
    },
    
    -- General Psychosis Messages
    psychosisGeneral = {
        "Can you hear us, {PlayerName}? We're trying to reach you...",
        "The truth about {PlayerName} is hidden in the static...",
        "Numbers station calling {PlayerName}: 7-4-1-9-2-8...",
        "{PlayerName}, your reality is not what it seems...",
        "The voices in the radio are trying to warn you, {PlayerName}...",
        "Something is very wrong with the world, {PlayerName}. Question everything.",
        "They replaced the real {PlayerName} weeks ago. Who are you really?",
        "The emergency broadcast system has a special message for {PlayerName}...",
        "Time is running out, {PlayerName}. Decode the signals before it's too late."
    }
}

-- Audio-only hallucinations
HallucinationSystem.AudioHallucinations = {
    environmental = {
        "Footsteps behind you...",
        "A door creaks open nearby...",
        "Whispered conversation in the next room...",
        "Phone ringing in an empty building...",
        "Music playing from nowhere...",
        "Someone calling your name...",
        "Children laughing in the distance...",
        "Dogs barking where there are no dogs..."
    },
    
    voices = {
        "Did you hear that voice?",
        "Someone's talking about me...",
        "They're planning something...",
        "I can hear them whispering...",
        "The voices are getting louder...",
        "Why are they arguing about me?",
        "I think someone's following me...",
        "There's something they're not telling me..."
    }
}

-- Check for hallucination triggers
function HallucinationSystem.checkForHallucinations(player)
    local mh = player:getModData().MentalHealth
    if not mh or not mh.hallucinations then return end
    
    local currentTime = getGameTime():getWorldAgeHours()
    local hallucinationChance = 0
    
    -- Calculate hallucination probability based on conditions
    if mh.psychosis > 60 then
        hallucinationChance = hallucinationChance + (mh.psychosis * 0.02)
    end
    
    if mh.bipolar then
        if mh.bipolar.currentMoodState == BipolarSystem.MOOD_MANIC and mh.bipolar.moodSeverity > 70 then
            hallucinationChance = hallucinationChance + (mh.bipolar.moodSeverity * 0.015)
        elseif mh.bipolar.currentMoodState == BipolarSystem.MOOD_DEPRESSED and mh.bipolar.moodSeverity > 80 then
            hallucinationChance = hallucinationChance + (mh.bipolar.moodSeverity * 0.01)
        end
    end
    
    -- Sleep deprivation increases hallucinations
    if player:getStats():getFatigue() > 0.8 then
        hallucinationChance = hallucinationChance + 5
    end
    
    -- Isolation increases hallucinations
    if currentTime - (mh.lastSocialInteraction or 0) > 72 then
        hallucinationChance = hallucinationChance + 3
    end
    
    -- Trigger hallucination if chance met
    if ZombRand(10000) < hallucinationChance then
        HallucinationSystem.triggerHallucination(player)
    end
    
    -- Check for media hallucinations specifically
    HallucinationSystem.checkMediaHallucinations(player)
end

-- Check for TV/Radio hallucinations
function HallucinationSystem.checkMediaHallucinations(player)
    local mh = player:getModData().MentalHealth
    if not mh or not mh.hallucinations then return end
    
    local currentTime = getGameTime():getWorldAgeHours()
    
    -- Cooldown check
    if currentTime - mh.hallucinations.lastMediaHallucination < 2 then return end
    
    -- Check if player is near TV or radio
    local square = player:getSquare()
    if not square then return end
    
    local nearMedia = false
    local objects = square:getObjects()
    
    -- Check current square and adjacent squares for TV/radio
    for x = -1, 1 do
        for y = -1, 1 do
            local checkSquare = getCell():getGridSquare(square:getX() + x, square:getY() + y, square:getZ())
            if checkSquare then
                local squareObjects = checkSquare:getObjects()
                for i = 0, squareObjects:size() - 1 do
                    local obj = squareObjects:get(i)
                    if obj then
                        local spriteName = obj:getSprite():getName()
                        if string.find(spriteName, "television") or 
                           string.find(spriteName, "radio") or
                           string.find(spriteName, "Television") or
                           string.find(spriteName, "Radio") then
                            nearMedia = true
                            break
                        end
                    end
                end
                if nearMedia then break end
            end
        end
        if nearMedia then break end
    end
    
    if not nearMedia then return end
    
    -- Calculate media hallucination chance
    local mediaChance = 0
    
    if mh.psychosis > 50 then
        mediaChance = mediaChance + (mh.psychosis * 0.03)
    end
    
    if mh.bipolar then
        if mh.bipolar.currentMoodState == BipolarSystem.MOOD_MANIC and mh.bipolar.moodSeverity > 60 then
            mediaChance = mediaChance + (mh.bipolar.moodSeverity * 0.02)
        elseif mh.bipolar.currentMoodState == BipolarSystem.MOOD_DEPRESSED and mh.bipolar.moodSeverity > 70 then
            mediaChance = mediaChance + (mh.bipolar.moodSeverity * 0.015)
        end
    end
    
    -- Trigger media hallucination
    if ZombRand(5000) < mediaChance then
        HallucinationSystem.triggerMediaHallucination(player)
    end
end

-- Trigger a general hallucination
function HallucinationSystem.triggerHallucination(player)
    local mh = player:getModData().MentalHealth
    local hallucinationType = ZombRand(4) + 1
    
    if hallucinationType == HallucinationSystem.AUDIO then
        HallucinationSystem.triggerAudioHallucination(player)
    elseif hallucinationType == HallucinationSystem.VISUAL then
        HallucinationSystem.triggerVisualHallucination(player)
    elseif hallucinationType == HallucinationSystem.TACTILE then
        HallucinationSystem.triggerTactileHallucination(player)
    else
        HallucinationSystem.triggerAudioHallucination(player) -- Default to audio
    end
    
    -- Record hallucination
    table.insert(mh.hallucinations.recentHallucinations, {
        type = hallucinationType,
        time = getGameTime():getWorldAgeHours(),
        severity = mh.psychosis + (mh.bipolar and mh.bipolar.moodSeverity or 0)
    })
    
    -- Keep only recent hallucinations
    if #mh.hallucinations.recentHallucinations > 10 then
        table.remove(mh.hallucinations.recentHallucinations, 1)
    end
end

-- Trigger TV/Radio hallucination
function HallucinationSystem.triggerMediaHallucination(player)
    local mh = player:getModData().MentalHealth
    local playerName = player:getDisplayName() or "Survivor"
    local messages = {}
    
    -- Determine which message set to use based on current mental state
    if mh.bipolar then
        if mh.bipolar.currentMoodState == BipolarSystem.MOOD_MANIC then
            messages = HallucinationSystem.MediaMessages.bipolarManic
        elseif mh.bipolar.currentMoodState == BipolarSystem.MOOD_DEPRESSED then
            messages = HallucinationSystem.MediaMessages.bipolarDepressed
        end
    end
    
    if mh.psychosis > 70 then
        if ZombRand(2) == 0 then
            messages = HallucinationSystem.MediaMessages.psychosisParanoid
        else
            messages = HallucinationSystem.MediaMessages.psychosisGrandiose
        end
    elseif mh.psychosis > 40 then
        messages = HallucinationSystem.MediaMessages.psychosisGeneral
    end
    
    -- Default to general psychosis if no specific condition
    if #messages == 0 then
        messages = HallucinationSystem.MediaMessages.psychosisGeneral
    end
    
    -- Select and personalize message
    local selectedMessage = messages[ZombRand(#messages) + 1]
    local personalizedMessage = string.gsub(selectedMessage, "{PlayerName}", playerName)
    
    -- Display the hallucination
    HallucinationSystem.displayMediaHallucination(player, personalizedMessage)
    
    -- Update tracking
    mh.hallucinations.lastMediaHallucination = getGameTime():getWorldAgeHours()
    table.insert(mh.hallucinations.personalizedMessages, {
        message = personalizedMessage,
        time = getGameTime():getWorldAgeHours(),
        source = "media"
    })
end

-- Display media hallucination to player
function HallucinationSystem.displayMediaHallucination(player, message)
    -- Create a distinctive visual/audio cue
    player:getEmitter():playSound("RadioStatic")
    
    -- Wait a moment then deliver the message
    local function deliverMessage()
        player:Say("TV/Radio: " .. message)
        
        -- Add some visual effect (screen flicker simulation)
        if ZombRand(3) == 0 then
            player:Say("The screen flickers strangely...")
        end
    end
    
    -- Delay the message slightly for realism
    Events.OnTick.Add(function()
        deliverMessage()
        Events.OnTick.Remove(deliverMessage)
    end)
end

-- Trigger audio hallucination
function HallucinationSystem.triggerAudioHallucination(player)
    local audioType = ZombRand(2)
    
    if audioType == 0 then
        -- Environmental audio hallucination
        local envSounds = HallucinationSystem.AudioHallucinations.environmental
        local selectedSound = envSounds[ZombRand(#envSounds) + 1]
        player:Say(selectedSound)
        
        -- Play a subtle audio cue
        if ZombRand(3) == 0 then
            player:getEmitter():playSound("ZombieHit") -- Placeholder sound
        end
    else
        -- Voice hallucination
        local voices = HallucinationSystem.AudioHallucinations.voices
        local selectedVoice = voices[ZombRand(#voices) + 1]
        player:Say(selectedVoice)
    end
end

-- Trigger visual hallucination
function HallucinationSystem.triggerVisualHallucination(player)
    local visualHallucinations = {
        "I saw something move in my peripheral vision...",
        "There's a shadow that shouldn't be there...",
        "Did I just see someone watching me?",
        "The walls seem to be breathing...",
        "There's something wrong with that zombie... it looked familiar...",
        "I keep seeing faces in the darkness...",
        "The text on that sign just changed...",
        "Something's following me, but when I look, it's gone..."
    }
    
    local selectedHallucination = visualHallucinations[ZombRand(#visualHallucinations) + 1]
    player:Say(selectedHallucination)
    
    -- Potentially spawn a false zombie sprite (advanced feature)
    -- This would require more complex implementation
end

-- Trigger tactile hallucination
function HallucinationSystem.triggerTactileHallucination(player)
    local tactileHallucinations = {
        "I feel something crawling on my skin...",
        "There's something touching my shoulder...",
        "I can feel eyes watching me...",
        "Something just brushed against my arm...",
        "I feel a cold presence behind me...",
        "My skin feels like it's burning...",
        "There's something wet dripping on me...",
        "I feel like I'm being followed..."
    }
    
    local selectedHallucination = tactileHallucinations[ZombRand(#tactileHallucinations) + 1]
    player:Say(selectedHallucination)
end

-- Get hallucination summary for UI
function HallucinationSystem.getHallucinationSummary(player)
    local mh = player:getModData().MentalHealth
    if not mh or not mh.hallucinations then return "No recent hallucinations" end
    
    local recentCount = #mh.hallucinations.recentHallucinations
    if recentCount == 0 then
        return "No recent hallucinations"
    end
    
    local currentTime = getGameTime():getWorldAgeHours()
    local recentHallucinations = 0
    
    for _, hallucination in ipairs(mh.hallucinations.recentHallucinations) do
        if currentTime - hallucination.time < 24 then -- Within last 24 hours
            recentHallucinations = recentHallucinations + 1
        end
    end
    
    if recentHallucinations > 5 then
        return "Frequent hallucinations (severe)"
    elseif recentHallucinations > 2 then
        return "Multiple hallucinations (moderate)"
    elseif recentHallucinations > 0 then
        return "Occasional hallucinations (mild)"
    else
        return "No recent hallucinations"
    end
end

-- Integration with main mental health system
Events.OnCreatePlayer.Add(HallucinationSystem.initHallucinationData)
Events.OnPlayerUpdate.Add(HallucinationSystem.checkForHallucinations)
