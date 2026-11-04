-- [Draw] Bloom 3 - towers / new north
-- eventType: 3
-- displayPath: Role Draws
-- mechanicTime: 278
-- timelineIndex: 50
-- timerStartOffset: -14
-- timerEndOffset: -11.5
-- loop: True

-- [action] [Draw] Bloom 3 - towers / new north
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
-- ===== Bloom 3 helpers (add to the shared PRE anywhere after `local Z = data.zel`; self-guarded, defined once per pull) =====
-- Uses at call time: Z.pt, Z.slot, Z.slotOf, Z.isSup, Z.say, Z.dirName (existing PRE), and optionally Z.tiles / Z.tilesKnown / Z.tileT (tile tracker).
if not Z.b3fnV2 then
  Z.b3fnV2 = true
  -- offsets in 45-degree tile steps from the NEW NORTH inner tile n (colour pairs T1/R1 N, H2/R2 E, T2/M2 S, H1/M1 W):
  --   ro = inner rose tile, to = outer tower tile, wr/wo = plain tile to walk to after the drop (wr 1 = outer, 0 = inner)
  Z.B3_K = {
    T1 = {ro = 0, to = 0, wr = 0, wo = 2}, R1 = {ro = 0, to = 0, wr = 1, wo = 1},
    H2 = {ro = 3, to = 2, wr = 1, wo = 3}, R2 = {ro = 3, to = 2, wr = 1, wo = 3},
    T2 = {ro = 4, to = 4, wr = 0, wo = 6}, M2 = {ro = 4, to = 4, wr = 1, wo = 5},
    H1 = {ro = 5, to = 6, wr = 0, wo = 6}, M1 = {ro = 5, to = 6, wr = 0, wo = 6}}
  Z.B3_RANK = {[0] = 1, [3] = 2, [4] = 3, [5] = 4}
  Z.B3_ROSEOFF = {[0] = true, [3] = true, [4] = true, [5] = true}
  -- tiles {ring, offset} a correctly placed player of each slot stands on (votes for the party-position inference)
  local XN, XE, XS, XW = {{0, 0}, {1, 0}}, {{0, 3}, {1, 2}, {1, 3}}, {{0, 4}, {1, 4}}, {{0, 5}, {1, 6}}
  Z.B3_EXP = {T1 = XN, R1 = XN, H2 = XE, R2 = XE, T2 = XS, M2 = XS, H1 = XW, M1 = XW}

  -- BossMod tile index of a world point (0-7 inner r<=8, 8-15 outer; k spans [45k, 45k+45) clockwise from north)
  function Z.b3tile(x, z)
    if not (x and z) then return nil end
    local dx, dz = x - 100, z - 100
    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8
    if dx * dx + dz * dz <= 64 then return k end
    return k + 8
  end

  -- Bloom 3 pull state; a table older than 30 s (left over from an earlier pull if data was not reset) is replaced
  function Z.b3get()
    local now = Now()
    local b = Z.b3
    if type(b) ~= "table" or not b.t0 or now - b.t0 > 30000 then
      b = {t0 = now}
      Z.b3 = b
    end
    return b
  end

  -- point on the centre line of tile t at radius r
  function Z.b3spot(t, r)
    return Z.pt(100, 100, 22.5 + 45 * (t % 8), r)
  end

  -- new north from the tile tracker: the plain inner tile between the only two red inner tiles
  function Z.b3fromTiles(par)
    local T, TT, b = Z.tiles, Z.tileT, Z.b3
    if not (Z.tilesKnown and type(T) == "table" and type(TT) == "table" and b and b.t0) then return nil end
    -- only tiles that changed this bloom (from ~15 s before this state was created) count; stale tiles from earlier blooms are ignored
    local since = b.t0 - 15000
    local F, cnt = {}, 0
    for t = 0, 7 do
      if T[t] and TT[t] and TT[t] >= since then F[t] = true cnt = cnt + 1 end
    end
    if cnt ~= 2 then return nil end
    local found
    for n = 0, 7 do
      if (par == nil or n % 2 == par) and not F[n] and F[(n + 7) % 8] and F[(n + 1) % 8] then
        if found then return nil end
        found = n
      end
    end
    return found
  end

  -- new north from where the other 7 players stand (pairs pre-position on their rose tile relative to new north)
  function Z.b3fromParty(par)
    if not TensorCore.getEntityGroupList then return nil end
    local list = TensorCore.getEntityGroupList("Party")
    if type(list) ~= "table" then return nil end
    local me = TensorCore.mGetPlayer()
    local myId = me and me.id
    local sc, sf, nv = {}, {}, 0
    for n = 0, 7 do sc[n] = 0 sf[n] = 0 end
    for k, v in pairs(list) do
      local id = (type(v) == "table") and (v.id or k) or v
      local e = (type(v) == "table") and v or TensorCore.mGetEntity(v)
      if type(e) == "table" and id and id ~= myId and e.pos then
        local t = Z.b3tile(e.pos.x, e.pos.z)
        local s = Z.slotOf(id)
        local o = s and Z.B3_EXP[s]
        if t then
          if o then nv = nv + 1 end
          for n = 0, 7 do
            if par == nil or n % 2 == par then
              if o then
                for i = 1, #o do
                  local q = o[i]
                  if t == q[1] * 8 + (n + q[2]) % 8 then sc[n] = sc[n] + 1 break end
                end
              end
              if t < 8 and Z.B3_ROSEOFF[(t - n) % 8] then sf[n] = sf[n] + 1 end
            end
          end
        end
      end
    end
    local S, needB, needM = sc, 3, 2
    if nv < 4 then
      if par == nil then return nil end
      S, needB, needM = sf, 4, 2
    elseif par == nil then
      needB, needM = 4, 3
    end
    local best, bestN, second = -1, nil, -1
    for n = 0, 7 do
      if par == nil or n % 2 == par then
        local v = S[n]
        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end
      end
    end
    if bestN ~= nil and best >= needB and best - second >= needM then return bestN end
    return nil
  end

  -- new north from the 4 rose drops (correct drops land on inner n, n+3, n+4, n+5); real evidence, so it overrides every other source
  function Z.b3fromDrops()
    local b = Z.b3
    if not (b and b.drops) then return end
    local inner, m = {}, 0
    for _, t in pairs(b.drops) do
      if t and t < 8 and not inner[t] then inner[t] = true m = m + 1 end
    end
    if m < 3 then return end
    local best, bestN, second = -1, nil, -1
    for n = 0, 7 do
      if b.par == nil or n % 2 == b.par then
        local v = 0
        for o in pairs(Z.B3_ROSEOFF) do if inner[(n + o) % 8] then v = v + 1 end end
        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end
      end
    end
    if bestN == nil or best < 3 or best <= second then return end
    local old = b.nn
    b.nn, b.nnSrc, b.relN, b.rtFor = bestN, "drops", 22.5 + 45 * bestN, nil
    if old ~= nil and old ~= bestN then
      local s = Z.slot()
      local K = s and Z.B3_K[s]
      if K and b.roseSup ~= nil and b.roseSup ~= Z.isSup(s) then
        Z.say(4000, "Bloom 3: new north was wrong -> your tower is " .. Z.dirName(22.5 + 45 * ((bestN + K.to) % 8)), 0xFFFF3333)
      end
    end
  end

  -- pick the new north: tiles > party positions > tower parity guess (22.5 / 337.5); frozen once the roses drop
  function Z.b3resolve()
    local b = Z.b3
    if not b then return end
    local now = Now()
    if b.resT and now - b.resT < 250 then return end
    b.resT = now
    if b.par ~= nil and b.nn ~= nil and b.nn % 2 ~= b.par then b.nn, b.nnSrc = nil, nil end
    if b.nnSrc == "tiles" or b.nnSrc == "drops" then return end
    if b.dropT and b.nn ~= nil then return end
    local n, src = Z.b3fromTiles(b.par), "tiles"
    if n == nil then n, src = Z.b3fromParty(b.par), "party" end
    if n == nil then
      if b.nnSrc == "party" or b.par == nil then return end
      n, src = (b.par == 0) and 0 or 7, "guess"
    end
    if n ~= b.nn then b.rtFor = nil end
    b.nn, b.nnSrc, b.relN = n, src, 22.5 + 45 * n
  end

  -- is tile t active (red / tower) right now? strict boolean
  function Z.b3act(t)
    local b = Z.b3
    if not b or t == nil then return false end
    if b.tw and b.tw[t] then return true end
    if b.drops then for _, d in pairs(b.drops) do if d == t then return true end end end
    local T = Z.tiles
    if b.nnSrc == "tiles" then return (type(T) == "table" and T[t]) and true or false end
    local n = b.nn
    if n ~= nil then
      if t < 8 then
        local r = (t - n) % 8
        if r == 1 or r == 7 then return true end
      elseif (t - n) % 2 == 0 then
        return true
      end
    end
    if type(T) == "table" and T[t] and b.markT and type(Z.tileT) == "table" and Z.tileT[t] and Z.tileT[t] > b.markT then return true end
    return false
  end

  -- BossMod Bloom3Emblazon.DangerTile: outer ring, active tiles, and inner "side tiles" are unsafe for roses
  function Z.b3danger(t)
    if t >= 8 then return true end
    local A = Z.b3act
    if A(t) then return true end
    return A(t + 8) and (A((t + 1) % 8) ~= A((t + 7) % 8))
  end

  -- your rose tile: pair tile relative to new north; if DangerTile forbids it, the allowed tile of the same rank
  function Z.b3roseTile(s)
    local b, K = Z.b3, Z.B3_K[s]
    if not (b and b.nn ~= nil and K) then return nil end
    local n = b.nn
    local R = (n + K.ro) % 8
    if not Z.b3danger(R) then return R end
    local L = {}
    for o = 0, 7 do
      local t = (n + o) % 8
      if not Z.b3danger(t) then L[#L + 1] = t end
    end
    return L[Z.B3_RANK[K.ro] or 1] or L[1] or R
  end

  -- plain tile to walk to after the drop (pair default; nearest plain tile if that one is red)
  function Z.b3walkTile(s, px, pz)
    local b, K = Z.b3, Z.B3_K[s]
    if not (b and b.nn ~= nil and K) then return nil end
    local W = (b.nn + K.wo) % 8 + 8 * K.wr
    if not Z.b3act(W) or not (px and pz) then return W end
    local best, bd
    for t = 0, 15 do
      if not Z.b3act(t) then
        local x, z = Z.b3spot(t, (t < 8) and 5.0 or 10.0)
        local d = (x - px) * (x - px) + (z - pz) * (z - pz)
        if bd == nil or d < bd then best, bd = t, d end
      end
    end
    return best or W
  end
end
-- Bloom 3 towers (43201 cast from the 4 outer tile centres): record tower tiles + parity, then resolve the new north
local e = eventArgs
if not (e and e.spellID == 43201) then self.used = true return end
local ent = TensorCore.mGetEntity(e.entityID)
if ent and ent.pos and Z.b3tile and Z.b3get then
  local b = Z.b3get()
  local t = Z.b3tile(ent.pos.x, ent.pos.z)
  if t and t >= 8 then
    b.tw = b.tw or {}
    b.tw[t] = true
    b.par = t % 2
    b.resT = nil
    if Z.b3resolve then Z.b3resolve() end
  end
end
self.used = true
