**Mod Title:** Project Zomboid: Mental Health Expansion

**Game:** Project Zomboid (Build 41+)

**Version:** 1.0.0

**Mod Concept Overview:**
This mod introduces comprehensive mental health realism to Project Zomboid by simulating psychological conditions survivors may experience during the apocalypse. The goal is to increase immersion, narrative possibilities, and character complexity through dynamic mental health tracking, realistic symptom manifestation, coping mechanisms, medication systems, and a dedicated Mental Health UI tab within the character health screen.

**Mod Tags:**
- mental-health, psychology, survival, realism, simulation, RPG, immersive, character-management, emotional-storytelling

---

### **Purpose:**

* Add deeper psychological realism to survival gameplay with scientifically-informed mechanics
* Simulate the realistic impact of trauma, isolation, and long-term stress on mental well-being
* Offer players meaningful tools to manage mental health, increasing emotional storytelling opportunities
* Introduce fictional medications with realistic pharmacological behaviors
* Create awareness and reduce stigma around mental health challenges
* Provide an additional layer of character progression and management

---

### **Core Mental Health Conditions:**

**1. Depression (0-100% Severity)**
* **Triggers:** Prolonged isolation, malnutrition, physical injury, lack of sunlight, witnessing death
* **Symptoms:** 
  - Chronic fatigue (increased fatigue rate)
  - Reduced XP gain (planned feature)
  - Slower movement when severe
  - Negative mood moodles
* **Progression:** Builds slowly over days/weeks, harder to recover from than other conditions
* **Real-world inspiration:** Major Depressive Disorder symptoms

**2. Anxiety (0-100% Severity)**
* **Triggers:** High-stress situations, unsafe sleeping, loud noises, being outdoors at night, low health
* **Symptoms:**
  - Increased panic response
  - Panic attacks at severe levels (sudden max panic + stress)
  - Higher base panic level
  - Shaking/trembling visual effects (planned)
* **Progression:** Can spike quickly but also recovers faster than depression
* **Real-world inspiration:** Generalized Anxiety Disorder and Panic Disorder

**3. PTSD (0-100% Severity)**
* **Triggers:** Zombie kills, seeing corpses, blood exposure, near-death experiences, loud sudden noises
* **Symptoms:**
  - Random panic spikes (flashbacks)
  - Hypervigilance (increased hearing range but constant low panic)
  - Sleep disruption when severe
  - Avoidance behaviors (planned: penalties for entering "trigger" areas)
* **Progression:** Trauma-based spikes with slow natural recovery
* **Real-world inspiration:** Post-Traumatic Stress Disorder

**4. Insomnia (0-100% Severity)**
* **Triggers:** High anxiety/PTSD, sleeping in unsafe locations, caffeine overconsumption, pain
* **Symptoms:**
  - Difficulty falling asleep (longer sleep initiation time)
  - Random wake-ups during sleep
  - Increased fatigue accumulation
  - Reduced sleep quality (less fatigue recovery per hour)
* **Progression:** Often secondary to other conditions
* **Real-world inspiration:** Chronic Insomnia Disorder

**5. Psychosis (0-100% Severity)**
* **Triggers:** Extreme isolation (72+ hours alone), severe untreated mental illness, extreme stress, malnutrition
* **Symptoms:**
  - Auditory hallucinations ("Did you hear that?", zombie sounds when none present)
  - Paranoid thoughts (random panic spikes)
  - Visual distortions (planned: occasional false zombie sprites)
  - Difficulty distinguishing reality (planned: false inventory items)
* **Progression:** Rare condition, only occurs under extreme circumstances
* **Real-world inspiration:** Psychotic episodes and Brief Psychotic Disorder

**6. Obsessive-Compulsive Traits (0-100% Severity)**
* **Triggers:** High stress, need for control in chaotic environment, perfectionist tendencies
* **Symptoms:**
  - Compulsive item organization (automatic inventory sorting)
  - Excessive checking behaviors (multiple door lock checks)
  - Contamination fears (increased infection risk perception)
  - Ritualistic behaviors (planned: required action sequences)
* **Progression:** Stress-related buildup with behavioral reinforcement
* **Real-world inspiration:** Obsessive-Compulsive Disorder

**7. Bipolar Disorder (0-100% Severity with Mood State Tracking)**
* **Subtypes:**
  - **Bipolar I Disorder:** Severe manic episodes with major depressive episodes
  - **Bipolar II Disorder:** Hypomanic episodes with major depressive episodes
  - **Bipolar I with Psychotic Features:** Manic episodes including hallucinations/delusions
  - **Character Traits:** Each subtype can be chosen during character creation as a negative trait (Bipolar I, Bipolar II, or Bipolar I - Psychotic)

