-- [VPR] Burn Past Kill Time
-- displayPath: VPR Optimization
-- mechanicTime: 155.9
-- timelineIndex: 23
-- timerEndOffset: 600
-- loop: True
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] Burn Past Kill Time
local s = TensorZelVPR
if s and s.kill and not TensorZelVPRBurn then
  local t = TensorCore.API.TensorACR.getAutoSimTime()
  if t and t > s.kill then ACR_TensorViper4_Burn = true; TensorZelVPRBurn = true; self.used = true end
end
