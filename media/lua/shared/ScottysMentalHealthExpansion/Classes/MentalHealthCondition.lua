require "ISUI/ISBaseObject"

-- Base class for all mental health conditions
MentalHealthCondition = ISBaseObject:derive("MentalHealthCondition")

function MentalHealthCondition:new(name, player)
    local o = ISBaseObject:new()
    setmetatable(o, self)
    self.__index = self
    
    o.name = name
    o.player = player
    o.severity = 0
    o.lastUpdate = MentalHealthUtils.getCurrentGameHours()
    o.triggers = {}
    o.symptoms = {}
    o.medications = {}
    o.copingMechanisms = {}
    
    return o
end

function MentalHealthCondition:initialize()
    -- Override in subclasses
end

function MentalHealthCondition:update(timeDelta)
    -- Base update logic - override in subclasses
    self.lastUpdate = MentalHealthUtils.getCurrentGameHours()
end

function MentalHealthCondition:getSeverity()
    return self.severity
end

function MentalHealthCondition:setSeverity(value)
    self.severity = MentalHealthUtils.clamp(value, 0, 100)
end

function MentalHealthCondition:modifySeverity(delta)
    self:setSeverity(self.severity + delta)
end

function MentalHealthCondition:getSeverityLevel()
    return MentalHealthUtils.getSeverityLevel(self.severity)
end

function MentalHealthCondition:addTrigger(triggerType, intensity)
    table.insert(self.triggers, {
        type = triggerType,
        intensity = intensity,
        timestamp = MentalHealthUtils.getCurrentGameHours()
    })
end

function MentalHealthCondition:applySymptoms()
    -- Override in subclasses
end

function MentalHealthCondition:processRecovery(timeDelta)
    -- Base recovery logic
    if self.severity > 0 then
        local recoveryRate = MentalHealthConfig.CONDITIONS.RECOVERY_RATE * timeDelta
        self:modifySeverity(-recoveryRate)
    end
end

function MentalHealthCondition:canTrigger(triggerType)
    -- Check cooldowns and conditions
    return true
end

function MentalHealthCondition:getDescription()
    local level = self:getSeverityLevel()
    return string.format("%s (%s - %.1f%%)", self.name, level, self.severity)
end

print("MentalHealthCondition class loaded")