* **Mood States:**
  - **Depressive Episodes (0-100% severity):**
    - Triggers: Stress, sleep deprivation, seasonal changes, medication non-compliance
    - Symptoms: Severe fatigue, hopelessness, psychomotor retardation, suicidal ideation
    - Duration: 2+ weeks in-game, gradual onset and recovery
    - Effects: Massive XP penalties, movement speed reduction, social withdrawal

  - **Manic Episodes (0-100% severity):**
    - Triggers: Sleep deprivation, stimulants, high stress, substance use
    - Symptoms: Decreased need for sleep, grandiosity, hyperactivity, poor judgment
    - Duration: 1+ weeks in-game, rapid onset possible
    - Effects: Reduced sleep requirements but increased recklessness, hyperfocus on activities

  - **Hypomanic Episodes (0-60% severity - Bipolar II only):**
    - Milder version of mania, less impairment
    - Increased productivity and confidence
    - May feel beneficial initially but leads to burnout
    - Effects: Temporary skill bonuses but increased anxiety when episode ends

  - **Mixed Episodes:**
    - Simultaneous manic and depressive symptoms
    - Extremely dangerous state with high agitation
    - Increased risk of panic attacks and poor decisions
    - Most challenging state to manage

* **Mood Cycling Patterns:**
  - **Rapid Cycling:** 4+ mood episodes per in-game year
  - **Ultra-rapid Cycling:** Mood changes within days/weeks
  - **Ultradian Cycling:** Multiple mood shifts within 24 hours (severe cases)
  - **Seasonal Patterns:** Depression in winter, mania/hypomania in spring/summer

* **Specific Symptoms by Episode Type:**
  **Depressive Episode Symptoms:**
  - Severe fatigue and psychomotor retardation
  - Concentration difficulties (skill learning penalties)
  - Appetite changes (either increased or decreased hunger)
  - Sleep disturbances (hypersomnia or insomnia)
  - Feelings of worthlessness and guilt
  - Suicidal ideation in severe cases

  **Manic Episode Symptoms:**
  - Decreased sleep need (2-3 hours vs normal 6-8)
  - Grandiose beliefs and inflated self-esteem
  - Pressured speech and racing thoughts
  - Distractibility and attention problems
  - Increased goal-directed activity (hyperfocus on tasks)
  - Risky behavior and poor judgment
  - Irritability when interrupted or challenged

  **Hypomanic Episode Symptoms:**
  - Elevated mood and increased energy
  - Decreased sleep need (4-5 hours)
  - Increased creativity and productivity
  - More talkative and social
  - Mild increase in risky behavior
  - Generally functional but noticeable changes

  **Psychotic Features (Bipolar I only):**
  - Auditory hallucinations during severe manic episodes
  - Grandiose or paranoid delusions
  - Disorganized thinking and speech
  - Complete loss of insight during acute episodes
  - May believe they have special powers or missions

* **Triggers and Risk Factors:**
  - **Sleep Disruption:** Most reliable trigger for mood episodes
  - **Stress:** Major life events, trauma, ongoing pressure
  - **Substance Use:** Alcohol, stimulants, depressants
  - **Medication Changes:** Starting, stopping, or changing mood stabilizers
  - **Seasonal Changes:** Light exposure, temperature variations
  - **Hormonal Changes:** Planned future feature for realistic cycles

* **Progression and Patterns:**
  - **Early Stage:** Longer periods of stability between episodes
  - **Established Pattern:** More frequent episodes, clearer triggers
  - **Advanced/Untreated:** Rapid cycling, mixed episodes, cognitive decline
  - **With Treatment:** Longer periods of stability, milder episodes
* **Real-world inspiration:** DSM-5 Bipolar and Related Disorders, clinical research on mood cycling

---

### **Enhanced Trigger System:**

**Bipolar-Specific Triggers:**
* **Sleep Pattern Disruption:** Most critical trigger
  - Missing sleep for 2+ nights triggers mania/hypomania
  - Oversleeping for extended periods triggers depression
  - Irregular sleep schedules increase overall instability

* **Circadian Rhythm Disruption:**
  - Staying awake through dawn (circadian trigger)
  - Artificial light exposure during night hours
  - Seasonal light changes affecting mood regulation

* **Stimulant Exposure:**
  - Coffee, energy drinks, amphetamines trigger mania
  - Cumulative effect with multiple stimulant uses
  - Withdrawal from stimulants can trigger depression

* **High-Stress Achievement:**
  - Completing major goals or reaching milestones
  - Success paradoxically triggering manic episodes
  - Pressure to maintain high performance levels

---

### **Sophisticated Medication System:**

**Serizon (SSRI-class Antidepressant)**
* **Primary Effect:** Reduces depression by 0.5 points per hour for 24 hours
* **Secondary Effects:** Mild anxiety reduction, emotional stabilization
* **Side Effects:** 
  - 10% chance per hour of increased fatigue
  - Slight nausea during first few doses (planned)
  - Sexual dysfunction (planned: mood penalties)
* **Dosage:** Maximum 3 levels, once daily dosing
* **Onset:** 2-4 hours for acute effects, 2-4 weeks for full efficacy (simulated)
* **Real-world inspiration:** Fluoxetine (Prozac), Sertraline (Zoloft)

