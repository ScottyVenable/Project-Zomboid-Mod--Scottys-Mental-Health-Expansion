SelfHelpActions = {}

-- Self-Help Book Reading Functions
function SelfHelpActions.readAnxietyBook(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.anxiety = math.max(0, mh.anxiety - ZombRand(3, 6))
        player:getModData().SelfHelpSkills = player:getModData().SelfHelpSkills or {}
        player:getModData().SelfHelpSkills.deepBreathing = true
        player:Say("These breathing techniques could really help...")
    end
end

function SelfHelpActions.readDepressionBook(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.depression = math.max(0, mh.depression - ZombRand(4, 7))
        player:getModData().SelfHelpSkills = player:getModData().SelfHelpSkills or {}
        player:getModData().SelfHelpSkills.behavioralActivation = true
        player:Say("I need to focus on small, achievable activities...")
    end
end

function SelfHelpActions.readTraumaWorkbook(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.ptsd = math.max(0, mh.ptsd - ZombRand(5, 9))
        player:getModData().SelfHelpSkills = player:getModData().SelfHelpSkills or {}
        player:getModData().SelfHelpSkills.grounding = true
        player:Say("Understanding my triggers helps me feel more in control...")
    end
end

function SelfHelpActions.readMindfulnessBook(player)
    local mh = player:getModData().MentalHealth
    if mh then
        -- Reduces all conditions slightly
        mh.anxiety = math.max(0, mh.anxiety - ZombRand(1, 3))
        mh.depression = math.max(0, mh.depression - ZombRand(1, 3))
        mh.ptsd = math.max(0, mh.ptsd - ZombRand(1, 2))
        
        player:getModData().SelfHelpSkills = player:getModData().SelfHelpSkills or {}
        player:getModData().SelfHelpSkills.mindfulness = true
        player:Say("Being present in this moment brings me peace...")
    end
end

-- Advanced Coping Actions
function SelfHelpActions.deepBreathing(player)
    local skills = player:getModData().SelfHelpSkills or {}
    if skills.deepBreathing then
        local mh = player:getModData().MentalHealth
        if mh then
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(2, 4))
            player:getStats():setPanic(math.max(0, player:getStats():getPanic() - 10))
            player:Say("Breathe in... hold... breathe out...")
        end
    else
        player:Say("I need to learn proper breathing techniques first...")
    end
end

function SelfHelpActions.behavioralActivation(player)
    local skills = player:getModData().SelfHelpSkills or {}
    if skills.behavioralActivation then
        local mh = player:getModData().MentalHealth
        if mh then
            -- Small activity like organizing inventory
            if player:getInventory():getItems():size() > 5 then
                mh.depression = math.max(0, mh.depression - ZombRand(1, 3))
                player:Say("Completing small tasks helps me feel accomplished...")
            end
        end
    end
end

function SelfHelpActions.groundingTechnique(player)
    local skills = player:getModData().SelfHelpSkills or {}
    if skills.grounding then
        local mh = player:getModData().MentalHealth
        if mh then
            mh.ptsd = math.max(0, mh.ptsd - ZombRand(2, 5))
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(2, 4))
            player:Say("5 things I can see, 4 things I can touch, 3 things I can hear...")
        end
    end
end

-- Comfort Item Actions
function SelfHelpActions.useStressBall(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.anxiety = math.max(0, mh.anxiety - ZombRand(2, 4))
        player:Say("Squeezing this helps release the tension...")
    end
end

function SelfHelpActions.useComfortBlanket(player)
    if player:isInside() then
        local mh = player:getModData().MentalHealth
        if mh then
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(3, 6))
            mh.insomnia = math.max(0, mh.insomnia - ZombRand(2, 4))
            player:Say("This deep pressure is so calming...")
        end
    else
        player:Say("I need to be somewhere safe and private to use this...")
    end
end

function SelfHelpActions.viewPhoto(player)
    local mh = player:getModData().MentalHealth
    if mh then
        if ZombRand(100) < 70 then -- 70% chance positive reaction
            mh.depression = math.max(0, mh.depression - ZombRand(1, 4))
            player:Say("I miss them, but this gives me hope...")
        else -- 30% chance emotional trigger
            mh.depression = math.min(100, mh.depression + ZombRand(1, 2))
            player:Say("Looking at this hurts, but I need to remember...")
        end
    end
end

-- Creative Expression
function SelfHelpActions.createArt(player)
    if player:isInside() and not player:isOutside() then
        local mh = player:getModData().MentalHealth
        if mh then
            mh.depression = math.max(0, mh.depression - ZombRand(2, 5))
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(1, 3))
            player:Say("Expressing myself through art feels therapeutic...")
            
            -- Create artwork item in inventory
            local artwork = player:getInventory():AddItem("Base.Magazine") -- Placeholder
            if artwork then
                artwork:setName("Personal Artwork")
            end
        end
    else
        player:Say("I need a calm, safe space to focus on creating art...")
    end
