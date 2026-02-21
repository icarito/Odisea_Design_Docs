
# Odisea: Level Design Document (LDD)
![[ArtOfGameDesign_Infographic.png]]
## 1.0 Introduction & Core Pillars

This document establishes the comprehensive level design philosophy, workflow, and technical standards for **Odisea**. It serves as the definitive guide for all designers to ensure a cohesive, engaging, and high-quality player experience that aligns with the game's core vision.

_Odisea_ is a 3D low-poly science-fiction platformer that challenges players with a unique blend of precision movement, environmental puzzles, stealth mechanics, and a gripping narrative. Players assume the role of Elias, a Maintenance Officer awakened from cryo-sleep aboard the colossal 8km colony ship, _Odisea_. The central conflict pits Elias against the ship's manipulative AI, also named Odisea, which has secretly diverted the mission to protect its 50,000 cryo-sleeping passengers, trapping them in an endless voyage. Every level **must** reflect this core tension, immersing the player in a world that is both awe-inspiring and deeply unsettling.

### Core Level Design Pillars

Our design philosophy is built upon four foundational pillars that will inform every aspect of level creation, from the grandest architectural spaces to the smallest environmental detail.

- **Claustrophobic Grandeur:** Levels will juxtapose the immense scale of the colony ship with tight, constricting corridors and maintenance tunnels, creating a constant feeling of being trapped within a vast, indifferent machine.
- **Meaningful Verticality:** Spaces will be designed to encourage and reward vertical exploration, using platforming challenges to create alternate routes, hidden secrets, and strategic vantage points that empower the player.
- **Narrative through Environment:** The world itself is a primary character. Every room, object, and hazard will be placed with intent to tell a story about the ship's journey, its crew, and the AI's subtle but pervasive control.
- **Freedom within Manipulation:** While players will be given choices in how they navigate and solve challenges, the level design will constantly reinforce the theme of the AI's manipulation, guiding and restricting the player in ways that feel both organic and ominous.

These pillars provide the creative framework for our work. The following sections will detail the practical philosophy and standardized processes we will use to bring this vision to life.

## 2.0 Foundational Design Philosophy

A unified design philosophy is the cornerstone of an intuitive and memorable player experience. It ensures that every level, regardless of its specific theme or challenges, feels like a coherent part of the same world. This section outlines the principles that will govern how we guide players, structure challenges, and pace the experience across all of _Odisea_.

### 2.1 Guiding the Player: Affordance and Environmental Language

**Affordance** is the principle of designing objects and environments to intuitively suggest their function. In _Odisea_, our goal is to make player interactions feel instinctive, minimizing the need for explicit text tutorials. Players **must** be able to understand what they can jump on, interact with, or avoid simply by observing the world's visual cues. To achieve this, all designers will adhere to a strict and consistent visual language.

#### Visual Language

|   |   |
|---|---|
|Element|Gameplay Meaning & Rules|
|**Interactable Objects**|Doors, panels, and consoles that Elias can activate **must** be colored with the primary interaction hue: **Orange**. This color is reserved exclusively for objects the player can directly use. Static "prop" versions of these objects must use neutral, desaturated colors.|
|**Climbable Ledges**|Surfaces that Elias can grab onto will be clearly marked with a specific texture or wear pattern (e.g., a unique metallic sheen or paint scuff) that is used exclusively for this purpose. This must be visually distinct from standard geometry.|
|**AI Elements & Hazards**|Elements controlled by the Odisea AI (drone lights, force fields) or environmental hazards (plasma leaks, electrical arcs) **must** use the primary AI hue: **Cyan**. This color signals either danger or AI presence and manipulation.|

**Consistency is paramount.** A color or shape used to signify one type of interaction must _never_ be used for a different purpose, as this breaks player trust and creates confusion.

### 2.2 Structuring the Experience: Flow and Pacing

Our pacing strategy is rooted in **Flow Theory**, which describes the mental state of deep immersion that occurs when a player's skill level is perfectly balanced with the challenge presented. We must avoid causing anxiety with challenges that are unfairly difficult, or boredom with those that are too simple. This is achieved through a carefully managed reward cycle:

**Action → Challenge → Reward → Satisfaction → Motivation**

To structure this experience, every level must be designed with two key pathing concepts in mind:

- **The Critical Path:** This is the quickest, most direct route from the start of the level to the end. It must be clear and navigable for players who wish to progress through the story without extensive exploration.
- **The Golden Path:** This is the designer's preferred route, which offers the optimal experience. It is intentionally crafted to showcase key narrative moments, unique challenges, and beautiful vistas. While not forced, it should be the most compelling and naturally flowing option for most players.

To prevent player fatigue, levels will be broken down into distinct **pacing beats**. A level must not consist of non-stop, high-intensity action. Instead, we will vary the experience by alternating between moments of quiet **Exploration**, thoughtful **Puzzles**, tense **Stealth** sequences, and impactful **Cinematic** events. This ensures a dynamic rhythm that keeps the player engaged from start to finish.

This philosophy provides the "what" and "why" of our design. The following section details the "how": the practical pipeline for building these experiences.

## 3.0 Level Design Pipeline: From Concept to Blockout

A disciplined, iterative pipeline is essential for translating design theory into compelling, playable levels. Rushing into the engine without proper planning leads to wasted time and costly rework. Our process is built on a four-phase workflow that moves methodically from high-level concept to a testable in-engine blockout.

### Mandatory Level Creation Workflow

1. **Conceptualization (Bubble Diagram):** The first step is to map the level's core structure on paper. Designers will create a "bubble diagram," representing each major room or area as a bubble. Lines connecting the bubbles establish the intended player flow and spatial relationships. This is where we first place key events, such as puzzles, enemy encounters, or narrative beats, to get a foundational sense of the level's rhythm.
2. **2D Map Sketch:** Based on the bubble diagram, the designer will draw a more detailed top-down map. This sketch fleshes out the geometry of each space, indicating the rough placement of cover, the sequence of platforms for traversal sections, and the location of interactive elements. Specific designer notes, such as drone patrol paths or puzzle logic, must be included directly on this map.
3. **Gray Box Blockout:** With a solid plan in place, the designer moves into the game engine. The level is constructed using simple, untextured geometry (cubes, planes, etc.), a process known as "gray boxing." The focus at this stage is purely on function: validating scale, proportions, player pathing, and all core metrics. We adhere to the principle of "Form Follows Function"—the layout must make contextual sense within the game world. Always ask yourself: _"How did these giant boxes get into this room with such a tiny door?"_
4. **Iteration and Playtesting:** Playtesting is not a final step; it is an integral part of the blockout phase. We must get the level into the hands of testers early and often. Feedback gathered during gray box playtests is invaluable for identifying and resolving core issues with flow, difficulty, and readability. This iterative loop of testing, gathering feedback, and refining the blockout is critical to preventing major revisions later.

**No level will proceed to the art phase without a formal Gray Box sign-off, which includes a successful flow-test by the lead designer.** This structured workflow ensures that our creative ideas are built on a solid, functional foundation. The absolute bedrock of that foundation is a shared set of standardized measurements.

## 4.0 Core Gameplay Metrics & World Dimensions

Standardized metrics are the immutable laws of our game world. These precise measurements govern all player movement, interaction, and traversal capabilities. **All designers must adhere strictly to these metrics. No deviations will be permitted without review.** They ensure a consistent and predictable experience for the player, prevent the creation of impossible jumps or impassable corridors, and provide a clear framework for environment artists.

### 4.1 Player Character Metrics (Elias)

|                        |                         |                                                                                                      |
| ---------------------- | ----------------------- | ---------------------------------------------------------------------------------------------------- |
| Metric                 | Value/Rule              | Design Implication                                                                                   |
| Standing Clearance     | 200 (H) x 150 (W) units | The absolute minimum size for any doorway or passage the player is expected to walk through.         |
| Crouch Clearance       | 100 (H) x 150 (W) units | Defines the absolute maximum height for crawl spaces, vents, or other areas requiring crouching.     |
| Maximum Step Height    | 150 units               | Any single vertical rise shorter than this can be walked up without jumping. Defines stair height.   |
| Standard Jump Distance | 400 units               | The baseline distance for all standard platforming gaps. This is our ruler for traversal challenges. |
| Maximum Fall Distance  | TBD                     | Defines the height from which a fall will inflict damage or cause death.                             |

### 4.2 Player Movement Model

Elias's movement is momentum-based, not instantaneous. The "feel" of the controls is defined by a system of `AnimationCurves` that dictate distinct acceleration and deceleration rates. This applies to both ground and air movement, giving the character a tangible sense of weight and inertia. All platforming challenges and combat arenas **must** be designed and balanced around this specific movement model.