**Kaletraxin (Benzodiazepine-class Anxiolytic)**
* **Primary Effect:** Rapid anxiety reduction (2 points per hour for 4 hours)
* **Secondary Effects:** Panic attack prevention, muscle relaxation
* **Side Effects:**
  - Drowsiness and fatigue increase
  - Potential dependency (planned: withdrawal effects)
  - Cognitive impairment (planned: skill penalties)
* **Dosage:** Maximum 2 levels, as-needed dosing
* **Onset:** 30 minutes to 1 hour
* **Real-world inspiration:** Lorazepam (Ativan), Alprazolam (Xanax)

**Thresta (Atypical Antipsychotic)**
* **Primary Effect:** Reduces psychosis by 1 point per hour for 12 hours
* **Secondary Effects:** Severe anxiety reduction, mood stabilization
* **Side Effects:**
  - Sedation and movement slowdown
  - Weight gain simulation (planned: increased hunger)
  - Extrapyramidal symptoms (planned: movement penalties)
* **Dosage:** Maximum 2 levels, twice daily dosing
* **Onset:** 1-2 hours for acute effects
* **Real-world inspiration:** Risperidone, Olanzapine, Quetiapine

**Lithizone (Lithium-class Mood Stabilizer)**
* **Primary Effect:** Prevents and reduces severity of manic and depressive episodes
* **Mechanism:** Stabilizes mood cycling, reduces episode frequency
* **Dosage Requirements:**
  - Requires regular dosing every 12 hours
  - Blood level simulation (therapeutic window)
  - Too little = ineffective, too much = toxicity
* **Side Effects:**
  - Increased thirst and urination
  - Hand tremor and coordination issues
  - Weight gain and sluggishness
  - Potential kidney problems with long-term use
* **Monitoring Required:** Regular "blood tests" to maintain therapeutic levels
* **Real-world inspiration:** Lithium carbonate

**Valprex (Anticonvulsant Mood Stabilizer)**
* **Primary Effect:** Particularly effective for mixed episodes and rapid cycling
* **Secondary Effects:** Also helps with anxiety and agitation
* **Side Effects:**
  - Drowsiness and fatigue
  - Weight gain and increased appetite
  - Hair loss (cosmetic penalty)
  - Cognitive dulling (slight skill penalties)
* **Advantages:** More tolerable than lithium, broader spectrum
* **Real-world inspiration:** Valproic acid (Depakote)

**Lamotrigex (Anti-seizure Mood Stabilizer)**
* **Primary Effect:** Excellent for bipolar depression, prevents depressive episodes
* **Special Property:** Less effective for mania, often combined with other medications
* **Side Effects:**
  - Potentially serious skin reactions (rare but dangerous)
  - Insomnia and headaches
  - Dizziness and coordination problems
* **Titration Required:** Must start with low dose and increase gradually
* **Real-world inspiration:** Lamotrigine (Lamictal)
* **Game Implementation:** Side effects like thirst, fatigue, and insomnia occur when mood stabilizers are active

**Medication Combinations for Bipolar:**
* **Dual Therapy:** Two mood stabilizers for better coverage
* **Adjunct Antipsychotics:** Added during acute manic episodes
* **Antidepressant Caution:** Can trigger mania if used without mood stabilizer
* **Polypharmacy Management:** Complex interactions and side effect profiles

---

### **Comprehensive Coping Mechanisms:**

**Self-Help Literature System:**
* **"Managing Anxiety in Crisis" Book:** 
  - Reading provides anxiety reduction techniques
  - 10-page book with breathing exercises and grounding methods
  - Reduces anxiety by 3-5 points per reading session
  - Unlocks "Deep Breathing" action for emergency anxiety relief
  - Can be re-read for continued benefit (diminishing returns)

* **"Depression: A Survivor's Guide" Book:**
  - Comprehensive guide to understanding and managing depression
  - 15-page book covering cognitive restructuring and behavioral activation
  - Reduces depression by 4-6 points per reading session
  - Unlocks "Behavioral Activation" tasks (cleaning, organizing for mood boost)
  - Provides long-term coping strategies and relapse prevention

* **"Trauma Recovery Workbook" Book:**
  - Specialized resource for PTSD and trauma processing
  - 20-page interactive workbook with exercises
  - Reduces PTSD by 5-8 points per completion
  - Unlocks "Grounding Techniques" for flashback management
  - Requires multiple sessions to complete fully

* **"Sleep Hygiene Handbook" Book:**
  - Guide to improving sleep quality and combating insomnia
  - 8-page practical manual with sleep environment tips
  - Reduces insomnia by 4-7 points per reading
  - Unlocks "Sleep Ritual" action for better rest quality
  - Provides knowledge about sleep positioning and timing

* **"Mindfulness for Beginners" Book:**
  - Introduction to meditation and mindfulness practices
  - 12-page guide with progressive meditation techniques
  - Reduces all mental health conditions by 1-2 points
  - Unlocks advanced meditation options in Rest & Reflect
  - Enables "Mindful Walking" for outdoor stress relief

