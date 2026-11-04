-- [AutoSim BLM] Prepull Swiftcast check at 6s
-- displayPath: AutoSim
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=BLM
-- condition: category=Lua, dequeueIfLuaFalse=True, name=Countdown reaches 6s
-- condition lua:
--   local state = data.blm_autosim_prepull
--   return state ~= nil and state.endsAt ~= nil and not state.resolved and Now() >= state.endsAt - 6000
-- condition: actionCDValue=0.01, actionID=7561, category=Self, conditionType=4, name=Swiftcast used
-- condition: actionID=7561, category=Self, comparator=2, conditionType=4, name=Swiftcast ready

-- [action] Keep Fire III held to zero
local state = data.blm_autosim_prepull
state.resolved = true
self.used = true

-- [action] Release Fire III to land at zero
local state = data.blm_autosim_prepull
TensorCore.API.TensorACR.holdActionUntil(152, state.endsAt - 3286)
state.resolved = true
self.used = true
