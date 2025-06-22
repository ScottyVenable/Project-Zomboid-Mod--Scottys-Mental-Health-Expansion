-- Mental Health Expansion Configuration
-- Contains all shared config data used by both client and server scripts

MentalHealthConfig = {}

-- Version Information
MentalHealthConfig.VERSION = "1.0.0"
MentalHealthConfig.MOD_ID = "MentalHealthExpansion"
MentalHealthConfig.DEBUG_MODE = false

-- Core System Settings
MentalHealthConfig.SYSTEM = {
    -- Update frequency (in hours)
    UPDATE_FREQUENCY = 0.1,
    
    -- Maximum severity for conditions (0-100)
    MAX_SEVERITY = 100,
    
    -- Minimum time between similar events (hours)
    EVENT_COOLDOWN = 1.0,
    
    -- Enable/disable individual systems
    ENABLE_HALLUCINATIONS = true,
    ENABLE_PANIC_ATTACKS = true,
    ENABLE_MOOD_TRACKING = true,
    ENABLE_CRISIS_EVENTS = true,
}

-- Condition Scaling Factors
MentalHealthConfig.CONDITIONS = {
    -- Base progression rates (per hour)
    DEPRESSION_RATE = 0.01,
    ANXIETY_RATE = 0.02,
    PTSD_RATE = 0.015,
    INSOMNIA_RATE = 0.01,
    PSYCHOSIS_RATE = 0.005,
    OCD_RATE = 0.008,
    
    -- Recovery rates (per hour when conditions are met)
    RECOVERY_RATE = 0.005,
    
    -- Severity thresholds
    MILD_THRESHOLD = 33,
    MODERATE_THRESHOLD = 66,
    SEVERE_THRESHOLD = 90,
}

-- Medication Settings
MentalHealthConfig.MEDICATIONS = {
    -- Effectiveness multipliers
    EFFECTIVENESS_MULTIPLIER = 1.0,
    
    -- Side effect probability (percentage)
    SIDE_EFFECT_CHANCE = 15,
    
    -- Maximum dosage levels
    MAX_DOSAGE = {
        SERIZON = 3,
        KALETRAXIN = 2,
        THRESTA = 2,
        LITHIZONE = 3,
        VALPREX = 2,
        LAMOTRIGEX = 2,
    },
    
    -- Duration of effects (hours)
    DURATION = {
        SERIZON = 24,
        KALETRAXIN = 4,
        THRESTA = 12,
        LITHIZONE = 12,
        VALPREX = 12,
        LAMOTRIGEX = 24,
    },
}

-- Bipolar Disorder Settings
MentalHealthConfig.BIPOLAR = {
    -- Episode duration ranges (hours)
    EPISODE_DURATION = {
        DEPRESSION_MIN = 336,  -- 2 weeks
        DEPRESSION_MAX = 2160, -- 3 months
        MANIA_MIN = 168,       -- 1 week
        MANIA_MAX = 672,       -- 4 weeks
        HYPOMANIA_MIN = 96,    -- 4 days
        HYPOMANIA_MAX = 168,   -- 1 week
    },
    
    -- Mood state transition probabilities
    TRANSITION_PROBABILITY = 0.02,
    
    -- Rapid cycling threshold (episodes per year)
    RAPID_CYCLING_THRESHOLD = 4,
}

-- Trigger System Settings
MentalHealthConfig.TRIGGERS = {
    -- Environmental triggers
    DARKNESS_ANXIETY = 0.1,
    RAIN_DEPRESSION = 0.05,
    UNSAFE_SLEEP = 0.2,
    ISOLATION_FACTOR = 0.15,
    
    -- Trauma triggers
    ZOMBIE_KILL_PTSD = 2,
    BLOOD_SIGHT_TRAUMA = 1,
    CORPSE_SIGHT_TRAUMA = 1.5,
    NEAR_DEATH_TRAUMA = 5,
    
    -- Social triggers
    SOCIAL_ISOLATION_HOURS = 48,
    SOCIAL_BENEFIT_MULTIPLIER = 1.5,
}