* **"Cognitive Behavioral Therapy Workbook" Book:**
  - Advanced self-therapy resource combining multiple techniques
  - 25-page comprehensive workbook requiring multiple items
  - Most effective self-help resource with 8-12 point reductions
  - Unlocks "Thought Challenge" system for cognitive restructuring
  - Requires pen/pencil and paper for maximum effectiveness

* **"Living with Bipolar Disorder" Book:**
  - Comprehensive 30-page guide covering all aspects of bipolar management
  - Mood tracking techniques and episode recognition
  - Reduces mood episode severity by 15-20%
  - Unlocks "Mood Monitoring" and "Episode Planning" actions
  - Teaches early warning sign recognition

* **"Bipolar Mood Tracking Workbook":**
  - Specialized 25-page workbook for daily mood monitoring
  - Charts mood, sleep, medications, and triggers
  - Essential tool for pattern recognition and episode prediction
  - Enables "Mood Graph" feature in UI showing mood trends
  - Unlocks the Mood Tracking tab in the Health screen
  - Helps identify personal trigger patterns

* **"Managing Bipolar Depression" Book:**
  - 20-page focused guide for depressive episodes
  - Behavioral activation specifically for bipolar depression
  - Cognitive strategies for mood-related thoughts
  - Reduces depressive episode severity by 10-15%
  - Unlocks "Depression Action Plan" for episode management

* **"Mania Management Manual":**
  - 15-page emergency guide for manic episodes
  - Techniques for self-monitoring and damage control
  - Sleep hygiene and stimulation reduction strategies
  - Reduces manic episode severity and duration
  - Unlocks "Mania Safety Plan" action

**Advanced Journal Therapy System:**
* **Basic Therapy Journal:** 
  - 50-page writable journal for emotional processing
  - Standard mental health benefits as previously described
  - Can be personalized with drawings and specific entries

* **Structured CBT Journal:**
  - Specialized journal with guided prompts and exercises
  - 75-page journal with specific sections for different techniques
  - Enhanced benefits: reduces depression/anxiety by 3-4 points per entry
  - Includes mood tracking, thought records, and behavioral experiments
  - Unlocks "Weekly Review" sessions for pattern recognition

* **Trauma Processing Journal:**
  - Specialized journal for PTSD and trauma work
  - 60-page journal with trauma-specific prompts
  - Reduces PTSD by 4-6 points per entry
  - Includes exposure exercises and trigger management strategies
  - Safer alternative to direct trauma exposure

* **Gratitude Journal:**
  - Focus on positive psychology and resilience building
  - 40-page journal for daily gratitude practice
  - Provides passive mental health benefits when carried
  - Reduces depression by 2-3 points per entry
  - Builds "Resilience" stat that protects against future mental health decline

**Comfort Items and Emotional Support Objects:**
* **Teddy Bear:** 
  - Soft comfort object providing emotional security
  - Passive anxiety reduction when in inventory (-1 anxiety per hour)
  - Enhanced sleep quality when in bedroom
  - Can be "hugged" for immediate stress relief (action)

* **Comfort Blanket:**
  - Weighted blanket providing deep pressure stimulation
  - Reduces anxiety and insomnia when used for sleeping
  - Can be used for "Blanket Cocoon" comfort action
  - Provides warmth bonus and emotional security

* **Stress Ball:**
  - Portable stress relief tool for anxiety management
  - Right-click action provides immediate anxiety reduction (2-3 points)
  - Can be used during high-stress situations
  - Helps with restless energy and fidgeting

* **Personal Photos:**
  - Pictures of loved ones, pets, or happy memories
  - Provides emotional connection and hope
  - Viewing photos reduces depression and loneliness
  - Can trigger both positive and negative emotional responses

* **Memory Box:**
  - Container for storing meaningful personal items
  - Allows players to collect and organize sentimental objects
  - Provides cumulative emotional benefits based on contents
  - Can include letters, jewelry, photos, and small mementos

* **Aromatherapy Candles:**
  - Scented candles with calming properties
  - Lavender reduces anxiety, vanilla reduces depression
  - Creates "Calm Environment" mood bonus in enclosed spaces
  - Requires matches/lighter and safe location to use

**Mindfulness and Meditation Expanded:**
* **Basic Rest & Reflect:** 
  - Simple meditation and self-reflection
  - Requires safe, quiet environment
  - Reduces anxiety/depression by 1-2 points

* **Guided Meditation (with book):**
  - Enhanced meditation with "Mindfulness for Beginners" book
  - Structured meditation sessions with progressive difficulty
  - Reduces all mental health conditions by 2-4 points
  - Builds "Mindfulness" skill that enhances future meditation

* **Walking Meditation:**
  - Active meditation while walking slowly
  - Can be performed outdoors in safe areas
  - Combines physical activity with mindfulness
  - Reduces anxiety and depression while providing light exercise

