-- [Draw] Bloom 1 (repeat) - Thunder III your spread spot
-- eventType: 12
-- displayPath: Role Draws
-- mechanicTime: 561.8
-- timelineIndex: 114
-- timerStartOffset: -5.3
-- timerEndOffset: 1.2
-- loop: True

-- [action] [Draw] Bloom 1 (repeat) - Thunder III your spread spot
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
-- Bloom 1 Thunder III: per-slot spread spot on a plain (non-vine) tile, >= 5.2y from every other slot's spot
local s = Z.slot()
if not s then return end
local now = Now()
-- wait until the last Thunder II snapshot is out (15 steps) before pulling people off the rotation path
local b0 = Z.b1
if b0 and b0.t0 and now - b0.t0 < 45000 and (b0.k or 0) < 15 then
  local T0 = b0.T0 or (b0.chanT and (b0.chanT + 5540))
  if T0 and now - T0 < 14400 then return end
end
local c = Z.b1s
if not (c and c.t and now - c.t < 12000) then
  c = nil
  local b = Z.b1
  local plan = (b and b.t0 and now - b.t0 < 45000) and b.plan or nil
  local dir = plan and plan.dir or ((b and b.t0 and now - b.t0 < 45000) and b.dir or nil)
  local red, useT = {}, false
  if plan and plan.red then
    red, useT = plan.red, plan.useT
  else
    if Z.tilesKnown and type(Z.tiles) == "table" then
      local nr, newest = 0, 0
      for t = 0, 15 do
        if Z.tiles[t] then nr = nr + 1 end
        local tt = type(Z.tileT) == "table" and Z.tileT[t]
        if tt and tt > newest then newest = tt end
      end
      useT = (nr >= 4 and nr <= 13 and now - newest < 45000)
    end
    if not dir and useT then
      local cw = not (Z.tiles[2] or Z.tiles[3] or Z.tiles[4])
      local ccw = not (Z.tiles[6] or Z.tiles[7] or Z.tiles[0])
      if cw and not ccw then dir = 1 elseif ccw and not cw then dir = -1 end
    end
    if dir then
      if useT then
        for t = 0, 15 do red[t] = Z.tiles[t] and true or false end
      else
        local plain = (dir > 0) and {[2] = 1, [3] = 1, [4] = 1, [9] = 1, [10] = 1, [12] = 1}
          or {[0] = 1, [3] = 1, [6] = 1, [7] = 1, [13] = 1, [14] = 1}
        for t = 0, 15 do red[t] = not plain[t] end
      end
    end
  end
  if dir then
    -- {angle clockwise from N, radius}: the spots this PF used (CCW = marker 168, CW = marker 167)
    local DES = (dir > 0) and {T1 = {103, 4.5}, T2 = {62, 12.0}, H1 = {219, 14.8}, H2 = {203, 10.0},
        M1 = {211, 4.8}, M2 = {157, 6.5}, R1 = {116, 12.5}, R2 = {192, 15.0}}
      or {T1 = {33, 5.5}, T2 = {152, 6.0}, H1 = {230, 14.8}, H2 = {308, 14.5},
        M1 = {232, 9.5}, M2 = {299, 5.5}, R1 = {277, 14.5}, R2 = {254, 13.2}}
    local function good(x, z)
      local dx, dz = x - 100, z - 100
      local r = math.sqrt(dx * dx + dz * dz)
      if r < 3 or r > 15.3 then return false end
      local ang = math.deg(math.atan2(dx, -dz)) % 360
      local k = math.floor(ang / 45) % 8
      local base = (r <= 8) and 0 or 8
      local t = base + k
      if red[t] then return false end
      local rel = ang - 45 * k
      if red[base + (k + 7) % 8] and math.rad(rel) * r < 0.9 then return false end
      if red[base + (k + 1) % 8] and math.rad(45 - rel) * r < 0.9 then return false end
      if base == 0 and red[t + 8] and 8 - r < 0.9 then return false end
      if base == 8 and red[t - 8] and r - 8 < 0.9 then return false end
      return true
    end
    local placed = {}
    local function free(x, z)
      for i = 1, #placed do
        local dx, dz = placed[i][1] - x, placed[i][2] - z
        if dx * dx + dz * dz < 27.04 then return false end
      end
      return true
    end
    local sp = {}
    local ORDER = {"T1", "T2", "H1", "H2", "M1", "M2", "R1", "R2"}
    for i = 1, 8 do
      local sl = ORDER[i]
      local d = DES[sl]
      local x, z = Z.pt(100, 100, d[1], d[2])
      if not (good(x, z) and free(x, z)) then
        local bx, bz, bd
        for t = 0, 15 do
          if not red[t] then
            local ca = 22.5 + 45 * (t % 8)
            local rs = (t < 8) and {4.8, 6.6} or {9.6, 12.4, 15.0}
            for j = 1, #rs do
              for da = -14, 14, 7 do
                local cx, cz = Z.pt(100, 100, ca + da, rs[j])
                if good(cx, cz) and free(cx, cz) then
                  local dd = (cx - x) * (cx - x) + (cz - z) * (cz - z)
                  if not bd or dd < bd then bx, bz, bd = cx, cz, dd end
                end
              end
            end
          end
        end
        if bx then x, z = bx, bz end
      end
      sp[sl] = {x, z}
      placed[#placed + 1] = {x, z}
    end
    c = {t = now, sp = sp, dir = dir, useT = useT}
    Z.b1s = c
  end
end
if not c then return end
local q = c.sp[s]
if q then Z.goTo(q[1], q[2], 0xFF66FF, 0.8) end
