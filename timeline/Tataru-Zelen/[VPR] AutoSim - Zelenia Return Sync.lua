-- [VPR] AutoSim - Zelenia Return Sync
-- eventType: 3
-- displayPath: VPR Optimization
-- mechanicTime: 155.9
-- timelineIndex: 23
-- timerStartOffset: -45
-- timerEndOffset: 15
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] AutoSim - Zelenia Return Sync
-- Zelenia back from the add phase (Perfumed Quietus cast start): re-time kill + Thorns window
local e = eventArgs
if not (e and e.spellID == 43191) then return end
local s = TensorZelVPR
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if s and t and t > 110 and not s.ret then
  s.ret = t
  -- fast adds (~136 return) kill ~390, slow adds (~148 return) kill ~418
  if t < 142 then s.kill = 390 + (t - 136.3) else s.kill = 418 + (t - 148.3) end
  pcall(api.setAutoSimKillTime, s.kill)
  pcall(api.addAutoSimUncertainty, t, 3)
  if s.bn then local ok, id = pcall(api.setAutoSimPhase, s.bn, t + 230.0, t + 235.0); if ok then s.bn = id end end
  self.used = true
end