* **Progressive Muscle Relaxation:**
  - Systematic tension and relaxation of muscle groups
  - Particularly effective for anxiety and insomnia
  - Unlocked through self-help books or therapy sessions
  - Can be performed lying down or sitting

**Creative Expression Therapy:**
* **Art Therapy Supplies:**
  - Colored pencils, crayons, sketchpad for artistic expression
  - Drawing/coloring provides emotional outlet and stress relief
  - Creates "Artwork" items that provide ongoing mood benefits
  - Particularly effective for trauma processing and emotional expression

* **Music Therapy Tools:**
  - Harmonica, guitar, or other portable instruments
  - Playing music reduces depression and provides emotional outlet
  - Can create "Compositions" that provide lasting benefits
  - Builds "Musical" skill that enhances therapeutic effects

* **Poetry Journal:**
  - Specialized journal for creative writing and poetry
  - Writing poetry provides alternative to traditional journaling
  - Particularly effective for emotional expression and processing
  - Can share poems with other players in multiplayer for social benefits

**Physical Self-Care Expanded:**
* **Personal Hygiene Kit:**
  - Comprehensive kit with soap, shampoo, toothbrush, etc.
  - Regular use provides ongoing mental health benefits
  - Creates "Well-Groomed" mood bonus
  - Builds healthy routines and self-respect

* **Exercise Equipment:**
  - Yoga mat, resistance bands, jump rope for physical activity
  - Regular exercise provides significant mental health benefits
  - Reduces depression, anxiety, and improves sleep quality
  - Can perform various exercise routines with different benefits

* **Healthy Cooking Supplies:**
  - Vitamins, healthy recipe books, cooking equipment
  - Proper nutrition supports mental health recovery
  - Cooking provides therapeutic activity and accomplishment
  - Sharing meals with others provides social benefits

**Social Support and Communication:**
* **Letter Writing Kit:**
  - Paper, pens, envelopes for correspondence
  - Writing letters to imaginary loved ones provides emotional outlet
  - Can create "Unsent Letters" for therapeutic processing
  - Builds hope and maintains connection to pre-apocalypse life

* **Group Therapy Circle (Multiplayer):**
  - Designated areas where players can hold group sessions
  - Structured sharing and support activities
  - Significant mental health benefits for all participants
  - Requires trust and safety among group members

* **Peer Support Network:**
  - System for players to become "Mental Health Allies"
  - Training through books enables players to provide better support
  - Enhanced benefits when helping other players with mental health
  - Creates supportive community within multiplayer servers

**Professional Therapy Simulation:**
* **Self-Therapy Workbooks:**
  - Comprehensive workbooks simulating professional therapy techniques
  - Dialectical Behavior Therapy (DBT) skills workbook
  - Acceptance and Commitment Therapy (ACT) exercises
  - Exposure and Response Prevention (ERP) for OCD

* **Therapy Session Recordings:**
  - Cassette tapes or CDs with guided therapy sessions
  - Professional-quality sessions for various conditions
  - Can be listened to with appropriate audio equipment
  - Provides structured therapeutic content

* **Mental Health Assessment Tools:**
  - Self-assessment questionnaires for tracking progress
  - PHQ-9 for depression, GAD-7 for anxiety, PCL-5 for PTSD
  - Provides objective measurement of mental health status
  - Helps players understand their character's conditions

**Crisis Management Resources:**
* **Crisis Intervention Kit:**
  - Collection of immediate coping tools for severe episodes
  - Ice pack for grounding, essential oils for aromatherapy
  - Crisis hotline information cards (fictional)
  - Emergency coping skill cards for quick reference

* **Safety Planning Workbook:**
  - Structured approach to managing suicidal ideation or self-harm
  - Identifies warning signs, coping strategies, and support contacts
  - Creates personalized safety plan for crisis situations
  - Includes environmental safety modifications

* **Grounding Technique Cards:**
  - Quick reference cards for various grounding exercises
  - 5-4-3-2-1 sensory grounding, body awareness techniques
  - Breathing exercises and visualization scripts
  - Can be used for immediate anxiety and panic relief

**Technology-Based Coping (Powered Devices):**
* **Mental Health Apps (on tablets/phones):**
  - Meditation apps with guided sessions
  - Mood tracking applications
  - Cognitive behavioral therapy exercises
  - Requires battery/power but provides convenient access

* **Binaural Beats Audio:**
  - Specialized audio recordings for relaxation and focus
  - Different frequencies for anxiety relief, sleep improvement
  - Requires headphones for maximum effectiveness
  - Can be used during other activities for passive benefits

* **Virtual Reality Relaxation (rare item):**
  - VR headset with calming environments and experiences
  - Provides immersive relaxation and escape from stressful reality
  - Significant mental health benefits but requires power
  - Represents high-tech coping mechanism

**Environmental Therapy:**
* **Garden Therapy Supplies:**
  - Seeds, tools, and containers for therapeutic gardening
  - Growing plants provides purpose, routine, and connection to life
  - Harvesting food provides sense of accomplishment
  - Being in nature reduces stress and improves mood

