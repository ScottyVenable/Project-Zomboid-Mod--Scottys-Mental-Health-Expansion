-- Mental Health Expansion Utility Functions
-- Contains all utility functions that may be used by both client and server scripts

MentalHealthUtils = {}

-- Math Utilities
function MentalHealthUtils.clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

function MentalHealthUtils.lerp(a, b, t)
    return a + (b - a) * t
end

function MentalHealthUtils.smoothStep(edge0, edge1, x)
    local t = MentalHealthUtils.clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    return t * t * (3.0 - 2.0 * t)
end

-- Time Utilities
function MentalHealthUtils.getCurrentGameHours()
    return getGameTime():getWorldAgeHours()
end

function MentalHealthUtils.hoursToGameDays(hours)
    return math.floor(hours / 24)
end

function MentalHealthUtils.getTimeSince(previousTime)
    return MentalHealthUtils.getCurrentGameHours() - (previousTime or 0)
end

function MentalHealthUtils.isWithinHours(time1, time2, hours)
    return math.abs(time1 - time2) <= hours
end

-- Player Utilities
function MentalHealthUtils.isSafeLocation(player)
    if not player then return false end
    
    local square = player:getSquare()
    if not square then return false end
    
    -- Check if player is indoors
    if player:isOutside() then return false end
    
    -- Check if location has walls/roof
    local room = square:getRoom()
    if not room then return false end
    
    -- Check for proper doors/windows
    local building = room:getBuilding()
    if not building then return false end
    
    return true
end

function MentalHealthUtils.getNearbyPlayers(player, radius)
    if not player then return {} end
    
    local nearbyPlayers = {}
    local playerSquare = player:getSquare()
    
    if not playerSquare then return nearbyPlayers end
    
    local allPlayers = getOnlinePlayers()
    for i = 0, allPlayers:size() - 1 do
        local otherPlayer = allPlayers:get(i)
        if otherPlayer ~= player then
            local otherSquare = otherPlayer:getSquare()
            if otherSquare then
                local distance = MentalHealthUtils.getSquareDistance(playerSquare, otherSquare)
                if distance <= radius then
                    table.insert(nearbyPlayers, otherPlayer)
                end
            end
        end
    end
    
    return nearbyPlayers
end

function MentalHealthUtils.getSquareDistance(square1, square2)
    if not square1 or not square2 then return 999 end
    
    local dx = square1:getX() - square2:getX()
    local dy = square1:getY() - square2:getY()
    local dz = square1:getZ() - square2:getZ()
    
    return math.sqrt(dx*dx + dy*dy + dz*dz*4) -- Z difference weighted more
end

-- Inventory Utilities
function MentalHealthUtils.playerHasItem(player, itemType)
    if not player then return false end
    return player:getInventory():contains(itemType)
end

function MentalHealthUtils.countItemsInInventory(player, itemType)
    if not player then return 0 end
    return player:getInventory():getItemCount(itemType)
end

function MentalHealthUtils.getComfortItemsCount(player)
    if not player then return 0 end
    
    local comfortItems = {
        "TeddyBear",
        "ComfortBlanket", 
        "PersonalPhoto",
        "TherapyJournal",
        "StressBall"
    }
    
    local count = 0
    for _, item in ipairs(comfortItems) do
        if MentalHealthUtils.playerHasItem(player, item) then
            count = count + 1
        end
    end
    
    return count
end

-- Mental Health Data Utilities
function MentalHealthUtils.initializeMentalHealthData(player)
    if not player then return nil end
    
    local modData = player:getModData()
    if not modData.MentalHealth then
        modData.MentalHealth = {
            -- Core conditions
            depression = 0,
            anxiety = 0,
            ptsd = 0,
            insomnia = 0,
            psychosis = 0,
            ocd = 0,
            
            -- Tracking
            lastUpdate = MentalHealthUtils.getCurrentGameHours(),
            triggers = {},
            symptoms = {},
            
            -- Medications
            medications = {},
            
            -- Coping mechanisms
            coping = {
                journalEntries = 0,
                comfortItems = 0,
                lastMeditation = 0,
                lastTherapy = 0
            },
            
            -- History
            eventHistory = {},
            recoveryProgress = {}
        }
    end
    
    return modData.MentalHealth
end

function MentalHealthUtils.getMentalHealthData(player)
    if not player then return nil end
    
    local modData = player:getModData()
    return modData.MentalHealth or MentalHealthUtils.initializeMentalHealthData(player)
end

function MentalHealthUtils.getConditionSeverity(mentalHealth, condition)
    if not mentalHealth or not condition then return 0 end
    return mentalHealth[condition] or 0
end

function MentalHealthUtils.setConditionSeverity(mentalHealth, condition, value)
    if not mentalHealth or not condition then return end
    mentalHealth[condition] = MentalHealthUtils.clamp(value, 0, MentalHealthConfig.CONDITIONS.MAX_SEVERITY or 100)
end

function MentalHealthUtils.modifyCondition(mentalHealth, condition, delta)
    if not mentalHealth or not condition then return end
    local current = MentalHealthUtils.getConditionSeverity(mentalHealth, condition)
    MentalHealthUtils.setConditionSeverity(mentalHealth, condition, current + delta)
end

-- Severity Classification
function MentalHealthUtils.getSeverityLevel(value)
    if value <= MentalHealthConfig.CONDITIONS.MILD_THRESHOLD then
        return "mild"
    elseif value <= MentalHealthConfig.CONDITIONS.MODERATE_THRESHOLD then
        return "moderate"
    elseif value <= MentalHealthConfig.CONDITIONS.SEVERE_THRESHOLD then
        return "severe"
    else
        return "critical"
    end