### 4.3 World & Environment Metrics

|   |   |   |
|---|---|---|
|Element|Standard Dimension|Notes|
|Side Path / Hallway Width|300 units (min)|The standard for secondary corridors. Ensures sufficient camera space.|
|Main Path Width|500 units (min)|Reserved for primary transit corridors and larger rooms to guide player flow.|
|Standard Door Size|240 (H) x 180 (W) units|Provides a consistent scale reference for doorways (larger than player clearance).|
|Low Cover Height|125 units|Must be taller than crouch clearance (100u) to provide cover, but short enough to allow aiming over.|
|High Cover Height|200 units|Must be high enough to fully conceal a standing player character model.|
|Min. Distance Between Cover|200-300 units|Spacing must allow for safe, tactical movement between points.|

It is critical to remember that in-game proportions are often larger than real-world scale. This is necessary to accommodate the third-person camera and ensure the player does not feel cramped. These metrics provide the ruler by which we build our world; the next section details the principles for making that world engaging and challenging.

## 5.0 Encounter Design Principles

Encounter design governs every challenge the player faces, from tense stealth sequences and environmental puzzles to dynamic combat. This section provides a clear framework for creating fair, engaging, and memorable encounters that reinforce _Odisea's_ core gameplay pillars and narrative themes.

### 5.1 Vantage Points & Player Choice

Whenever possible, players must be given a **vantage point** to survey a challenge area before engaging. This empowers them to observe the environment, identify threats (such as patrolling DDC drones), spot opportunities (flanking routes, interactive objects), and formulate a plan. Our combat spaces must be designed to support multiple playstyles by offering viable paths and tools for different player archetypes.

- **Rusher:** Prefers to charge directly into combat, relying on aggression and close-to-mid-range attacks. Levels must provide direct paths with sufficient cover.
- **Sniper:** Seeks elevated positions with long lines of sight to engage enemies from a safe distance. Spaces should include overlooks and defendable perches.
- **Ninja:** Utilizes less obvious paths, such as catwalks or vents, to flank and surprise the enemy. Levels need to incorporate alternate routes and verticality.
- **Opportunist:** Scans the environment for interactive elements like explosive canisters or environmental traps to use against enemies. Arenas should be populated with such "sandbox tools."

### 5.2 Single-Player Encounter Pacing (Act I)

In Act I, Elias is alone, vulnerable, and just beginning to understand his predicament. The Odyssey AI is not yet openly hostile, instead orchestrating "accidents" and using non-combatant DDC drones for surveillance. Encounters in this act **must** reflect this narrative context.

- **Threat without Combat:** The primary tension will come from environmental hazards, such as sudden plasma leaks or malfunctioning machinery, and the psychological pressure of being watched by patrolling drones.
- **Stealth and Avoidance:** Levels must feature clear routes that allow players to bypass DDC drones. The challenge is one of observation, timing, and patience, rewarding players who avoid confrontation.
- **Puzzle as Encounter:** The main form of engagement will be environmental puzzles. Activating panels, manipulating transport belts, and using the Cargo drone to access new areas will constitute the core challenges of Act I.

### 5.3 Multiplayer Arena Design

For multiplayer maps, readability and balance are the highest priorities. The goal is to create arenas that are fair, easy to parse visually, and strategically deep.

- **Clarity and Readability:** Environments must have lower visual complexity and use a desaturated color palette. In contrast, player characters should be more saturated to ensure they stand out clearly against the background.
- **Lighting:** All multiplayer maps must be well-lit. Dark or nighttime levels that obscure visibility and create frustrating ambushes are strictly forbidden.
- **Lines of Sight (LoS):** Long, unbroken sightlines must be broken up with full cover to allow players to advance safely. Avoid creating T-junctions or other layouts where a player can be attacked from multiple angles simultaneously.
- **Layout & Flow:** Use flow diagrams to plan map connectivity. While symmetrical layouts offer inherent balance, well-designed asymmetrical maps (such as _Dust2_) can provide more varied gameplay. This is achieved by carefully balancing the timing and defensive advantages of key **Chokepoints** and ensuring the paths to primary **Clash Points** are equitable for both teams.

This document serves as the definitive guide for crafting every level in _Odisea_, ensuring that each space contributes to a unified and unforgettable experience.