require "ISUI/ISPanel"
require "ISUI/ISButton"

ISMentalHealthPanel = ISPanel:derive("ISMentalHealthPanel")

function ISMentalHealthPanel:initialise()
    ISPanel.initialise(self)
    self:createChildren()
end

function ISMentalHealthPanel:createChildren()
    -- Journal button for therapy
    self.journalButton = ISButton:new(10, self.height - 50, 100, 25, "Write Journal", self, ISMentalHealthPanel.onJournalClick)
    self.journalButton.internal = "JOURNAL"
    self:addChild(self.journalButton)
    
    -- Meditation/Rest button
    self.restButton = ISButton:new(120, self.height - 50, 100, 25, "Rest & Reflect", self, ISMentalHealthPanel.onRestClick)
    self.restButton.internal = "REST"
    self:addChild(self.restButton)
end

function ISMentalHealthPanel:new(x, y, width, height, player)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.player = player
    o.backgroundColor = {r=0, g=0, b=0, a=0.8}
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
    return o
end

function ISMentalHealthPanel:drawProgressBar(x, y, width, height, value, maxValue, r, g, b)
    -- Background
    self:drawRect(x, y, width, height, 0.3, 0.3, 0.3, 0.8)
    
    -- Fill
    local fillWidth = (value / maxValue) * width
    self:drawRect(x, y, fillWidth, height, r, g, b, 0.8)
    
    -- Border
    self:drawRectBorder(x, y, width, height, 1, 1, 1, 1)
end

function ISMentalHealthPanel:getSeverityColor(value)
    if value < 25 then
        return 0.2, 0.8, 0.2 -- Green (minimal)
    elseif value < 50 then
        return 0.8, 0.8, 0.2 -- Yellow (moderate)
    elseif value < 75 then
        return 0.9, 0.5, 0.2 -- Orange (severe)
    else
        return 0.9, 0.2, 0.2 -- Red (critical)
    end
end

function ISMentalHealthPanel:getSeverityText(value)
    if value < 25 then
        return "Minimal"
    elseif value < 50 then
        return "Moderate"
    elseif value < 75 then
        return "Severe"
    else
        return "Critical"
    end
end

function ISMentalHealthPanel:render()
    ISPanel.render(self)
    
    local modData = self.player:getModData()
    local mh = modData.MentalHealth
    
    if not mh then return end
    
    local y = 20
    local lineHeight = 18
    
    -- Draw title
    self:drawText("Mental Health Status", 10, y, 1, 1, 1, 1, UIFont.Medium)
    y = y + lineHeight * 2
    
    -- Draw condition levels
    self:drawText("Depression: " .. math.floor(mh.depression) .. "%", 10, y, 1, 1, 1, 1, UIFont.Small)
    self:drawProgressBar(150, y, 100, 12, mh.depression, 100, 0.8, 0.2, 0.2)
    y = y + lineHeight
    
    self:drawText("Anxiety: " .. math.floor(mh.anxiety) .. "%", 10, y, 1, 1, 1, 1, UIFont.Small)
    self:drawProgressBar(150, y, 100, 12, mh.anxiety, 100, 0.8, 0.8, 0.2)
    y = y + lineHeight
    
    self:drawText("PTSD: " .. math.floor(mh.ptsd) .. "%", 10, y, 1, 1, 1, 1, UIFont.Small)
    self:drawProgressBar(150, y, 100, 12, mh.ptsd, 100, 0.6, 0.3, 0.8)
    y = y + lineHeight
    
    self:drawText("Insomnia: " .. math.floor(mh.insomnia) .. "%", 10, y, 1, 1, 1, 1, UIFont.Small)
    self:drawProgressBar(150, y, 100, 12, mh.insomnia, 100, 0.3, 0.6, 0.8)
    y = y + lineHeight
    
    self:drawText("Psychosis: " .. math.floor(mh.psychosis) .. "%", 10, y, 1, 1, 1, 1, UIFont.Small)
    self:drawProgressBar(150, y, 100, 12, mh.psychosis, 100, 0.5, 0.2, 0.5)
    y = y + lineHeight
    
    self:drawText("OCD: " .. math.floor(mh.ocd) .. "%", 10, y, 1, 1, 1, 1, UIFont.Small)
    self:drawProgressBar(150, y, 100, 12, mh.ocd, 100, 0.2, 0.8, 0.4)
    y = y + lineHeight * 2
    
    -- Active medications
    self:drawText("Active Medications:", 10, y, 1, 1, 1, 1, UIFont.Small)
    y = y + lineHeight
    
    if mh.medications.serizon.level > 0 then
        self:drawText("• Serizon (Level " .. mh.medications.serizon.level .. ")", 20, y, 0.8, 0.8, 1, 1, UIFont.Small)
        y = y + lineHeight
    end
    
    if mh.medications.kaletraxin.level > 0 then
        self:drawText("• Kaletraxin (Level " .. mh.medications.kaletraxin.level .. ")", 20, y, 0.8, 0.8, 1, 1, UIFont.Small)
        y = y + lineHeight
    end
    
    if mh.medications.thresta.level > 0 then
        self:drawText("• Thresta (Level " .. mh.medications.thresta.level .. ")", 20, y, 0.8, 0.8, 1, 1, UIFont.Small)
        y = y + lineHeight
    end
