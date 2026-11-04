-- [BLM] AutoSim - Specter / Thunder III / Queen's Crusade 2 Sync
-- eventType: 3
-- displayPath: BLM Optimization
-- mechanicTime: 11.4
-- timelineIndex: 1
-- timerStartOffset: -11.4
-- timerEndOffset: 600
-- loop: True
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] Extra caster downtime syncs
-- Re-time the Specter 1, Thunder III 1 and Queen's Crusade 2 caster downtime on the real cast start
local e = eventArgs
if not e then return end
local sp = e.spellID
if sp ~= 43167 and sp ~= 43235 and sp ~= 43236 and sp ~= 43194 then return end
local s = TensorZelBLM
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if not (s and t) then return end
local function place(key, a, b)
  if s[key] then
    local ok, id = pcall(api.setAutoSimPhase, s[key], t + a, t + b)
    if ok then s[key] = id end
  else
    local ok, id = pcall(api.addAutoSimPhase, "CasterDowntime", t + a, t + b)
    if ok then s[key] = id end
  end
end
if sp == 43167 and not s.spS then
  s.spS = true
  place("sp", 2.5, 5.5)
elseif (sp == 43235 or sp == 43236) and not s.th3S then
  s.th3S = true
  place("th3", 1.5, 3.5)
elseif sp == 43194 then
  -- count Queen's Crusade casts (5s debounce); only the 2nd one gets a window
  if not s.qcT or t - s.qcT > 5 then
    s.qcT = t
    s.qcN = (s.qcN or 0) + 1
    if s.qcN == 2 then place("qc2", 13.5, 16.0) end
  end
end