-- Coping Mechanism Settings
MentalHealthConfig.COPING = {
    -- Therapy effectiveness
    JOURNAL_EFFECTIVENESS = 2,
    MEDITATION_EFFECTIVENESS = 1.5,
    READING_EFFECTIVENESS = 3,
    
    -- Item benefits
    COMFORT_ITEM_BENEFIT = 0.5,
    PROFESSIONAL_MULTIPLIER = 1.5,
    
    -- Skill progression
    SKILL_GAIN_RATE = 0.1,
    MAX_SKILL_LEVEL = 10,
}

-- UI Settings
MentalHealthConfig.UI = {
    -- Panel dimensions
    PANEL_WIDTH = 300,
    PANEL_HEIGHT = 400,
    
    -- Update frequency (seconds)
    UI_UPDATE_FREQUENCY = 1.0,
    
    -- Color themes
    COLORS = {
        DEPRESSION = {r=0.8, g=0.2, b=0.2, a=0.8},
        ANXIETY = {r=0.8, g=0.8, b=0.2, a=0.8},
        PTSD = {r=0.6, g=0.3, b=0.8, a=0.8},
        INSOMNIA = {r=0.3, g=0.6, b=0.8, a=0.8},
        PSYCHOSIS = {r=0.5, g=0.2, b=0.5, a=0.8},
        OCD = {r=0.2, g=0.8, b=0.4, a=0.8},
        STABLE = {r=0.3, g=0.8, b=0.3, a=0.8},
    },
}

-- Professional System Settings
MentalHealthConfig.PROFESSIONALS = {
    -- Effectiveness bonuses
    PSYCHOLOGIST_BONUS = 1.5,
    PSYCHIATRIST_BONUS = 2.0,
    PHARMACIST_BONUS = 1.3,
    BHP_BONUS = 1.2,
    DSP_BONUS = 1.1,
    
    -- Training capabilities
    CAN_TRAIN_OTHERS = true,
    TRAINING_EFFECTIVENESS = 2.0,
}

-- Multiplayer Settings
MentalHealthConfig.MULTIPLAYER = {
    -- Sync frequency (seconds)
    SYNC_FREQUENCY = 5.0,
    
    -- Social interaction benefits
    GROUP_THERAPY_BONUS = 2.0,
    PEER_SUPPORT_BONUS = 1.5,
    
    -- Privacy settings
    SHARE_MENTAL_HEALTH = false,
    ANONYMOUS_SUPPORT = true,
}

-- Debug Settings
MentalHealthConfig.DEBUG = {
    -- Console logging
    LOG_LEVEL = "INFO", -- DEBUG, INFO, WARNING, ERROR
    
    -- Debug commands
    ENABLE_DEBUG_COMMANDS = false,
    
    -- Testing mode
    ACCELERATED_PROGRESSION = false,
    INSTANT_EFFECTS = false,
}

-- Accessibility Settings
MentalHealthConfig.ACCESSIBILITY = {
    -- Content warnings
    SHOW_CONTENT_WARNINGS = true,
    
    -- Sensitive content filters
    FILTER_SELF_HARM_CONTENT = false,
    FILTER_SUICIDE_CONTENT = false,
    
    -- Alternative descriptions
    USE_CLINICAL_LANGUAGE = false,
    SIMPLIFIED_DESCRIPTIONS = false,
}

-- Save these settings to player mod data for persistence
function MentalHealthConfig.saveToPlayer(player)
    local modData = player:getModData()
    modData.MentalHealthConfig = MentalHealthConfig
end

-- Load settings from player mod data
function MentalHealthConfig.loadFromPlayer(player)
    local modData = player:getModData()
    if modData.MentalHealthConfig then
        -- Merge saved settings with defaults
        for category, settings in pairs(modData.MentalHealthConfig) do
            if MentalHealthConfig[category] then
                for key, value in pairs(settings) do
                    MentalHealthConfig[category][key] = value
                end
            end
        end
    end
end

-- Sandbox options integration
function MentalHealthConfig.loadFromSandboxOptions()
    local options = getSandboxOptions()
    if options then
        -- Load sandbox settings if they exist
        MentalHealthConfig.SYSTEM.UPDATE_FREQUENCY = options:getOptionByName("MH_UpdateFrequency"):getValue() or 0.1
        MentalHealthConfig.CONDITIONS.DEPRESSION_RATE = options:getOptionByName("MH_DepressionRate"):getValue() or 0.01
        -- Add more sandbox option mappings as needed
    end
end

print("Mental Health Config loaded - Version " .. MentalHealthConfig.VERSION)
