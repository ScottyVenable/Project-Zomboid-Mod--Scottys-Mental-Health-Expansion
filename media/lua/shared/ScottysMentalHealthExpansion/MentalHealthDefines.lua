-- Mental Health Global Adjustments
-- These modify base game mechanics to better integrate with mental health system

-- Only modify globals if mental health mod is enabled
if getActivatedMods():contains("MentalHealthExpansion") then
    
    -- Reduce base stress decrease to make stress more persistent
    -- (Mental health system will handle stress relief through therapy)
    ZomboidGlobals.StressDecrease = 0.05  -- Default: 0.1
    
    -- Slightly increase stress from sounds for anxiety sufferers
    ZomboidGlobals.StressFromSoundsMultiplier = 0.00003  -- Default: 0.00002
    
    -- Make unhappiness more persistent (mental health system handles recovery)
    ZomboidGlobals.UnhappinessIncrease = 0.0001  -- Default: 0.0
    
    -- Reduce boredom decrease (depression affects ability to enjoy activities)
    ZomboidGlobals.BoredomDecrease = 0.02  -- Default: 0.0385
    
    -- Slightly increase fatigue accumulation (mental health affects energy)
    ZomboidGlobals.FatigueIncrease = 0.00001  -- Default: 0.0
    
    print("Mental Health global adjustments applied")
end
