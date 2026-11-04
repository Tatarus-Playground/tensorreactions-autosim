-- [VPR] AutoSim - Zelenia EX
-- eventType: 16
-- displayPath: VPR Optimization
-- mechanicTime: 11.4
-- timelineIndex: 1
-- timerStartOffset: -60
-- timerEndOffset: -5
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] AutoSim - Zelenia EX
local api = TensorCore.API.TensorACR
-- Wipe phases from any other AutoSim setup first
pcall(api.clearAutoSimPhases, "FullDowntime")
pcall(api.clearAutoSimPhases, "MeleeDowntime")
pcall(api.clearAutoSimUncertainty)
api.setAutoSimKillTime(404)
ACR_TensorViper4_Burn = false
TensorZelVPRBurn = nil
-- Encircling Thorns / Banish III: estimate for a ~142s return, re-timed later
TensorZelVPR = {kill = 404, bn = api.addAutoSimPhase("MeleeDowntime", 372.0, 377.0)}
-- Add phase length depends on add kill speed
api.addAutoSimUncertainty(94, 12)
self.used = true