* **Pet Therapy (planned):**
  - Companion animals providing emotional support
  - Cats, dogs, or small animals requiring care
  - Daily care routines provide structure and purpose
  - Unconditional companionship reduces loneliness

* **Sacred Space Creation:**
  - Items for creating personal meditation/reflection spaces
  - Cushions, candles, incense, meaningful objects
  - Designated areas provide psychological safety
  - Can be shared with trusted individuals

**Substance-Based Coping (with caution):**
* **Herbal Remedies:**
  - Chamomile tea for anxiety and sleep
  - St. John's Wort for mild depression (with side effects)
  - Lavender for relaxation and stress relief
  - Natural alternatives with mild benefits and minimal side effects

* **Essential Oils:**
  - Aromatherapy oils for various mental health benefits
  - Requires diffuser or direct application methods
  - Lavender for anxiety, peppermint for focus, bergamot for depression
  - Can enhance other coping activities

* **Nutritional Supplements:**
  - Omega-3 fatty acids for brain health
  - Vitamin D for seasonal depression
  - Magnesium for anxiety and sleep
  - B-complex vitamins for stress and energy

**Community and Social Coping:**
* **Support Group Materials:**
  - Meeting guides, discussion topics, group activities
  - Enables players to facilitate mental health support groups
  - Provides structure for peer support in multiplayer
  - Includes confidentiality agreements and group rules

* **Mental Health Education Materials:**
  - Pamphlets and brochures about various conditions
  - Helps players understand their characters' experiences
  - Reduces stigma and increases empathy
  - Can be shared with other players for education

* **Recovery Story Collections:**
  - Books containing first-person accounts of mental health recovery
  - Provides hope and inspiration during difficult times
  - Shows various paths to healing and resilience
  - Particularly powerful for players experiencing similar struggles

**Specialized Coping for Specific Conditions:**

**OCD-Specific Tools:**
* **Exposure and Response Prevention Workbook**
* **Contamination Anxiety Kit** (gloves, sanitizer, cleaning supplies)
* **Ritual Interruption Tools** (timers, distraction items)
* **Uncertainty Training Exercises**

**PTSD-Specific Tools:**
* **Trauma Timeline Workbook**
* **Trigger Identification Kit**
* **Grounding Stone** (tactile grounding object)
* **Safe Place Visualization Guide**

**Depression-Specific Tools:**
* **Activity Scheduling Planner**
* **Behavioral Activation Worksheet**
* **Pleasure and Mastery Activity Lists**
* **Energy Level Tracking Journal**

**Psychosis-Specific Tools:**
* **Reality Testing Workbook**
* **Hallucination Log**
* **Medication Compliance Tracker**
* **Crisis Contact Information**

**Bipolar-Specific Tools:**
* **Mood Tracking Chart:**
  - Visual daily mood tracking tool (1-10 scale)
  - Tracks sleep hours, medication compliance, triggers
  - Creates patterns visible to player for self-awareness
  - Essential for episode prediction and prevention

* **Sleep Hygiene Kit:**
  - Specialized tools for maintaining regular sleep schedule
  - Sleep mask, earplugs, caffeine-limiting reminders
  - Critical for bipolar stability and episode prevention
  - Unlocks "Sleep Schedule Maintenance" routine

* **Crisis Box for Mania:**
  - Emergency kit for manic episodes
  - Contains grounding tools, emergency contacts, reality checks
  - Includes financial safeguards and decision-limiting tools
  - Used when mania severity reaches dangerous levels

* **Light Therapy Lamp:**
  - Bright light device for seasonal mood regulation
  - Helps with seasonal patterns and circadian rhythm
  - Must be used correctly (timing and duration matter)
  - Can trigger mania if overused

---

### **Implementation Architecture:**

