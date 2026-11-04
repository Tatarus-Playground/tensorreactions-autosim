-- [VPR] Burn Past Kill Time
-- displayPath: VPR Optimization
-- mechanicTime: 321
-- timelineIndex: 56
-- timerEndOffset: 360
-- loop: True
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] Burn Past Kill Time
local s = TensorNecronVPR
if s and s.kill and not TensorNecronVPRBurn then
  local t = TensorCore.API.TensorACR.getAutoSimTime()
  if t and t > s.kill then ACR_TensorViper4_Burn = true; TensorNecronVPRBurn = true; self.used = true end
end
