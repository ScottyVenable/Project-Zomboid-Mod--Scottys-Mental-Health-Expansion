-- Mental Health Event Manager Library
-- Handles custom event registration and triggering for the mental health system

MentalHealthEventManager = {}

-- Event registry
MentalHealthEventManager.events = {}
MentalHealthEventManager.listeners = {}

-- Register a new event type
function MentalHealthEventManager.registerEvent(eventName)
    if not MentalHealthEventManager.events[eventName] then
        MentalHealthEventManager.events[eventName] = {}
        MentalHealthEventManager.listeners[eventName] = {}
        MentalHealthUtils.debugPrint("Registered event: " .. eventName, "DEBUG")
    end
end

-- Add a listener for an event
function MentalHealthEventManager.addEventListener(eventName, callback)
    MentalHealthEventManager.registerEvent(eventName)
    table.insert(MentalHealthEventManager.listeners[eventName], callback)
    MentalHealthUtils.debugPrint("Added listener for: " .. eventName, "DEBUG")
end

-- Remove a listener for an event
function MentalHealthEventManager.removeEventListener(eventName, callback)
    if MentalHealthEventManager.listeners[eventName] then
        for i, listener in ipairs(MentalHealthEventManager.listeners[eventName]) do
            if listener == callback then
                table.remove(MentalHealthEventManager.listeners[eventName], i)
                break
            end
        end
    end
end

-- Trigger an event
function MentalHealthEventManager.triggerEvent(eventName, eventData)
    if MentalHealthEventManager.listeners[eventName] then
        for _, callback in ipairs(MentalHealthEventManager.listeners[eventName]) do
            local success, error = pcall(callback, eventData)
            if not success then
                MentalHealthUtils.debugPrint("Error in event listener: " .. tostring(error), "ERROR")
            end
        end
    end
    
    -- Store event in history
    MentalHealthEventManager.recordEvent(eventName, eventData)
end

-- Record event in history
function MentalHealthEventManager.recordEvent(eventName, eventData)
    if not MentalHealthEventManager.events[eventName] then
        MentalHealthEventManager.registerEvent(eventName)
    end
    
    local event = {
        name = eventName,
        data = eventData,
        timestamp = MentalHealthUtils.getCurrentGameHours()
    }
    
    table.insert(MentalHealthEventManager.events[eventName], event)
    
    -- Keep only last 50 events per type
    if #MentalHealthEventManager.events[eventName] > 50 then
        table.remove(MentalHealthEventManager.events[eventName], 1)
    end
end

-- Get recent events of a specific type
function MentalHealthEventManager.getRecentEvents(eventName, hours)
    hours = hours or 24
    local currentTime = MentalHealthUtils.getCurrentGameHours()
    local recentEvents = {}
    
    if MentalHealthEventManager.events[eventName] then
        for _, event in ipairs(MentalHealthEventManager.events[eventName]) do
            if currentTime - event.timestamp <= hours then
                table.insert(recentEvents, event)
            end
        end
    end
    
    return recentEvents
end

-- Initialize standard mental health events
function MentalHealthEventManager.initializeStandardEvents()
    local standardEvents = {
        "OnMentalHealthCrisis",
        "OnPanicAttack", 
        "OnMoodEpisodeStart",
        "OnMoodEpisodeEnd",
        "OnMedicationTaken",
        "OnTherapySession",
        "OnHallucination",
        "OnTraumaExposure",
        "OnRecoveryMilestone"
    }
    
    for _, eventName in ipairs(standardEvents) do
        MentalHealthEventManager.registerEvent(eventName)
    end
    
    MentalHealthUtils.debugPrint("Initialized standard mental health events", "INFO")
end

-- Call initialization
MentalHealthEventManager.initializeStandardEvents()

print("Mental Health Event Manager loaded")
