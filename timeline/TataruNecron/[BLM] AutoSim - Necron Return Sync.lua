-- [BLM] AutoSim - Necron Return Sync
-- eventType: 26
-- displayPath: BLM Optimization
-- mechanicTime: 250.8
-- timelineIndex: 50
-- timerStartOffset: 20
-- timerEndOffset: 75
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Necron Return Sync
-- Necron targetable again after the intermission: end downtime, re-time kill (same as Viper)
local e = eventArgs
if not (e and e.isTargetable) then return end
local ent = TensorCore.mGetEntity(e.entityID)
if not (ent and ent.name == "Necron") then return end
local s = TensorNecronBLM
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if s and t and t > 260 and not s.ret then
  s.ret = t
  if s.g2 and s.g2s and t > s.g2s + 1 then
    local ok, id = pcall(api.setAutoSimPhase, s.g2, s.g2s, t); if ok then s.g2 = id end
  end
  s.kill = 480 + (t - 303.9)
  pcall(api.setAutoSimKillTime, s.kill)
  pcall(api.addAutoSimUncertainty, t, 3)
  -- move the later caster downtime forecasts by the same amount (the cast syncs fine-tune them)
  local d = t - 303.9
  if s.ee2 then local ok, id = pcall(api.setAutoSimPhase, s.ee2, 326.30 + d, 331.80 + d); if ok then s.ee2 = id end end
  if s.sd2a then local ok, id = pcall(api.setAutoSimPhase, s.sd2a, 401.40 + d, 404.40 + d); if ok then s.sd2a = id end end
  if s.sd2b then local ok, id = pcall(api.setAutoSimPhase, s.sd2b, 406.40 + d, 409.40 + d); if ok then s.sd2b = id end end
  if s.sr3a then local ok, id = pcall(api.setAutoSimPhase, s.sr3a, 412.10 + d, 414.10 + d); if ok then s.sr3a = id end end
  if s.sr3b then local ok, id = pcall(api.setAutoSimPhase, s.sr3b, 416.60 + d, 419.10 + d); if ok then s.sr3b = id end end
  self.used = true
end