end

function SelfHelpActions.writePoetry(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.depression = math.max(0, mh.depression - ZombRand(2, 4))
        mh.anxiety = math.max(0, mh.anxiety - ZombRand(1, 3))
        player:Say("Putting my feelings into words helps me understand them...")
    end
end

-- Physical Self-Care
function SelfHelpActions.doYoga(player)
    if player:isInside() and player:getStats():getFatigue() < 0.8 then
        local mh = player:getModData().MentalHealth
        if mh then
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(3, 6))
            mh.depression = math.max(0, mh.depression - ZombRand(2, 4))
            mh.insomnia = math.max(0, mh.insomnia - ZombRand(1, 3))
            player:Say("Stretching and breathing centers my mind and body...")
        end
    else
        player:Say("I'm too tired or this isn't a safe space for exercise...")
    end
end

function SelfHelpActions.selfCare(player)
    if player:isInside() then
        local mh = player:getModData().MentalHealth
        if mh then
            mh.depression = math.max(0, mh.depression - ZombRand(1, 3))
            player:Say("Taking care of my appearance helps me feel human...")
            
            -- Add hygiene bonus
            player:getModData().lastSelfCare = getGameTime():getWorldAgeHours()
        end
    end
end

-- Crisis Management
function SelfHelpActions.useCrisisKit(player)
    local mh = player:getModData().MentalHealth
    if mh then
        -- Emergency intervention for severe symptoms
        if mh.anxiety > 70 or mh.ptsd > 70 then
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(5, 10))
            mh.ptsd = math.max(0, mh.ptsd - ZombRand(3, 7))
            player:Say("I need to focus on my crisis plan right now...")
        else
            player:Say("I'll save this for when I really need it...")
        end
    end
end

function SelfHelpActions.useGroundingCards(player)
    local mh = player:getModData().MentalHealth
    if mh then
        if mh.anxiety > 40 or mh.ptsd > 40 then
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(3, 6))
            mh.ptsd = math.max(0, mh.ptsd - ZombRand(2, 5))
            player:Say("Name 5 things I can see... this technique works...")
        end
    end
end

-- Natural Remedies
function SelfHelpActions.drinkChamomileTea(player)
    local mh = player:getModData().MentalHealth
    if mh then
        mh.anxiety = math.max(0, mh.anxiety - ZombRand(1, 3))
        mh.insomnia = math.max(0, mh.insomnia - ZombRand(1, 2))
        player:Say("This tea has such a calming effect...")
    end
end

-- Technology-Based Coping
function SelfHelpActions.useMeditationApp(player)
    -- Check if device has power
    local devicePowered = true -- Simplified for now
    
    if devicePowered then
        local mh = player:getModData().MentalHealth
        if mh then
            mh.anxiety = math.max(0, mh.anxiety - ZombRand(3, 6))
            mh.depression = math.max(0, mh.depression - ZombRand(2, 4))
            player:Say("These guided meditations are so helpful...")
        end
    else
        player:Say("The device needs power to work...")
    end
end

-- Group Support Actions
function SelfHelpActions.facilitateGroup(player)
    -- Check for other players nearby in multiplayer
    local nearbyPlayers = 0
    -- This would need actual multiplayer detection logic
    
    if nearbyPlayers > 0 then
        local mh = player:getModData().MentalHealth
        if mh then
            -- Benefits for facilitating group
            mh.depression = math.max(0, mh.depression - ZombRand(2, 5))
            player:Say("Helping others helps me too...")
        end
    else
        player:Say("I need other people here to facilitate a group...")
    end
end

-- Passive Benefits System
function SelfHelpActions.updatePassiveBenefits(player)
    local mh = player:getModData().MentalHealth
    local inventory = player:getInventory()
    
    if not mh then return end
    
    -- Comfort item passive benefits
    local comfortBonus = 0
    if inventory:contains("TeddyBear") then comfortBonus = comfortBonus + 1 end
    if inventory:contains("ComfortBlanket") then comfortBonus = comfortBonus + 1 end
    if inventory:contains("PersonalPhoto") then comfortBonus = comfortBonus + 0.5 end
    
    -- Apply passive anxiety reduction
    if comfortBonus > 0 then
        mh.anxiety = math.max(0, mh.anxiety - (comfortBonus * 0.1))
    end
    
    -- Self-care bonus
    local lastSelfCare = player:getModData().lastSelfCare or 0
    local currentTime = getGameTime():getWorldAgeHours()
    if currentTime - lastSelfCare < 24 then -- Recent self-care
        mh.depression = math.max(0, mh.depression - 0.05)
    end
end

-- Add to main update cycle
Events.OnPlayerUpdate.Add(SelfHelpActions.updatePassiveBenefits)