**Organized File Structure:**
```
MentalHealthMod/
├── mod.info                                    # Mod metadata
├── poster.png                                  # Mod thumbnail
├── media/
│   ├── lua/
│   │   ├── client/
│   │   │   └── ScottysMentalHealthExpansion/
│   │   │       ├── ISMentalHealthPanel.lua     # Main UI panel
│   │   │       ├── ISHealthPanelMod.lua        # Health panel integration
│   │   │       ├── MoodTrackingUI.lua          # Mood tracking interface
│   │   │       └── HallucinationEffects.lua    # Visual/audio effects
│   │   ├── shared/
│   │   │   └── ScottysMentalHealthExpansion/
│   │   │       ├── Classes/
│   │   │       │   ├── MentalHealthCondition.lua   # Base condition class
│   │   │       │   ├── Medication.lua              # Base medication class
│   │   │       │   └── TherapySession.lua          # Therapy session class
│   │   │       ├── Libraries/
│   │   │       │   ├── Json.lua                    # JSON handling library
│   │   │       │   └── EventManager.lua           # Event management library
│   │   │       ├── Config.lua                     # Shared configuration
│   │   │       ├── Utils.lua                      # Utility functions
│   │   │       ├── MentalHealthSystem.lua         # Core system logic
│   │   │       ├── BipolarSystem.lua              # Bipolar-specific systems
│   │   │       ├── HallucinationSystem.lua        # Hallucination management
│   │   │       ├── MedicationSystem.lua           # Medication effects
│   │   │       ├── CopingMechanisms.lua           # Therapy and coping tools
│   │   │       └── ProfessionalSkills.lua         # Mental health professions
│   │   └── server/
│   │       └── ScottysMentalHealthExpansion/
│   │           └── MultiplayerSync.lua            # Multiplayer synchronization
│   ├── scripts/
│   │   ├── items/
│   │   │   ├── MentalMedications.txt              # Psychiatric medications
│   │   │   ├── SelfHelpResources.txt              # Books and therapy tools
│   │   │   ├── ComfortItems.txt                   # Emotional support items
│   │   │   └── ProfessionalEquipment.txt          # Professional tools
│   │   ├── professions/
│   │   │   └── MentalHealthProfessions.txt        # Therapist, psychiatrist, etc.
│   │   └── traits/
│   │       └── MentalHealthTraits.txt             # Starting mental conditions
│   └── textures/
│       ├── ui/
│       │   ├── mental_health_icons/               # Condition severity icons
│       │   └── mood_tracking/                     # Mood chart graphics
│       └── items/
│           ├── medications/                       # Pill bottle icons
│           └── therapy_tools/                     # Journal, comfort item icons
```

**Core System Architecture:**
```lua
MentalHealthSystem = {
    -- Data structure stored in player:getModData()
    MentalHealth = {
        depression = 0,      -- 0-100 scale
        anxiety = 0,         -- 0-100 scale
        ptsd = 0,           -- 0-100 scale
        insomnia = 0,       -- 0-100 scale
        psychosis = 0,      -- 0-100 scale
        ocd = 0,           -- 0-100 scale
        
        medications = {     -- Active medication tracking
            serizon = {level = 0, lastTaken = 0},
            kaletraxin = {level = 0, lastTaken = 0},
            thresta = {level = 0, lastTaken = 0}
        },
        
        triggers = {},      -- Recent trigger history
        symptoms = {},      -- Active symptom tracking
        coping = {          -- Coping mechanism usage
            journalEntries = 0,
            comfortItems = 0,
            lastMeditation = 0
        }
    }
}
```

**Event-Driven Updates:**
* `Events.OnCreatePlayer` - Initialize mental health data
* `Events.OnPlayerUpdate` - Process ongoing mental health changes
* `Events.OnZombieDead` - PTSD triggers from violence
* `Events.OnPlayerDamaged` - Trauma response to injury
* `Events.OnPlayerSleep` - Sleep quality assessment
* `Events.OnPlayerWakeUp` - Insomnia and nightmare effects

---

### **Balancing and Gameplay Integration:**

**Progression Curves:**
* **Early Game:** Mental health starts stable, gradual decline as trauma accumulates
* **Mid Game:** Conditions become more pronounced, coping mechanisms become essential
* **Late Game:** Experienced survivors develop resilience, but face unique challenges

**Difficulty Scaling:**
* **Sandbox Options:** Planned sliders for trigger sensitivity and recovery rates
* **Realistic Mode:** Slower recovery, more persistent symptoms
* **Arcade Mode:** Faster recovery, less severe impacts on gameplay

**Integration with Existing Mechanics:**
* **Traits:** Mental health affects and is affected by existing traits
* **Moodles:** Mental health conditions appear as persistent moodles
* **Skills:** Planned integration with skill learning and XP gain
* **Social:** Multiplayer interactions provide mental health benefits

---

### **Technical Considerations:**

**Performance Optimization:**
* Update cycles limited to prevent performance impact
* Efficient data structures for mental health tracking
* Minimal UI refresh rates for better performance
* Optional debug mode for development testing

**Compatibility:**
* **Multiplayer Safe:** All systems designed for server compatibility
* **Save Persistence:** Mental health data preserved across sessions
* **Mod Compatibility:** Minimal conflicts with other gameplay mods
* **Version Updates:** Backward compatibility for save files

**Error Handling:**
* Graceful degradation if mod data is corrupted
* Initialization checks for new installations
* Fallback systems for missing components
* Comprehensive logging for debugging

---

### **Future Development Roadmap:**

**Version 1.1 - Enhanced Realism:**
* Visual hallucination system with false sprites
* Trait-based starting mental health conditions
* Advanced sleep system integration
* Expanded medication library

**Version 1.2 - Social Integration:**
* NPC mod compatibility for social support
* Group therapy mechanics for multiplayer
* Professional consultation system
* Relationship-based mental health modifiers

**Version 1.3 - Comprehensive Expansion:**
* Addiction and dependency systems
* Personality disorder simulations
* Advanced cognitive therapy mechanics
* Mental health professional career path

