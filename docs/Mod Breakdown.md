**Mod Title:** Project Zomboid: Mental Health Expansion

**Game:** Project Zomboid (Build 41+)

**Mod Concept Overview:**
This mod introduces mental health realism to Project Zomboid by simulating psychological conditions survivors may experience during the apocalypse. The goal is to increase immersion, narrative possibilities, and character complexity. It includes dynamic traits, symptoms, coping mechanisms, medication systems, and a dedicated Mental Health UI tab within the character health screen.

---

### **Purpose:**

* Add deeper psychological realism to survival gameplay.
* Simulate the impact of trauma, isolation, and long-term stress.
* Offer players tools to manage mental health, increasing emotional storytelling.
* Introduce fictional medications and therapy-inspired mechanics.

---

### **Core Mechanics:**

**1. Mental Health Conditions:**

* Depression
* Anxiety
* PTSD
* Insomnia
* Psychosis (optional, sensitive implementation)
* Obsessive-Compulsive Traits

**2. Triggers and Risk Factors:**

* Witnessing death, blood, corpses
* Sleeping in unsafe locations
* Excessive loneliness (no NPC/social actions)
* Malnutrition, insomnia, untreated wounds
* Zombie encounters or near-death experiences

**3. Symptoms:**

* Mood debuffs (e.g., sadness, exhaustion)
* Panic attacks, shaking, lowered focus
* Auditory hallucinations (sfx cues)
* Compulsive behaviors or sleep issues

**4. Coping and Recovery Tools:**

* Journals
* Books & cassette therapy tapes
* Comfort items (teddy bears, etc.)
* Medications (detailed below)

**5. Medications (Fictional):**

* *Serizon* — SSRI for depression
* *Kaletraxin* — Fast-acting anxiety relief
* *Thresta* — Antipsychotic
* Each has side effects, activation time, and dosage tracking

**6. UI Expansion:**

* Adds new "Mental Health" tab in Health Panel
* Displays conditions, current mood, recent triggers, medications
* Optionally includes therapy progress meter or journal entries

---

### **Implementation Strategy:**

**File Structure:**

```
MentalHealthMod/
├── media/
│   ├── lua/
│   │   ├── client/ISMentalHealthPanel.lua
│   │   ├── shared/MentalHealthSystem.lua
│   ├── scripts/items/MentalMedications.txt
├── textures/ui/
├── mod.info
```

**Lua Systems:**

* `MentalHealthSystem.lua` handles:

  * Condition tracking (stored in `player:getModData()`)
  * Trigger listeners (via `Events.OnPlayerUpdate`)
  * Symptom application
* `ISMentalHealthPanel.lua` handles:

  * UI logic to show mental state, icons, and effects

**Items File Example:**

```txt
item Serizon
{
    DisplayName = Serizon,
    Type = Drug,
    Weight = 0.1,
    UseDelta = 0.05,
    Tooltip = "Treats depressive symptoms over time.",
    Tags = Drug;
}
```

**Sample Lua Snippet:**

```lua
Events.OnPlayerUpdate.Add(function(player)
    local mh = player:getModData().MentalHealth or {depression = 0, anxiety = 0}
    if player:isOutside() and ZombRand(100) < 2 then
        mh.anxiety = mh.anxiety + 1
    end
    player:getModData().MentalHealth = mh
end)
```

---

### **Installation Instructions:**

1. Place mod folder in `C:\Users\[User]\Zomboid\mods\`
2. Launch Project Zomboid > Mods > Enable "Mental Health Expansion"
3. Optional: Use debug mode to view mental health states

---

### **Requirements & Tools:**

* Project Zomboid Build 41+
* Basic Lua knowledge
* Notepad++ / VS Code for scripting
* PZ Modding Tutorials:

  * [https://pzwiki.net/wiki/Modding](https://pzwiki.net/wiki/Modding)
  * The Indie Stone forums
  * GitHub PZ mod examples
* Image editor (e.g., GIMP) for UI icons

---

### **Future Features (Planned):**

* Trait-based initial conditions (e.g., "Melancholic")
* Hallucination system using sound and visual distortion
* Compatibility with NPC mods (e.g., real social support)
* Mood-based skill XP penalties or bonuses

---

### **Credits and Considerations:**

* Inspired by real mental health experiences
* Aim for respectful representation
* Feedback encouraged from mental health professionals and players alike
