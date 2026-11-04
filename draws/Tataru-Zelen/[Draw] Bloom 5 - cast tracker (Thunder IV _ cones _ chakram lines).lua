-- [Draw] Bloom 5 - cast tracker (Thunder IV / cones / chakram lines)
-- eventType: 3
-- displayPath: Role Draws
-- mechanicTime: 469.2
-- timelineIndex: 89
-- timerStartOffset: -13
-- timerEndOffset: -0.3
-- loop: True

-- [action] [Draw] Bloom 5 - cast tracker (Thunder IV / cones / chakram lines)
data.zel = data.zel or {}
local Z = data.zel
if not Z.initV then
  Z.initV = true
  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY
  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}
  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}
  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}
  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}
  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}
  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}
  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}
  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}
  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}
  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}
  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}
  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}
  function Z.slot()
    local R = AnyoneCore and AnyoneCore.Roster
    local s = R and R.mySlot and R.mySlot()
    if not s and GetCurrentRole then
      local r = GetCurrentRole()
      s = (r == "MT" and "T1") or (r == "OT" and "T2") or r
    end
    return s
  end
  function Z.slotOf(id)
    local R = AnyoneCore and AnyoneCore.Roster
    return R and R.slotOf and R.slotOf(id)
  end
  function Z.isSup(s) return s == "T1" or s == "T2" or s == "H1" or s == "H2" end
  function Z.supOf(id)
    local s = Z.slotOf(id)
    if s then return Z.isSup(s) end
    local e = TensorCore.mGetEntity(id)
    return (e and Z.SUPJOB[e.job]) and true or false
  end
  function Z.tankOf(id)
    local s = Z.slotOf(id)
    if s then return s == "T1" or s == "T2" end
    local e = TensorCore.mGetEntity(id)
    return (e and Z.TANKJOB[e.job]) and true or false
  end
  function Z.pt(cx, cz, deg, r)
    local a = math.rad(deg)
    return cx + r * math.sin(a), cz - r * math.cos(a)
  end
  function Z.goTo(x, z, col, rad)
    local p = TensorCore.mGetPlayer()
    if not (p and p.pos) then return end
    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)
    local px, py, pz = p.pos.x, p.pos.y, p.pos.z
    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)
    if d > 0.8 then
      -- tether from you to your spot
      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)
      local tip = math.min(1.5, d * 0.35)
      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)
    end
    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)
  end
  function Z.say(ms, txt, col)
    local p = TensorCore.mGetPlayer()
    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then
      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)
    end
  end
  function Z.dirName(deg)
    local N = {"N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"}
    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]
  end
  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)
  function Z.efState(k)
    local ef = Z.ef
    if not ef then return nil end
    local sym = ef.sym
    if not sym[k] then return nil end
    local mySup = Z.isSup(Z.slot())
    local supFirst
    if ef.mode == 2 and Z.donutSup ~= nil then
      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3
      supFirst = not Z.donutSup
    else
      if not sym[1] then return nil end
      supFirst = (sym[1] == "F")
    end
    local iTake = ((k % 2 == 1) == (supFirst == mySup))
    if iTake then return (sym[k] == "N") and "IN" or "OUT" end
    return (sym[k] == "N") and "OUT" or "IN"
  end
end
-- Bloom 5 tracker: Thunder IV in/out (43450 circle = OUT first, 43451 donut = IN first;
-- boss visual 43448 = OUT first, 43449 = IN first), Thunder Slash cones (43216: helper heading
-- = cone direction), Valorous Ascension chakram lines (43210, Briar Thorn 40x8 rect).
local e = eventArgs
local sid = e and e.spellID
if not (sid == 43450 or sid == 43451 or sid == 43448 or sid == 43449 or sid == 43216 or sid == 43210) then
  self.used = true
  return
end
local now = Now()
local B = Z.b5
if not (B and B.t0 and now - B.t0 < 40000) then
  B = {t0 = now, ids = {}, idSeen = {}, rect = {}, resT = {}, appT = {}, cones = {}, seenIV = {}, seenC = {}}
  Z.b5 = B
end
local id = e.entityID
local ct = e.channelTimeMax
local ms = math.floor(((ct and ct > 0) and ct or 6.4) * 1000)
if sid == 43450 or sid == 43451 then
  if id and not B.seenIV[id] then
    B.seenIV[id] = true
    local io = (sid == 43451) and "IN" or "OUT"
    B.nIV = (B.nIV or 0) + 1
    if B.nIV == 1 then
      B.io1 = io
      B.tIV1 = now + ms
      if not B.tIO then B.tIO = now end
    elseif B.nIV == 2 then
      B.io2 = io
    end
  end
elseif sid == 43448 or sid == 43449 then
  if not B.io1 then B.io1 = (sid == 43449) and "IN" or "OUT" end
  if not B.tIV1 then B.tIV1 = now + ms + 700 end
  if not B.tIO then B.tIO = now end
elseif id then
  local ent = TensorCore.mGetEntity(id)
  if sid == 43216 then
    if not B.seenC[id] and ent and ent.pos and ent.pos.h then
      B.seenC[id] = true
      B.cones[#B.cones + 1] = {a = (180 - math.deg(ent.pos.h)) % 360, t = now + ms}
    end
  else
    if not B.idSeen[id] then
      B.idSeen[id] = true
      B.ids[#B.ids + 1] = id
    end
    if not B.resT[id] then
      B.resT[id] = now + ms
      if ent and ent.pos and ent.pos.h then B.rect[id] = {x = ent.pos.x, z = ent.pos.z, h = ent.pos.h} end
    end
  end
end
B.dirty = true
self.used = true
