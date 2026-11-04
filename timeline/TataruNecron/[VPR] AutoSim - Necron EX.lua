-- [VPR] AutoSim - Necron EX
-- eventType: 16
-- displayPath: VPR Optimization
-- mechanicTime: 8
-- timelineIndex: 1
-- timerStartOffset: -60
-- timerEndOffset: -5
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] AutoSim - Necron EX
local api = TensorCore.API.TensorACR
-- Wipe phases from any other AutoSim setup first
pcall(api.clearAutoSimPhases, "FullDowntime")
pcall(api.clearAutoSimPhases, "MeleeDowntime")
pcall(api.clearAutoSimUncertainty)
api.setAutoSimKillTime(480)
-- New pull: make sure Burn starts off
ACR_TensorViper4_Burn = false
TensorNecronVPRBurn = nil
-- Darkness of Eternity (median hit 243.2s): no target from +6 to +21.3,
-- something hittable for ~8s, then no target until Necron returns (~+60.6)
TensorNecronVPR = {
  kill = 480,
  g1 = api.addAutoSimPhase("FullDowntime", 249.2, 264.5),
  g2s = 272.7,
  g2 = api.addAutoSimPhase("FullDowntime", 272.7, 303.9),
  -- Mass Macabre (median cast 439.9): M1 2-person tower west is out of melee
  mm = api.addAutoSimPhase("MeleeDowntime", 442.4, 450.4),
}
api.addAutoSimUncertainty(200, 5)
self.used = true
