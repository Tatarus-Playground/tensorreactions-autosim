-- [AutoSim BLM] Target at 5s, start at 0
-- eventType: 16
-- displayPath: AutoSim
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=BLM
-- condition: category=Event, comparator=2, eventCountdownTime=5, name=Countdown <=5s

-- [action] Hold Fire III and Swiftcast until zero
data.blm_autosim_prepull = data.blm_autosim_prepull or {}
local state = data.blm_autosim_prepull
state.endsAt = Now() + eventArgs.time * 1000
state.resolved = false
TensorCore.API.TensorACR.holdActionUntil(152, state.endsAt)
TensorCore.API.TensorACR.holdActionUntil(7561, state.endsAt)
self.used = true

-- [action] aType=Misc, name=Target boss at 5s, setTarget=True, targetType=Enemy