end

function ISMentalHealthPanel:onJournalClick()
    local inventory = self.player:getInventory()
    if inventory:contains("TherapyJournal") then
        if MentalHealthSystem then
            MentalHealthSystem.writeJournal(self.player)
        end
    else
        self.player:Say("I need a therapy journal to write in...")
    end
end

function ISMentalHealthPanel:onRestClick()
    if not self.player:isOutside() and self.player:getStats():getFatigue() < 0.5 then
        local mh = self.player:getModData().MentalHealth
        if mh then
            mh.anxiety = math.max(0, mh.anxiety - 2)
            mh.depression = math.max(0, mh.depression - 1)
            self.player:Say("Taking a moment to center myself...")
        end
    else
        self.player:Say("I need to be in a safe, calm place to properly rest...")
    end
end

function ISMentalHealthPanel:update()
    ISPanel.update(self)
    
    -- Update button availability
    local inventory = self.player:getInventory()
    if self.journalButton then
        self.journalButton.enable = inventory:contains("TherapyJournal")
    end
    
    if self.restButton then
        self.restButton.enable = not self.player:isOutside() and self.player:getStats():getFatigue() < 0.5
    end
end

print("Mental Health Panel loaded successfully")
        end
        if bipolar.moodStabilizers.valprex.level > 0 then
            self:drawText("• Valprex (Level " .. math.floor(bipolar.moodStabilizers.valprex.level) .. ")", 20, y, 0.6, 1, 0.6, 1, UIFont.Small)
            y = y + lineHeight - 2
            hasMeds = true
        end
        if bipolar.moodStabilizers.lamotrigex.level > 0 then
            self:drawText("• Lamotrigex (Level " .. math.floor(bipolar.moodStabilizers.lamotrigex.level) .. ")", 20, y, 0.6, 1, 0.6, 1, UIFont.Small)
            y = y + lineHeight - 2
            hasMeds = true
        end
    end
    
    if not hasMeds then
        self:drawText("None", 20, y, 0.6, 0.6, 0.6, 1, UIFont.Small)
        y = y + lineHeight
    end
    
    y = y + 5
    
    -- Current Symptoms
    self:drawText("Active Symptoms:", 10, y, 1, 0.7, 0.7, 1, UIFont.Small)
    y = y + lineHeight
    
    local hasSymptoms = false
    
    if mh.depression > 30 then
        self:drawText("• Chronic fatigue and low energy", 20, y, 0.9, 0.7, 0.7, 1, UIFont.Small)
        y = y + lineHeight - 2
        hasSymptoms = true
    end
    
    if mh.anxiety > 40 then
        self:drawText("• Heightened panic and stress", 20, y, 0.9, 0.7, 0.7, 1, UIFont.Small)
        y = y + lineHeight - 2
        hasSymptoms = true
    end
    
    if mh.ptsd > 50 then
        self:drawText("• Flashbacks and sudden panic", 20, y, 0.9, 0.7, 0.7, 1, UIFont.Small)
        y = y + lineHeight - 2
        hasSymptoms = true
    end
    
    if mh.insomnia > 50 then
        self:drawText("• Difficulty sleeping and resting", 20, y, 0.9, 0.7, 0.7, 1, UIFont.Small)
        y = y + lineHeight - 2
        hasSymptoms = true
    end
    
    if mh.psychosis > 60 then
        self:drawText("• Auditory hallucinations", 20, y, 0.9, 0.7, 0.7, 1, UIFont.Small)
        y = y + lineHeight - 2
        hasSymptoms = true
    end
    
    if not hasSymptoms then
        self:drawText("You are feeling relatively stable", 20, y, 0.6, 0.8, 0.6, 1, UIFont.Small)
        y = y + lineHeight
    end
    
    y = y + 5
    
    -- Coping Resources
    self:drawText("Coping Resources:", 10, y, 0.7, 0.9, 1, 1, UIFont.Small)
    y = y + lineHeight
    
    if mh.comfortItems > 0 then
        self:drawText("• Comfort items in inventory: " .. mh.comfortItems, 20, y, 0.7, 0.9, 0.7, 1, UIFont.Small)
        y = y + lineHeight - 2
    end
    
    if mh.journalEntries > 0 then
        self:drawText("• Journal entries written: " .. mh.journalEntries, 20, y, 0.7, 0.9, 0.7, 1, UIFont.Small)
        y = y + lineHeight - 2
    end
    
    -- Overall mental state assessment
    y = y + 8
    local overallScore = (mh.depression + mh.anxiety + mh.ptsd + mh.insomnia + mh.psychosis) / 5
    local stateText = ""
    local stateColor = {r=0.6, g=0.6, b=0.6}
    
    if overallScore < 20 then
        stateText = "Mental state: Stable"
        stateColor = {r=0.2, g=0.8, b=0.2}
    elseif overallScore < 40 then
        stateText = "Mental state: Mild distress"
        stateColor = {r=0.8, g=0.8, b=0.2}
    elseif overallScore < 60 then
        stateText = "Mental state: Moderate distress"
        stateColor = {r=0.9, g=0.5, b=0.2}
    else
        stateText = "Mental state: Severe distress"
        stateColor = {r=0.9, g=0.2, b=0.2}
    end
    
    self:drawText(stateText, 10, y, stateColor.r, stateColor.g, stateColor.b, 1, UIFont.Small)
end

-- Button click handlers
function ISMentalHealthPanel:onJournalClick()
    local inventory = self.player:getInventory()
    if inventory:contains("TherapyJournal") then
        if MentalHealthSystem then
            MentalHealthSystem.writeJournal(self.player)
        end
    else
        self.player:Say("I need a therapy journal to write in...")
    end
end

function ISMentalHealthPanel:onRestClick()
    if not self.player:isOutside() and self.player:getStats():getFatigue() < 0.5 then
        local mh = self.player:getModData().MentalHealth
        if mh then
            mh.anxiety = math.max(0, mh.anxiety - 2)
            mh.depression = math.max(0, mh.depression - 1)
            self.player:Say("Taking a moment to center myself...")
        end
    else
        self.player:Say("I need to be in a safe, calm place to properly rest...")
    end
end

function ISMentalHealthPanel:update()
    ISPanel.update(self)
    
    -- Update button availability
    local inventory = self.player:getInventory()
    if self.journalButton then
        self.journalButton.enable = inventory:contains("TherapyJournal")
    end
    
    if self.restButton then
        self.restButton.enable = not self.player:isOutside() and self.player:getStats():getFatigue() < 0.5
    end
end
