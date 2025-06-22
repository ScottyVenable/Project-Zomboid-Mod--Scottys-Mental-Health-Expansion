# Project Zomboid Modding Guide for Mental Health Expansion

**Version:** 1.0.0  
**Last Updated:** [Date]  
**Game Version:** Build 41.78.16+  
**Focus:** Mental Health System Development

This guide provides comprehensive information about modding Project Zomboid specifically for developing mental health and psychological systems. It covers both general modding principles and specific implementations for our Mental Health Expansion mod.

---

## **Table of Contents**

1. [Getting Started with PZ Modding](#getting-started)
2. [File Structure and Organization](#file-structure)
3. [Lua Scripting in Project Zomboid](#lua-scripting)
4. [Item Scripting System](#item-scripting)
5. [UI Development](#ui-development)
6. [Player Data Management](#player-data)
7. [Event System](#event-system)
8. [Profession and Trait Creation](#professions-traits)
9. [Mental Health Specific Implementation](#mental-health-implementation)
10. [Testing and Debugging](#testing-debugging)
11. [Distribution and Publishing](#distribution)

---

## **Getting Started with PZ Modding** {#getting-started}

### **Development Environment Setup**

#### **Required Tools**
* **Text Editor:** Visual Studio Code, Notepad++, or Sublime Text
* **File Manager:** Windows Explorer or 7-Zip for archive handling
* **Version Control:** Git for tracking changes
* **Testing Environment:** Project Zomboid game installation

#### **Essential Extensions/Plugins**
* **VS Code Lua Extension:** Syntax highlighting and autocomplete
* **PZ Modding Extension:** Project Zomboid specific tools (if available)
* **File Association:** .txt files for item scripts, .lua for logic

#### **Project Zomboid Installation Paths**
```
Game Installation: C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\
User Data: C:\Users\[Username]\Zomboid\
Mods Directory: C:\Users\[Username]\Zomboid\mods\
Saves Directory: C:\Users\[Username]\Zomboid\Saves\
```

### **Modding Resources**

#### **Official Documentation**
* **PZ Wiki Modding Section:** https://pzwiki.net/wiki/Modding
* **The Indie Stone Forums:** Official mod development discussions
* **Steam Workshop:** Examples and inspiration from existing mods

#### **Community Resources**
* **GitHub Examples:** Open-source mod repositories
* **Discord Communities:** Real-time help and collaboration
* **YouTube Tutorials:** Video guides for specific techniques
* **Reddit Communities:** r/projectzomboid modding discussions

---

## **File Structure and Organization** {#file-structure}

### **Standard Mod Directory Structure**
```
YourModName/
├── mod.info                          # Mod metadata and configuration
├── poster.png                        # Mod thumbnail (256x256 recommended)
├── preview.png                       # Steam Workshop preview image
├── media/
│   ├── lua/
│   │   ├── client/                   # Client-side scripts (UI, effects)
│   │   │   ├── ISYourUIPanel.lua
│   │   │   └── ClientEvents.lua
│   │   ├── server/                   # Server-side scripts (multiplayer)
│   │   │   ├── ServerCommands.lua
│   │   │   └── ServerEvents.lua
│   │   └── shared/                   # Shared scripts (both client/server)
│   │       ├── YourMainSystem.lua
│   │       └── SharedUtilities.lua
│   ├── scripts/
│   │   ├── items/                    # Item definitions
│   │   │   ├── YourItems.txt
│   │   │   └── YourWeapons.txt
│   │   ├── professions/              # Career definitions
│   │   │   └── YourProfessions.txt
│   │   ├── traits/                   # Character traits
│   │   │   └── YourTraits.txt
│   │   └── recipes/                  # Crafting recipes
│   │       └── YourRecipes.txt
│   ├── textures/                     # Image assets
│   │   ├── ui/                       # User interface graphics
│   │   ├── items/                    # Item icons
│   │   └── characters/               # Character-related graphics
│   └── sounds/                       # Audio files
│       ├── effects/
│       └── music/
└── README.md                         # Documentation
```

### **Mental Health Mod Specific Structure**
```
MentalHealthMod/
├── mod.info
├── media/
│   ├── lua/
│   │   ├── client/
│   │   │   ├── ISMentalHealthPanel.lua        # Main UI panel
│   │   │   ├── ISHealthPanelMod.lua           # Health panel integration
│   │   │   ├── MoodTrackingUI.lua             # Mood tracking interface
│   │   │   └── HallucinationEffects.lua       # Visual/audio hallucinations
│   │   ├── shared/
│   │   │   ├── MentalHealthSystem.lua         # Core mental health logic
│   │   │   ├── BipolarSystem.lua              # Bipolar-specific systems
│   │   │   ├── HallucinationSystem.lua        # Hallucination management
│   │   │   ├── MedicationSystem.lua           # Medication effects
│   │   │   ├── CopingMechanisms.lua           # Therapy and coping tools
│   │   │   └── ProfessionalSkills.lua         # Mental health professions
│   │   └── server/
│   │       └── MultiplayerSync.lua            # Multiplayer synchronization
│   ├── scripts/
│   │   ├── items/
│   │   │   ├── MentalMedications.txt          # Psychiatric medications
│   │   │   ├── SelfHelpResources.txt          # Books and therapy tools
│   │   │   ├── ComfortItems.txt               # Emotional support items
│   │   │   └── ProfessionalEquipment.txt      # Professional tools
│   │   ├── professions/
│   │   │   └── MentalHealthProfessions.txt    # Therapist, psychiatrist, etc.
│   │   └── traits/
│   │       └── MentalHealthTraits.txt         # Starting mental conditions
│   └── textures/
│       ├── ui/
│       │   ├── mental_health_icons/           # Condition severity icons
│       │   └── mood_tracking/                 # Mood chart graphics
│       └── items/
│           ├── medications/                   # Pill bottle icons
│           └── therapy_tools/                 # Journal, comfort item icons
```

---

## **Lua Scripting in Project Zomboid** {#lua-scripting}

### **Basic Lua Concepts for PZ Modding**

#### **Variable Declaration and Scope**
```lua
-- Global variables (accessible everywhere)
MentalHealthSystem = {}

-- Local variables (function/file scope)
local function calculateAnxiety(player)
    local currentAnxiety = 0
    -- Function logic here
    return currentAnxiety
end

-- Module pattern for organization
local MyModule = {}
MyModule.publicFunction = function()
    -- Code here
end
return MyModule
```

#### **Project Zomboid Specific Functions**

**Player Access:**
```lua
-- Get the main player
local player = getPlayer()

-- Get specific player by index (multiplayer)
local player = getSpecificPlayer(0)

-- Get all players
local players = getOnlinePlayers()
```

**Player Data Management:**
```lua
-- Access mod data (persistent storage)
local modData = player:getModData()
modData.MentalHealth = modData.MentalHealth or {}

-- Get player stats
local stats = player:getStats()
local fatigue = stats:getFatigue()
local panic = stats:getPanic()

-- Modify player stats
stats:setFatigue(0.5)
stats:setPanic(25)
```

**Inventory Management:**
```lua
-- Get player inventory
local inventory = player:getInventory()

-- Check for specific items
if inventory:contains("Serizon") then
    -- Player has medication
end

-- Add items
inventory:AddItem("TherapyJournal")

-- Remove items
inventory:Remove("UsedMedication")
```

### **Mental Health System Implementation Patterns**

#### **Data Structure Design**
```lua
-- Initialize mental health data
function MentalHealthSystem.initPlayer(player)
    local modData = player:getModData()
    if not modData.MentalHealth then
        modData.MentalHealth = {
            -- Primary conditions (0-100 scale)
            depression = 0,
            anxiety = 0,
            ptsd = 0,
            insomnia = 0,
            psychosis = 0,
            ocd = 0,
            
            -- Tracking data
            lastUpdate = getGameTime():getWorldAgeHours(),
            triggers = {},
            medications = {},
            
            -- Recovery tracking
            therapySessions = 0,
            journalEntries = 0,
            lastCrisis = 0
        }
    end
end
```

#### **Update Loop Pattern**
```lua
-- Main update function called every game tick
function MentalHealthSystem.update(player)
    local modData = player:getModData()
    local mh = modData.MentalHealth
    
    if not mh then return end
    
    local currentTime = getGameTime():getWorldAgeHours()
    local timeDelta = currentTime - mh.lastUpdate
    
    -- Only update if sufficient time has passed (performance optimization)
    if timeDelta < 0.1 then return end
    
    -- Process various systems
    MentalHealthSystem.processEnvironmentalFactors(player, mh, timeDelta)
    MentalHealthSystem.processMedications(player, mh, currentTime)
    MentalHealthSystem.applySymptoms(player, mh)
    
    mh.lastUpdate = currentTime
end
```

#### **Event Handling Pattern**
```lua
-- Register event listeners
Events.OnCreatePlayer.Add(MentalHealthSystem.initPlayer)
Events.OnPlayerUpdate.Add(MentalHealthSystem.update)

-- Custom event creation
function MentalHealthSystem.triggerPanicAttack(player)
    player:getStats():setPanic(100)
    
    -- Trigger custom event for other systems to respond
    triggerEvent("OnPanicAttack", player)
end

-- Listen for custom events
Events.OnPanicAttack.Add(function(player)
    -- Other systems can respond to panic attacks
    print("Player is having a panic attack!")
end)
```

---

## **Item Scripting System** {#item-scripting}

### **Basic Item Definition Structure**

#### **Medication Item Example**
```txt
module Base
{
    item Serizon
    {
        DisplayName = "Serizon (SSRI)",
        Type = Drug,
        Weight = 0.1,
        Icon = Pills,
        
        # Usage properties
        UseDelta = 0.05,                    # How much is consumed per use
        UseWhileEquipped = false,
        
        # Effects
        OnEat = MentalHealthSystem.takeSerizon,
        
        # Tooltips and descriptions
        Tooltip = "Treats depressive symptoms over time. May cause drowsiness.",
        
        # Tags for categorization
        Tags = Drug;Mental;SSRI,
        
        # Rarity and distribution
        Rarity = 25,                        # Lower = more rare
    }
}
```

#### **Therapy Book Item Example**
```txt
item TherapyJournal
{
    DisplayName = "Therapy Journal",
    Type = Literature,
    Weight = 0.3,
    Icon = Book,
    
    # Literature-specific properties
    CanBeRead = true,
    CanBeWrite = true,
    NumberOfPages = 50,
    PageToWrite = 50,
    
    # Custom functionality
    OnRead = MentalHealthSystem.writeJournal,
    
    Tooltip = "A journal for recording thoughts and emotions. Helps process trauma.",
    Tags = Literature;Therapy;Mental,
}
```

### **Advanced Item Properties**

#### **Conditional Effects**
```txt
item AdvancedMedication
{
    DisplayName = "Complex Medication",
    Type = Drug,
    
    # Multiple effect handlers
    OnEat = MedicationSystem.takeAdvancedMed,
    OnUse = MedicationSystem.checkDosage,
    
    # Conditional properties
    RequireInHandsForEquipped = true,
    CantBeFrozen = true,
    
    # Medical properties
    PoisonDetectionLevel = 3,           # Detectable by medical skills
    PoisonPower = 0,                    # Not actually poisonous
    
    # Custom data
    ModData = {
        MedicalCategory = "Psychiatric",
        RequiresPrescription = true,
        SideEffects = "drowsiness;nausea",
    }
}
```

#### **Container Items for Therapy Kits**
```txt
item TherapyKit
{
    DisplayName = "Complete Therapy Kit",
    Type = Container,
    Weight = 2.0,
    Capacity = 15,
    Icon = Bag_SchoolBag,
    
    # Container-specific properties
    CanBeEquipped = Back,
    OpenSound = BagOpen,
    CloseSound = BagClose,
    
    # Starting contents
    ItemsToSpawnAtWorldStart = {
        "TherapyJournal",
        "CrisisCards", 
        "ComfortBlanket"
    },
    
    Tooltip = "Professional therapy supplies for mental health treatment.",
    Tags = Container;Therapy;Professional,
}
```

### **Item Distribution and Spawning**

#### **Adding Items to Spawn Lists**
```lua
-- In Lua files, modify spawn tables
function MentalHealthItems.addToSpawnLists()
    -- Add to medical locations
    SuburbsDistributions["medicine"]["items"] = SuburbsDistributions["medicine"]["items"] or {}
    table.insert(SuburbsDistributions["medicine"]["items"], "Serizon")
    table.insert(SuburbsDistributions["medicine"]["items"], 5.0) -- Weight/probability
    
    -- Add to bookstore locations  
    SuburbsDistributions["bookstore"]["items"] = SuburbsDistributions["bookstore"]["items"] or {}
    table.insert(SuburbsDistributions["bookstore"]["items"], "TherapyJournal")
    table.insert(SuburbsDistributions["bookstore"]["items"], 10.0)
end

-- Call during mod initialization
Events.OnGameStart.Add(MentalHealthItems.addToSpawnLists)
```

---

## **UI Development** {#ui-development}

### **Creating Custom UI Panels**

#### **Basic Panel Structure**
```lua
require "ISUI/ISPanel"

-- Define the panel class
ISMentalHealthPanel = ISPanel:derive("ISMentalHealthPanel")

function ISMentalHealthPanel:initialise()
    ISPanel.initialise(self)
    -- Initialize panel-specific elements
end

function ISMentalHealthPanel:new(x, y, width, height, player)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    
    -- Store player reference
    o.player = player
    
    -- Set visual properties
    o.backgroundColor = {r=0, g=0, b=0, a=0.8}
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
    
    return o
end
```

#### **Rendering Content**
```lua
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
    
    -- Draw condition bars
    self:drawProgressBar(10, y, 200, 15, mh.depression, 100, 0.8, 0.2, 0.2)
    self:drawText("Depression: " .. math.floor(mh.depression) .. "%", 220, y, 1, 1, 1, 1, UIFont.Small)
    y = y + lineHeight + 5
    
    -- Continue for other conditions...
end

-- Helper function for progress bars
function ISMentalHealthPanel:drawProgressBar(x, y, width, height, value, maxValue, r, g, b)
    -- Background
    self:drawRect(x, y, width, height, 0.3, 0.3, 0.3, 0.8)
    
    -- Fill
    local fillWidth = (value / maxValue) * width
    self:drawRect(x, y, fillWidth, height, r, g, b, 0.8)
    
    -- Border
    self:drawRectBorder(x, y, width, height, 1, 1, 1, 1)
end
```

#### **Interactive Elements**
```lua
function ISMentalHealthPanel:createChildren()
    -- Add buttons for actions
    self.journalButton = ISButton:new(10, self.height - 50, 100, 25, "Write Journal", self, ISMentalHealthPanel.onJournalClick)
    self.journalButton.internal = "JOURNAL"
    self:addChild(self.journalButton)
    
    self.meditateButton = ISButton:new(120, self.height - 50, 100, 25, "Meditate", self, ISMentalHealthPanel.onMeditateClick)
    self.meditateButton.internal = "MEDITATE"
    self:addChild(self.meditateButton)
end

function ISMentalHealthPanel:onJournalClick()
    local inventory = self.player:getInventory()
    if inventory:contains("TherapyJournal") then
        MentalHealthSystem.writeJournal(self.player)
    else
        self.player:Say("I need a journal to write in...")
    end
end
```

### **Integrating with Existing UI**

#### **Adding Tab to Health Panel**
```lua
-- Override existing health panel
local original_ISHealthPanel_createChildren = ISHealthPanel.createChildren

function ISHealthPanel:createChildren()
    -- Call original function
    original_ISHealthPanel_createChildren(self)
    
    -- Add our mental health tab
    self.mentalHealthPanel = ISMentalHealthPanel:new(0, 0, self.width, self.height, self.character)
    self.mentalHealthPanel:initialise()
    self.panel:addView("Mental Health", self.mentalHealthPanel)
end
```

---

## **Player Data Management** {#player-data}

### **ModData System**

#### **Data Persistence**
```lua
-- ModData automatically saves with the player save file
function MentalHealthSystem.saveData(player)
    local modData = player:getModData()
    
    -- Data in modData persists automatically
    modData.MentalHealth.lastSaveTime = getGameTime():getWorldAgeHours()
    
    -- Force save if needed (usually automatic)
    player:transmitModData()
end
```

#### **Data Migration and Updates**
```lua
function MentalHealthSystem.migrateData(player)
    local modData = player:getModData()
    local mh = modData.MentalHealth
    
    if not mh then
        -- First time initialization
        MentalHealthSystem.initPlayer(player)
        return
    end
    
    -- Check version and migrate
    if not mh.version or mh.version < 2.0 then
        -- Add new fields for version 2.0
        mh.bipolar = mh.bipolar or {
            subtype = 0,
            currentMoodState = 0,
            moodSeverity = 0
        }
        mh.version = 2.0
    end
end
```

### **Multiplayer Considerations**

#### **Client-Server Synchronization**
```lua
-- Client requests data from server
function MentalHealthSystem.requestServerData(player)
    if isClient() then
        sendClientCommand(player, "MentalHealth", "RequestData", {})
    end
end

-- Server responds with data
function MentalHealthSystem.onServerCommand(module, command, player, args)
    if module == "MentalHealth" then
        if command == "RequestData" then
            -- Send mental health data to client
            sendServerCommand(player, "MentalHealth", "ReceiveData", player:getModData().MentalHealth)
        end
    end
end

-- Register server command handler
Events.OnClientCommand.Add(MentalHealthSystem.onServerCommand)
```

---

## **Event System** {#event-system}

### **Built-in Events**

#### **Player Lifecycle Events**
```lua
-- Character creation and initialization
Events.OnCreatePlayer.Add(function(playerNum, player)
    MentalHealthSystem.initPlayer(player)
end)

-- Regular updates (every game tick)
Events.OnPlayerUpdate.Add(function(player)
    MentalHealthSystem.update(player)
end)

-- Player death
Events.OnPlayerDeath.Add(function(player)
    MentalHealthSystem.handleDeath(player)
end)
```

#### **Game State Events**
```lua
-- Game start/load
Events.OnGameStart.Add(function()
    MentalHealthSystem.initializeGlobalSystems()
end)

-- Save game
Events.OnSave.Add(function()
    MentalHealthSystem.saveGlobalData()
end)

-- Load game
Events.OnLoad.Add(function()
    MentalHealthSystem.loadGlobalData()
end)
```

#### **Action-Based Events**
```lua
-- Combat and violence
Events.OnZombieDead.Add(function(zombie)
    local player = getPlayer()
    MentalHealthSystem.processViolenceTrauma(player, zombie)
end)

-- Item usage
Events.OnPlayerAttackFinished.Add(function(player, handWeapon)
    MentalHealthSystem.processWeaponUse(player, handWeapon)
end)

-- Sleep and rest
Events.OnPlayerSleep.Add(function(player)
    MentalHealthSystem.processSleepQuality(player)
end)
```

### **Custom Events**

#### **Creating Custom Events**
```lua
-- Define custom events for mental health system
function MentalHealthSystem.triggerCustomEvent(eventName, player, data)
    -- Create event data
    local eventData = {
        player = player,
        timestamp = getGameTime():getWorldAgeHours(),
        data = data
    }
    
    -- Trigger the event
    triggerEvent(eventName, eventData)
end

-- Example usage
MentalHealthSystem.triggerCustomEvent("OnMentalHealthCrisis", player, {
    condition = "severe_depression",
    severity = 85
})
```

#### **Event Listeners**
```lua
-- Register custom event listeners
Events.OnMentalHealthCrisis.Add(function(eventData)
    local player = eventData.player
    local severity = eventData.data.severity
    
    -- Respond to crisis
    if severity > 80 then
        MentalHealthSystem.initiateCrisisIntervention(player)
    end
end)
```

---

## **Profession and Trait Creation** {#professions-traits}

### **Profession Definition**

#### **Mental Health Professional Example**
```txt
profession psychiatrist
{
    name = "Psychiatrist",
    description = "You are a medical doctor specializing in mental health. You can prescribe psychiatric medications and provide comprehensive treatment.",
    
    # Point cost for character creation
    cost = 8,
    
    # Starting traits
    traits = {
        FastLearner = 1,
        KeenHearing = 1,
        EagleEyed = 1,
    },
    
    # Starting skills
    skills = {
        MentalHealthLiteracy = 4,
        FirstAid = 3,
        Chemistry = 2,
        Psychology = 2,
    },
    
    # Starting items
    startingItems = {
        "Shirt_FormalWhite",
        "Trousers_Suit",
        "Stethoscope",
        "Pills",
        "Book",
        "Notebook",
        "Pen",
    },
}
```

### **Trait Definition**

#### **Mental Health Condition Trait**
```txt
trait BipolarI
{
    name = "Bipolar I Disorder",
    description = "You have been diagnosed with Bipolar I Disorder, experiencing severe manic and depressive episodes.",
    
    # Negative trait (costs points)
    cost = -6,
    
    # Cannot be taken with conflicting traits
    cantHave = {
        "BipolarII",
        "Depression",
    },
    
    # Required with other traits
    requiresAll = {},
    
    # Custom initialization
    OnCreate = BipolarSystem.initializeBipolarI,
}
```

#### **Trait Implementation in Lua**
```lua
function BipolarSystem.initializeBipolarI(player)
    local modData = player:getModData()
    
    -- Initialize mental health data if not exists
    MentalHealthSystem.initPlayer(player)
    
    -- Set bipolar-specific data
    modData.MentalHealth.bipolar = {
        subtype = BipolarSystem.BIPOLAR_I,
        currentMoodState = BipolarSystem.MOOD_STABLE,
        moodSeverity = 0,
        episodeHistory = {},
        lastEpisode = 0
    }
    
    -- Set initial depression level
    modData.MentalHealth.depression = ZombRand(20, 40)
    
    player:Say("Managing my bipolar disorder will be crucial for survival...")
end
```

---

## **Mental Health Specific Implementation** {#mental-health-implementation}

### **Condition Severity Scaling**

#### **Progressive Symptom System**
```lua
function MentalHealthSystem.applySymptoms(player, mentalHealth)
    local stats = player:getStats()
    
    -- Depression effects scale with severity
    if mentalHealth.depression > 0 then
        local depressionEffect = mentalHealth.depression / 100
        
        -- Mild (0-33%): Slight fatigue increase
        if mentalHealth.depression <= 33 then
            stats:setFatigue(math.min(1.0, stats:getFatigue() + (depressionEffect * 0.1)))
            
        -- Moderate (34-66%): Fatigue + movement penalties
        elseif mentalHealth.depression <= 66 then
            stats:setFatigue(math.min(1.0, stats:getFatigue() + (depressionEffect * 0.15)))
            -- Add movement speed penalty (implementation needed)
            
        -- Severe (67-100%): Major impairment
        else
            stats:setFatigue(math.min(1.0, stats:getFatigue() + (depressionEffect * 0.25)))
            -- Severe movement and XP penalties
            if ZombRand(1000) < 5 then
                player:Say("I can barely function anymore...")
            end
        end
    end
end
```

### **Trigger Event Processing**

#### **Environmental Factor Assessment**
```lua
function MentalHealthSystem.processEnvironmentalFactors(player, mentalHealth, timeDelta)
    local square = player:getSquare()
    local stats = player:getStats()
    
    -- Darkness and isolation
    local lightLevel = square:getLightLevel(player:getPlayerNum())
    if lightLevel < 0.3 and player:isOutside() then
        mentalHealth.anxiety = math.min(100, mentalHealth.anxiety + (timeDelta * 0.5))
    end
    
    -- Weather effects
    local weather = getClimateManager():getWeatherPeriod()
    if weather:isRaining() and player:isOutside() then
        mentalHealth.depression = math.min(100, mentalHealth.depression + (timeDelta * 0.2))
    end
    
    -- Social isolation
    local lastSocialContact = mentalHealth.lastSocialContact or 0
    local currentTime = getGameTime():getWorldAgeHours()
    if currentTime - lastSocialContact > 48 then -- 2 days
        mentalHealth.depression = math.min(100, mentalHealth.depression + (timeDelta * 0.3))
    end
    
    -- Unsafe sleeping
    if player:isAsleep() and not MentalHealthSystem.isSafeLocation(player) then
        mentalHealth.anxiety = math.min(100, mentalHealth.anxiety + (timeDelta * 0.8))
        mentalHealth.insomnia = math.min(100, mentalHealth.insomnia + (timeDelta * 0.4))
    end
end
```

### **Recovery Mechanism Implementation**

#### **Therapy Session Processing**
```lua
function MentalHealthSystem.conductTherapySession(patient, therapist, sessionType)
    local patientMH = patient:getModData().MentalHealth
    local therapistSkills = therapist:getModData().ProfessionalSkills
    
    if not patientMH then return end
    
    -- Base effectiveness
    local effectiveness = 1.0
    
    -- Professional skill bonus
    if therapistSkills and therapistSkills.psychology then
        effectiveness = effectiveness + (therapistSkills.psychology * 0.1)
    end
    
    -- Session type effectiveness
    local reductionAmount = 0
    if sessionType == "CBT" then
        reductionAmount = 5 * effectiveness
        patientMH.depression = math.max(0, patientMH.depression - reductionAmount)
        patientMH.anxiety = math.max(0, patientMH.anxiety - reductionAmount)
        
    elseif sessionType == "trauma_therapy" then
        reductionAmount = 8 * effectiveness
        patientMH.ptsd = math.max(0, patientMH.ptsd - reductionAmount)
        
    elseif sessionType == "crisis_intervention" then
        reductionAmount = 15 * effectiveness
        -- Target highest severity condition
        local highestCondition = MentalHealthSystem.getHighestSeverityCondition(patientMH)
        patientMH[highestCondition] = math.max(0, patientMH[highestCondition] - reductionAmount)
    end
    
    -- Track therapy sessions
    patientMH.therapySessions = (patientMH.therapySessions or 0) + 1
    
    -- Provide feedback
    therapist:Say("How are you feeling after this session?")
    patient:Say("That was really helpful. Thank you.")
end
```

---

## **Testing and Debugging** {#testing-debugging}

### **Debug Mode Implementation**

#### **Debug Panel for Testing**
```lua
ISMentalHealthDebug = ISPanel:derive("ISMentalHealthDebug")

function ISMentalHealthDebug:new(x, y, width, height)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    return o
end

function ISMentalHealthDebug:createChildren()
    local y = 30
    
    -- Add buttons for testing various conditions
    self.depressionButton = ISButton:new(10, y, 150, 25, "Add Depression +20", self, self.addDepression)
    self:addChild(self.depressionButton)
    y = y + 30
    
    self.anxietyButton = ISButton:new(10, y, 150, 25, "Add Anxiety +20", self, self.addAnxiety)
    self:addChild(self.anxietyButton)
    y = y + 30
    
    self.resetButton = ISButton:new(10, y, 150, 25, "Reset All", self, self.resetMentalHealth)
    self:addChild(self.resetButton)
end

function ISMentalHealthDebug:addDepression()
    local player = getPlayer()
    local mh = player:getModData().MentalHealth
    if mh then
        mh.depression = math.min(100, mh.depression + 20)
    end
end

-- Toggle debug mode with key combination
function MentalHealthSystem.toggleDebugMode()
    if not MentalHealthSystem.debugMode then
        MentalHealthSystem.debugMode = true
        MentalHealthSystem.debugPanel = ISMentalHealthDebug:new(100, 100, 200, 300)
        MentalHealthSystem.debugPanel:initialise()
        MentalHealthSystem.debugPanel:addToUIManager()
    else
        MentalHealthSystem.debugMode = false
        if MentalHealthSystem.debugPanel then
            MentalHealthSystem.debugPanel:removeFromUIManager()
            MentalHealthSystem.debugPanel = nil
        end
    end
end

-- Bind to key (F12 for example)
Events.OnKeyPressed.Add(function(key)
    if key == Keyboard.KEY_F12 then
        MentalHealthSystem.toggleDebugMode()
    end
end)
```

### **Logging and Error Handling**

#### **Comprehensive Logging System**
```lua
MentalHealthLogger = {}

function MentalHealthLogger.log(level, message, data)
    local timestamp = getGameTime():getWorldAgeHours()
    local logEntry = string.format("[%s] %s: %s", timestamp, level, message)
    
    if data then
        logEntry = logEntry .. " | Data: " .. tostring(data)
    end
    
    -- Output to console
    print("[Mental Health Mod] " .. logEntry)
    
    -- Save to file (if modding API supports it)
    -- writeLog("mental_health.log", logEntry)
end

function MentalHealthLogger.error(message, data)
    MentalHealthLogger.log("ERROR", message, data)
end

function MentalHealthLogger.warning(message, data)
    MentalHealthLogger.log("WARNING", message, data)
end

function MentalHealthLogger.info(message, data)
    MentalHealthLogger.log("INFO", message, data)
end

function MentalHealthLogger.debug(message, data)
    if MentalHealthSystem.debugMode then
        MentalHealthLogger.log("DEBUG", message, data)
    end
end
```

#### **Error Handling Patterns**
```lua
function MentalHealthSystem.safeUpdate(player)
    local success, error = pcall(function()
        MentalHealthSystem.update(player)
    end)
    
    if not success then
        MentalHealthLogger.error("Failed to update mental health system", error)
        
        -- Attempt to reinitialize if data is corrupted
        local modData = player:getModData()
        if not modData.MentalHealth then
            MentalHealthLogger.info("Reinitializing corrupted mental health data")
            MentalHealthSystem.initPlayer(player)
        end
    end
end

-- Use safe update in event handlers
Events.OnPlayerUpdate.Add(MentalHealthSystem.safeUpdate)
```

### **Testing Scenarios**

#### **Automated Testing Functions**
```lua
MentalHealthTesting = {}

function MentalHealthTesting.testDepressionProgression()
    local player = getPlayer()
    local mh = player:getModData().MentalHealth
    
    MentalHealthLogger.info("Testing depression progression...")
    
    -- Simulate isolation
    mh.lastSocialContact = getGameTime():getWorldAgeHours() - 72
    
    -- Run update cycles
    for i = 1, 100 do
        MentalHealthSystem.processEnvironmentalFactors(player, mh, 1.0)
    end
    
    MentalHealthLogger.info("Depression level after isolation: " .. mh.depression)
    
    -- Test therapy effectiveness
    MentalHealthSystem.writeJournal(player)
    MentalHealthLogger.info("Depression level after journal therapy: " .. mh.depression)
end

function MentalHealthTesting.runAllTests()
    MentalHealthTesting.testDepressionProgression()
    MentalHealthTesting.testMedicationEffects()
    MentalHealthTesting.testCrisisIntervention()
    -- Add more tests as needed
end
```

---

## **Distribution and Publishing** {#distribution}

### **Preparing for Release**

#### **mod.info Configuration**
```ini
name=Mental Health Expansion
poster=poster.png
id=MentalHealthMod
description=Comprehensive mental health simulation for Project Zomboid. Adds realistic psychological conditions, treatments, and coping mechanisms to enhance survival gameplay.

url=https://github.com/yourname/pz-mental-health-mod
modversion=1.0.0
pzversion=41.78.16

# Workshop tags
tags=Realistic;Medical;Survival;Psychology

# Author information
author=YourName
authorurl=https://github.com/yourname

# File requirements
require=

# Pack ID for Steam Workshop
packId=
```

#### **File Cleanup and Optimization**
```bash
# Remove development files
rm -rf .git/
rm -rf debug/
rm -rf temp/

# Compress textures if needed
# Optimize audio files

# Validate all .lua files for syntax errors
lua -l yourfile.lua

# Check all .txt files for proper formatting
```

### **Steam Workshop Publishing**

#### **Preparation Steps**
1. **Create Workshop Item:**
   - Open Project Zomboid
   - Go to Workshop → Create Mod
   - Fill in mod details

2. **Upload Files:**
   - Select mod folder
   - Add preview images
   - Write comprehensive description

3. **Set Visibility:**
   - Private for testing
   - Friends only for beta testing
   - Public for release

#### **Workshop Description Template**
```markdown
# Mental Health Expansion for Project Zomboid

A comprehensive mental health simulation mod that adds psychological realism to your survival experience.

## Features
- 7 mental health conditions with realistic symptoms
- Professional mental health careers
- Comprehensive medication system
- Therapy and coping mechanisms
- Dedicated mental health UI

## Installation
1. Subscribe to this mod
2. Enable in Mods menu
3. Start new game or load existing save

## Compatibility
- Project Zomboid Build 41.78.16+
- Compatible with most other mods
- Multiplayer supported

## Support
- GitHub: [link]
- Discord: [link]
- Bug reports: [link]
```

### **GitHub Repository Setup**

#### **Repository Structure**
```
pz-mental-health-mod/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── CONTRIBUTING.md
├── .gitignore
├── docs/
│   ├── installation.md
│   ├── user-guide.md
│   └── developer-guide.md
├── releases/
└── [mod files]
```

#### **Release Process**
```bash
# Tag version
git tag -a v1.0.0 -m "Version 1.0.0 release"

# Create release archive
zip -r mental-health-mod-v1.0.0.zip MentalHealthMod/

# Upload to GitHub releases
# Update Steam Workshop
```

---

## **Best Practices and Tips**

### **Performance Optimization**

#### **Efficient Update Loops**
```lua
-- Only update when necessary
function MentalHealthSystem.efficientUpdate(player)
    local modData = player:getModData()
    local mh = modData.MentalHealth
    
    if not mh then return end
    
    local currentTime = getGameTime():getWorldAgeHours()
    local timeDelta = currentTime - mh.lastUpdate
    
    -- Skip frequent updates
    if timeDelta < 0.5 then return end
    
    -- Batch similar operations
    MentalHealthSystem.processAllConditions(player, mh, timeDelta)
    
    mh.lastUpdate = currentTime
end
```

#### **Memory Management**
```lua
-- Clean up old data
function MentalHealthSystem.cleanupOldData(mentalHealth)
    local currentTime = getGameTime():getWorldAgeHours()
    
    -- Remove old triggers (keep last 7 days)
    if mentalHealth.triggers then
        for i = #mentalHealth.triggers, 1, -1 do
            local trigger = mentalHealth.triggers[i]
            if currentTime - trigger.time > 168 then -- 7 days
                table.remove(mentalHealth.triggers, i)
            end
        end
    end
end
```

### **Code Organization**

#### **Modular Design**
```lua
-- Separate systems into modules
MentalHealthCore = require "MentalHealthCore"
MedicationSystem = require "MedicationSystem"
TherapySystem = require "TherapySystem"
UISystem = require "UISystem"

-- Main coordinator
MentalHealthMod = {
    core = MentalHealthCore,
    medications = MedicationSystem,
    therapy = TherapySystem,
    ui = UISystem
}
```

#### **Configuration System**
```lua
MentalHealthConfig = {
    -- Adjustment factors for balancing
    depressionRate = 1.0,
    anxietyRate = 1.0,
    recoveryRate = 1.0,
    
    -- Feature toggles
    enableHallucinations = true,
    enableCrisisEvents = true,
    debugMode = false,
    
    -- UI settings
    showDetailedSymptoms = true,
    updateFrequency = 0.5,
}

-- Load from file if available
function MentalHealthConfig.load()
    -- Load configuration from sandbox options or file
end
```

---

## **Troubleshooting Common Issues**

### **Frequent Problems and Solutions**

#### **Save File Corruption**
```lua
function MentalHealthSystem.validateSaveData(player)
    local modData = player:getModData()
    
    if not modData.MentalHealth then
        MentalHealthLogger.warning("Missing mental health data, reinitializing")
        MentalHealthSystem.initPlayer(player)
        return false
    end
    
    -- Check for required fields
    local required = {"depression", "anxiety", "ptsd", "insomnia", "psychosis", "ocd"}
    for _, field in ipairs(required) do
        if modData.MentalHealth[field] == nil then
            MentalHealthLogger.warning("Missing field: " .. field .. ", resetting to 0")
            modData.MentalHealth[field] = 0
        end
    end
    
    return true
end
```

#### **Multiplayer Desync Issues**
```lua
function MentalHealthSystem.synchronizeWithServer(player)
    if isClient() then
        -- Request sync from server
        sendClientCommand(player, "MentalHealth", "RequestSync", {
            playerID = player:getPlayerNum()
        })
    end
end

-- Handle sync response
function MentalHealthSystem.handleSyncResponse(player, data)
    if isClient() then
        local modData = player:getModData()
        modData.MentalHealth = data
        MentalHealthLogger.info("Mental health data synchronized with server")
    end
end
```

### **Debug Tools**

#### **Console Commands**
```lua
-- Register debug commands
function MentalHealthSystem.registerCommands()
    if isDebugEnabled() then
        -- Add mental health condition
        registerCommand("addCondition", function(args)
            local player = getPlayer()
            local condition = args[1]
            local amount = tonumber(args[2]) or 10
            
            local mh = player:getModData().MentalHealth
            if mh and mh[condition] then
                mh[condition] = math.min(100, mh[condition] + amount)
                print("Added " .. amount .. " to " .. condition)
            end
        end)
        
        -- Reset mental health
        registerCommand("resetMentalHealth", function(args)
            local player = getPlayer()
            MentalHealthSystem.initPlayer(player)
            print("Mental health reset")
        end)
    end
end
```

This comprehensive modding guide provides the foundation for developing mental health systems in Project Zomboid, with specific examples and patterns tailored to our Mental Health Expansion mod. Use this as a reference for implementing features and troubleshooting issues during development.