**Long-term Goals:**
* Integration with major overhaul mods
* Educational partnership with mental health organizations
* Research collaboration for improved realism
* Community-driven content expansion

---

### **Research and Inspiration:**

**Mental Health Resources Consulted:**
* DSM-5 diagnostic criteria for authenticity
* Mental Health First Aid training materials
* Cognitive Behavioral Therapy principles
* Trauma-informed care guidelines
* Pharmaceutical reference materials

**Game Design Inspirations:**
* This War of Mine - civilian trauma simulation
* PTSD Simulator - educational mental health game
* Depression Quest - interactive depression experience
* Actual Sunlight - mental health narrative game

**Community Feedback Integration:**
* Mental health professional consultation
* Player experience testing and feedback
* Accessibility considerations for affected players
* Cultural sensitivity in implementation

---

### **Installation and Usage:**

**System Requirements:**
* Project Zomboid Build 41.78.16 or newer
* 10MB additional storage space
* No additional dependencies required

**Installation Steps:**
1. Download mod from GitHub releases or Steam Workshop
2. Extract to `C:\Users\[User]\Zomboid\mods\` directory
3. Launch Project Zomboid
4. Navigate to Mods menu and enable "Mental Health Expansion"
5. Start new game or load existing save

**First-Time Setup:**
* Mental health system initializes automatically on character creation
* All conditions start at 0% severity for new characters
* Tutorial notifications guide players through new mechanics
* Optional debug mode available for testing and demonstration

**Usage Guidelines:**
* Monitor Mental Health tab in Health panel regularly
* Use coping mechanisms proactively, not just reactively
* Understand that mental health is a long-term management challenge
* Seek in-game medications and support when conditions become severe

---

### **Community and Support:**

**Player Resources:**
* In-game help system with mental health information
* Community Discord server for support and discussion
* GitHub wiki with detailed mechanic explanations
* Video tutorials for optimal mental health management

**Mental Health Awareness:**
* Links to real-world mental health resources
* Disclaimer about entertainment vs. medical advice
* Sensitivity warnings for potentially triggering content
* Educational content about mental health stigma reduction

**Feedback and Contribution:**
* GitHub issue tracker for bug reports and feature requests
* Community polls for future development priorities
* Open-source contribution opportunities
* Mental health professional consultation program

---

### **Credits and Acknowledgments:**

**Development Team:**
* Primary Developer: Scott
* Mental Health Consultant: [To be added]
* Beta Testing Community: [Contributors to be listed]

**Special Thanks:**
* The Indie Stone for Project Zomboid modding support
* Mental Health First Aid organization for educational resources
* Project Zomboid modding community for tutorials and guidance
* Mental health advocacy organizations for awareness materials

**Disclaimer:**
This mod is designed for educational and entertainment purposes only. It should not be considered a substitute for professional mental health advice, diagnosis, or treatment. If you are experiencing mental health challenges, please consult with qualified mental health professionals.

---

**Last Updated:** [Date]  
**Document Version:** 2.0  
**Mod Version:** 1.0.0

---

### **Disorder-Specific Future Expansion Ideas:**

### **Depression Expansion Ideas:**

**Seasonal Affective Disorder (SAD) Variant:**
* Light-sensitive depression that worsens during winter months
* Improved symptoms with light therapy and bright environments
* Weather-dependent mood fluctuations
* Vitamin D deficiency simulation affecting mood

**Anhedonia Simulation:**
* Inability to feel pleasure from normally enjoyable activities
* Diminished rewards from positive activities (reading, music, etc.)
* Gradual loss of interest in hobbies and survival tasks
* Recovery of pleasure response with treatment

**Psychomotor Symptoms:**
* Visible movement slowdown during severe episodes
* Difficulty initiating actions (delayed response to player input)
* Physical fatigue affecting all activities
* Restoration of normal movement with recovery

**Social Withdrawal Mechanics:**
* Reduced benefits from multiplayer interactions
* Difficulty maintaining friendships/alliances
* Isolation reinforcing depressive symptoms
* Social reintegration as part of recovery process

---

### **Anxiety Expansion Ideas:**

**Specific Phobia Development:**
* Agoraphobia: Fear of open spaces and crowds
* Claustrophobia: Panic in enclosed spaces
* Blood phobia: Severe reactions to gore and injury
* Dynamic phobia development based on traumatic experiences

**Social Anxiety Disorder:**
* Intense fear of judgment in multiplayer interactions
* Difficulty communicating with other players
* Physical symptoms (blushing, sweating, trembling)
* Avoidance of group activities and social situations

**Panic Disorder with Agoraphobia:**
* Avoidance of places where escape might be difficult
* Fear of having panic attacks in public spaces
* Gradual shrinking of "safe zones"
* Exposure therapy mechanics for recovery

**Generalized Worry Mechanics:**
* Constant background anxiety about future events
* Catastrophic thinking patterns
* Difficulty concentrating on tasks
* Physical tension and restlessness

---

### **PTSD Expansion Ideas:**
