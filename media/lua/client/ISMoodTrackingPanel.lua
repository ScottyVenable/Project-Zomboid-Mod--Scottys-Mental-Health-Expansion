require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISScrollingListBox"
require "ISUI/ISTextEntryBox"

ISMoodTrackingPanel = ISPanel:derive("ISMoodTrackingPanel")

function ISMoodTrackingPanel:initialise()
    ISPanel.initialise(self)
    self:createChildren()
end

function ISMoodTrackingPanel:createChildren()
    -- Mood list
    self.list = ISScrollingListBox:new(10, 10, self.width - 20, self.height - 80)
    self.list:initialise()
    self.list:instantiate()
    self.list.itemheight = 18
    self:addChild(self.list)

    -- Input for new mood rating
    self.entry = ISTextEntryBox:new("", 10, self.height - 60, 40, 18)
    self.entry:initialise()
    self:addChild(self.entry)

    self.recordButton = ISButton:new(60, self.height - 60, 80, 18, "Record Mood", self, ISMoodTrackingPanel.onRecordMood)
    self.recordButton.internal = "RECORD"
    self:addChild(self.recordButton)

    self:refreshList()
end

function ISMoodTrackingPanel:refreshList()
    self.list:clear()
    local bipolar = self.player:getModData().MentalHealth and self.player:getModData().MentalHealth.bipolar
    if not bipolar then return end
    local days = {}
    for day,_ in pairs(bipolar.dailyMoods) do
        table.insert(days, day)
    end
    table.sort(days, function(a,b) return a>b end)
    local shown = 0
    for _,day in ipairs(days) do
        local mood = bipolar.dailyMoods[day]
        self.list:addItem("Day " .. tostring(day), tostring(math.floor(mood)))
        shown = shown + 1
        if shown >= 7 then break end
    end
end

function ISMoodTrackingPanel:onRecordMood()
    local rating = tonumber(self.entry:getText())
    if rating then
        rating = math.max(0, math.min(100, rating))
        BipolarSystem.trackMood(self.player, rating)
        self.entry:setText("")
        self:refreshList()
    else
        self.player:Say("Enter a mood rating 0-100")
    end
end

function ISMoodTrackingPanel:new(x, y, width, height, player)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.player = player
    o.backgroundColor = {r=0, g=0, b=0, a=0.8}
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
    return o
end
