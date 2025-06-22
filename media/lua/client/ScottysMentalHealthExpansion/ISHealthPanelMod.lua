require "ISUI/ISTabPanel"
require "ISUI/ISCollapsableWindow"

-- Store original function
local original_ISHealthPanel_createChildren = ISHealthPanel.createChildren

-- Override the createChildren function to add our mental health tab
function ISHealthPanel:createChildren()
    -- Call original function first
    original_ISHealthPanel_createChildren(self)
    
    -- Add Mental Health tab
    self.mentalHealthPanel = ISMentalHealthPanel:new(0, 0, self.width, self.height, self.character)
    self.mentalHealthPanel:initialise()
    self.panel:addView("Mental Health", self.mentalHealthPanel)
    
    -- Set background for consistency
    self.mentalHealthPanel.backgroundColor = {r=0, g=0, b=0, a=0.8}
end

-- Ensure mental health system is initialized when health panel is created
Events.OnCreatePlayer.Add(function(playerNum, player)
    if MentalHealthSystem then
        MentalHealthSystem.initPlayer(player)
    end
end)

print("Health Panel integration loaded successfully")
-- Hook into the health window creation
local original_ISHealthWindow_new = ISHealthWindow.new

function ISHealthWindow:new(x, y, character)
    local o = original_ISHealthWindow_new(self, x, y, character)
    return o
end

-- Duplicate listener removed
