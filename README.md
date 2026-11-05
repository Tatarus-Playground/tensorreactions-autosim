# TensorReactions AutoSim reactions

My own TensorReactions reactions that drive TensorACR's AutoSim: kill times, full/melee/caster downtime windows, timing uncertainty, the syncs that move those windows to the real boss casts, and the Burn on/off helpers that go with them. It also has my role draws for Zelenia EX and Necron EX, and an Arkveld EX helper.

Store modules and other authors' profiles are not included.

> **Disclaimer:** these draws use Anyone's Party Roster function (AnyoneCore), so AnyoneCore with a filled-in Party Roster is needed for them to work.

## Files

Each timeline file is a full copy of my live profile in TensorReactions' own save format. It only references store reactions and profiles (to switch some reactions off, or to inherit a store profile) and does not contain their code.

| File | Fight / timeline | Contents |
|---|---|---|
| `timeline/Tataru-Zelen.lua` | Zelenia EX | AutoSim for Viper and Black Mage (10 reactions) and role draws for any job (98 reactions) |
| `timeline/TataruNecron.lua` | Necron EX | AutoSim for Viper and Black Mage (9 reactions) and role draws for any job (32 reactions) |
| `timeline/Arkveld.lua` | Guardian Arkveld EX | Arkveld helper for any job (92 reactions): limit cut arrows, tower picker and puddle countdown, role-based safety arrows |
| `general/blm.lua` | Any fight | Black Mage countdown / pre-pull helpers (3 reactions) |

`general/blm.lua` is built from the live profile by `tools/export_autosim.py`.

## Using the reactions

Copy a timeline file into `TensorReactions/TimelineReactions` (or the general file into `TensorReactions/GeneralReactions`) and select it as the profile for that fight or job. To add the reactions to a profile you already have, merge the entries into that profile file instead. Close the game or reload TensorReactions first, and keep a backup of the profile.

## Changelog

### 2026-11-06

- **Necron EX (`TataruNecron.lua`):** new Memento Mori spread markers for Smite of Gloom. You get an arrow and circle to your own role slot's spot: tanks on the dark side, everyone else on the light side. The side is read from the Memento Mori cast, so the markers flip when the dark side is east.

### 2026-11-05

- **Zelenia EX (`Tataru-Zelen.lua`):**
  - Reworked Bloom draws. Bloom 1-6 now draw per-Bloom arrows, and the replaced draws are kept as disabled "(old)" copies.
  - New draws for the Bloom 5 in/out callout and the Bloom 6 first and second cleaves.
  - A text filter that only shows SWAP, STAND STILL and GO while the timeline runs.
  - Viper Feint and Black Mage Addle / Manaward for Stock Break and Thorned Catharsis.
  - A melee gap closer after the EF2 donut drop.
- **Necron EX (`TataruNecron.lua`):**
  - Role draws for Grand Cross 1 and 2 (routes, intercards, stack middle), Fear of Death spread spots, and Mass Macabre numbered towers with tower state.
  - Blight / Season stack tethers and alerts, and End's Embrace 2 spread and hand bait.
  - Viper Feint for Grand Cross, Fear of Death, Darkness of Eternity and Twofold/Fourfold Blight.
- **Guardian Arkveld EX (`Arkveld.lua`, new):**
  - First version of the Arkveld helper: limit cut arrows, a tower picker window with puddle countdown, and role-based safety arrows. The arrows cover Chainblade, Siegeflight / Wrathful Rattle stacks, Rush, Ouroblade, tail / charge, lasers and Exa.
  - Each reaction sits on its own mechanic's timeline entry.
  - Not tested in a live pull yet.