end

function MentalHealthUtils.getSeverityColor(value)
    local level = MentalHealthUtils.getSeverityLevel(value)
    
    if level == "mild" then
        return {r=0.3, g=0.8, b=0.3, a=0.8}     -- Green
    elseif level == "moderate" then
        return {r=0.8, g=0.8, b=0.3, a=0.8}     -- Yellow
    elseif level == "severe" then
        return {r=0.8, g=0.5, b=0.2, a=0.8}     -- Orange
    else
        return {r=0.8, g=0.2, b=0.2, a=0.8}     -- Red
    end
end

-- Event Utilities
function MentalHealthUtils.recordEvent(mentalHealth, eventType, severity, description)
    if not mentalHealth then return end
    
    if not mentalHealth.eventHistory then
        mentalHealth.eventHistory = {}
    end
    
    local event = {
        type = eventType,
        severity = severity,
        description = description,
        timestamp = MentalHealthUtils.getCurrentGameHours(),
        gameDay = MentalHealthUtils.hoursToGameDays(MentalHealthUtils.getCurrentGameHours())
    }
    
    table.insert(mentalHealth.eventHistory, event)
    
    -- Keep only last 100 events to prevent memory bloat
    if #mentalHealth.eventHistory > 100 then
        table.remove(mentalHealth.eventHistory, 1)
    end
end

function MentalHealthUtils.getRecentEvents(mentalHealth, hours)
    if not mentalHealth or not mentalHealth.eventHistory then return {} end
    
    local currentTime = MentalHealthUtils.getCurrentGameHours()
    local recentEvents = {}
    
    for _, event in ipairs(mentalHealth.eventHistory) do
        if currentTime - event.timestamp <= hours then
            table.insert(recentEvents, event)
        end
    end
    
    return recentEvents
end

-- Professional Utilities
function MentalHealthUtils.isHealthcareProfessional(player)
    if not player then return false end
    
    local profession = player:getDescriptor():getProfession()
    local healthcareProfessions = {
        "psychiatrist",
        "psychologist", 
        "pharmacist",
        "bhp",
        "dsp"
    }
    
    for _, prof in ipairs(healthcareProfessions) do
        if profession == prof then
            return true
        end
    end
    
    return false
end

function MentalHealthUtils.getProfessionalMultiplier(player)
    if not MentalHealthUtils.isHealthcareProfessional(player) then
        return 1.0
    end
    
    local profession = player:getDescriptor():getProfession()
    local multipliers = MentalHealthConfig.PROFESSIONALS or {}
    
    if profession == "psychiatrist" then
        return multipliers.PSYCHIATRIST_BONUS or 2.0
    elseif profession == "psychologist" then
        return multipliers.PSYCHOLOGIST_BONUS or 1.5
    elseif profession == "pharmacist" then
        return multipliers.PHARMACIST_BONUS or 1.3
    elseif profession == "bhp" then
        return multipliers.BHP_BONUS or 1.2
    elseif profession == "dsp" then
        return multipliers.DSP_BONUS or 1.1
    end
    
    return 1.0
end

-- Random Utilities
function MentalHealthUtils.weightedRandom(weights)
    local totalWeight = 0
    for _, weight in ipairs(weights) do
        totalWeight = totalWeight + weight
    end
    
    local random = ZombRand(totalWeight * 100) / 100
    local currentWeight = 0
    
    for i, weight in ipairs(weights) do
        currentWeight = currentWeight + weight
        if random <= currentWeight then
            return i
        end
    end
    
    return #weights
end

function MentalHealthUtils.rollPercent(chance)
    return ZombRand(100) < chance
end

-- String Utilities
function MentalHealthUtils.formatTime(hours)
    local days = math.floor(hours / 24)
    local remainingHours = math.floor(hours % 24)
    
    if days > 0 then
        return string.format("%d day(s), %d hour(s)", days, remainingHours)
    else
        return string.format("%d hour(s)", remainingHours)
    end
end

function MentalHealthUtils.formatPercentage(value, decimals)
    decimals = decimals or 1
    return string.format("%." .. decimals .. "f%%", value)
end

-- Validation Utilities
function MentalHealthUtils.validatePlayer(player)
    return player ~= nil and player:getModData() ~= nil
end

function MentalHealthUtils.validateMentalHealthData(mentalHealth)
    if not mentalHealth then return false end
    
    local requiredFields = {"depression", "anxiety", "ptsd", "insomnia", "psychosis", "ocd"}
    for _, field in ipairs(requiredFields) do
        if mentalHealth[field] == nil then
            return false
        end
    end
    
    return true
end

-- Debug Utilities
function MentalHealthUtils.debugPrint(message, level)
    if not MentalHealthConfig or not MentalHealthConfig.DEBUG_MODE then return end
    
    level = level or "INFO"
    local timestamp = MentalHealthUtils.getCurrentGameHours()
    print(string.format("[MH %s %.2f] %s", level, timestamp, tostring(message)))
end

function MentalHealthUtils.dumpMentalHealthData(player)
    if not MentalHealthConfig.DEBUG_MODE then return end
    
    local mh = MentalHealthUtils.getMentalHealthData(player)
    if not mh then
        MentalHealthUtils.debugPrint("No mental health data found", "WARNING")
        return
    end
    
    MentalHealthUtils.debugPrint("=== Mental Health Data Dump ===", "DEBUG")
    for condition, value in pairs(mh) do
        if type(value) == "number" then
            MentalHealthUtils.debugPrint(string.format("%s: %.2f", condition, value), "DEBUG")
        end
    end
    MentalHealthUtils.debugPrint("=== End Dump ===", "DEBUG")
end

print("Mental Health Utils loaded successfully")
