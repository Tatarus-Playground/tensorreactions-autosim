-- [AutoSim BLM] Clear Fire III hold on countdown cancel
-- eventType: 17
-- displayPath: AutoSim
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=BLM

-- [action] Clear Fire III and Swiftcast holds
TensorCore.API.TensorACR.holdActionUntil(152, Now())
data.blm_autosim_prepull = nil
TensorCore.API.TensorACR.holdActionUntil(7561, Now())
self.used = true
