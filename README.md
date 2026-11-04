# TensorReactions AutoSim reactions

My own TensorReactions reactions that drive TensorACR's AutoSim: kill times, full/melee/caster downtime windows, timing uncertainty, the syncs that move those windows to the real boss casts, and the Burn on/off helpers that go with them. It also has my Zelenia EX role draws.

Store modules and other authors' profiles are not included.

> **Disclaimer:** these draws use Anyone's Party Roster function (AnyoneCore), so AnyoneCore with a filled-in Party Roster is needed for them to work.

## Files

Each file is one profile in TensorReactions' own save format, holding only these reactions and their folders.

| File | Fight / timeline | Contents |
|---|---|---|
| `timeline/Tataru-Zelen.lua` | Zelenia EX | AutoSim for Viper and Black Mage (12 reactions) and role draws for any job (90 reactions) |
| `timeline/TataruNecron.lua` | Necron EX | AutoSim for Viper and Black Mage (10 reactions) |
| `general/blm.lua` | Any fight | Black Mage countdown / pre-pull helpers (3 reactions) |

`tools/export_autosim.py` is the script that builds these files from the live profiles.

## Using the reactions

Copy a timeline file into `TensorReactions/TimelineReactions` (or the general file into `TensorReactions/GeneralReactions`) and select it as the profile for that fight or job. To add the reactions to a profile you already have, merge the entries into that profile file instead. Close the game or reload TensorReactions first, and keep a backup of the profile.
