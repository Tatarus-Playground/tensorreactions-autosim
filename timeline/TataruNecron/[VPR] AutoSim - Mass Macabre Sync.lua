-- [VPR] AutoSim - Mass Macabre Sync
-- eventType: 2
-- displayPath: VPR Optimization
-- mechanicTime: 447.1
-- timelineIndex: 80
-- timerStartOffset: -15
-- timerEndOffset: 8
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] Mass Macabre sync
-- Mass Macabre cast finished: M1 leaves melee for the west 2-person tower
local e = eventArgs
if not (e and e.spellID == 44595) then return end
local s = TensorNecronVPR
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if not (s and t and t > 300) or s.mmDone then return end
s.mmDone = true
if s.mm then
  local ok, id = pcall(api.setAutoSimPhase, s.mm, t + 2.5, t + 10.5); if ok then s.mm = id end
else
  local ok, id = pcall(api.addAutoSimPhase, "MeleeDowntime", t + 2.5, t + 10.5); if ok then s.mm = id end
end
self.used = true
