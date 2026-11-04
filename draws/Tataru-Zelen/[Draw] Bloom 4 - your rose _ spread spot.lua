-- [Draw] Bloom 4 - your rose / spread spot
-- eventType: 12
-- displayPath: Role Draws
-- mechanicTime: 365.1
-- timelineIndex: 67
-- timerStartOffset: -7.2
-- timerEndOffset: 0.6
-- loop: True

-- [action] [Draw] Bloom 4 - your rose / spread spot
local function hush() end -- removed text callouts (draws cover them)
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
if not Z.tileHV1 then
  Z.tileHV1 = true
  -- floor tiles (BossMod Ex4Zelenia numbering): 0-7 inner ring (r <= 8), 8-15 outer ring (8 < r <= 16);
  -- tile t%8 = k spans [45k, 45k+45) degrees clockwise from north (centre 22.5 + 45k). Z.tiles[t] = true while red.
  Z.tiles = Z.tiles or {}
  Z.tileT = Z.tileT or {}
  function Z.tileAngle(t) return 22.5 + 45 * (t % 8) end
  function Z.tileCenter(t) return Z.pt(100, 100, Z.tileAngle(t), (t < 8) and 4 or 12) end
  function Z.tilePoint(t, frac)
    local r0 = (t < 8) and 0 or 8
    return Z.pt(100, 100, Z.tileAngle(t), r0 + 8 * (frac or 0.5))
  end
  function Z.tileOf(x, z)
    local dx, dz = x - 100, z - 100
    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8
    if dx * dx + dz * dz <= 64 then return k end
    return k + 8
  end
  function Z.tileEdges(t)
    if t == 0 then return {7, 1, 8} elseif t == 7 then return {6, 0, 15}
    elseif t == 8 then return {15, 9, 0} elseif t == 15 then return {14, 8, 7} end
    return {t - 1, t + 1, (t > 8) and (t - 8) or (t + 8)}
  end
  function Z.connected(t)
    local set = {}
    if not (t and Z.tiles[t]) then return set end
    local q, h = {t}, 1
    set[t] = true
    while q[h] do
      local v = q[h]; h = h + 1
      for _, w in ipairs(Z.tileEdges(v)) do
        if Z.tiles[w] and not set[w] then set[w] = true; q[#q + 1] = w end
      end
    end
    return set
  end
end
-- Bloom 4: roses opposite the ground AoEs, spreads by them. Angles are relative to G (the ground-AoE side), + = clockwise.
-- Floor variants: in some pulls (2311, 2303) the outer tile at the T2/M2 spread spot (G+21, r9.5) is pre-red -> T2/M2 uses
-- (G-30, r12) instead. Only decidable if the tile tracker sees the Bloom 4 floor pattern; otherwise both spots are shown.
local b = Z.b4
local s = Z.slot()
if not (b and b.gT and b.gz and b.gz ~= 0 and b.roseSup ~= nil and s) then return end
local now = Now()
if now - b.gT > 7600 then return end
local p = TensorCore.mGetPlayer()
if not (p and p.pos) then return end
local G = (b.gz > 0) and 180 or 0
if b.roseSup == Z.isSup(s) then
  local rs = Z.B4_ROSE and Z.B4_ROSE[s]
  if not rs then return end
  local rx, rz = Z.pt(100, 100, G + rs[1], rs[2])
  Z.goTo(rx, rz, 0xFF66FF, 1.0)
  return
end
local sp = Z.B4_SPREAD and Z.B4_SPREAD[s]
if not sp then return end
local rel, r = sp[1], sp[2]
local axisOuter = (s == "T2" or s == "M2")
local v = b.var
if axisOuter and v == nil and Z.tilesKnown and Z.tiles and Z.tileT and Z.tileOf then
  -- only trust tiles that changed after Bloom 4 started and before the rose drop (i.e. the floor pattern itself)
  local known = false
  for t = 0, 15 do
    local tt = Z.tileT[t]
    if Z.tiles[t] and tt and now - tt < 16000 and tt - b.gT < 6500 then
      known = true
      break
    end
  end
  if known then
    local ax, az = Z.pt(100, 100, G + rel, r)
    local at = Z.tileOf(ax, az)
    local tt = at and Z.tileT[at]
    v = (at and Z.tiles[at] and tt and now - tt < 16000) and "B" or "A"
    b.var = v
  end
end
if axisOuter and v == "B" then rel, r = -30, 12 end
local x, z = Z.pt(100, 100, G + rel, r)
Z.goTo(x, z, 0x0099FF, 1.0)
local py = p.pos.y
if axisOuter and v == nil then
  local ax, az = Z.pt(100, 100, G - 30, 12)
  TensorCore.getCachedDrawer(0x22FFFFFF, 0x44FFFFFF, 0x88FFFFFF, 0xFFFFFFFF, 2):addCircle(ax, py, az, 1.0, false, Z.flags)
  if not b.altSaid then
    b.altSaid = true
    hush(7000, "SPREAD: if the OUTER tile under your arrow is RED, use the WHITE ring", 0xFFFFFFFF)
  end
end
-- your spread (r4) and the two always-red flank tiles it must not touch
TensorCore.getCachedDrawer(0x103333FF, 0x183333FF, 0x283333FF, 0xFF3333FF, 2):addCircle(p.pos.x, py, p.pos.z, 4.0, false, Z.flags)
local d = TensorCore.getStaticDrawer(0xFF3333FF, 2)
for f = 0, 1 do
  local a0 = G - 135
  if f == 0 then a0 = G + 90 end
  local pix, piz, pox, poz
  for i = 0, 3 do
    local aa = a0 + 15 * i
    local ix, iz = Z.pt(100, 100, aa, 8)
    local ox, oz = Z.pt(100, 100, aa, 15.8)
    if i == 0 or i == 3 then d:addLine(ix, py, iz, ox, py, oz, 2) end
    if pix then
      d:addLine(pix, py, piz, ix, py, iz, 2)
      d:addLine(pox, py, poz, ox, py, oz, 2)
    end
    pix, piz, pox, poz = ix, iz, ox, oz
  end
end
