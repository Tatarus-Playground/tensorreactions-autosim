local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "1ecc04dc-eb5a-c89b-b658-974b5de32c22",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Valigarmanda EX setup on the countdown (universal: any job, no job condition).\n-- Kill 292.4 s = mean of our last 2 clears (2026-11-13). Clears the phase types this profile\n-- uses (Full/Melee/Caster downtime, BossModifier) and the uncertainty, then predicts every fixed window,\n-- the Beacon-phase 0.8 weighting and the DoT blacklist. Each window is re-timed later by its own cast sync.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nV.setup(true)\n",
							name = "setup (countdown)",
							uuid = "f2a544a7-6786-b259-b957-e9086397b874",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				loop = true,
				mechanicTime = 6,
				name = "[AutoSim] Valigarmanda EX - setup (countdown)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "b25e3093-6703-7b71-a0d5-628ad3c4d861",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Valigarmanda EX setup at pull start when there was no countdown.\n-- Polled OnUpdate, runs once per pull. Skipped only when a countdown setup is waiting for this pull and its\n-- AutoSim schedule is still live.\nself.used = true -- run once per pull\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal s = TensorValX\nif s and s.cd and not s.pulled and Now() - (s.stamp or 0) < 75000 then\n  s.pulled = true -- the countdown setup belongs to this pull\n  if V.alive(s) then return end -- its AutoSim schedule is still live (not reset by a cancel or by the pull)\nend\nV.setup(false)\n",
							name = "setup without countdown",
							uuid = "600884fb-87e9-228d-872d-f06177b0405c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				mechanicTime = 6,
				name = "[AutoSim] Valigarmanda EX - setup without countdown",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -2.5,
				timerStartOffset = -5.5,
				uuid = "821c4912-c172-e3f0-9164-eb88700201ad",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Valigarmanda EX: forget this pull's AutoSim state on a wipe, so the next pull starts clean\n-- (AutoSim itself clears its phases on the encounter reset).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nTensorValX = nil\n",
							name = "reset on wipe",
							uuid = "8408f071-d9ed-167d-8c54-d157d592bc55",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 9,
				mechanicTime = 6,
				name = "[AutoSim] Valigarmanda EX - reset on wipe",
				timelineIndex = 1,
				uuid = "d7925506-fa0f-c1b8-b18b-8b80b5f2b1c6",
				version = 2,
			},
		},
	},
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "eba49703-ded9-4371-bf18-d5f1be620a63",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Opening Spikesicle (36850 begincast, FFLogs 9.9 s): shift the predicted pre-Beacon windows,\n-- the Beacon phase and the kill onto this client's AutoSim clock.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 36850) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nif t < 60 then V.opener(s, t) end\n",
							name = "opener clock sync (Spikesicle)",
							uuid = "91e9de16-fc18-c556-8e71-24e7affacc09",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 18,
				name = "[AutoSim] Valigarmanda EX - opener clock sync (Spikesicle)",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = -6,
				timerStartOffset = -14,
				uuid = "3d81e4cd-7491-cadc-ba6e-ffb624ae58cb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "c6d2049b-95c9-f6d4-bcbb-e07525b62b5a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnMapEffect): Spikesicle line order, erupting volcano, avalanche half.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal i = eventArgs.a1\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nif i >= 4 and i <= 13 then\n  local s = spGet(V, now)\n  for _, m in ipairs(s.me) do\n    if m.i == i then return end\n  end\n  s.me[#s.me + 1] = {i = i, t = now}\n  s.plan = nil\nelseif i == 14 or i == 15 then\n  V.vol = {i = i, t = now}\nelseif i == 3 then\n  V.aval = {ne = (eventArgs.a2 == 16), t = now}\n  if V.sp then V.sp.plan = nil end\nend\n",
							conditions = 
							{
								
								{
									"d1947261-9a31-e719-bd5f-2b7d2fb14a3b",
									true,
								},
							},
							name = "Capture",
							uuid = "16ce6b89-5c99-13c4-b064-a696f4c66d53",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnMapEffect, Dequeue Action if False = on).\n-- 4..13 state 0x00020004 = Spikesicle lines (BossmodReborn Spikesicle.cs:22); 14/15 state 0x00200010 = volcano\n-- eruption (VolcanicDrop.cs:18-21); 3 state 0x00200010 / 0x00020001 = avalanche half (NorthernCross.cs, cactbot :710-718).\nlocal a1, a2, a3 = eventArgs.a1, eventArgs.a2, eventArgs.a3\nif a1 >= 4 and a1 <= 13 then return a2 == 4 and a3 == 2 end\nif a1 == 14 or a1 == 15 then return a2 == 16 and a3 == 32 end\nif a1 == 3 then return (a2 == 16 and a3 == 32) or (a2 == 1 and a3 == 2) end\nreturn false\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "d1947261-9a31-e719-bd5f-2b7d2fb14a3b",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 14,
				loop = true,
				mechanicTime = 18,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture map effects)",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 13,
				timerStartOffset = -14,
				uuid = "216587a1-cdf2-ea4e-a57f-b6a0f896a64b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"cf0896ee-2f0e-bdef-a5e5-643fc73fe9a1",
									true,
								},
							},
							name = "Capture",
							uuid = "1cde8d0f-8954-2291-a96e-8ccaedbb778c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "cf0896ee-2f0e-bdef-a5e5-643fc73fe9a1",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 18,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 1,
				timerStartOffset = -12,
				uuid = "d5c93664-0c99-c5d4-a9b0-bb7f4204d793",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"9de32c66-f991-54f1-8df9-eef9c84d4b21",
									true,
								},
							},
							name = "Capture",
							uuid = "9f1ba4f2-bab4-7660-ab47-735ad269d56d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "9de32c66-f991-54f1-8df9-eef9c84d4b21",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 18,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 20,
				timerStartOffset = -12,
				uuid = "3d48b1ac-448b-39b2-862e-684f82de9b6e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityAdd): Ice Boulder 12856 (Sphere Shatter r13 centre), Feather of Ruin\n--   12855 (Blighted Bolt r8 centre), Arcane Sphere 12857 (storm lanes).\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nif not (e and e.pos and e.pos.x) then return end -- not ready yet: retry next tick (self.used stays unset on purpose)\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal c = eventArgs.entityContentID\nlocal id = eventArgs.entityID\nlocal function add(list, rec)\n  for _, r in ipairs(list) do\n    if r.id == id then return end\n  end\n  list[#list + 1] = rec\nend\nif c == 12856 then\n  local s = V.sp\n  if s and now - s.t0 < 45000 then\n    add(s.bould, {id = id, x = e.pos.x, z = e.pos.z, t = now})\n    s.plan = nil\n  end\nelseif c == 12855 then\n  if not V.fea or now - V.fea.t > 40000 then V.fea = {t = now, list = {}} end\n  add(V.fea.list, {id = id, x = e.pos.x, z = e.pos.z})\nelseif c == 12857 then\n  if not V.sph or now - V.sph.t > 15000 then V.sph = {t = now, list = {}} end\n  add(V.sph.list, {id = id, x = e.pos.x, z = e.pos.z})\nend\n",
							conditions = 
							{
								
								{
									"2c2a8aae-ee68-b3fe-9240-834c0fdf0fd4",
									true,
								},
							},
							name = "Capture",
							uuid = "ed7b8ea2-cd2f-6527-8a95-a6e4811519f0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityAdd, Dequeue Action if False = on).\n-- 12856 Ice Boulder, 12855 Feather of Ruin, 12857 Arcane Sphere (store reactions key the same ids).\nlocal c = eventArgs.entityContentID\nreturn c == 12856 or c == 12855 or c == 12857\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "2c2a8aae-ee68-b3fe-9240-834c0fdf0fd4",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 5,
				loop = true,
				mechanicTime = 18,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture spawns)",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 14,
				uuid = "966ef9a0-c7a6-71d4-8df3-31e7a8afce7a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Spikesicle role spot (whole party, opener idx 2 and ice phase idx 78).\n-- Shows the one spot that none of the still-pending attacks hits, re-planned whenever a line fires, a boulder\n-- appears or explodes, or the avalanche half is known:\n--   * 10 lines (map effects 4..13): donuts r20-25/25-30/30-35/35-40 around boss+-20 x, rect 40 x 5 at boss -+17 x\n--     (BossmodReborn Spikesicle.cs:7,34-38). Order: first 04/05, then the whole opposite set, then the rest\n--     (cactbot valigarmanda-ex.ts:121-131); ~1.2 s apart, first ~1.3 s after the Spikesicle cast (FFLogs).\n--   * Ice Boulders (12856): Sphere Shatter r13, in spawn order ~6.5 s after spawn (Spikesicle.cs:61-85).\n--   * ice phase: avalanche half (map effect 3) = rect 60 x 25 (NorthernCross.cs).\n-- Strat (74.webp / 81.webp): wall on the 2nd line's side (first 04 -> west), after 2 lines cross to the other side of\n-- the arrow, after 2 explosions sit at the top of the arrow (ice: slightly left/right of it away from the avalanche).\n-- The strat points are only the preference: the drawn spot is the closest grid point (0.5 y) to it that is outside\n-- every pending AoE (on the wall: until line 2), with a 0.3 y margin (0.8 y preferred), and that you can walk to\n-- without crossing an AoE as it lands; if there is none, the reachable spot that stays clear longest.\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal s = V and V.sp\nif not (s and s.me and #s.me > 0) then return end\nlocal now = Now()\nif now - s.t0 > 45000 or s.shat >= 10 then return end\nlocal first = s.me[1].i\nlocal west = (first == 4)\nlocal av = V.aval\nif av and (av.t < s.t0 - 15000 or av.done) then av = nil end\nlocal key = table.concat({#s.me, s.lines, s.shat, #s.bould, av and (av.ne and \"n\" or \"s\") or \"-\", av and av.nc and 1 or 0,\n  s.castStart and 1 or 0, s.castEnd and 1 or 0}, \":\")\nif not (s.plan and s.plan.key == key) then\n  local bx, bz = s.bx or 100, s.bz or 85\n  local seq\n  if first == 4 then seq = {4, 5, 7, 9, 11, 13, 6, 8, 10, 12} elseif first == 5 then seq = {5, 4, 6, 8, 10, 12, 7, 9, 11, 13} end\n  local order, got = {}, {}\n  for _, m in ipairs(s.me) do\n    order[#order + 1] = m.i\n    got[m.i] = true\n  end\n  if seq then\n    for _, i in ipairs(seq) do\n      if not got[i] then order[#order + 1] = i end\n    end\n  end\n  local base\n  if s.castEnd then base = s.castEnd + 1300 elseif s.castStart then base = s.castStart + 11000 else base = s.me[1].t + 12000 end\n  local H = {}\n  for j = s.lines + 1, #order do\n    local i = order[j]\n    local t = (s.lt and s.lines > 0) and (s.lt + 1200 * (j - s.lines)) or (base + 1200 * (j - 1))\n    t = math.max(now, t)\n    if i <= 11 then\n      local ring = math.floor((i - 4) / 2)\n      local cx = bx + ((i % 2 == 1) and -20 or 20)\n      H[#H + 1] = {k = \"d\", x = cx, z = bz, r1 = 20 + 5 * ring, r2 = 25 + 5 * ring, t = t}\n    else\n      local cx = bx + ((i % 2 == 1) and 17 or -17)\n      H[#H + 1] = {k = \"r\", x = cx, z = bz, dx = 0, dz = 1, len = 40, hw = 2.5, t = t}\n    end\n  end\n  for j = s.shat + 1, #s.bould do\n    local b = s.bould[j]\n    H[#H + 1] = {k = \"c\", x = b.x, z = b.z, r = 13, t = math.max(now, b.t + 6600)}\n  end\n  if av then\n    local ox, oz = 131.487, 107.988\n    if not av.ne then ox, oz = 116.472, 127.977 end\n    -- avalanche resolves ~13 s after the Spikesicle cast (FFLogs ice phase: Northern Cross 3 s after its own cast start)\n    local avT = av.nc and (av.nc + 3000) or math.max(av.t + 3000, base + 11700)\n    H[#H + 1] = {k = \"r\", x = ox, z = oz, dx = -0.8, dz = -0.6, len = 60, hw = 12.5, t = avT}\n  end\n  table.sort(H, function(a, b) return a.t < b.t end)\n  local ax, az\n  if s.lines < 2 then\n    ax, az = west and 81.5 or 118.5, 99.5\n  elseif s.shat < 2 then\n    ax, az = west and 102 or 98, 95\n  elseif av then\n    if av.ne then ax, az = 98.3, 100 else ax, az = 101.2, 99 end\n  else\n    ax, az = 100, 99.5\n  end\n  local n = #H\n  -- on the wall a spot only has to stay clear until line 2 (+3.5 s to walk off); after that it has to stay clear\n  -- of everything still pending (when no such spot can be reached: the one that stays clear longest)\n  local Th = math.huge\n  if s.lines < 2 then Th = math.max(now, base + 1200) + 3500 end\n  local function hit(h, x, z, m)\n    local dx, dz = x - h.x, z - h.z\n    if h.k == \"c\" then\n      local r = h.r + m\n      return dx * dx + dz * dz <= r * r\n    elseif h.k == \"d\" then\n      local d = math.sqrt(dx * dx + dz * dz)\n      return d >= h.r1 - m and d <= h.r2 + m\n    end\n    local a = dx * h.dx + dz * h.dz\n    local p = dx * h.dz - dz * h.dx\n    return a >= -m and a <= h.len + m and math.abs(p) <= h.hw + m\n  end\n  -- every grid point: index of the first pending AoE that hits it (0.3 y margin; n + 1 = never hit);\n  -- cost = distance to the strat point, +3 y when the 0.8 y margin is not met\n  local C = {}\n  -- grid keeps 1 y off the arena edges (ice phase: x < 80, x > 120 and z > 115 are a void zone, Splatoon EX1\n  -- preset \"Ice Phase Void Zone\"; the drawn ring has r1)\n  for xi = 0, 76 do\n    local x = 81 + xi * 0.5\n    for zi = 0, 57 do\n      local z = 85.5 + zi * 0.5\n      local s3, s8 = n + 1, n + 1\n      for j = 1, n do\n        if hit(H[j], x, z, 0.3) then\n          s3 = j\n          break\n        end\n      end\n      for j = 1, s3 - 1 do\n        if hit(H[j], x, z, 0.8) then\n          s8 = j\n          break\n        end\n      end\n      local cost = math.sqrt((x - ax) * (x - ax) + (z - az) * (z - az)) + ((s8 < s3) and 3 or 0)\n      local good = (s3 > n) or (H[s3].t > Th)\n      C[#C + 1] = {x, z, s3, cost, good}\n    end\n  end\n  table.sort(C, function(a, b)\n    if a[5] ~= b[5] then return a[5] end\n    if not a[5] and a[3] ~= b[3] then return a[3] > b[3] end\n    return a[4] < b[4]\n  end)\n  -- walk check: straight run from where you stand; by the time an AoE lands you have covered between\n  -- (t - 0.6 s) * 5 y/s and (t - 0.2 s) * 6.5 y/s of the path: none of those points may be inside it\n  local me = TensorCore.mGetPlayer()\n  local px, pz = ax, az\n  if me and me.pos then px, pz = me.pos.x, me.pos.z end\n  local function pathOk(x, z)\n    local d = math.sqrt((x - px) * (x - px) + (z - pz) * (z - pz))\n    local steps = math.max(1, math.ceil(d / 0.5))\n    for j = 1, n do\n      local h = H[j]\n      local dt = (h.t - now) / 1000\n      local lo = math.max(0, (dt - 0.6) * 5) - 0.25\n      local hi = math.max(0, (dt - 0.2) * 6.5) + 0.25\n      if lo <= d then\n        for k = 0, steps do\n          local sd = d * k / steps\n          if sd >= lo and sd <= hi and hit(h, px + (x - px) * k / steps, pz + (z - pz) * k / steps, 0.3) then return false end\n        end\n      end\n    end\n    return true\n  end\n  local pick = C[1]\n  for i = 1, #C do\n    if pathOk(C[i][1], C[i][2]) then\n      pick = C[i]\n      break\n    end\n  end\n  local bxp, bzp, bs = pick[1], pick[2], pick[3]\n  s.plan = {key = key, x = bxp, z = bzp, clear = bs - 1, n = n}\nend\nvxSpot(s.plan.x, s.plan.z, 1.0)\n",
							name = "Draw",
							uuid = "754c225d-8a5f-7ab9-ad41-1d48e543e7bf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 18,
				name = "[Draw] Valigarmanda - Spikesicle role spot",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 19.5,
				timerStartOffset = -12,
				uuid = "f4cb34e4-5444-0b53-9da6-49072a03a20f",
				version = 2,
			},
		},
	}, 
	[6] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "629c00e2-0ad7-40ca-9f99-947a4b820de9",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Calamity's Chill (status 3822) on me: Freezing Up (3523, 2 s move check) starts when it runs out.\n-- Adds my own CasterDowntime [expiry, expiry + 2] (short Chill 29 s or long 91 s). Polled OnUpdate: no\n-- self.used until the window is placed, then it stops polling.\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal s = V.get()\nif s and V.chill(s) then self.used = true end\n",
							name = "Freezing Up (fire Calamity's Chill)",
							uuid = "0d31f301-be73-88de-94c2-a453dc165207",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 54.8,
				name = "[AutoSim] Valigarmanda EX - Freezing Up (fire Calamity's Chill)",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 6,
				timerEndOffset = 14,
				timerStartOffset = 0.5,
				uuid = "08ec8acd-f4f7-8596-a4e8-326a626d0981",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Motion",
				uuid = "efcd4e56-9c0a-b89f-a2af-9ce2267e5d07",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"6e111fe3-68a7-b074-ac04-447fe74c395e",
									true,
								},
							},
							name = "Force slidecast (Chill)",
							uuid = "334d169a-3e09-4791-9c13-14ed45cfdd46",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"f1facf3f-88fa-27d1-a75d-2e8b560b69ec",
									true,
								},
							},
							name = "Force slidecast (Freezing Up)",
							uuid = "7c32810d-050b-e9c0-b94c-3f195bd46a18",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"1562f4f5-a338-1d07-b344-3f2c6a90e283",
									true,
								},
							},
							name = "Jump (Chill <= 1.5 s)",
							uuid = "d7616916-35b5-7f14-a5de-5f99c5b899a6",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"f1facf3f-88fa-27d1-a75d-2e8b560b69ec",
									true,
								},
							},
							name = "Jump (Freezing Up)",
							uuid = "ef851295-1e66-0eab-a63b-bcbd0da4d3bd",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Chill and Freezing Up are gone: release the forced slidecast this reaction set.\nif data.valxSlide then\n  TensorDrift_SlidecastForceHold = false\n  data.valxSlide = nil\nend",
							conditions = 
							{
								
								{
									"6e111fe3-68a7-b074-ac04-447fe74c395e",
									false,
								},
								
								{
									"f1facf3f-88fa-27d1-a75d-2e8b560b69ec",
									false,
								},
							},
							name = "End slidecast",
							uuid = "814d113a-c623-d18a-abe1-ee3c474eb52b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 3,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 3 s",
							uuid = "6e111fe3-68a7-b074-ac04-447fe74c395e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 1.5,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 1.5 s",
							uuid = "1562f4f5-a338-1d07-b344-3f2c6a90e283",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 3523,
							category = "Self",
							name = "Freezing Up",
							uuid = "f1facf3f-88fa-27d1-a75d-2e8b560b69ec",
							version = 3,
						},
					},
				},
				displayPath = "Motion",
				loop = true,
				mechanicTime = 54.8,
				name = "[Motion] Valigarmanda - Calamity's Chill / Freezing Up: jump + slidecast",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 6,
				timerEndOffset = 100,
				timerStartOffset = 15,
				uuid = "439c3949-fc0e-cc10-8d49-4e1d81538150",
				version = 2,
			},
		},
	},
	[7] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "0d38cd8d-8d63-37f0-bccb-07db1c3a4e57",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnMapEffect): Spikesicle line order, erupting volcano, avalanche half.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal i = eventArgs.a1\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nif i >= 4 and i <= 13 then\n  local s = spGet(V, now)\n  for _, m in ipairs(s.me) do\n    if m.i == i then return end\n  end\n  s.me[#s.me + 1] = {i = i, t = now}\n  s.plan = nil\nelseif i == 14 or i == 15 then\n  V.vol = {i = i, t = now}\nelseif i == 3 then\n  V.aval = {ne = (eventArgs.a2 == 16), t = now}\n  if V.sp then V.sp.plan = nil end\nend\n",
							conditions = 
							{
								
								{
									"5022ef38-e3ed-7cdc-a145-f4f89c2c75b0",
									true,
								},
							},
							name = "Capture",
							uuid = "5aa49f91-b1dc-3ca1-8634-a0850b0aa96f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnMapEffect, Dequeue Action if False = on).\n-- 4..13 state 0x00020004 = Spikesicle lines (BossmodReborn Spikesicle.cs:22); 14/15 state 0x00200010 = volcano\n-- eruption (VolcanicDrop.cs:18-21); 3 state 0x00200010 / 0x00020001 = avalanche half (NorthernCross.cs, cactbot :710-718).\nlocal a1, a2, a3 = eventArgs.a1, eventArgs.a2, eventArgs.a3\nif a1 >= 4 and a1 <= 13 then return a2 == 4 and a3 == 2 end\nif a1 == 14 or a1 == 15 then return a2 == 16 and a3 == 32 end\nif a1 == 3 then return (a2 == 16 and a3 == 32) or (a2 == 1 and a3 == 2) end\nreturn false\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "5022ef38-e3ed-7cdc-a145-f4f89c2c75b0",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 14,
				loop = true,
				mechanicTime = 62.9,
				name = "[Draw] Valigarmanda - Volcanic Drop role spot (capture map effects)",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -10,
				uuid = "0b253440-3c4d-cf63-96f4-b38b2e33e3a0",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Volcanic Drop role spot. Map effect 14 = east volcano erupts (r20 at (113,100)) -> west\n-- column; 15 = west volcano (87,100) -> east column (VolcanicDrop.cs:18-21; cactbot :154-159). Spots: strat 75.webp.\nlocal WESTCOL = {T1 = {88.3, 91.0}, T2 = {82.7, 90.4}, H1 = {86.4, 106.4}, H2 = {83.2, 106.4}, M1 = {82.7, 103.0}, M2 = {89.6, 95.2}, R1 = {88.2, 102.2}, R2 = {85.4, 103.9}}\nlocal EASTCOL = {T1 = {111.7, 91.0}, T2 = {117.3, 90.4}, H1 = {113.6, 106.4}, H2 = {116.8, 106.4}, M1 = {117.3, 103.0}, M2 = {110.4, 95.2}, R1 = {111.8, 102.2}, R2 = {114.6, 103.9}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal v = V and V.vol\nif not v or Now() - v.t > 12000 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal T = (v.i == 14) and WESTCOL or EASTCOL\nlocal p = T[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "bee043e1-6713-777f-869a-28049adcbb50",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 62.9,
				name = "[Draw] Valigarmanda - Volcanic Drop role spot",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 1,
				timerStartOffset = -9,
				uuid = "856e6ada-8a9e-cde9-af85-9c68d3605a9d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Volcanic Drop puddle countdown: a countdown on each puddle (36836, r2) until it bursts.\n-- OnAOECreate gives the puddle spot; it bursts about 2.5 s later (2.47-2.55 s in the 2026-11-13 clear), same style as the Arkveld puddle timers.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not (e and e.x and e.z) then return end\nif not (AnyoneCore and AnyoneCore.addWorldTextCountdown) then return end\nlocal ms = math.floor(((e.duration or 2.2) + 0.3) * 1000)\npcall(AnyoneCore.addWorldTextCountdown, ms, {x = e.x, y = (e.y or 0) + 0.1, z = e.z}, 0xFF2288FF, true, 1.3)\n",
							conditions = 
							{
								
								{
									"c6006875-dda0-5f32-b3a7-942031fe23be",
									true,
								},
							},
							name = "Countdown",
							uuid = "e113c228-6916-1961-a998-fdc35c85180d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- Volcanic Drop puddle (36836) only. Dequeue Action if False = on.\nreturn eventArgs.aoeID == 36836\n",
							dequeueIfLuaFalse = true,
							name = "puddle 36836",
							uuid = "c6006875-dda0-5f32-b3a7-942031fe23be",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 62.9,
				name = "[Draw] Valigarmanda - Volcanic Drop puddle countdown",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 7,
				timerStartOffset = -2,
				uuid = "f9e0cd8e-92d4-543c-aa06-6801d589d735",
				version = 2,
			},
		},
	},
	[8] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "91cd623f-6660-64c1-b810-4e1f3798670b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Slithering Strike (36809 storm / 36810 ice / 36811 fire; the corner pick is random):\n-- MeleeDowntime begincast +5.0..+8.5 (FFLogs, 14 melee samples). Susurrant Breath / Strangling Coil add nothing.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.SLITHER[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.slither(s, e.spellID, t)\n",
							name = "Slithering Strike melee downtime (fire 1)",
							uuid = "b76259fb-770c-9026-8b09-c44e2acd363a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 76.3,
				name = "[AutoSim] Valigarmanda EX - Slithering Strike melee downtime (fire 1)",
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = -1,
				timerStartOffset = -13,
				uuid = "a393d8f3-5a9c-334f-967a-b0bb955bf541",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "051170f1-2876-933e-8b63-930438c991f9",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"c02dfae2-2e9c-6f64-bf2f-521f15e54b29",
									true,
								},
							},
							name = "Capture",
							uuid = "08de64bb-926a-4c9e-9450-3a4b87fe5b29",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "c02dfae2-2e9c-6f64-bf2f-521f15e54b29",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 76.3,
				name = "[Draw] Valigarmanda - Partners role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 8,
				timerStartOffset = -9.5,
				uuid = "d34aac5b-696e-35fb-9de5-1352af502b70",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"14c08ee7-32a1-9244-a933-8f6e4ab578d2",
									true,
								},
							},
							name = "Capture",
							uuid = "f2346a70-3d45-bbe9-aac6-530f2ff8034d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "14c08ee7-32a1-9244-a933-8f6e4ab578d2",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 76.3,
				name = "[Draw] Valigarmanda - Partners role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "4dcaf7c9-254d-f662-ba63-e9cc9c3fa609",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Partners role spot (fire phase: stance + Charring Cataclysm partner stacks, strat 73.webp).\n-- Stance from the boss/helper cast start (cone 36807/36808, out 36811/36812, donut 36815/36816; Stance.cs).\n-- Pairs MT+M1, OT+M2, H1+R1, H2+R2. Hidden once Charring Cataclysm (36804) resolves.\nlocal SPOTS = {\n  cone = {T1 = {86.4, 86.6}, T2 = {112.5, 86.6}, H1 = {81.9, 91.1}, H2 = {118.1, 91.1}, M1 = {87.5, 86.6}, M2 = {113.6, 86.6}, R1 = {80.9, 92.4}, R2 = {119.1, 92.4}},\n  out = {T1 = {94.6, 110.5}, T2 = {103.3, 110.5}, H1 = {84.0, 107.0}, H2 = {113.4, 107.2}, M1 = {96.1, 110.5}, M2 = {104.7, 110.5}, R1 = {82.6, 106.4}, R2 = {114.8, 107.2}},\n  donut = {T1 = {95.3, 97.7}, T2 = {103.5, 97.7}, H1 = {95.6, 105.4}, H2 = {103.2, 105.4}, M1 = {96.5, 97.7}, M2 = {104.7, 97.7}, R1 = {96.8, 105.4}, R2 = {104.4, 105.4}}\n}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal st = V and V.st\nlocal now = Now()\nif not st or now - st.t > 9000 or (st.done and now - st.done > 300) then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = SPOTS[st.k] and SPOTS[st.k][slot]\nif p then vxSpot(p[1], p[2]) end\n",
							name = "Draw",
							uuid = "2ce47367-2370-ab8a-9a07-e5f8270e7227",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 76.3,
				name = "[Draw] Valigarmanda - Partners role spot",
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = 1.5,
				timerStartOffset = -7.5,
				uuid = "bba9dab3-0f51-1519-b05e-88ecb5044ea2",
				version = 2,
			},
		},
	},
	[10] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "60c98663-7217-9684-be2c-983e95379813",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"3e1c641b-833a-8e89-99b7-e4add8098ee1",
									true,
								},
							},
							name = "Capture",
							uuid = "8d112bff-f1bb-771b-a14c-404a8251c662",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "3e1c641b-833a-8e89-99b7-e4add8098ee1",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 92.3,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 1,
				timerStartOffset = -5,
				uuid = "5d37231d-92dc-b534-b13b-16f455fad513",
				version = 2,
			},
		},
	},
	[11] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "fcaaa77f-6544-9fc7-9bf6-c4cc338d789d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"64b7c084-e899-48f6-8a3b-56d290ecfc10",
									true,
								},
							},
							name = "Capture",
							uuid = "3fd9fd99-7a2e-87d3-b0ae-46c6bb07e9f1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "64b7c084-e899-48f6-8a3b-56d290ecfc10",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 97.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 11,
				timerStartOffset = -4.5,
				uuid = "88797f95-f5fa-e248-99c0-407c3ea2f198",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"836885ac-cf87-de3f-9294-9c129b49379d",
									true,
								},
							},
							name = "Capture",
							uuid = "6742eb15-bbd8-8b77-9c5a-5fd616272d5c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "836885ac-cf87-de3f-9294-9c129b49379d",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 97.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 11,
				timerStartOffset = -4.5,
				uuid = "c5397ae5-ece9-e12b-b63e-84312d2d6306",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"e0b90375-7fec-2587-b306-ddc6a77f1f27",
									true,
								},
							},
							name = "Capture",
							uuid = "f5de8c57-b2a0-8fcb-9467-fc4a9c894d58",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "e0b90375-7fec-2587-b306-ddc6a77f1f27",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 97.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "af8d80d3-1664-e1bd-b798-c911622b14f3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "f02a60b6-102c-8783-9858-aba8fbf17dfa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 97.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "8accbcac-f74e-ad8a-959a-e6bfb5494883",
				version = 2,
			},
		},
	},
	[12] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "4941a8d1-abf1-52e1-9eb7-e8a357da2a3f",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"b74c8abd-c2ed-09ef-834a-6e0d2832844d",
									true,
								},
							},
							name = "Capture",
							uuid = "7ed6394e-375b-73ca-b43d-1470ba661c0e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "b74c8abd-c2ed-09ef-834a-6e0d2832844d",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 102.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 12,
				timerStartOffset = -4.5,
				uuid = "1e86b185-4db2-51df-adf8-92e76627e20b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"a732056f-6c37-6ff9-a515-1e1f2e7340ee",
									true,
								},
							},
							name = "Capture",
							uuid = "180eea83-85d9-66b8-9287-71b6dce40d2f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "a732056f-6c37-6ff9-a515-1e1f2e7340ee",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 102.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 12,
				timerStartOffset = -4.5,
				uuid = "50d46ad2-9dbb-c641-8f5a-c192371f2dc0",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"0063d9b2-8202-709e-9bde-c88b1cc6c6d9",
									true,
								},
							},
							name = "Capture",
							uuid = "144f063c-3ff8-099e-b0b5-82759f38c29a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "0063d9b2-8202-709e-9bde-c88b1cc6c6d9",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 102.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "c7f62eab-b792-e8de-9a1c-23781dc9abe0",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "7f141b29-962f-51d6-a0ee-2c0a6c99488a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 102.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "16054932-640e-cb53-a3ae-e6c77a7ade8e",
				version = 2,
			},
		},
	},
	[13] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "21fb0940-cd76-a199-8f47-f2cccd3d7f65",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"4ec2b883-5ae0-1fe0-8040-670e44809fb9",
									true,
								},
							},
							name = "Capture",
							uuid = "b0f8caad-4332-de7b-95a3-e7d6dd5aa195",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "4ec2b883-5ae0-1fe0-8040-670e44809fb9",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 107.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 13,
				timerStartOffset = -4.5,
				uuid = "67038670-d54d-f570-8fdc-b64bebface17",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"7b4d14fd-692a-3e87-851f-34f96bb40959",
									true,
								},
							},
							name = "Capture",
							uuid = "34e539e5-5591-6668-8252-f897e34c018d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "7b4d14fd-692a-3e87-851f-34f96bb40959",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 107.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 13,
				timerStartOffset = -4.5,
				uuid = "e16501b5-2d7a-00ea-8729-9957b16befe8",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"04d6a23b-68f8-9724-a06f-557f7065d5ef",
									true,
								},
							},
							name = "Capture",
							uuid = "5b6b5f2f-0d16-d6ae-8b67-0eee0167482b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "04d6a23b-68f8-9724-a06f-557f7065d5ef",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 107.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "c65cb989-2540-c55b-b8ac-944bbc87e1b6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "c1f6b578-a5e8-332c-a0b1-3b06169b8bc5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 107.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "6e2f037f-9dd1-0aa9-aa55-1ab7748dec35",
				version = 2,
			},
		},
	},
	[14] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "2f403620-c4a1-90ed-9b65-fd3c69e78a6f",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"e1002c1a-7da1-d93f-aa07-e9b3d48d52b5",
									true,
								},
							},
							name = "Capture",
							uuid = "faf51bb4-2903-8442-acda-7a3aab6c704f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "e1002c1a-7da1-d93f-aa07-e9b3d48d52b5",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 112.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 14,
				timerStartOffset = -4.5,
				uuid = "463e54b9-e2d2-e88c-9167-b68c532ba784",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"c6eab0cc-4fba-1e4b-96ef-b50c45450d43",
									true,
								},
							},
							name = "Capture",
							uuid = "3b08a75e-f2b6-e038-9a3a-eba1c02bc678",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "c6eab0cc-4fba-1e4b-96ef-b50c45450d43",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 112.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 14,
				timerStartOffset = -4.5,
				uuid = "c7e4b3ff-1fcd-a949-87d7-591e7434a56f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"f4854b40-45da-702d-8225-7efbf3068906",
									true,
								},
							},
							name = "Capture",
							uuid = "3aa74a44-454d-fe48-8304-194b3227f569",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "f4854b40-45da-702d-8225-7efbf3068906",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 112.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "a852ef45-c7c8-0a00-b74f-624d156176fb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "68028c06-2a9d-2610-96b4-acc530441fd1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 112.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "a1d3e00f-39d0-11e3-a02e-8b2bd89c3836",
				version = 2,
			},
		},
	},
	[15] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "3ec87f8b-7738-1701-8b5d-103cf3523364",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"96c06d1b-2340-e921-aec4-ff170874f89b",
									true,
								},
							},
							name = "Capture",
							uuid = "d36ba5ee-c8e7-32d8-9152-9a36e38a9b08",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "96c06d1b-2340-e921-aec4-ff170874f89b",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 117.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 15,
				timerStartOffset = -4.5,
				uuid = "0d701a5f-ec6f-eb97-adca-2cc3a8379682",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"618740dd-e869-a688-9e96-d78b96e06359",
									true,
								},
							},
							name = "Capture",
							uuid = "222bcb29-dba3-4ef3-bee7-ae9198b7f685",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "618740dd-e869-a688-9e96-d78b96e06359",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 117.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 15,
				timerStartOffset = -4.5,
				uuid = "db78b4de-c73d-f742-8839-a86fc6363518",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"781476d2-e033-5a44-8d82-7b71d2f2522b",
									true,
								},
							},
							name = "Capture",
							uuid = "324dfbcb-171c-a953-90b6-b00bd0d035c8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "781476d2-e033-5a44-8d82-7b71d2f2522b",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 117.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 15,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "3d079133-41d3-7c7d-81d2-65a8590e2789",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "4a393baf-eeef-4d9e-9467-761f2c2d82f5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 117.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 15,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "290a405d-af17-8ec6-a23a-3d17454e4e87",
				version = 2,
			},
		},
	},
	[16] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "c8a64fb4-e9eb-aaad-9233-7a81c6dc26d5",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"341e080a-2c8f-8183-a0fa-c70c191ac743",
									true,
								},
							},
							name = "Capture",
							uuid = "5bff24de-6f23-e265-96be-21a3627bb1f3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "341e080a-2c8f-8183-a0fa-c70c191ac743",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 122.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 16,
				timerStartOffset = -4.5,
				uuid = "83810984-a272-ae97-9c8e-b4e36ef78d14",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"4d2fd2df-5e18-5a8a-aaed-58eaf58f680f",
									true,
								},
							},
							name = "Capture",
							uuid = "cf825848-b064-e37a-a017-084be484a7b1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "4d2fd2df-5e18-5a8a-aaed-58eaf58f680f",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 122.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 16,
				timerStartOffset = -4.5,
				uuid = "df6cdb83-3f01-9bab-a7d0-e88e322ecea2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"9029c235-c3aa-fa3a-b81b-5b2b67f369d1",
									true,
								},
							},
							name = "Capture",
							uuid = "7a548614-54b8-2323-b29e-6fabbc888fe9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "9029c235-c3aa-fa3a-b81b-5b2b67f369d1",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 122.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "c60a7124-474d-f7c2-8e91-2fe6ff2a8584",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "fa750578-7238-61ea-92d3-c3be34f8dd5a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 122.8,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "61231aa7-ce60-0521-afdf-201c23ac647b",
				version = 2,
			},
		},
	},
	[17] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "be12c2db-7078-74ad-8012-bbffd483eec7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Scourge of Fire x3 movement: CasterDowntime Mountain Fire begincast 1 (36876) +44.6..+51.8\n-- (FFLogs abs 134.8-142.0, 137 Black Mages).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 36876) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.anchor(s, 36876, t)\n",
							name = "Scourge of Fire movement",
							uuid = "350daf52-4104-c9a0-8ec3-01f6149d5f70",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 131.8,
				name = "[AutoSim] Valigarmanda EX - Scourge of Fire movement",
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = -38,
				timerStartOffset = -48,
				uuid = "d5a940df-547b-d965-b325-bffbf3f09e44",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "7e8bdc92-e277-e21c-9648-b1fbd13aac74",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"6e245a2d-e726-d673-a755-b4359628214a",
									true,
								},
							},
							name = "Capture",
							uuid = "6b69bbf4-b4c4-ba34-816c-009aa711ed3c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "6e245a2d-e726-d673-a755-b4359628214a",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 131.8,
				name = "[Draw] Valigarmanda - Scourge of Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = 9,
				timerStartOffset = -2,
				uuid = "667fc6aa-1c10-b638-8aa0-df2b7071728f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Scourge of Fire role spot (fire phase, 3 light-party stacks that leave r6 puddles).\n-- Light parties stack on C (G1) / D (G2) and walk forward one step per hit, then step out sideways\n-- (strat 76.webp; FireScourgeOfFire 36847 x3, Triscourge.cs). Hit count from the 36847 resolves.\nlocal SPOTS = {[1] = {T1 = {95.5, 106.8}, T2 = {104.0, 106.8}, H1 = {95.5, 106.8}, H2 = {104.0, 106.8}, M1 = {95.5, 106.8}, M2 = {104.0, 106.8}, R1 = {95.5, 106.8}, R2 = {104.0, 106.8}}, [2] = {T1 = {95.5, 99.3}, T2 = {104.0, 99.3}, H1 = {95.5, 99.3}, H2 = {104.0, 99.3}, M1 = {95.5, 99.3}, M2 = {104.0, 99.3}, R1 = {95.5, 99.3}, R2 = {104.0, 99.3}}, [3] = {T1 = {95.5, 91.8}, T2 = {104.0, 91.8}, H1 = {95.5, 91.8}, H2 = {104.0, 91.8}, M1 = {95.5, 91.8}, M2 = {104.0, 91.8}, R1 = {95.5, 91.8}, R2 = {104.0, 91.8}}, after = {T1 = {89.0, 91.8}, T2 = {110.5, 91.8}, H1 = {89.0, 91.8}, H2 = {110.5, 91.8}, M1 = {89.0, 91.8}, M2 = {110.5, 91.8}, R1 = {89.0, 91.8}, R2 = {110.5, 91.8}}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal f = V and V.sof\nlocal now = Now()\nlocal n = (f and now - f.t < 10000) and f.n or 0\nlocal slot = vxSlot()\nif not slot then return end\nlocal p\nif n >= 3 then\n  if now - f.t > 2500 then return end\n  p = SPOTS.after[slot]\nelse\n  p = SPOTS[n + 1][slot]\nend\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "6a67efef-1a6e-dbaa-be5f-c89d7bf9fd9c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 131.8,
				name = "[Draw] Valigarmanda - Scourge of Fire role spot",
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = 9,
				timerStartOffset = -6,
				uuid = "d72ef63d-2bdf-aa76-b94f-82124db96d23",
				version = 2,
			},
		},
	},
	[20] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "a478c859-dc88-e5e3-a075-b69ab9161bf7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnMapEffect): Spikesicle line order, erupting volcano, avalanche half.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal i = eventArgs.a1\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nif i >= 4 and i <= 13 then\n  local s = spGet(V, now)\n  for _, m in ipairs(s.me) do\n    if m.i == i then return end\n  end\n  s.me[#s.me + 1] = {i = i, t = now}\n  s.plan = nil\nelseif i == 14 or i == 15 then\n  V.vol = {i = i, t = now}\nelseif i == 3 then\n  V.aval = {ne = (eventArgs.a2 == 16), t = now}\n  if V.sp then V.sp.plan = nil end\nend\n",
							conditions = 
							{
								
								{
									"54b63161-b5b7-b74d-a073-4861b622bd33",
									true,
								},
							},
							name = "Capture",
							uuid = "b12fad8d-c4d0-0022-962d-da67d9c60d33",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnMapEffect, Dequeue Action if False = on).\n-- 4..13 state 0x00020004 = Spikesicle lines (BossmodReborn Spikesicle.cs:22); 14/15 state 0x00200010 = volcano\n-- eruption (VolcanicDrop.cs:18-21); 3 state 0x00200010 / 0x00020001 = avalanche half (NorthernCross.cs, cactbot :710-718).\nlocal a1, a2, a3 = eventArgs.a1, eventArgs.a2, eventArgs.a3\nif a1 >= 4 and a1 <= 13 then return a2 == 4 and a3 == 2 end\nif a1 == 14 or a1 == 15 then return a2 == 16 and a3 == 32 end\nif a1 == 3 then return (a2 == 16 and a3 == 32) or (a2 == 1 and a3 == 2) end\nreturn false\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "54b63161-b5b7-b74d-a073-4861b622bd33",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 14,
				loop = true,
				mechanicTime = 155.6,
				name = "[Draw] Valigarmanda - Volcanic Drop role spot (capture map effects)",
				timeRange = true,
				timelineIndex = 20,
				timerStartOffset = -10,
				uuid = "f19c1fbb-00f6-f579-aba3-cfd4e7550ad7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Volcanic Drop role spot. Map effect 14 = east volcano erupts (r20 at (113,100)) -> west\n-- column; 15 = west volcano (87,100) -> east column (VolcanicDrop.cs:18-21; cactbot :154-159). Spots: strat 75.webp.\nlocal WESTCOL = {T1 = {88.3, 91.0}, T2 = {82.7, 90.4}, H1 = {86.4, 106.4}, H2 = {83.2, 106.4}, M1 = {82.7, 103.0}, M2 = {89.6, 95.2}, R1 = {88.2, 102.2}, R2 = {85.4, 103.9}}\nlocal EASTCOL = {T1 = {111.7, 91.0}, T2 = {117.3, 90.4}, H1 = {113.6, 106.4}, H2 = {116.8, 106.4}, M1 = {117.3, 103.0}, M2 = {110.4, 95.2}, R1 = {111.8, 102.2}, R2 = {114.6, 103.9}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal v = V and V.vol\nif not v or Now() - v.t > 12000 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal T = (v.i == 14) and WESTCOL or EASTCOL\nlocal p = T[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "b95a9bf5-3cd9-2a8c-96c3-cbd4d357d11b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 155.6,
				name = "[Draw] Valigarmanda - Volcanic Drop role spot",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 1,
				timerStartOffset = -9,
				uuid = "baae253e-a8f6-d2c1-b97b-1f285586b35c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Volcanic Drop puddle countdown: a countdown on each puddle (36836, r2) until it bursts.\n-- OnAOECreate gives the puddle spot; it bursts about 2.5 s later (2.47-2.55 s in the 2026-11-13 clear), same style as the Arkveld puddle timers.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not (e and e.x and e.z) then return end\nif not (AnyoneCore and AnyoneCore.addWorldTextCountdown) then return end\nlocal ms = math.floor(((e.duration or 2.2) + 0.3) * 1000)\npcall(AnyoneCore.addWorldTextCountdown, ms, {x = e.x, y = (e.y or 0) + 0.1, z = e.z}, 0xFF2288FF, true, 1.3)\n",
							conditions = 
							{
								
								{
									"13296793-cf10-4aa4-9a64-b18dd316048d",
									true,
								},
							},
							name = "Countdown",
							uuid = "4eded8db-edaf-bd3b-9604-cfad1399063b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- Volcanic Drop puddle (36836) only. Dequeue Action if False = on.\nreturn eventArgs.aoeID == 36836\n",
							dequeueIfLuaFalse = true,
							name = "puddle 36836",
							uuid = "13296793-cf10-4aa4-9a64-b18dd316048d",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 155.6,
				name = "[Draw] Valigarmanda - Volcanic Drop puddle countdown",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 7,
				timerStartOffset = -2,
				uuid = "b1fa5d50-716e-aab9-a59e-5173a5969ec2",
				version = 2,
			},
		},
	},
	[21] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "3746425d-a480-820c-bb71-4ab0e3c6f7cb",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Slithering Strike (36809 storm / 36810 ice / 36811 fire; the corner pick is random):\n-- MeleeDowntime begincast +5.0..+8.5 (FFLogs, 14 melee samples). Susurrant Breath / Strangling Coil add nothing.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.SLITHER[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.slither(s, e.spellID, t)\n",
							name = "Slithering Strike melee downtime (fire 2)",
							uuid = "cc0b4c6a-08ef-264b-8307-fff0f8099e9e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 167.1,
				name = "[AutoSim] Valigarmanda EX - Slithering Strike melee downtime (fire 2)",
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = -1,
				timerStartOffset = -13,
				uuid = "f30c4674-c3f1-3f9a-9eda-fa978f436557",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "5e66a21b-569a-93aa-aebd-7adb8061892b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"5c05e343-65a9-de96-9f95-20932fd12f79",
									true,
								},
							},
							name = "Capture",
							uuid = "bbaa617c-beaa-5162-bdb2-1c16b2854c57",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "5c05e343-65a9-de96-9f95-20932fd12f79",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 167.1,
				name = "[Draw] Valigarmanda - Partners role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 21,
				timerStartOffset = -9.5,
				uuid = "43383b94-f246-00a7-9af7-45af666f7d6b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"776fd6bd-adc3-df26-99ef-a42f80ae2aec",
									true,
								},
							},
							name = "Capture",
							uuid = "878bf8a0-3a93-2737-9fac-89ddc5e903ae",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "776fd6bd-adc3-df26-99ef-a42f80ae2aec",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 167.1,
				name = "[Draw] Valigarmanda - Partners role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "029f032a-a3cd-c192-8a13-c152aef2b295",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Partners role spot (fire phase: stance + Charring Cataclysm partner stacks, strat 73.webp).\n-- Stance from the boss/helper cast start (cone 36807/36808, out 36811/36812, donut 36815/36816; Stance.cs).\n-- Pairs MT+M1, OT+M2, H1+R1, H2+R2. Hidden once Charring Cataclysm (36804) resolves.\nlocal SPOTS = {\n  cone = {T1 = {86.4, 86.6}, T2 = {112.5, 86.6}, H1 = {81.9, 91.1}, H2 = {118.1, 91.1}, M1 = {87.5, 86.6}, M2 = {113.6, 86.6}, R1 = {80.9, 92.4}, R2 = {119.1, 92.4}},\n  out = {T1 = {94.6, 110.5}, T2 = {103.3, 110.5}, H1 = {84.0, 107.0}, H2 = {113.4, 107.2}, M1 = {96.1, 110.5}, M2 = {104.7, 110.5}, R1 = {82.6, 106.4}, R2 = {114.8, 107.2}},\n  donut = {T1 = {95.3, 97.7}, T2 = {103.5, 97.7}, H1 = {95.6, 105.4}, H2 = {103.2, 105.4}, M1 = {96.5, 97.7}, M2 = {104.7, 97.7}, R1 = {96.8, 105.4}, R2 = {104.4, 105.4}}\n}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal st = V and V.st\nlocal now = Now()\nif not st or now - st.t > 9000 or (st.done and now - st.done > 300) then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = SPOTS[st.k] and SPOTS[st.k][slot]\nif p then vxSpot(p[1], p[2]) end\n",
							name = "Draw",
							uuid = "d157c280-18ea-a6a6-b937-d7a5fd24b3c1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 167.1,
				name = "[Draw] Valigarmanda - Partners role spot",
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = 1.5,
				timerStartOffset = -7.5,
				uuid = "639813c8-e656-0825-a9ea-0085018d75dc",
				version = 2,
			},
		},
	},
	[25] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "54088b14-8e30-b5d9-a983-28d5bf3f519b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Ruin Foretold (38546 begincast): Valigarmanda leaves at +5.9, Beacons targetable at +7.0.\n-- FullDowntime +5.9..+7.0, CasterDowntime +5.6..+6.8, Beacon-phase 0.8 from +5.9, return/kill re-timed.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 38546) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.ruin(s, t)\n",
							name = "Ruin Foretold / Beacons",
							uuid = "427a0ee0-f351-eff4-83c6-48209352259a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 195,
				name = "[AutoSim] Valigarmanda EX - Ruin Foretold / Beacons",
				timeRange = true,
				timelineIndex = 25,
				timerStartOffset = -10,
				uuid = "4ed63c0d-5c48-901c-927e-5e3dc242ffb2",
				version = 2,
			},
		},
	},
	[28] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "8b35b6e3-12b6-87a3-b60a-069992b4c1e2",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Beacon phase casts: each Calamitous Cry (36866 first / 36867 rest) pushes the predicted return to\n-- the next 6.05 s slot; Beacons-dead visual (38245/38246/38247) = boss back; return cast 38323 re-times the kill\n-- (kill = 38323 + 75.8).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif not (sp == 36866 or sp == 36867 or sp == 38245 or sp == 38246 or sp == 38247 or sp == 38323) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nif t < 150 then return end\nif sp == 36866 or sp == 36867 then\n  V.cry(s, t)\nelseif sp == 38323 then\n  V.ret(s, t)\nelse\n  V.back(s, t - 0.1)\nend\n",
							name = "Beacon phase Cry / return sync",
							uuid = "1c2c8c8d-a2fe-a793-bb14-dbdc904e5cab",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 2,
				loop = true,
				mechanicTime = 204.2,
				name = "[AutoSim] Valigarmanda EX - Beacon phase Cry / return sync",
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 45,
				timerStartOffset = -8,
				uuid = "3ea32a60-31b8-1fc6-b21e-b23c865ce960",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Valigarmanda targetable again after the Beacons: end the 0.8 weighting and the return gap here.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.isTargetable and e.entityContentID == 12854) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nif t > 150 then V.back(s, t) end\n",
							name = "Valigarmanda targetable (return)",
							uuid = "9d3cdc17-c06f-c218-bce7-87a179e09da5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 26,
				loop = true,
				mechanicTime = 204.2,
				name = "[AutoSim] Valigarmanda EX - Valigarmanda targetable (return)",
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 45,
				timerStartOffset = -8,
				uuid = "112cc3db-e0f1-8272-8928-cfcf678194ce",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Tulidisaster begincast (36872, 2.1-2.8 s after 38323): return/kill fallback if 38323 was missed.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 36872) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nif t > 150 then V.ret(s, t - 2.45) end\n",
							name = "Tulidisaster return fallback (adds loop)",
							uuid = "1113390c-9521-d7c9-9885-ebb52fd86112",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 204.2,
				name = "[AutoSim] Valigarmanda EX - Tulidisaster return fallback (adds loop)",
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 45,
				timerStartOffset = -8,
				uuid = "ac2d22ed-bd13-fda0-8261-2fd77821163a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "c7a38b4b-287d-e6d1-8b5b-8cebb991daed",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"414ee1bc-bc3b-e1d1-9f6f-adc9b4fdd9db",
									true,
								},
							},
							name = "Capture",
							uuid = "5c20ea36-8283-0dd7-bf47-9c8908141219",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "414ee1bc-bc3b-e1d1-9f6f-adc9b4fdd9db",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 204.2,
				name = "[Draw] Valigarmanda - Calamitous Cry role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 40,
				timerStartOffset = -6,
				uuid = "0ea6d410-e9b7-c907-95f0-2a918cfa0ec3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Calamitous Cry role spot (Beacon adds). G1 left / G2 right, lined up from the boss with the\n-- tank in front for the wild-charge line stack (2 wild charges per Cry, 80 x 6, Beacons.cs:20-50). EX casts 5\n-- Calamitous Echo cones (40 y, 10 deg half-angle, Beacons.cs:53) every Cry (FFLogs: 5 x 36870 per Cry in all 9\n-- logs; normal mode casts 4/3, so its headings do not apply). The strat card (77.png) shows the EX cones centred\n-- ~-79/-43/-9/+28/+61 deg off south; G1 stands on the -61 deg ray and G2 on the +44.5 deg ray (centres of the two\n-- gaps the card's groups use). Distances along the ray follow the strat order (tank in front).\nlocal SPOTS = {T1 = {92.57, 89.12}, T2 = {105.96, 91.06}, H1 = {87.32, 92.03}, H2 = {110.16, 95.34}, M1 = {90.82, 90.09}, M2 = {107.36, 92.49}, R1 = {89.07, 91.06}, R2 = {108.76, 93.92}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nif V and V.ret and Now() - V.ret < 60000 then return end\nlocal slot = vxSlot()\nif not slot then return end\n-- Arrow to your side only until your group's beacon is dead: G1 = Flame-kissed Beacon (12858, left),\n-- G2 = Glacial Beacon (12859, right). Hidden for good once it has been seen and is gone or untargetable.\nlocal want = (slot:sub(2, 2) == \"1\") and 12858 or 12859\ndata.valxCry = data.valxCry or {}\nlocal st = data.valxCry\nif st[want] == \"dead\" then return end\nlocal alive = false\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif l then\n  for _, en in pairs(l) do\n    if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n    if type(en) == \"table\" and en.contentid == want and en.targetable and not (en.hp and en.hp.current and en.hp.current <= 0) then\n      alive = true\n      break\n    end\n  end\nend\nif alive then\n  st[want] = \"seen\"\nelseif st[want] == \"seen\" then\n  st[want] = \"dead\"\n  return\nend\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "68ce697b-2284-7436-824c-da7534370b80",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 204.2,
				name = "[Draw] Valigarmanda - Calamitous Cry role spot",
				timeRange = true,
				timelineIndex = 28,
				timerStartOffset = -5.9,
				uuid = "57ea1ab7-bf67-c352-8f59-5107499baccb",
				version = 2,
			},
		},
	},
	[29] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "bab084c0-e508-4761-b852-1b84659d86e5",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Calamitous Cry role spot (Beacon adds). G1 left / G2 right, lined up from the boss with the\n-- tank in front for the wild-charge line stack (2 wild charges per Cry, 80 x 6, Beacons.cs:20-50). EX casts 5\n-- Calamitous Echo cones (40 y, 10 deg half-angle, Beacons.cs:53) every Cry (FFLogs: 5 x 36870 per Cry in all 9\n-- logs; normal mode casts 4/3, so its headings do not apply). The strat card (77.png) shows the EX cones centred\n-- ~-79/-43/-9/+28/+61 deg off south; G1 stands on the -61 deg ray and G2 on the +44.5 deg ray (centres of the two\n-- gaps the card's groups use). Distances along the ray follow the strat order (tank in front).\nlocal SPOTS = {T1 = {92.57, 89.12}, T2 = {105.96, 91.06}, H1 = {87.32, 92.03}, H2 = {110.16, 95.34}, M1 = {90.82, 90.09}, M2 = {107.36, 92.49}, R1 = {89.07, 91.06}, R2 = {108.76, 93.92}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nif V and V.ret and Now() - V.ret < 60000 then return end\nlocal slot = vxSlot()\nif not slot then return end\n-- Arrow to your side only until your group's beacon is dead: G1 = Flame-kissed Beacon (12858, left),\n-- G2 = Glacial Beacon (12859, right). Hidden for good once it has been seen and is gone or untargetable.\nlocal want = (slot:sub(2, 2) == \"1\") and 12858 or 12859\ndata.valxCry = data.valxCry or {}\nlocal st = data.valxCry\nif st[want] == \"dead\" then return end\nlocal alive = false\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif l then\n  for _, en in pairs(l) do\n    if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n    if type(en) == \"table\" and en.contentid == want and en.targetable and not (en.hp and en.hp.current and en.hp.current <= 0) then\n      alive = true\n      break\n    end\n  end\nend\nif alive then\n  st[want] = \"seen\"\nelseif st[want] == \"seen\" then\n  st[want] = \"dead\"\n  return\nend\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "ebb8866b-eec2-50d2-9524-2c88cefbab19",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 210.2,
				name = "[Draw] Valigarmanda - Calamitous Cry role spot",
				timeRange = true,
				timelineIndex = 29,
				timerStartOffset = -5.9,
				uuid = "b84641f8-6be2-a058-a6c5-bc9704427cd0",
				version = 2,
			},
		},
	},
	[30] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "e12a5248-5609-1fd5-95b3-0a264d31b1bd",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Calamitous Cry role spot (Beacon adds). G1 left / G2 right, lined up from the boss with the\n-- tank in front for the wild-charge line stack (2 wild charges per Cry, 80 x 6, Beacons.cs:20-50). EX casts 5\n-- Calamitous Echo cones (40 y, 10 deg half-angle, Beacons.cs:53) every Cry (FFLogs: 5 x 36870 per Cry in all 9\n-- logs; normal mode casts 4/3, so its headings do not apply). The strat card (77.png) shows the EX cones centred\n-- ~-79/-43/-9/+28/+61 deg off south; G1 stands on the -61 deg ray and G2 on the +44.5 deg ray (centres of the two\n-- gaps the card's groups use). Distances along the ray follow the strat order (tank in front).\nlocal SPOTS = {T1 = {92.57, 89.12}, T2 = {105.96, 91.06}, H1 = {87.32, 92.03}, H2 = {110.16, 95.34}, M1 = {90.82, 90.09}, M2 = {107.36, 92.49}, R1 = {89.07, 91.06}, R2 = {108.76, 93.92}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nif V and V.ret and Now() - V.ret < 60000 then return end\nlocal slot = vxSlot()\nif not slot then return end\n-- Arrow to your side only until your group's beacon is dead: G1 = Flame-kissed Beacon (12858, left),\n-- G2 = Glacial Beacon (12859, right). Hidden for good once it has been seen and is gone or untargetable.\nlocal want = (slot:sub(2, 2) == \"1\") and 12858 or 12859\ndata.valxCry = data.valxCry or {}\nlocal st = data.valxCry\nif st[want] == \"dead\" then return end\nlocal alive = false\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif l then\n  for _, en in pairs(l) do\n    if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n    if type(en) == \"table\" and en.contentid == want and en.targetable and not (en.hp and en.hp.current and en.hp.current <= 0) then\n      alive = true\n      break\n    end\n  end\nend\nif alive then\n  st[want] = \"seen\"\nelseif st[want] == \"seen\" then\n  st[want] = \"dead\"\n  return\nend\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "3147b36e-c324-cd0f-8f25-7be1fec64933",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 216.2,
				name = "[Draw] Valigarmanda - Calamitous Cry role spot",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -5.9,
				uuid = "9f088fe0-9653-fcf7-9486-81cb2d5b58f2",
				version = 2,
			},
		},
	},
	[31] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "80f7cfc6-9f4f-1db5-8384-5fdaa5bee7a6",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Calamitous Cry role spot (Beacon adds). G1 left / G2 right, lined up from the boss with the\n-- tank in front for the wild-charge line stack (2 wild charges per Cry, 80 x 6, Beacons.cs:20-50). EX casts 5\n-- Calamitous Echo cones (40 y, 10 deg half-angle, Beacons.cs:53) every Cry (FFLogs: 5 x 36870 per Cry in all 9\n-- logs; normal mode casts 4/3, so its headings do not apply). The strat card (77.png) shows the EX cones centred\n-- ~-79/-43/-9/+28/+61 deg off south; G1 stands on the -61 deg ray and G2 on the +44.5 deg ray (centres of the two\n-- gaps the card's groups use). Distances along the ray follow the strat order (tank in front).\nlocal SPOTS = {T1 = {92.57, 89.12}, T2 = {105.96, 91.06}, H1 = {87.32, 92.03}, H2 = {110.16, 95.34}, M1 = {90.82, 90.09}, M2 = {107.36, 92.49}, R1 = {89.07, 91.06}, R2 = {108.76, 93.92}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nif V and V.ret and Now() - V.ret < 60000 then return end\nlocal slot = vxSlot()\nif not slot then return end\n-- Arrow to your side only until your group's beacon is dead: G1 = Flame-kissed Beacon (12858, left),\n-- G2 = Glacial Beacon (12859, right). Hidden for good once it has been seen and is gone or untargetable.\nlocal want = (slot:sub(2, 2) == \"1\") and 12858 or 12859\ndata.valxCry = data.valxCry or {}\nlocal st = data.valxCry\nif st[want] == \"dead\" then return end\nlocal alive = false\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif l then\n  for _, en in pairs(l) do\n    if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n    if type(en) == \"table\" and en.contentid == want and en.targetable and not (en.hp and en.hp.current and en.hp.current <= 0) then\n      alive = true\n      break\n    end\n  end\nend\nif alive then\n  st[want] = \"seen\"\nelseif st[want] == \"seen\" then\n  st[want] = \"dead\"\n  return\nend\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "aecca6f0-83c7-a9af-ba61-412f14be78b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 222.2,
				name = "[Draw] Valigarmanda - Calamitous Cry role spot",
				timeRange = true,
				timelineIndex = 31,
				timerStartOffset = -5.9,
				uuid = "21d97ea5-0872-7a0d-9b72-18800b55a83b",
				version = 2,
			},
		},
	},
	[32] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "1ba474e8-fedf-78ad-b78c-b8de41dca92b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Calamitous Cry role spot (Beacon adds). G1 left / G2 right, lined up from the boss with the\n-- tank in front for the wild-charge line stack (2 wild charges per Cry, 80 x 6, Beacons.cs:20-50). EX casts 5\n-- Calamitous Echo cones (40 y, 10 deg half-angle, Beacons.cs:53) every Cry (FFLogs: 5 x 36870 per Cry in all 9\n-- logs; normal mode casts 4/3, so its headings do not apply). The strat card (77.png) shows the EX cones centred\n-- ~-79/-43/-9/+28/+61 deg off south; G1 stands on the -61 deg ray and G2 on the +44.5 deg ray (centres of the two\n-- gaps the card's groups use). Distances along the ray follow the strat order (tank in front).\nlocal SPOTS = {T1 = {92.57, 89.12}, T2 = {105.96, 91.06}, H1 = {87.32, 92.03}, H2 = {110.16, 95.34}, M1 = {90.82, 90.09}, M2 = {107.36, 92.49}, R1 = {89.07, 91.06}, R2 = {108.76, 93.92}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nif V and V.ret and Now() - V.ret < 60000 then return end\nlocal slot = vxSlot()\nif not slot then return end\n-- Arrow to your side only until your group's beacon is dead: G1 = Flame-kissed Beacon (12858, left),\n-- G2 = Glacial Beacon (12859, right). Hidden for good once it has been seen and is gone or untargetable.\nlocal want = (slot:sub(2, 2) == \"1\") and 12858 or 12859\ndata.valxCry = data.valxCry or {}\nlocal st = data.valxCry\nif st[want] == \"dead\" then return end\nlocal alive = false\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif l then\n  for _, en in pairs(l) do\n    if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n    if type(en) == \"table\" and en.contentid == want and en.targetable and not (en.hp and en.hp.current and en.hp.current <= 0) then\n      alive = true\n      break\n    end\n  end\nend\nif alive then\n  st[want] = \"seen\"\nelseif st[want] == \"seen\" then\n  st[want] = \"dead\"\n  return\nend\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "b3fe85d2-e7ae-cd7e-bc75-cec2a0ad1529",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 228.2,
				name = "[Draw] Valigarmanda - Calamitous Cry role spot",
				timeRange = true,
				timelineIndex = 32,
				timerStartOffset = -5.9,
				uuid = "c28fef63-5634-98e5-9a25-553b50c43757",
				version = 2,
			},
		},
	},
	[33] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "70e2594c-1c8b-2a08-a62a-88a83aa89216",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Calamitous Cry role spot (Beacon adds). G1 left / G2 right, lined up from the boss with the\n-- tank in front for the wild-charge line stack (2 wild charges per Cry, 80 x 6, Beacons.cs:20-50). EX casts 5\n-- Calamitous Echo cones (40 y, 10 deg half-angle, Beacons.cs:53) every Cry (FFLogs: 5 x 36870 per Cry in all 9\n-- logs; normal mode casts 4/3, so its headings do not apply). The strat card (77.png) shows the EX cones centred\n-- ~-79/-43/-9/+28/+61 deg off south; G1 stands on the -61 deg ray and G2 on the +44.5 deg ray (centres of the two\n-- gaps the card's groups use). Distances along the ray follow the strat order (tank in front).\nlocal SPOTS = {T1 = {92.57, 89.12}, T2 = {105.96, 91.06}, H1 = {87.32, 92.03}, H2 = {110.16, 95.34}, M1 = {90.82, 90.09}, M2 = {107.36, 92.49}, R1 = {89.07, 91.06}, R2 = {108.76, 93.92}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nif V and V.ret and Now() - V.ret < 60000 then return end\nlocal slot = vxSlot()\nif not slot then return end\n-- Arrow to your side only until your group's beacon is dead: G1 = Flame-kissed Beacon (12858, left),\n-- G2 = Glacial Beacon (12859, right). Hidden for good once it has been seen and is gone or untargetable.\nlocal want = (slot:sub(2, 2) == \"1\") and 12858 or 12859\ndata.valxCry = data.valxCry or {}\nlocal st = data.valxCry\nif st[want] == \"dead\" then return end\nlocal alive = false\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif l then\n  for _, en in pairs(l) do\n    if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n    if type(en) == \"table\" and en.contentid == want and en.targetable and not (en.hp and en.hp.current and en.hp.current <= 0) then\n      alive = true\n      break\n    end\n  end\nend\nif alive then\n  st[want] = \"seen\"\nelseif st[want] == \"seen\" then\n  st[want] = \"dead\"\n  return\nend\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "ddaf6795-fb70-0ac1-8fac-baffc1b34f99",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 234.2,
				name = "[Draw] Valigarmanda - Calamitous Cry role spot",
				timeRange = true,
				timelineIndex = 33,
				timerStartOffset = -5.9,
				uuid = "6091ccf5-7a46-64f4-9636-825b91839a0c",
				version = 2,
			},
		},
	},
	[36] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "9d1c8032-3f96-15db-a3da-f3bcf4e742a8",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Beacon phase casts: each Calamitous Cry (36866 first / 36867 rest) pushes the predicted return to\n-- the next 6.05 s slot; Beacons-dead visual (38245/38246/38247) = boss back; return cast 38323 re-times the kill\n-- (kill = 38323 + 75.8).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif not (sp == 36866 or sp == 36867 or sp == 38245 or sp == 38246 or sp == 38247 or sp == 38323) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nif t < 150 then return end\nif sp == 36866 or sp == 36867 then\n  V.cry(s, t)\nelseif sp == 38323 then\n  V.ret(s, t)\nelse\n  V.back(s, t - 0.1)\nend\n",
							name = "Beacon phase return sync (after jump)",
							uuid = "3c0997f1-e1cd-5a26-ab38-c9980050eaaa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 2,
				loop = true,
				mechanicTime = 1006.7,
				name = "[AutoSim] Valigarmanda EX - Beacon phase return sync (after jump)",
				timeRange = true,
				timelineIndex = 36,
				timerEndOffset = -3,
				timerStartOffset = -12,
				uuid = "97abf2b4-39da-3683-bbf3-39cda628fec5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Valigarmanda targetable again after the Beacons: end the 0.8 weighting and the return gap here.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.isTargetable and e.entityContentID == 12854) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nif t > 150 then V.back(s, t) end\n",
							name = "Valigarmanda targetable (return, after jump)",
							uuid = "d00ba625-c047-78dd-bbd3-b5d954691530",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 26,
				loop = true,
				mechanicTime = 1006.7,
				name = "[AutoSim] Valigarmanda EX - Valigarmanda targetable (return, after jump)",
				timeRange = true,
				timelineIndex = 36,
				timerEndOffset = -3,
				timerStartOffset = -12,
				uuid = "d681bf8c-4620-8ce3-bc66-012af9f59c50",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Tulidisaster begincast (36872, 2.1-2.8 s after 38323): return/kill fallback if 38323 was missed.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 36872) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nif t > 150 then V.ret(s, t - 2.45) end\n",
							name = "Tulidisaster return fallback",
							uuid = "d8ebc065-a8c2-6c75-b9bb-36b77417c1aa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 1006.7,
				name = "[AutoSim] Valigarmanda EX - Tulidisaster return fallback",
				timeRange = true,
				timelineIndex = 36,
				timerEndOffset = -3,
				timerStartOffset = -12,
				uuid = "129fd2fc-45f0-b2b2-9b98-dbff658347aa",
				version = 2,
			},
		},
	},
	[44] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "de124d70-ca08-da56-9dcb-458d209da4ce",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Elemental Skyruin cast end (38339 storm / 36817 ice, begincast + 6.0): records the phase order and\n-- predicts that phase's movement windows (re-timed again by Hail of Feathers / Blighted Bolt / ice corner /\n-- Freezing Dust). If the return was missed entirely, the first one also re-times the kill.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.ELEM[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.elem(s, e.spellID, t)\n",
							name = "storm phase start",
							uuid = "6d982930-e26e-7900-bdf2-9ce932d5e3b5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 2,
				loop = true,
				mechanicTime = 2011.1,
				name = "[AutoSim] Valigarmanda EX - storm phase start",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = -2,
				timerStartOffset = -8,
				uuid = "af6ff18e-8ce7-aedc-96d8-18f2528a4c9c",
				version = 2,
			},
		},
	},
	[45] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "9aeeca34-2e8b-dd9b-a866-ed7603cd838a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Calamity's Chill (status 3822) on me: Freezing Up (3523, 2 s move check) starts when it runs out.\n-- Adds my own CasterDowntime [expiry, expiry + 2] (short Chill 29 s or long 91 s). Polled OnUpdate: no\n-- self.used until the window is placed, then it stops polling.\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal s = V.get()\nif s and V.chill(s) then self.used = true end\n",
							name = "Freezing Up (storm Triscourge)",
							uuid = "50ba5f9e-953d-df23-a1d2-ce4b2c078609",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 2019.8,
				name = "[AutoSim] Valigarmanda EX - Freezing Up (storm Triscourge)",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 14,
				timerStartOffset = 0.5,
				uuid = "c71d13f1-2e49-f7b1-85b8-cfeb0f95f58c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Motion",
				uuid = "64970c64-cceb-c2e1-8c9b-d13bca3797c3",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"a7dc0866-d4a4-621e-9cad-ad269aa7f264",
									true,
								},
							},
							name = "Force slidecast (Chill)",
							uuid = "9439cd60-e3db-249d-b9b3-02cb91d2f974",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"cf28144d-12a5-4a3a-a458-77001c8999b0",
									true,
								},
							},
							name = "Force slidecast (Freezing Up)",
							uuid = "8dbd720e-015d-6c56-9c5f-00a8c649e626",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"4e3f0710-821d-c4bb-85de-f3f2dd6c3c5d",
									true,
								},
							},
							name = "Jump (Chill <= 1.5 s)",
							uuid = "9b6b1d22-ca7f-df64-a778-3a1a4dda5565",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"cf28144d-12a5-4a3a-a458-77001c8999b0",
									true,
								},
							},
							name = "Jump (Freezing Up)",
							uuid = "e17d50f8-bf4f-c957-9d4b-33b0f994410d",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Chill and Freezing Up are gone: release the forced slidecast this reaction set.\nif data.valxSlide then\n  TensorDrift_SlidecastForceHold = false\n  data.valxSlide = nil\nend",
							conditions = 
							{
								
								{
									"a7dc0866-d4a4-621e-9cad-ad269aa7f264",
									false,
								},
								
								{
									"cf28144d-12a5-4a3a-a458-77001c8999b0",
									false,
								},
							},
							name = "End slidecast",
							uuid = "315cb13c-73df-ae1e-9baa-6fbd4021349a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 3,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 3 s",
							uuid = "a7dc0866-d4a4-621e-9cad-ad269aa7f264",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 1.5,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 1.5 s",
							uuid = "4e3f0710-821d-c4bb-85de-f3f2dd6c3c5d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 3523,
							category = "Self",
							name = "Freezing Up",
							uuid = "cf28144d-12a5-4a3a-a458-77001c8999b0",
							version = 3,
						},
					},
				},
				displayPath = "Motion",
				loop = true,
				mechanicTime = 2019.8,
				name = "[Motion] Valigarmanda - Calamity's Chill / Freezing Up: jump + slidecast",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 100,
				timerStartOffset = 15,
				uuid = "65d54358-d13e-8758-a3a6-761f4a0f1773",
				version = 2,
			},
		},
	},
	[46] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "d0c1b720-67d6-6527-9057-8f912fee2abf",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - static role spot (Storm Fire Stacks: 4-man light-party stacks (ThunderScourgeOfFire 36845 r5) on the south inner ground tiles C/D). Spots: strat 78.webp card 1; ThunderPlatform.cs:22-30.\nlocal SPOTS = {T1 = {95.6, 107.3}, T2 = {103.9, 107.3}, H1 = {95.6, 107.3}, H2 = {103.9, 107.3}, M1 = {95.6, 107.3}, M2 = {103.9, 107.3}, R1 = {95.6, 107.3}, R2 = {103.9, 107.3}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "b573ff3a-a44d-aef7-8819-2cbaf4636a25",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2031.8,
				name = "[Draw] Valigarmanda - Fire Stacks role spot",
				timeRange = true,
				timelineIndex = 46,
				timerStartOffset = -7,
				uuid = "e21e95f0-1629-3624-a10e-3fbecb5bd1ad",
				version = 2,
			},
		},
	},
	[47] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "d92e8f84-3c0b-b4c8-a453-19fa8bc78fc7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Storm: Hail of Feathers (36829 begincast) -> CasterDowntime +7.4..+15.5 (FFLogs, n=26).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 36829) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.anchor(s, 36829, t)\n",
							name = "Hail of Feathers movement",
							uuid = "c5d93e3b-f1eb-1ed8-8a52-6f91a92830ac",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 2045,
				name = "[AutoSim] Valigarmanda EX - Hail of Feathers movement",
				timeRange = true,
				timelineIndex = 47,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "4dfa702a-0739-908b-9d7a-7c5da6cfcd31",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "721e5c6d-0acd-efa1-8f18-eb142999b3ca",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"558e6078-76f2-a1cb-a053-95e7ecd42c01",
									true,
								},
							},
							name = "Capture",
							uuid = "4d46dfa9-8ec1-b9d9-a3cc-e7738dedf007",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "558e6078-76f2-a1cb-a053-95e7ecd42c01",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 2045,
				name = "[Draw] Valigarmanda - Hail of Feathers role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 47,
				timerStartOffset = -8,
				uuid = "d7a5d2d4-7614-d3da-9226-ab0351007c00",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"4ff0aaee-8301-341b-8987-2f0e977bf333",
									true,
								},
							},
							name = "Capture",
							uuid = "f9c893c9-1245-8cc5-a623-255fa9f0eeb6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "4ff0aaee-8301-341b-8987-2f0e977bf333",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 2045,
				name = "[Draw] Valigarmanda - Hail of Feathers role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 47,
				timerStartOffset = -8,
				uuid = "7b5e1ef8-e91d-4237-81b5-4a9eda2c3d4a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityAdd): Ice Boulder 12856 (Sphere Shatter r13 centre), Feather of Ruin\n--   12855 (Blighted Bolt r8 centre), Arcane Sphere 12857 (storm lanes).\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nif not (e and e.pos and e.pos.x) then return end -- not ready yet: retry next tick (self.used stays unset on purpose)\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal c = eventArgs.entityContentID\nlocal id = eventArgs.entityID\nlocal function add(list, rec)\n  for _, r in ipairs(list) do\n    if r.id == id then return end\n  end\n  list[#list + 1] = rec\nend\nif c == 12856 then\n  local s = V.sp\n  if s and now - s.t0 < 45000 then\n    add(s.bould, {id = id, x = e.pos.x, z = e.pos.z, t = now})\n    s.plan = nil\n  end\nelseif c == 12855 then\n  if not V.fea or now - V.fea.t > 40000 then V.fea = {t = now, list = {}} end\n  add(V.fea.list, {id = id, x = e.pos.x, z = e.pos.z})\nelseif c == 12857 then\n  if not V.sph or now - V.sph.t > 15000 then V.sph = {t = now, list = {}} end\n  add(V.sph.list, {id = id, x = e.pos.x, z = e.pos.z})\nend\n",
							conditions = 
							{
								
								{
									"e754d259-1140-2add-b6db-5ab87be9d65c",
									true,
								},
							},
							name = "Capture",
							uuid = "e7d47d16-0e3a-9fa6-b30e-b0992fe43f8a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityAdd, Dequeue Action if False = on).\n-- 12856 Ice Boulder, 12855 Feather of Ruin, 12857 Arcane Sphere (store reactions key the same ids).\nlocal c = eventArgs.entityContentID\nreturn c == 12856 or c == 12855 or c == 12857\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "e754d259-1140-2add-b6db-5ab87be9d65c",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 5,
				loop = true,
				mechanicTime = 2045,
				name = "[Draw] Valigarmanda - Hail of Feathers role spot (capture spawns)",
				timeRange = true,
				timelineIndex = 47,
				timerEndOffset = 20,
				timerStartOffset = -3,
				uuid = "ca9f812c-6e56-6ccd-a915-b174dc48697f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Hail of Feathers role spot (whole party). Six drops (36893..36898, r20 falloff) land 3 s apart\n-- around the stage. Route from the user (2026-11-13): corner opposite the first drop -> the other corner on that edge\n-- -> down to the far corner, then back to the first feather's tile when it dies (Blighted Bolt: stand on the dead\n-- feather's tile). Mirrors for a west start or drops heading north.\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal H = V and V.hofd\nif not (H and H.d and H.d[1] and H.d[2]) then return end\nlocal el = (Now() - H.t) / 1000\n-- the user's route: start in the corner opposite the first drop on the edge the drops move away from, run along that\n-- edge to the other corner, then down that side to the far corner; drops land 5.7 / 8.7 / ... / 20.7 s after creation\nlocal d1, d2 = H.d[1], H.d[2]\nlocal sx = (d1.x > 100) and -1 or 1          -- first drop east -> start west\nlocal sz = (d2.z > 100) and -1 or 1          -- drops head south -> start on the north edge\nlocal A = {100 + 18.2 * sx, 100 + 13.2 * sz}  -- e.g. NW corner\nlocal B = {100 - 18.2 * sx, A[2]}             -- other corner on the same edge (NE)\nlocal C = {B[1], 100 - 13.2 * sz}             -- far corner on that side (SE)\nif el <= 8.7 then vxSpot(A[1], A[2], 1.2) return end   -- drops 1-2\nif el <= 14.7 then vxSpot(B[1], B[2], 1.2) return end  -- drops 3-4 (leave A before drop 4 lands next to it)\nif el <= 20.7 then vxSpot(C[1], C[2], 1.2) return end  -- drops 5-6 (drop 6 lands next to B)\n-- after the last drop: back to the first feather's tile once that feather (the one the party burns) is dead\nlocal F = V.fea\nlocal first, bd\nif F and F.list then\n  for _, f in ipairs(F.list) do\n    local dx, dz = f.x - d1.x, f.z - d1.z\n    local dd = dx * dx + dz * dz\n    if not bd or dd < bd then first, bd = f, dd end\n  end\nend\nif first and bd < 9 then\n  local e = TensorCore.mGetEntity(first.id)\n  local isDead = (not e) or e.alive == false or (e.hp and e.hp.current and e.hp.current <= 0)\n  if isDead then vxSpot(first.x, first.z, 1.2) return end\nend\nvxSpot(C[1], C[2], 1.2)\n",
							name = "Draw",
							uuid = "a49cf551-68d3-dacb-b8b6-2946e3190efa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2045,
				name = "[Draw] Valigarmanda - Hail of Feathers role spot",
				timeRange = true,
				timelineIndex = 47,
				timerEndOffset = 19,
				timerStartOffset = -6,
				uuid = "a8f0d4d3-7025-eb48-a00a-876d54402c82",
				version = 2,
			},
		},
	},
	[53] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "0dcc9d6e-d39e-c315-99ef-9051818ca870",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Storm: Blighted Bolt (36831 begincast) -> CasterDowntime +9.8..+12.9 (FFLogs Hail of Feathers\n-- +35.1..+38.2, n=18, low confidence).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 36831) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.anchor(s, 36831, t)\n",
							name = "Blighted Bolt movement",
							uuid = "3c08cb7a-90e2-4238-9c18-da32697a5a45",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 2070.1,
				name = "[AutoSim] Valigarmanda EX - Blighted Bolt movement",
				timeRange = true,
				timelineIndex = 53,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "825722a5-ddd5-14a2-a07f-16a4d5a7f419",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "153633cf-7d46-d715-85a9-32417f2c9a18",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Blighted Bolt role spot. r8 on every LIVING feather (HailOfFeathers.cs:19,47-55); stay on\n-- the tile of the feather you killed (strat 78.webp). Killed feather = first captured feather that is dead/gone,\n-- else the first feather (the strat burns the 1st one). Role offsets from the card (example tile (85,100)),\n-- mirrored for east-half feathers, pulled in until >= 8.5 y from every living feather and inside the tile.\nlocal OFFS = {T1 = {1.3, 0.5}, T2 = {-1.6, -1.2}, H1 = {-1.6, 3.0}, H2 = {0.6, 3.0}, M1 = {-0.8, 1.6}, M2 = {-4.0, -0.6}, R1 = {-3.2, 1.2}, R2 = {0.6, -0.6}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal F = V and V.fea\nif not (F and F.list and #F.list > 0) then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal dead, alive = nil, {}\nfor _, f in ipairs(F.list) do\n  local e = TensorCore.mGetEntity(f.id)\n  local isDead = (not e) or e.alive == false or (e.hp and e.hp.current and e.hp.current <= 0)\n  if isDead and not dead then dead = f else alive[#alive + 1] = f end\nend\nif not dead then\n  dead = F.list[1]\n  alive = {}\n  for i = 2, #F.list do alive[#alive + 1] = F.list[i] end\nend\nlocal o = OFFS[slot]\nlocal ox = (dead.x > 100) and -o[1] or o[1]\nlocal oz = o[2]\nfor _, k in ipairs({1, 0.75, 0.5, 0.25, 0}) do\n  local x, z = dead.x + ox * k, dead.z + oz * k\n  local ok = math.abs(x - dead.x) <= 4.5 and math.abs(z - dead.z) <= 4.5 and x >= 80.5 and x <= 119.5\n  if ok then\n    for _, a in ipairs(alive) do\n      local dx, dz = x - a.x, z - a.z\n      if dx * dx + dz * dz < 8.5 * 8.5 then\n        ok = false\n        break\n      end\n    end\n  end\n  if ok then\n    vxSpot(x, z)\n    return\n  end\nend\n",
							name = "Draw",
							uuid = "45f76623-0377-32d1-8fd3-d2025e104be6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2070.1,
				name = "[Draw] Valigarmanda - Blighted Bolt role spot",
				timeRange = true,
				timelineIndex = 53,
				timerEndOffset = 0.5,
				timerStartOffset = -6,
				uuid = "45e5cee3-267e-cd74-96ae-f0bd85259f27",
				version = 2,
			},
		},
	},
	[54] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "de44382c-1c7e-5248-8d8f-b9ce68d98610",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityMarkerAdd): who got 507 Bolt / 509 Chill / 344 Ice Talon.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nV.mk = V.mk or {}\nlocal k = eventArgs.markerID\nlocal s = V.mk[k]\nif not s or now - s.t > 5000 then\n  s = {t = now, ids = {}}\n  V.mk[k] = s\nend\ns.ids[eventArgs.entityID] = true\n",
							conditions = 
							{
								
								{
									"548ae5ed-2f3e-648d-8b68-df1596078da7",
									true,
								},
							},
							name = "Capture",
							uuid = "0c69eb3b-34ee-6cc1-9d94-9b517ee86cc5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityMarkerAdd, Dequeue Action if False = on).\n-- 507 Calamity's Bolt, 509 Calamity's Chill, 344 Ice Talon (BossmodReborn Ex1ValigarmandaEnums.cs IconID).\nlocal m = eventArgs.markerID\nreturn m == 507 or m == 509 or m == 344\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "548ae5ed-2f3e-648d-8b68-df1596078da7",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 2079.9,
				name = "[Draw] Valigarmanda - Thunder/Ice Spread role spot (capture markers)",
				timeRange = true,
				timelineIndex = 54,
				timerEndOffset = -4,
				timerStartOffset = -9,
				uuid = "36619220-6e7b-6f34-965e-17f516b78f22",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Thunder/Ice Spread role spot (storm). Your next debuff: head marker 507 Bolt = thunder\n-- (r8 spread, ground tile), 509 Chill = ice (floating tile) (FFLogs headmarkers 7.1 s before; ThunderPlatform.cs);\n-- fallback = the storm debuff with less time left (3824 Fulgur thunder / 3820 Frost ice, cactbot :359-371).\n-- Spots: strat 79.webp card 1 (as drawn; the other-debuff tiles are the strat file's collision-free choice).\nlocal SPOTS = {thunder = {T1 = {94.0, 88.4}, T2 = {82.0, 96.9}, H1 = {94.1, 110.7}, H2 = {103.9, 110.4}, M1 = {105.0, 90.0}, M2 = {115.0, 100.0}, R1 = {95.0, 110.0}, R2 = {105.0, 110.0}}, ice = {T1 = {85.0, 90.0}, T2 = {105.0, 100.0}, H1 = {85.0, 110.0}, H2 = {115.0, 110.0}, M1 = {94.5, 99.6}, M2 = {115.2, 89.6}, R1 = {84.1, 109.6}, R2 = {115.2, 111.0}}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal now = Now()\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal typ\nlocal mk = V and V.mk\nif mk then\n  local a = mk[507]\n  if a and now - a.t < 9000 and a.ids[p.id] then typ = \"thunder\" end\n  local b = mk[509]\n  if not typ and b and now - b.t < 9000 and b.ids[p.id] then typ = \"ice\" end\nend\nif not typ then\n  local f = TensorCore.getBuff(p, 3824)\n  local c = TensorCore.getBuff(p, 3820)\n  if f and (not c or f.duration <= c.duration) then typ = \"thunder\" elseif c then typ = \"ice\" end\nend\nif not typ then return end\nlocal q = SPOTS[typ][slot]\nvxSpot(q[1], q[2])\n",
							name = "Draw",
							uuid = "53cfb7df-c593-8312-813e-94a81d026064",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2079.9,
				name = "[Draw] Valigarmanda - Thunder/Ice Spread role spot",
				timeRange = true,
				timelineIndex = 54,
				timerStartOffset = -7,
				uuid = "83b7464c-4ea0-d2ca-bea8-dedd61c4c2e6",
				version = 2,
			},
		},
	},
	[55] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "3b601c6b-19db-fa62-acfa-2917bcf6b6d7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Slithering Strike (36809 storm / 36810 ice / 36811 fire; the corner pick is random):\n-- MeleeDowntime begincast +5.0..+8.5 (FFLogs, 14 melee samples). Susurrant Breath / Strangling Coil add nothing.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.SLITHER[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.slither(s, e.spellID, t)\n",
							name = "Slithering Strike melee downtime (storm 1)",
							uuid = "07a5e9a1-b15f-e9c2-b5cd-7b736a578a55",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 2094.8,
				name = "[AutoSim] Valigarmanda EX - Slithering Strike melee downtime (storm 1)",
				timeRange = true,
				timelineIndex = 55,
				timerEndOffset = -1,
				timerStartOffset = -13,
				uuid = "19a66209-7ef8-54ad-bf99-4415ba1603d3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "73ef2ee9-a9da-8efa-8893-f3c5262092ba",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"1ecab55a-6096-ed98-8e21-3792d23e1494",
									true,
								},
							},
							name = "Capture",
							uuid = "a2a67f6d-6205-0d3d-b387-b5021b963f82",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "1ecab55a-6096-ed98-8e21-3792d23e1494",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 2094.8,
				name = "[Draw] Valigarmanda - Crackling Cataclysm role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 55,
				timerStartOffset = -9.5,
				uuid = "da59d87d-ba24-e9b0-a9b9-f186c738292b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"bcdda638-9114-2e08-afd5-bf261ccc194e",
									true,
								},
							},
							name = "Capture",
							uuid = "2666b902-5d37-9047-90b3-a65fe23a66dc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "bcdda638-9114-2e08-afd5-bf261ccc194e",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 2094.8,
				name = "[Draw] Valigarmanda - Crackling Cataclysm role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 55,
				timerEndOffset = 5,
				timerStartOffset = -1,
				uuid = "789466d6-bbd7-d125-9512-0dc6d305a81b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Crackling Cataclysm role spot (storm stance + baited r6 puddles, strat 79.webp card 2).\n-- Before the stance resolves: the light-party spot for the stance (cone 36805/36808, out 36809/36812, donut\n-- 36813/36816). After it resolves: move >= 7 y to the \"after\" spot so the puddles (36801) land on the old one.\nlocal BEFORE = {cone = {G1 = {84.0, 88.5}, G2 = {116.0, 88.5}}, out = {G1 = {91.0, 111.5}, G2 = {109.0, 111.5}}, donut = {G1 = {95.8, 97.6}, G2 = {104.2, 97.6}}}\nlocal AFTER = {cone = {G1 = {95.6, 97.0}, G2 = {103.4, 97.0}}, out = {G1 = {95.8, 99.0}, G2 = {104.2, 99.0}}, donut = {G1 = {87.0, 101.0}, G2 = {113.0, 101.0}}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal st = V and V.st\nlocal now = Now()\nif not st or now - st.t > 12000 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal g = \"G\" .. slot:sub(2, 2)\nlocal p\nif not st.res then\n  p = BEFORE[st.k][g]\nelse\n  if st.crack or now - st.res > 5000 then return end\n  p = AFTER[st.k][g]\nend\nif p then vxSpot(p[1], p[2]) end\n",
							name = "Draw",
							uuid = "57f040c1-425c-53ee-a439-804afcc602fe",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2094.8,
				name = "[Draw] Valigarmanda - Crackling Cataclysm role spot",
				timeRange = true,
				timelineIndex = 55,
				timerEndOffset = 4.5,
				timerStartOffset = -7,
				uuid = "f333e4eb-a450-58ac-bbfa-b59d034229d9",
				version = 2,
			},
		},
	},
	[58] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "a914b3aa-78fb-64ed-85ad-fb0390267e4f",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityAdd): Ice Boulder 12856 (Sphere Shatter r13 centre), Feather of Ruin\n--   12855 (Blighted Bolt r8 centre), Arcane Sphere 12857 (storm lanes).\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nif not (e and e.pos and e.pos.x) then return end -- not ready yet: retry next tick (self.used stays unset on purpose)\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal c = eventArgs.entityContentID\nlocal id = eventArgs.entityID\nlocal function add(list, rec)\n  for _, r in ipairs(list) do\n    if r.id == id then return end\n  end\n  list[#list + 1] = rec\nend\nif c == 12856 then\n  local s = V.sp\n  if s and now - s.t0 < 45000 then\n    add(s.bould, {id = id, x = e.pos.x, z = e.pos.z, t = now})\n    s.plan = nil\n  end\nelseif c == 12855 then\n  if not V.fea or now - V.fea.t > 40000 then V.fea = {t = now, list = {}} end\n  add(V.fea.list, {id = id, x = e.pos.x, z = e.pos.z})\nelseif c == 12857 then\n  if not V.sph or now - V.sph.t > 15000 then V.sph = {t = now, list = {}} end\n  add(V.sph.list, {id = id, x = e.pos.x, z = e.pos.z})\nend\n",
							conditions = 
							{
								
								{
									"c570333d-dd58-b8b8-a365-02b17e50a0e4",
									true,
								},
							},
							name = "Capture",
							uuid = "922d247e-700f-37b1-a86c-8508b5bde244",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityAdd, Dequeue Action if False = on).\n-- 12856 Ice Boulder, 12855 Feather of Ruin, 12857 Arcane Sphere (store reactions key the same ids).\nlocal c = eventArgs.entityContentID\nreturn c == 12856 or c == 12855 or c == 12857\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "c570333d-dd58-b8b8-a365-02b17e50a0e4",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 5,
				loop = true,
				mechanicTime = 2109.5,
				name = "[Draw] Valigarmanda - Thunderous Breath role spot (capture spawns)",
				timeRange = true,
				timelineIndex = 58,
				timerEndOffset = -1,
				timerStartOffset = -15,
				uuid = "0c0168bd-a925-a07d-8055-86bdbe4e6a28",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Thunderous Breath role spot. 5 Arcane Spheres (12857) take 5 of the 6 lanes\n-- z = 87.5..112.5 (cactbot :493-530); their Arcane Lightning is 50 x 5 along the row (ThunderousBreath.cs:25-35).\n-- Breath needs everyone floating (ThunderousBreath.cs:15): middle row -> the inner floating tiles (x spread as on\n-- 79.webp card 3), north/south row -> G1 on the west floating tile (x 85), G2 on the east one (x 115).\nlocal MIDX = {T1 = 93.8, T2 = 99.5, H1 = 98.4, H2 = 103.0, M1 = 97.0, M2 = 102.2, R1 = 95.8, R2 = 100.2}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal S = V and V.sph\nif not (S and S.list and #S.list >= 5) or Now() - S.t > 20000 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal lanes = {87.5, 92.5, 97.5, 102.5, 107.5, 112.5}\nlocal free = {}\nfor _, L in ipairs(lanes) do\n  local taken = false\n  for _, s in ipairs(S.list) do\n    if math.abs(s.z - L) < 2.5 then taken = true end\n  end\n  if not taken then free[#free + 1] = L end\nend\nif #free ~= 1 then return end\nlocal L = free[1]\nlocal x\nif L > 95 and L < 105 then\n  x = MIDX[slot]\nelse\n  local g = tonumber(slot:sub(2, 2))\n  local off = ({T = -3, H = -1, M = 1, R = 3})[slot:sub(1, 1)]\n  x = ((g == 1) and 85 or 115) + off\nend\nvxSpot(x, L)\n",
							name = "Draw",
							uuid = "0d3462c3-08ba-ea4c-a279-fc4afb0200e7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2109.5,
				name = "[Draw] Valigarmanda - Thunderous Breath role spot",
				timeRange = true,
				timelineIndex = 58,
				timerEndOffset = 0.5,
				timerStartOffset = -10,
				uuid = "2330dfb2-1112-8b3d-abd9-479f9e1a7229",
				version = 2,
			},
		},
	},
	[59] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "631b4c06-f1b3-38a5-ad11-5fff9fe108f8",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityMarkerAdd): who got 507 Bolt / 509 Chill / 344 Ice Talon.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nV.mk = V.mk or {}\nlocal k = eventArgs.markerID\nlocal s = V.mk[k]\nif not s or now - s.t > 5000 then\n  s = {t = now, ids = {}}\n  V.mk[k] = s\nend\ns.ids[eventArgs.entityID] = true\n",
							conditions = 
							{
								
								{
									"81711806-bf21-32d0-b121-c23c7f6cb7e6",
									true,
								},
							},
							name = "Capture",
							uuid = "70a34d46-677a-17f7-9a6f-49715d9cb5b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityMarkerAdd, Dequeue Action if False = on).\n-- 507 Calamity's Bolt, 509 Calamity's Chill, 344 Ice Talon (BossmodReborn Ex1ValigarmandaEnums.cs IconID).\nlocal m = eventArgs.markerID\nreturn m == 507 or m == 509 or m == 344\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "81711806-bf21-32d0-b121-c23c7f6cb7e6",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 2119.9,
				name = "[Draw] Valigarmanda - Thunder/Ice Spread role spot (capture markers)",
				timeRange = true,
				timelineIndex = 59,
				timerEndOffset = -4,
				timerStartOffset = -9,
				uuid = "b9afc4a1-fb45-fdf2-b199-0c02c4ff2590",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Thunder/Ice Spread role spot (storm). Your next debuff: head marker 507 Bolt = thunder\n-- (r8 spread, ground tile), 509 Chill = ice (floating tile) (FFLogs headmarkers 7.1 s before; ThunderPlatform.cs);\n-- fallback = the storm debuff with less time left (3824 Fulgur thunder / 3820 Frost ice, cactbot :359-371).\n-- Spots: strat 79.webp card 1 (as drawn; the other-debuff tiles are the strat file's collision-free choice).\nlocal SPOTS = {thunder = {T1 = {94.0, 88.4}, T2 = {82.0, 96.9}, H1 = {94.1, 110.7}, H2 = {103.9, 110.4}, M1 = {105.0, 90.0}, M2 = {115.0, 100.0}, R1 = {95.0, 110.0}, R2 = {105.0, 110.0}}, ice = {T1 = {85.0, 90.0}, T2 = {105.0, 100.0}, H1 = {85.0, 110.0}, H2 = {115.0, 110.0}, M1 = {94.5, 99.6}, M2 = {115.2, 89.6}, R1 = {84.1, 109.6}, R2 = {115.2, 111.0}}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal now = Now()\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal typ\nlocal mk = V and V.mk\nif mk then\n  local a = mk[507]\n  if a and now - a.t < 9000 and a.ids[p.id] then typ = \"thunder\" end\n  local b = mk[509]\n  if not typ and b and now - b.t < 9000 and b.ids[p.id] then typ = \"ice\" end\nend\nif not typ then\n  local f = TensorCore.getBuff(p, 3824)\n  local c = TensorCore.getBuff(p, 3820)\n  if f and (not c or f.duration <= c.duration) then typ = \"thunder\" elseif c then typ = \"ice\" end\nend\nif not typ then return end\nlocal q = SPOTS[typ][slot]\nvxSpot(q[1], q[2])\n",
							name = "Draw",
							uuid = "155a335e-764f-4901-83bb-28d4bd7ae523",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2119.9,
				name = "[Draw] Valigarmanda - Thunder/Ice Spread role spot",
				timeRange = true,
				timelineIndex = 59,
				timerStartOffset = -7,
				uuid = "9a3fd36a-aa03-82ad-bf49-b77ff1f3b8ce",
				version = 2,
			},
		},
	},
	[60] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "3273dbf8-187e-d254-a212-773440163501",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Slithering Strike (36809 storm / 36810 ice / 36811 fire; the corner pick is random):\n-- MeleeDowntime begincast +5.0..+8.5 (FFLogs, 14 melee samples). Susurrant Breath / Strangling Coil add nothing.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.SLITHER[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.slither(s, e.spellID, t)\n",
							name = "Slithering Strike melee downtime (storm 2)",
							uuid = "0a3331c4-6eb1-3dfe-83fd-ca3264dd5e44",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 2135.2,
				name = "[AutoSim] Valigarmanda EX - Slithering Strike melee downtime (storm 2)",
				timeRange = true,
				timelineIndex = 60,
				timerEndOffset = -1,
				timerStartOffset = -13,
				uuid = "d7a889dc-d9e5-201b-9173-2515ab23e931",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "010fe4c8-8a9a-2485-a974-50889b566ac1",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"1baedd55-e92f-0d97-882b-3e794b4b5614",
									true,
								},
							},
							name = "Capture",
							uuid = "2f7443f6-62ad-8e3e-9a28-88a607628f36",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "1baedd55-e92f-0d97-882b-3e794b4b5614",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 2135.2,
				name = "[Draw] Valigarmanda - Crackling Cataclysm role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 60,
				timerStartOffset = -9.5,
				uuid = "2a072529-756f-1e94-abed-9b5a851377de",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"5de5b6b1-67c6-8613-b790-2c1477909bba",
									true,
								},
							},
							name = "Capture",
							uuid = "6c82cd05-b45c-40bd-b8b1-e0abfb9f0824",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "5de5b6b1-67c6-8613-b790-2c1477909bba",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 2135.2,
				name = "[Draw] Valigarmanda - Crackling Cataclysm role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 60,
				timerEndOffset = 5,
				timerStartOffset = -1,
				uuid = "da96b418-859f-36cd-b29b-ef68400ead30",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Crackling Cataclysm role spot (storm stance + baited r6 puddles, strat 79.webp card 2).\n-- Before the stance resolves: the light-party spot for the stance (cone 36805/36808, out 36809/36812, donut\n-- 36813/36816). After it resolves: move >= 7 y to the \"after\" spot so the puddles (36801) land on the old one.\nlocal BEFORE = {cone = {G1 = {84.0, 88.5}, G2 = {116.0, 88.5}}, out = {G1 = {91.0, 111.5}, G2 = {109.0, 111.5}}, donut = {G1 = {95.8, 97.6}, G2 = {104.2, 97.6}}}\nlocal AFTER = {cone = {G1 = {95.6, 97.0}, G2 = {103.4, 97.0}}, out = {G1 = {95.8, 99.0}, G2 = {104.2, 99.0}}, donut = {G1 = {87.0, 101.0}, G2 = {113.0, 101.0}}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal st = V and V.st\nlocal now = Now()\nif not st or now - st.t > 12000 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal g = \"G\" .. slot:sub(2, 2)\nlocal p\nif not st.res then\n  p = BEFORE[st.k][g]\nelse\n  if st.crack or now - st.res > 5000 then return end\n  p = AFTER[st.k][g]\nend\nif p then vxSpot(p[1], p[2]) end\n",
							name = "Draw",
							uuid = "a32123e0-ae11-d46f-9452-0188d3d55ea4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2135.2,
				name = "[Draw] Valigarmanda - Crackling Cataclysm role spot",
				timeRange = true,
				timelineIndex = 60,
				timerEndOffset = 4.5,
				timerStartOffset = -7,
				uuid = "d882da8f-1227-2904-92fe-6c0803896706",
				version = 2,
			},
		},
	},
	[64] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "1f2856cb-2797-f5b6-9ae4-cabb348592cf",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"3568aea0-8570-e3bf-8964-5399fe59bd25",
									true,
								},
							},
							name = "Capture",
							uuid = "86f5a0c7-7524-942f-932f-ccdf14a2158a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "3568aea0-8570-e3bf-8964-5399fe59bd25",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 2156.8,
				name = "[Draw] Valigarmanda - Ruinfall role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 64,
				timerStartOffset = -6,
				uuid = "18e2c124-06c6-3ede-a664-3b7f2dd3d2e3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"436a0458-1c5b-5e1b-b04b-2a75124a65e2",
									true,
								},
							},
							name = "Capture",
							uuid = "f4295a56-bbed-805c-a4e4-8caab2dd0647",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "436a0458-1c5b-5e1b-b04b-2a75124a65e2",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 2156.8,
				name = "[Draw] Valigarmanda - Ruinfall role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 64,
				timerStartOffset = -6,
				uuid = "c7d0bcfb-449b-b534-b1ba-dbd75d22c23c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Ruinfall role spot. Tanks soak the r6 two-tank tower (36861, Ruinfall.cs:20), everyone\n-- else waits outside it in the two side groups of strat 80.png (everyone uses knockback immunity, store reaction\n-- \"Knockback Cancel\"). Tank spots follow the tower if its cast location is known.\nlocal SPOTS = {T1 = {99.9, 98.4}, T2 = {101.7, 100.0}, H1 = {109.7, 95.8}, H2 = {116.6, 96.6}, M1 = {91.2, 96.5}, M2 = {88.8, 96.5}, R1 = {86.3, 97.5}, R2 = {113.2, 95.8}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = SPOTS[slot]\nlocal x, z = p[1], p[2]\nlocal rf = V and V.rf\nif rf and Now() - rf.t < 12000 and (slot == \"T1\" or slot == \"T2\") then\n  x, z = x + rf.x - 100, z + rf.z - 100\nend\nvxSpot(x, z)\n",
							name = "Draw",
							uuid = "d36885cf-ae9f-04c9-95b0-dbf254e89d67",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 2156.8,
				name = "[Draw] Valigarmanda - Ruinfall role spot",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 2.4,
				timerStartOffset = -5.5,
				uuid = "65ba3172-6abf-6b0e-a31f-c30cfa57866d",
				version = 2,
			},
		},
	},
	[69] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "9b85907e-d26f-9b8f-aaee-4368494edaa6",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Elemental Skyruin cast end (38339 storm / 36817 ice, begincast + 6.0): records the phase order and\n-- predicts that phase's movement windows (re-timed again by Hail of Feathers / Blighted Bolt / ice corner /\n-- Freezing Dust). If the return was missed entirely, the first one also re-times the kill.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.ELEM[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.elem(s, e.spellID, t)\n",
							name = "ice phase start",
							uuid = "5e5a201c-f126-5146-8f44-938e3246705d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 2,
				loop = true,
				mechanicTime = 3011.1,
				name = "[AutoSim] Valigarmanda EX - ice phase start",
				timeRange = true,
				timelineIndex = 69,
				timerEndOffset = -2,
				timerStartOffset = -8,
				uuid = "2a32c413-e7f3-d6ec-960e-90b3c624d822",
				version = 2,
			},
		},
	},
	[70] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "c0239e48-f4fb-3934-bb3f-50ad4f25b31a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Calamity's Chill (status 3822) on me: Freezing Up (3523, 2 s move check) starts when it runs out.\n-- Adds my own CasterDowntime [expiry, expiry + 2] (short Chill 29 s or long 91 s). Polled OnUpdate: no\n-- self.used until the window is placed, then it stops polling.\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal s = V.get()\nif s and V.chill(s) then self.used = true end\n",
							name = "Freezing Up (ice Triscourge)",
							uuid = "d0838cf5-949e-6533-b2a0-dfa715017a32",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 3019.8,
				name = "[AutoSim] Valigarmanda EX - Freezing Up (ice Triscourge)",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 70,
				timerEndOffset = 14,
				timerStartOffset = 0.5,
				uuid = "7a6420a5-e89e-e0cb-a847-087dba05f664",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Motion",
				uuid = "3ccec983-1be4-4d9c-8b02-db4423f80119",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"fcff85c3-43a9-c27f-98f6-9520edab46d1",
									true,
								},
							},
							name = "Force slidecast (Chill)",
							uuid = "29a1862e-82be-4d66-a6c0-24319e7b0a6d",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"abccff64-c0f9-3a0b-a806-a9322940f257",
									true,
								},
							},
							name = "Force slidecast (Freezing Up)",
							uuid = "7efab20d-7fe1-40c5-afd5-43a100f26c49",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"78fb1989-0d68-83fa-a0ba-e1b89891af4f",
									true,
								},
							},
							name = "Jump (Chill <= 1.5 s)",
							uuid = "aac4ae7b-7cee-f5f6-8050-fc7426c006d5",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"abccff64-c0f9-3a0b-a806-a9322940f257",
									true,
								},
							},
							name = "Jump (Freezing Up)",
							uuid = "1a245ee6-4ecb-b6a8-97e5-7a82a65604dc",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Chill and Freezing Up are gone: release the forced slidecast this reaction set.\nif data.valxSlide then\n  TensorDrift_SlidecastForceHold = false\n  data.valxSlide = nil\nend",
							conditions = 
							{
								
								{
									"fcff85c3-43a9-c27f-98f6-9520edab46d1",
									false,
								},
								
								{
									"abccff64-c0f9-3a0b-a806-a9322940f257",
									false,
								},
							},
							name = "End slidecast",
							uuid = "e19bb0c0-b698-8758-93a0-04fd5a2af06a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 3,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 3 s",
							uuid = "fcff85c3-43a9-c27f-98f6-9520edab46d1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 1.5,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 1.5 s",
							uuid = "78fb1989-0d68-83fa-a0ba-e1b89891af4f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 3523,
							category = "Self",
							name = "Freezing Up",
							uuid = "abccff64-c0f9-3a0b-a806-a9322940f257",
							version = 3,
						},
					},
				},
				displayPath = "Motion",
				loop = true,
				mechanicTime = 3019.8,
				name = "[Motion] Valigarmanda - Calamity's Chill / Freezing Up: jump + slidecast",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 70,
				timerEndOffset = 100,
				timerStartOffset = 15,
				uuid = "82764068-9d8d-0aed-a70d-fba77f8a0cfe",
				version = 2,
			},
		},
	},
	[71] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "38ffd729-230d-f1ab-943c-381cee9e1fb7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - static role spot (Scourge of Ice/Fire (ice phase): tanks carry the r16 ice defamations to waymarks 2/3, light parties 3-man r5 fire stacks on C/D). Spots: strat 81.webp card 1; Triscourge.cs IceScourgeOfFireIce; cactbot :692-708.\nlocal SPOTS = {T1 = {87.1, 86.3}, T2 = {112.9, 86.3}, H1 = {96.0, 107.4}, H2 = {103.9, 107.4}, M1 = {94.6, 106.0}, M2 = {102.8, 106.0}, R1 = {96.3, 106.0}, R2 = {104.6, 106.0}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = SPOTS[slot]\nvxSpot(p[1], p[2])\n",
							name = "Draw",
							uuid = "0f50b9f7-544d-7370-b823-7f76bcc40989",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 3031.8,
				name = "[Draw] Valigarmanda - Scourge of Ice/Fire role spot",
				timeRange = true,
				timelineIndex = 71,
				timerStartOffset = -7,
				uuid = "541afda8-009a-b60b-b215-e42314c0929f",
				version = 2,
			},
		},
	},
	[73] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "3d998b48-632e-73c3-8d1c-ecb5838b9787",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnMapEffect): Spikesicle line order, erupting volcano, avalanche half.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal i = eventArgs.a1\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nif i >= 4 and i <= 13 then\n  local s = spGet(V, now)\n  for _, m in ipairs(s.me) do\n    if m.i == i then return end\n  end\n  s.me[#s.me + 1] = {i = i, t = now}\n  s.plan = nil\nelseif i == 14 or i == 15 then\n  V.vol = {i = i, t = now}\nelseif i == 3 then\n  V.aval = {ne = (eventArgs.a2 == 16), t = now}\n  if V.sp then V.sp.plan = nil end\nend\n",
							conditions = 
							{
								
								{
									"08f88c49-7716-4603-9ce5-067deb01d996",
									true,
								},
							},
							name = "Capture",
							uuid = "c6cabab9-b8c7-9800-8809-57eaf58dda4f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnMapEffect, Dequeue Action if False = on).\n-- 4..13 state 0x00020004 = Spikesicle lines (BossmodReborn Spikesicle.cs:22); 14/15 state 0x00200010 = volcano\n-- eruption (VolcanicDrop.cs:18-21); 3 state 0x00200010 / 0x00020001 = avalanche half (NorthernCross.cs, cactbot :710-718).\nlocal a1, a2, a3 = eventArgs.a1, eventArgs.a2, eventArgs.a3\nif a1 >= 4 and a1 <= 13 then return a2 == 4 and a3 == 2 end\nif a1 == 14 or a1 == 15 then return a2 == 16 and a3 == 32 end\nif a1 == 3 then return (a2 == 16 and a3 == 32) or (a2 == 1 and a3 == 2) end\nreturn false\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "08f88c49-7716-4603-9ce5-067deb01d996",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 14,
				loop = true,
				mechanicTime = 3048.1,
				name = "[Draw] Valigarmanda - Avalanche role spot (capture map effects)",
				timeRange = true,
				timelineIndex = 73,
				timerEndOffset = 1,
				timerStartOffset = -12,
				uuid = "5e7bc679-7f93-3ab4-8cf5-3264ac09084e",
				version = 2,
			},
		},
	},
	[74] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "54408b51-10d3-57d8-ac49-08330bf7b05d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Slithering Strike (36809 storm / 36810 ice / 36811 fire; the corner pick is random):\n-- MeleeDowntime begincast +5.0..+8.5 (FFLogs, 14 melee samples). Susurrant Breath / Strangling Coil add nothing.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.SLITHER[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.slither(s, e.spellID, t)\n",
							name = "Slithering Strike melee downtime (ice 1)",
							uuid = "07d5b9d3-7594-b2eb-8005-37da9c4a751b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 3049.6,
				name = "[AutoSim] Valigarmanda EX - Slithering Strike melee downtime (ice 1)",
				timeRange = true,
				timelineIndex = 74,
				timerEndOffset = -1,
				timerStartOffset = -13,
				uuid = "6faf3430-fe07-cf8f-813e-8593f243c592",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "d052b63d-cc54-3978-841d-8eb68c9293e1",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"ec40f60f-b4eb-8fc2-93f3-a9708ce7e4e9",
									true,
								},
							},
							name = "Capture",
							uuid = "d1ec9887-ac8a-c925-8a2e-4d87825a044d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "ec40f60f-b4eb-8fc2-93f3-a9708ce7e4e9",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 3049.6,
				name = "[Draw] Valigarmanda - Avalanche role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 74,
				timerStartOffset = -9.5,
				uuid = "4cf953ee-557f-5ba8-9da1-bf62df08c4a2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"121fabce-aaac-0cfe-a79d-aa89f04f917d",
									true,
								},
							},
							name = "Capture",
							uuid = "8a851396-243c-8a84-a7a5-04f7e6a1b4b8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "121fabce-aaac-0cfe-a79d-aa89f04f917d",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 3049.6,
				name = "[Draw] Valigarmanda - Avalanche role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 74,
				timerEndOffset = 1,
				timerStartOffset = -2,
				uuid = "5c0314fe-726e-6e8c-b632-bdccdc10ca03",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Avalanche stance role spot (ice phase, whole party: avalanche half + cone/out/donut).\n-- Map effect 3: 0x00200010 cleaves the NE half (stay SW), 0x00020001 the SW half (stay NE) (cactbot :710-718,\n-- NorthernCross.cs). Stance from the ice casts 36806/36810/36814 (+helper). Spots: strat 81.webp card 2\n-- (only out + SW-safe is drawn on the card; the other 5 combos are derived and geometry-checked).\nlocal SPOTS = {NE_cone = {118.5, 90.5}, NE_donut = {103.0, 97.0}, NE_out = {118.5, 103.5}, SW_cone = {81.5, 90.5}, SW_donut = {97.0, 103.0}, SW_out = {84.0, 106.0}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal av = V and V.aval\nlocal st = V and V.st\nlocal now = Now()\nif not (av and st) or now - av.t > 20000 or now - st.t > 9000 then return end\nif st.res and now - st.res > 300 then return end\nlocal p = SPOTS[(av.ne and \"SW_\" or \"NE_\") .. st.k]\nif p then vxSpot(p[1], p[2], 1.2) end\n",
							name = "Draw",
							uuid = "e72a9499-94c9-c549-b4ec-db8c0564f2e7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 3049.6,
				name = "[Draw] Valigarmanda - Avalanche role spot",
				timeRange = true,
				timelineIndex = 74,
				timerEndOffset = 0.5,
				timerStartOffset = -7,
				uuid = "366d5dce-beb5-7535-81bb-7f385e0eda72",
				version = 2,
			},
		},
	},
	[75] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "041bab60-7c23-28f7-987f-f6b6865c719c",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Ice: corner mechanic begincast (36806 / 36810 / 36814) -> reposition for Chilling Cataclysm,\n-- CasterDowntime +10.1..+12.7 (FFLogs, 1st one n=20; the 2nd one uses the same offsets, not measured).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif not (sp == 36806 or sp == 36810 or sp == 36814) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.anchor(s, sp, t)\n",
							name = "Chilling Cataclysm 1 movement",
							uuid = "2c63b6ee-55f4-6763-becc-676cf1b2cda8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 3055.6,
				name = "[AutoSim] Valigarmanda EX - Chilling Cataclysm 1 movement",
				timeRange = true,
				timelineIndex = 75,
				timerEndOffset = -8,
				timerStartOffset = -18,
				uuid = "dac555a3-42da-78b5-86fc-b33b5ebb0a1b",
				version = 2,
			},
		},
	},
	[76] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "6d5335d4-571a-8fa9-865f-e64ac03cee02",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityMarkerAdd): who got 507 Bolt / 509 Chill / 344 Ice Talon.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nV.mk = V.mk or {}\nlocal k = eventArgs.markerID\nlocal s = V.mk[k]\nif not s or now - s.t > 5000 then\n  s = {t = now, ids = {}}\n  V.mk[k] = s\nend\ns.ids[eventArgs.entityID] = true\n",
							conditions = 
							{
								
								{
									"a82efac6-b312-e519-b154-2feb6aa93b9a",
									true,
								},
							},
							name = "Capture",
							uuid = "1419f161-be69-24c6-bf5a-fe604627bda0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityMarkerAdd, Dequeue Action if False = on).\n-- 507 Calamity's Bolt, 509 Calamity's Chill, 344 Ice Talon (BossmodReborn Ex1ValigarmandaEnums.cs IconID).\nlocal m = eventArgs.markerID\nreturn m == 507 or m == 509 or m == 344\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "a82efac6-b312-e519-b154-2feb6aa93b9a",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 3063.9,
				name = "[Draw] Valigarmanda - Thunder Spread role spot (capture markers)",
				timeRange = true,
				timelineIndex = 76,
				timerEndOffset = -4,
				timerStartOffset = -9,
				uuid = "98d06d86-6bee-651b-bc1a-d3bb633e09af",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Thunder Spread role spot (ice phase, r5 spreads on one role group, strat 81.webp card 4).\n-- Which group has thunder: your own 507 marker (or Calamity's Bolt 3823) + your role. Supports case is the\n-- card; the DPS case swaps MT<->M1, OT<->M2, H1<->R1, H2<->R2 (assumed).\nlocal SUP = {T1 = {93.2, 86.7}, T2 = {104.7, 86.7}, H1 = {93.2, 103.1}, H2 = {104.6, 101.4}, M1 = {81.6, 92.4}, M2 = {115.4, 92.1}, R1 = {82.0, 98.1}, R2 = {115.9, 104.9}}\nlocal DPS = {T1 = {81.6, 92.4}, T2 = {115.4, 92.1}, H1 = {82.0, 98.1}, H2 = {115.9, 104.9}, M1 = {93.2, 86.7}, M2 = {104.7, 86.7}, R1 = {93.2, 103.1}, R2 = {104.6, 101.4}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal now = Now()\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal a = V and V.mk and V.mk[507]\nlocal mine\nif a and now - a.t < 9000 then\n  mine = a.ids[p.id] and true or false\nelseif TensorCore.hasBuff(p, 3823) then\n  mine = true\nelse\n  return\nend\nlocal sup = (slot:sub(1, 1) == \"T\" or slot:sub(1, 1) == \"H\")\nlocal T = (mine == sup) and SUP or DPS\nlocal q = T[slot]\nvxSpot(q[1], q[2])\n",
							name = "Draw",
							uuid = "c0909936-176a-cb2f-9c3a-c62adae95afa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 3063.9,
				name = "[Draw] Valigarmanda - Thunder Spread role spot",
				timeRange = true,
				timelineIndex = 76,
				timerStartOffset = -7,
				uuid = "6b6ae607-cd74-5997-be80-17cc38bff623",
				version = 2,
			},
		},
	},
	[78] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "0cd30b36-b4d4-e22a-bbaf-4bbc4244359e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnMapEffect): Spikesicle line order, erupting volcano, avalanche half.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal i = eventArgs.a1\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nif i >= 4 and i <= 13 then\n  local s = spGet(V, now)\n  for _, m in ipairs(s.me) do\n    if m.i == i then return end\n  end\n  s.me[#s.me + 1] = {i = i, t = now}\n  s.plan = nil\nelseif i == 14 or i == 15 then\n  V.vol = {i = i, t = now}\nelseif i == 3 then\n  V.aval = {ne = (eventArgs.a2 == 16), t = now}\n  if V.sp then V.sp.plan = nil end\nend\n",
							conditions = 
							{
								
								{
									"397ece58-5253-3f58-a604-bac6900ffa97",
									true,
								},
							},
							name = "Capture",
							uuid = "35b1cad3-00d1-0911-b919-337e721087f1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnMapEffect, Dequeue Action if False = on).\n-- 4..13 state 0x00020004 = Spikesicle lines (BossmodReborn Spikesicle.cs:22); 14/15 state 0x00200010 = volcano\n-- eruption (VolcanicDrop.cs:18-21); 3 state 0x00200010 / 0x00020001 = avalanche half (NorthernCross.cs, cactbot :710-718).\nlocal a1, a2, a3 = eventArgs.a1, eventArgs.a2, eventArgs.a3\nif a1 >= 4 and a1 <= 13 then return a2 == 4 and a3 == 2 end\nif a1 == 14 or a1 == 15 then return a2 == 16 and a3 == 32 end\nif a1 == 3 then return (a2 == 16 and a3 == 32) or (a2 == 1 and a3 == 2) end\nreturn false\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "397ece58-5253-3f58-a604-bac6900ffa97",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 14,
				loop = true,
				mechanicTime = 3079.5,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture map effects)",
				timeRange = true,
				timelineIndex = 78,
				timerEndOffset = 16,
				timerStartOffset = -24,
				uuid = "8d06e8ca-6a9d-4959-8c2b-e51798cece64",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"21c92341-36e6-c776-a1fc-260e5f6a88ec",
									true,
								},
							},
							name = "Capture",
							uuid = "a1d691a9-6130-35d5-85f2-547428d340e0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "21c92341-36e6-c776-a1fc-260e5f6a88ec",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 3079.5,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 78,
				timerEndOffset = 14,
				timerStartOffset = -12,
				uuid = "75721492-031b-416c-b206-b9ed4c37db4a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"48689c8b-accd-ac68-a0a8-10295d68b88b",
									true,
								},
							},
							name = "Capture",
							uuid = "cd4089f3-fe7c-cbfa-8477-859d21db8450",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "48689c8b-accd-ac68-a0a8-10295d68b88b",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 3079.5,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 78,
				timerEndOffset = 20,
				timerStartOffset = -12,
				uuid = "72ba953d-9b98-9de5-9630-a32fa4830883",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityAdd): Ice Boulder 12856 (Sphere Shatter r13 centre), Feather of Ruin\n--   12855 (Blighted Bolt r8 centre), Arcane Sphere 12857 (storm lanes).\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nif not (e and e.pos and e.pos.x) then return end -- not ready yet: retry next tick (self.used stays unset on purpose)\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal c = eventArgs.entityContentID\nlocal id = eventArgs.entityID\nlocal function add(list, rec)\n  for _, r in ipairs(list) do\n    if r.id == id then return end\n  end\n  list[#list + 1] = rec\nend\nif c == 12856 then\n  local s = V.sp\n  if s and now - s.t0 < 45000 then\n    add(s.bould, {id = id, x = e.pos.x, z = e.pos.z, t = now})\n    s.plan = nil\n  end\nelseif c == 12855 then\n  if not V.fea or now - V.fea.t > 40000 then V.fea = {t = now, list = {}} end\n  add(V.fea.list, {id = id, x = e.pos.x, z = e.pos.z})\nelseif c == 12857 then\n  if not V.sph or now - V.sph.t > 15000 then V.sph = {t = now, list = {}} end\n  add(V.sph.list, {id = id, x = e.pos.x, z = e.pos.z})\nend\n",
							conditions = 
							{
								
								{
									"a65a7d75-11c4-d81f-a2df-b8965943f618",
									true,
								},
							},
							name = "Capture",
							uuid = "2eb2216f-b562-6217-acd7-b123a31511a2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityAdd, Dequeue Action if False = on).\n-- 12856 Ice Boulder, 12855 Feather of Ruin, 12857 Arcane Sphere (store reactions key the same ids).\nlocal c = eventArgs.entityContentID\nreturn c == 12856 or c == 12855 or c == 12857\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "a65a7d75-11c4-d81f-a2df-b8965943f618",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 5,
				loop = true,
				mechanicTime = 3079.5,
				name = "[Draw] Valigarmanda - Spikesicle role spot (capture spawns)",
				timeRange = true,
				timelineIndex = 78,
				timerEndOffset = 14,
				uuid = "a4f079cb-1119-46b8-8821-104bf58367fd",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Spikesicle role spot (whole party, opener idx 2 and ice phase idx 78).\n-- Shows the one spot that none of the still-pending attacks hits, re-planned whenever a line fires, a boulder\n-- appears or explodes, or the avalanche half is known:\n--   * 10 lines (map effects 4..13): donuts r20-25/25-30/30-35/35-40 around boss+-20 x, rect 40 x 5 at boss -+17 x\n--     (BossmodReborn Spikesicle.cs:7,34-38). Order: first 04/05, then the whole opposite set, then the rest\n--     (cactbot valigarmanda-ex.ts:121-131); ~1.2 s apart, first ~1.3 s after the Spikesicle cast (FFLogs).\n--   * Ice Boulders (12856): Sphere Shatter r13, in spawn order ~6.5 s after spawn (Spikesicle.cs:61-85).\n--   * ice phase: avalanche half (map effect 3) = rect 60 x 25 (NorthernCross.cs).\n-- Strat (74.webp / 81.webp): wall on the 2nd line's side (first 04 -> west), after 2 lines cross to the other side of\n-- the arrow, after 2 explosions sit at the top of the arrow (ice: slightly left/right of it away from the avalanche).\n-- The strat points are only the preference: the drawn spot is the closest grid point (0.5 y) to it that is outside\n-- every pending AoE (on the wall: until line 2), with a 0.3 y margin (0.8 y preferred), and that you can walk to\n-- without crossing an AoE as it lands; if there is none, the reachable spot that stays clear longest.\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal s = V and V.sp\nif not (s and s.me and #s.me > 0) then return end\nlocal now = Now()\nif now - s.t0 > 45000 or s.shat >= 10 then return end\nlocal first = s.me[1].i\nlocal west = (first == 4)\nlocal av = V.aval\nif av and (av.t < s.t0 - 15000 or av.done) then av = nil end\nlocal key = table.concat({#s.me, s.lines, s.shat, #s.bould, av and (av.ne and \"n\" or \"s\") or \"-\", av and av.nc and 1 or 0,\n  s.castStart and 1 or 0, s.castEnd and 1 or 0}, \":\")\nif not (s.plan and s.plan.key == key) then\n  local bx, bz = s.bx or 100, s.bz or 85\n  local seq\n  if first == 4 then seq = {4, 5, 7, 9, 11, 13, 6, 8, 10, 12} elseif first == 5 then seq = {5, 4, 6, 8, 10, 12, 7, 9, 11, 13} end\n  local order, got = {}, {}\n  for _, m in ipairs(s.me) do\n    order[#order + 1] = m.i\n    got[m.i] = true\n  end\n  if seq then\n    for _, i in ipairs(seq) do\n      if not got[i] then order[#order + 1] = i end\n    end\n  end\n  local base\n  if s.castEnd then base = s.castEnd + 1300 elseif s.castStart then base = s.castStart + 11000 else base = s.me[1].t + 12000 end\n  local H = {}\n  for j = s.lines + 1, #order do\n    local i = order[j]\n    local t = (s.lt and s.lines > 0) and (s.lt + 1200 * (j - s.lines)) or (base + 1200 * (j - 1))\n    t = math.max(now, t)\n    if i <= 11 then\n      local ring = math.floor((i - 4) / 2)\n      local cx = bx + ((i % 2 == 1) and -20 or 20)\n      H[#H + 1] = {k = \"d\", x = cx, z = bz, r1 = 20 + 5 * ring, r2 = 25 + 5 * ring, t = t}\n    else\n      local cx = bx + ((i % 2 == 1) and 17 or -17)\n      H[#H + 1] = {k = \"r\", x = cx, z = bz, dx = 0, dz = 1, len = 40, hw = 2.5, t = t}\n    end\n  end\n  for j = s.shat + 1, #s.bould do\n    local b = s.bould[j]\n    H[#H + 1] = {k = \"c\", x = b.x, z = b.z, r = 13, t = math.max(now, b.t + 6600)}\n  end\n  if av then\n    local ox, oz = 131.487, 107.988\n    if not av.ne then ox, oz = 116.472, 127.977 end\n    -- avalanche resolves ~13 s after the Spikesicle cast (FFLogs ice phase: Northern Cross 3 s after its own cast start)\n    local avT = av.nc and (av.nc + 3000) or math.max(av.t + 3000, base + 11700)\n    H[#H + 1] = {k = \"r\", x = ox, z = oz, dx = -0.8, dz = -0.6, len = 60, hw = 12.5, t = avT}\n  end\n  table.sort(H, function(a, b) return a.t < b.t end)\n  local ax, az\n  if s.lines < 2 then\n    ax, az = west and 81.5 or 118.5, 99.5\n  elseif s.shat < 2 then\n    ax, az = west and 102 or 98, 95\n  elseif av then\n    if av.ne then ax, az = 98.3, 100 else ax, az = 101.2, 99 end\n  else\n    ax, az = 100, 99.5\n  end\n  local n = #H\n  -- on the wall a spot only has to stay clear until line 2 (+3.5 s to walk off); after that it has to stay clear\n  -- of everything still pending (when no such spot can be reached: the one that stays clear longest)\n  local Th = math.huge\n  if s.lines < 2 then Th = math.max(now, base + 1200) + 3500 end\n  local function hit(h, x, z, m)\n    local dx, dz = x - h.x, z - h.z\n    if h.k == \"c\" then\n      local r = h.r + m\n      return dx * dx + dz * dz <= r * r\n    elseif h.k == \"d\" then\n      local d = math.sqrt(dx * dx + dz * dz)\n      return d >= h.r1 - m and d <= h.r2 + m\n    end\n    local a = dx * h.dx + dz * h.dz\n    local p = dx * h.dz - dz * h.dx\n    return a >= -m and a <= h.len + m and math.abs(p) <= h.hw + m\n  end\n  -- every grid point: index of the first pending AoE that hits it (0.3 y margin; n + 1 = never hit);\n  -- cost = distance to the strat point, +3 y when the 0.8 y margin is not met\n  local C = {}\n  -- grid keeps 1 y off the arena edges (ice phase: x < 80, x > 120 and z > 115 are a void zone, Splatoon EX1\n  -- preset \"Ice Phase Void Zone\"; the drawn ring has r1)\n  for xi = 0, 76 do\n    local x = 81 + xi * 0.5\n    for zi = 0, 57 do\n      local z = 85.5 + zi * 0.5\n      local s3, s8 = n + 1, n + 1\n      for j = 1, n do\n        if hit(H[j], x, z, 0.3) then\n          s3 = j\n          break\n        end\n      end\n      for j = 1, s3 - 1 do\n        if hit(H[j], x, z, 0.8) then\n          s8 = j\n          break\n        end\n      end\n      local cost = math.sqrt((x - ax) * (x - ax) + (z - az) * (z - az)) + ((s8 < s3) and 3 or 0)\n      local good = (s3 > n) or (H[s3].t > Th)\n      C[#C + 1] = {x, z, s3, cost, good}\n    end\n  end\n  table.sort(C, function(a, b)\n    if a[5] ~= b[5] then return a[5] end\n    if not a[5] and a[3] ~= b[3] then return a[3] > b[3] end\n    return a[4] < b[4]\n  end)\n  -- walk check: straight run from where you stand; by the time an AoE lands you have covered between\n  -- (t - 0.6 s) * 5 y/s and (t - 0.2 s) * 6.5 y/s of the path: none of those points may be inside it\n  local me = TensorCore.mGetPlayer()\n  local px, pz = ax, az\n  if me and me.pos then px, pz = me.pos.x, me.pos.z end\n  local function pathOk(x, z)\n    local d = math.sqrt((x - px) * (x - px) + (z - pz) * (z - pz))\n    local steps = math.max(1, math.ceil(d / 0.5))\n    for j = 1, n do\n      local h = H[j]\n      local dt = (h.t - now) / 1000\n      local lo = math.max(0, (dt - 0.6) * 5) - 0.25\n      local hi = math.max(0, (dt - 0.2) * 6.5) + 0.25\n      if lo <= d then\n        for k = 0, steps do\n          local sd = d * k / steps\n          if sd >= lo and sd <= hi and hit(h, px + (x - px) * k / steps, pz + (z - pz) * k / steps, 0.3) then return false end\n        end\n      end\n    end\n    return true\n  end\n  local pick = C[1]\n  for i = 1, #C do\n    if pathOk(C[i][1], C[i][2]) then\n      pick = C[i]\n      break\n    end\n  end\n  local bxp, bzp, bs = pick[1], pick[2], pick[3]\n  s.plan = {key = key, x = bxp, z = bzp, clear = bs - 1, n = n}\nend\nvxSpot(s.plan.x, s.plan.z, 1.0)\n",
							name = "Draw",
							uuid = "3d1ed400-6103-5a80-b826-2fd25a078261",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 3079.5,
				name = "[Draw] Valigarmanda - Spikesicle role spot",
				timeRange = true,
				timelineIndex = 78,
				timerEndOffset = 19.5,
				timerStartOffset = -12,
				uuid = "5be6e016-f5c7-ca6a-b1de-f3779e0fc019",
				version = 2,
			},
		},
	},
	[80] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "33efb9c8-8fd6-3c9b-86bc-eda69d7ba97e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Slithering Strike (36809 storm / 36810 ice / 36811 fire; the corner pick is random):\n-- MeleeDowntime begincast +5.0..+8.5 (FFLogs, 14 melee samples). Susurrant Breath / Strangling Coil add nothing.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and V.SLITHER[e.spellID]) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.slither(s, e.spellID, t)\n",
							name = "Slithering Strike melee downtime (ice 2)",
							uuid = "18fcc00c-851d-d2a5-8633-f49b01d56caf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 3115.6,
				name = "[AutoSim] Valigarmanda EX - Slithering Strike melee downtime (ice 2)",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = -1,
				timerStartOffset = -13,
				uuid = "848c5c15-646f-b85e-920f-cf7378ebd660",
				version = 2,
			},
		},
	},
	[81] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "8a7bbd12-3d9b-bced-b781-80cf351c876b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Ice: corner mechanic begincast (36806 / 36810 / 36814) -> reposition for Chilling Cataclysm,\n-- CasterDowntime +10.1..+12.7 (FFLogs, 1st one n=20; the 2nd one uses the same offsets, not measured).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif not (sp == 36806 or sp == 36810 or sp == 36814) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.anchor(s, sp, t)\n",
							name = "Chilling Cataclysm 2 movement",
							uuid = "daef2c66-313b-fb9d-b79b-10fa4ef517f0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 3121.6,
				name = "[AutoSim] Valigarmanda EX - Chilling Cataclysm 2 movement",
				timeRange = true,
				timelineIndex = 81,
				timerEndOffset = -8,
				timerStartOffset = -18,
				uuid = "ccb6f296-bc1e-558d-8480-2103b2ab6f76",
				version = 2,
			},
		},
	},
	[83] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "b9049024-026a-5cd3-8c23-388c264a7a83",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [AutoSim] Ice: Freezing Dust (36848 begincast, 5.0+0.8 s): move check at cast end, then Freezing Up 2 s.\n-- CasterDowntime +5.0..+8.0 (from BossMod FreezingDust.cs:10 / States.cs:326-332; not FFLogs-measured).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\n-- ===== Valigarmanda EX universal AutoSim library v4 =====\n-- The same block is in every [AutoSim] reaction of \"ex1 autosim\"; whichever reaction runs first defines it.\n-- Pull state lives in TensorValX (the wipe reaction clears it). No job condition: an ACR ignores phase types it doesn't use.\nlocal V = TensorValXLib\nif not (V and V.v == 4) then\n  V = {v = 4}\n  TensorValXLib = V\n  -- Kill 292.4 s = mean of our last 2 clears (2026-11-13 15:42 = 293.1, 15:51 = 291.8); return 38323 at 216.6 in both.\n  -- Window times are FFLogs pull times. The opener Spikesicle sync shifts them onto this client's AutoSim clock;\n  -- after the Beacons, 38323 re-times the kill (292.4 - 216.6 = 75.8 s after it).\n  V.KILL = 292.4\n  V.RET = 216.6   -- Valigarmanda's return cast 38323 (our last 2 clears)\n  V.RUIN = 192.1  -- Ruin Foretold 38546 begincast\n  V.SPIKE = 9.9   -- opening Spikesicle 36850 begincast\n  V.CRY = 6.05    -- Calamitous Cry slot spacing; 38323 takes the first free slot after the last Beacon dies\n  V.TGT = 1.5     -- Valigarmanda targetable ~1.5 s before 38323 (FFLogs 1.4-5.8, 2-Cry kills 1.4-2.4); prediction only\n  V.BM = 0.8      -- Beacon-phase damage weight (same as the Zelenia EX adds)\n  V.BOSS = 12854  -- Valigarmanda content ID (helpers share it but are never targetable)\n  -- DoT blacklist: short-lived adds / objects. Valigarmanda itself (12854) is never blacklisted.\n  V.DOTBL = {\n    {12858, \"Flame-kissed Beacon\"}, {12859, \"Glacial Beacon\"}, {12860, \"Thunderous Beacon\"},\n    {12855, \"Feather of Ruin\"}, {12856, \"Ice Boulder\"},\n  }\n  -- Windows placed at setup (FFLogs pull time), each re-timed by its anchor cast below.\n  V.PRE = {\n    {\"c_scourge\", \"CasterDowntime\", 134.8, 142.0}, -- Scourge of Fire x3 puddles\n    {\"c_ruin\", \"CasterDowntime\", 197.7, 198.9},    -- boss vanishes, Beacons not targetable yet\n    {\"f_leave\", \"FullDowntime\", 198.0, 199.1},     -- nothing targetable\n  }\n  -- Anchored windows: [spellID] = {count group, {ordinal, key, type, start offset, end offset}, ...}\n  local ICE = {\"icecorner\", {1, \"c_ice1\", \"CasterDowntime\", 10.1, 12.7}, {2, \"c_ice2\", \"CasterDowntime\", 10.1, 12.7}}\n  V.ANCH = {\n    [36876] = {\"mf\", {1, \"c_scourge\", \"CasterDowntime\", 44.6, 51.8}},    -- Mountain Fire begincast 1\n    [38546] = {\"ruin\", {1, \"f_leave\", \"FullDowntime\", 5.9, 7.0}, {1, \"c_ruin\", \"CasterDowntime\", 5.6, 6.8}},\n    [36829] = {\"hof\", {1, \"c_feath1\", \"CasterDowntime\", 7.4, 15.5}},     -- storm: Hail of Feathers drops\n    [36831] = {\"bb\", {1, \"c_feath2\", \"CasterDowntime\", 9.8, 12.9}},      -- storm: feathers explode, spread\n    [36806] = ICE, [36810] = ICE, [36814] = ICE,                         -- ice corner -> Chilling Cataclysm\n    [36848] = {\"fdust\", {1, \"c_fdust\", \"CasterDowntime\", 5.0, 8.0}},     -- ice: Freezing Dust move check\n  }\n  V.SLITHER = {[36809] = true, [36810] = true, [36811] = true}          -- Slithering Strike (storm/ice/fire)\n  -- Elemental Skyruin cast end (S + 6.0): predict that phase's movement before the closer anchors arrive.\n  V.ELEM = {\n    [38339] = {\"storm\", {{\"c_feath1\", 46.8, 54.9}, {\"c_feath2\", 74.4, 77.5}}},\n    [36817] = {\"ice\", {{\"c_ice1\", 52.5, 55.1}, {\"c_ice2\", 118.5, 121.1}, {\"c_fdust\", 130.5, 133.5}}},\n  }\n  V.KINDS = {\"FullDowntime\", \"MeleeDowntime\", \"CasterDowntime\", \"BossModifier\"}\n\n  function V.api() return TensorCore and TensorCore.API and TensorCore.API.TensorACR end\n  function V.time()\n    local api = V.api()\n    if not api then return nil end\n    local ok, t = pcall(api.getAutoSimTime)\n    if ok and type(t) == \"number\" then return t end\n  end\n  -- Place or move window `key`. Same-type windows must not overlap, so clip against my other windows first.\n  function V.place(s, key, kind, a, b, v)\n    local api = V.api()\n    if not api then return end\n    for _ = 1, 4 do\n      local hit = false\n      for k, o in pairs(s.win) do\n        if k ~= key and o.kind == kind and a < o.b and o.a < b then\n          hit = true\n          if o.a <= a then a = o.b else b = o.a end\n        end\n      end\n      if not hit then break end\n    end\n    local w = s.win[key]\n    if b - a < 0.2 then\n      if w and w.id then pcall(api.removeAutoSimPhase, w.id) end\n      s.win[key] = nil\n      return\n    end\n    if w and w.id then\n      local ok, id = pcall(api.setAutoSimPhase, w.id, a, b, v)\n      if ok then w.id, w.a, w.b, w.v = id, a, b, v; return id end\n      pcall(api.removeAutoSimPhase, w.id)\n    end\n    local ok, id = pcall(api.addAutoSimPhase, kind, a, b, v)\n    s.win[key] = {kind = kind, a = a, b = b, v = v, id = ok and id or nil}\n    return ok and id or nil\n  end\n  function V.unc(s, key, t, sec)\n    local api = V.api()\n    if not api then return end\n    for k, u in pairs(s.unc) do\n      if k ~= key and math.abs(u.t - t) < 0.05 then t = t + 0.1 end\n    end\n    local u = s.unc[key]\n    if u and u.id then\n      local ok = pcall(api.setAutoSimUncertainty, u.id, t, sec)\n      if ok then u.t, u.s = t, sec; return end\n      pcall(api.removeAutoSimUncertainty, u.id)\n    end\n    local ok, id = pcall(api.addAutoSimUncertainty, t, sec)\n    s.unc[key] = {id = ok and id or nil, t = t, s = sec}\n  end\n  function V.kill(s, k)\n    local api = V.api()\n    if not api then return end\n    s.kill = k\n    pcall(api.setAutoSimKillTime, k)\n    local lo = (s.unc.adds and s.unc.adds.t or 0) + 1\n    V.unc(s, \"kill\", math.max(k - 45, lo), 10) -- kill spread (FFLogs recent-20 IQR 276-300)\n  end\n  -- Predicted return cast 38323 at `pred`: Beacon-phase 0.8 window, return gap, kill.\n  function V.retPred(s, pred)\n    if s.back or s.ret then return end\n    s.pred = pred\n    local tg = pred - V.TGT\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tg, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tg - 0.7, tg)\n    V.kill(s, pred + V.KILL - V.RET)\n  end\n  function V.setup(fromCountdown)\n    local api = V.api()\n    if not api then return nil end\n    for _, k in ipairs(V.KINDS) do pcall(api.clearAutoSimPhases, k) end\n    pcall(api.clearAutoSimUncertainty)\n    local s = {win = {}, unc = {}, cnt = {}, last = {}, done = {}, shift = 0, bmA = 198.0,\n               stamp = Now and Now() or 0, cd = fromCountdown and true or false}\n    TensorValX = s\n    for _, p in ipairs(V.PRE) do V.place(s, p[1], p[2], p[3], p[4]) end\n    V.unc(s, \"base\", 0, 0.5)   -- phase 1 is a fixed clock (<= 1 s jitter)\n    V.unc(s, \"adds\", 198.0, 6) -- Beacon kill speed: return lands in 6.05 s steps\n    V.retPred(s, V.RET)\n    local dirty = false\n    for _, b in ipairs(V.DOTBL) do\n      local okE, has = pcall(api.getBlacklistEntry, b[1])\n      if okE and not has then\n        if pcall(api.addBlacklistEntry, b[1], b[2]) then dirty = true end\n      end\n    end\n    if dirty then pcall(api.saveDotBlacklist) end\n    return s\n  end\n  -- True while the schedule this state was set up on is still live. AutoSim raises on an unknown or reset\n  -- uncertainty change ID, so re-applying the base change with the same values is a side-effect-free probe.\n  function V.alive(s)\n    local api = V.api()\n    local u = s and s.unc and s.unc.base\n    if not (api and u and u.id) then return false end\n    return (pcall(api.setAutoSimUncertainty, u.id, u.t, u.s))\n  end\n  -- Pull state; created late (mid-pull) only when setup never ran and combat is on.\n  function V.get()\n    local s = TensorValX\n    if s then return s end\n    local t = V.time()\n    if t and t > 1 then\n      s = V.setup(false)\n      if s then s.lazy = true end\n      return s\n    end\n  end\n  -- Opening Spikesicle: move the not-yet-synced predictions onto this client's clock.\n  function V.opener(s, t)\n    if s.op or s.back or s.ret then return end\n    s.op = true\n    s.live = true\n    local d = t - V.SPIKE\n    if math.abs(d) > 8 then return end\n    s.shift = d\n    for _, p in ipairs(V.PRE) do\n      if not s.done[p[1]] then V.place(s, p[1], p[2], p[3] + d, p[4] + d) end\n    end\n    if not s.ruin then\n      s.bmA = 198.0 + d\n      V.unc(s, \"adds\", 198.0 + d, 6)\n      V.retPred(s, V.RET + d)\n    end\n  end\n  -- Ordinal-counted anchor casts (5 s debounce: copies and helper duplicates count once).\n  function V.anchor(s, sp, t)\n    local A = V.ANCH[sp]\n    if not A then return end\n    local g = A[1]\n    if not s.last[g] or t - s.last[g] > 5 then\n      s.last[g] = t\n      s.cnt[g] = (s.cnt[g] or 0) + 1\n    end\n    local n = s.cnt[g]\n    for i = 2, #A do\n      local w = A[i]\n      if w[1] == n and not s.done[w[2]] then\n        s.done[w[2]] = true\n        V.place(s, w[2], w[3], t + w[4], t + w[5])\n      end\n    end\n  end\n  function V.ruin(s, t)\n    s.live = true\n    V.anchor(s, 38546, t)\n    if s.ruin or s.back or s.ret then return end\n    s.ruin = t\n    s.bmA = t + 5.9\n    V.unc(s, \"adds\", t + 5.9, 6)\n    V.retPred(s, t + V.RET - V.RUIN)\n  end\n  function V.cry(s, t)\n    if s.back or s.ret then return end\n    if s.lastCry and t - s.lastCry < 2 then return end\n    s.lastCry = t\n    s.nCry = (s.nCry or 0) + 1\n    local p = t + V.CRY\n    if p > (s.pred or 0) + 0.5 then V.retPred(s, p) end\n  end\n  -- Valigarmanda targetable again (last Beacon dead): end the 0.8 weighting here.\n  function V.back(s, tb)\n    if s.back then return end\n    s.back = tb\n    s.live = true\n    V.place(s, \"bm\", \"BossModifier\", s.bmA, tb, V.BM)\n    V.place(s, \"f_return\", \"FullDowntime\", tb - 0.6, tb)\n    V.unc(s, \"adds\", tb, 1.0)\n    if not s.ret then\n      local p = tb + V.TGT\n      if s.lastCry and s.lastCry + V.CRY > tb then p = s.lastCry + V.CRY end\n      s.pred = p\n      V.kill(s, p + V.KILL - V.RET)\n    end\n  end\n  -- Return cast 38323: everything after it is a fixed clock.\n  function V.ret(s, t)\n    if s.ret then return end\n    if not s.back then V.back(s, t - V.TGT) end\n    s.ret = t\n    V.kill(s, t + V.KILL - V.RET)\n  end\n  function V.elem(s, sp, t)\n    local E = V.ELEM[sp]\n    if not E or s.done[\"elem\" .. sp] then return end\n    s.done[\"elem\" .. sp] = true\n    local S = t - 6.0\n    s.order = (s.order and (s.order .. \">\") or \"\") .. E[1]\n    if not s.ret and not s.order:find(\">\") then V.ret(s, S - 32.6) end\n    for _, w in ipairs(E[2]) do\n      if not s.done[w[1]] then V.place(s, w[1], \"CasterDowntime\", S + w[2], S + w[3]) end\n    end\n  end\n  function V.slither(s, sp, t)\n    if not V.SLITHER[sp] then return end\n    if s.lastSl and t - s.lastSl < 5 then return end\n    s.lastSl = t\n    s.nSl = (s.nSl or 0) + 1\n    V.place(s, \"m_sl\" .. s.nSl, \"MeleeDowntime\", t + 5.0, t + 8.5)\n  end\n  -- Calamity's Chill (3822) on me: Freezing Up (move check, 2 s) starts when it runs out.\n  function V.chill(s)\n    local t = V.time()\n    if not t then return false end\n    local p = TensorCore.mGetPlayer and TensorCore.mGetPlayer()\n    if not p then return false end\n    local ok, b = pcall(TensorCore.getBuff, p, 3822)\n    if not (ok and b and b.duration and b.duration > 0) then return false end\n    local ex = t + b.duration\n    local k = \"c_chill\" .. math.floor(ex + 0.5)\n    if not s.win[k] then V.place(s, k, \"CasterDowntime\", ex, ex + 2.0) end\n    return true\n  end\nend\n-- ===== end library =====\nlocal e = eventArgs\nif not (e and e.spellID == 36848) then return end\nlocal s = V.get()\nlocal t = V.time()\nif not (s and t) then return end\nV.anchor(s, 36848, t)\n",
							name = "Freezing Dust movement",
							uuid = "cb367b2b-b811-f092-a707-f5ba1cbb5187",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 3130.4,
				name = "[AutoSim] Valigarmanda EX - Freezing Dust movement",
				timeRange = true,
				timelineIndex = 83,
				timerEndOffset = -1,
				timerStartOffset = -9,
				uuid = "19186d32-5082-8bcd-b47d-d488a985196d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Motion",
				uuid = "de9d78a8-bc63-39f7-9a3e-91b53b14f95a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"e6d1a5af-7031-aff3-bafe-45bd76a6d5b9",
									true,
								},
							},
							name = "Force slidecast (Chill)",
							uuid = "4c9355b9-7e7d-2f43-a5c6-f9ebe45c92ab",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: keep casting while you move (TensorDrift only).\nif TensorDrift_SlidecastForceHold ~= nil then\n  TensorDrift_SlidecastForceHold = true\n  data.valxSlide = true\nend",
							conditions = 
							{
								
								{
									"a2126271-8461-8563-81d0-ba4cf4c12456",
									true,
								},
							},
							name = "Force slidecast (Freezing Up)",
							uuid = "1c87d235-973b-4132-87b5-9d0107e8268d",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"d9d11ca9-5595-9bc4-b62a-47050344b609",
									true,
								},
							},
							name = "Jump (Chill <= 1.5 s)",
							uuid = "a5e4a35e-d6b5-77d3-bb49-1d5d41070037",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Lj's DMU motion pattern: jumping keeps you in motion for Freezing Up (2 s check after Calamity's Chill runs out).\nlocal now = Now()\nif data.valxJumpT and now - data.valxJumpT < 600 then return end\nlocal p = TensorCore.mGetPlayer()\nif p then\n  data.valxJumpT = now\n  p:Jump()\nend",
							conditions = 
							{
								
								{
									"a2126271-8461-8563-81d0-ba4cf4c12456",
									true,
								},
							},
							name = "Jump (Freezing Up)",
							uuid = "ad63b7e7-3918-bda4-be0d-b590a1d678b5",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Chill and Freezing Up are gone: release the forced slidecast this reaction set.\nif data.valxSlide then\n  TensorDrift_SlidecastForceHold = false\n  data.valxSlide = nil\nend",
							conditions = 
							{
								
								{
									"e6d1a5af-7031-aff3-bafe-45bd76a6d5b9",
									false,
								},
								
								{
									"a2126271-8461-8563-81d0-ba4cf4c12456",
									false,
								},
							},
							name = "End slidecast",
							uuid = "cb856a02-6378-f466-b92c-700721725859",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 3,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 3 s",
							uuid = "e6d1a5af-7031-aff3-bafe-45bd76a6d5b9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 1.5,
							buffID = 3822,
							category = "Self",
							comparator = 2,
							name = "Chill <= 1.5 s",
							uuid = "d9d11ca9-5595-9bc4-b62a-47050344b609",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 3523,
							category = "Self",
							name = "Freezing Up",
							uuid = "a2126271-8461-8563-81d0-ba4cf4c12456",
							version = 3,
						},
					},
				},
				displayPath = "Motion",
				loop = true,
				mechanicTime = 3130.4,
				name = "[Motion] Valigarmanda - Calamity's Chill / Freezing Up: jump + slidecast",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 83,
				timerEndOffset = 12,
				timerStartOffset = -2,
				uuid = "3108d759-f8c8-3ba3-8707-a1a7b9a5144b",
				version = 2,
			},
		},
	},
	[84] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "149460f2-46be-1226-afe8-72838db6b06d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityMarkerAdd): who got 507 Bolt / 509 Chill / 344 Ice Talon.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nV.mk = V.mk or {}\nlocal k = eventArgs.markerID\nlocal s = V.mk[k]\nif not s or now - s.t > 5000 then\n  s = {t = now, ids = {}}\n  V.mk[k] = s\nend\ns.ids[eventArgs.entityID] = true\n",
							conditions = 
							{
								
								{
									"f03c2ade-a93f-f46c-9a76-abdd144c3bb1",
									true,
								},
							},
							name = "Capture",
							uuid = "5c50eb0d-ab51-232e-b760-14663afca875",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityMarkerAdd, Dequeue Action if False = on).\n-- 507 Calamity's Bolt, 509 Calamity's Chill, 344 Ice Talon (BossmodReborn Ex1ValigarmandaEnums.cs IconID).\nlocal m = eventArgs.markerID\nreturn m == 507 or m == 509 or m == 344\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "f03c2ade-a93f-f46c-9a76-abdd144c3bb1",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 3140.7,
				name = "[Draw] Valigarmanda - Thunder Spread role spot (capture markers)",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = -4,
				timerStartOffset = -9,
				uuid = "d9003c67-ea8d-4354-9afd-223b4ec47050",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Thunder Spread role spot (ice phase, r5 spreads on one role group, strat 81.webp card 4).\n-- Which group has thunder: your own 507 marker (or Calamity's Bolt 3823) + your role. Supports case is the\n-- card; the DPS case swaps MT<->M1, OT<->M2, H1<->R1, H2<->R2 (assumed).\nlocal SUP = {T1 = {93.2, 86.7}, T2 = {104.7, 86.7}, H1 = {93.2, 103.1}, H2 = {104.6, 101.4}, M1 = {81.6, 92.4}, M2 = {115.4, 92.1}, R1 = {82.0, 98.1}, R2 = {115.9, 104.9}}\nlocal DPS = {T1 = {81.6, 92.4}, T2 = {115.4, 92.1}, H1 = {82.0, 98.1}, H2 = {115.9, 104.9}, M1 = {93.2, 86.7}, M2 = {104.7, 86.7}, R1 = {93.2, 103.1}, R2 = {104.6, 101.4}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal now = Now()\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal a = V and V.mk and V.mk[507]\nlocal mine\nif a and now - a.t < 9000 then\n  mine = a.ids[p.id] and true or false\nelseif TensorCore.hasBuff(p, 3823) then\n  mine = true\nelse\n  return\nend\nlocal sup = (slot:sub(1, 1) == \"T\" or slot:sub(1, 1) == \"H\")\nlocal T = (mine == sup) and SUP or DPS\nlocal q = T[slot]\nvxSpot(q[1], q[2])\n",
							name = "Draw",
							uuid = "55421d01-7292-0b35-ae0c-e317a13e0da9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 3140.7,
				name = "[Draw] Valigarmanda - Thunder Spread role spot",
				timeRange = true,
				timelineIndex = 84,
				timerStartOffset = -7,
				uuid = "8c6acda3-2d56-a40e-8615-d7be9019f59a",
				version = 2,
			},
		},
	},
	[86] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "4fe32610-a121-050c-983e-927ed3b37a88",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityMarkerAdd): who got 507 Bolt / 509 Chill / 344 Ice Talon.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nV.mk = V.mk or {}\nlocal k = eventArgs.markerID\nlocal s = V.mk[k]\nif not s or now - s.t > 5000 then\n  s = {t = now, ids = {}}\n  V.mk[k] = s\nend\ns.ids[eventArgs.entityID] = true\n",
							conditions = 
							{
								
								{
									"af789b04-a7dc-2544-9286-2a7f52a453b7",
									true,
								},
							},
							name = "Capture",
							uuid = "b58bae1d-5d26-77ba-8b2d-b6183c09cfb1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityMarkerAdd, Dequeue Action if False = on).\n-- 507 Calamity's Bolt, 509 Calamity's Chill, 344 Ice Talon (BossmodReborn Ex1ValigarmandaEnums.cs IconID).\nlocal m = eventArgs.markerID\nreturn m == 507 or m == 509 or m == 344\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "af789b04-a7dc-2544-9286-2a7f52a453b7",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 3157.7,
				name = "[Draw] Valigarmanda - Ice Talon role spot (capture markers)",
				timeRange = true,
				timelineIndex = 86,
				timerStartOffset = -8,
				uuid = "a382d66b-712f-c923-a419-63e8f1f8f539",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Ice Talon role spot. r6 busters on the top-2 enmity players (icon 344, Enums.cs:98-99).\n-- Strat 82.png: the two busters go to the MT/OT spots, the party clumps at the arrow. A non-tank with the icon\n-- takes the tank spot the other icon holder is not using.\nlocal SPOTS = {T1 = {93.8, 93.8}, T2 = {104.8, 93.8}, H1 = {100.0, 102.4}, H2 = {105.6, 100.8}, M1 = {94.4, 103.4}, M2 = {100.0, 99.5}, R1 = {96.2, 101.9}, R2 = {102.9, 101.9}}\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal now = Now()\nlocal slot = vxSlot()\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal a = V and V.mk and V.mk[344]\nlocal q\nif a and now - a.t < 8000 then\n  if a.ids[p.id] then\n    if slot == \"T1\" then q = SPOTS.T1 elseif slot == \"T2\" then q = SPOTS.T2 else\n      local Ro = AnyoneCore and AnyoneCore.Roster\n      local other\n      for id in pairs(a.ids) do\n        if id ~= p.id and Ro and Ro.slotOf then\n          local ok, s = pcall(Ro.slotOf, id)\n          if ok then other = s end\n        end\n      end\n      q = (other == \"T1\") and SPOTS.T2 or SPOTS.T1\n    end\n  elseif slot == \"T1\" or slot == \"T2\" then\n    q = {100, 101.5}\n  else\n    q = SPOTS[slot]\n  end\nelse\n  q = SPOTS[slot]\nend\nvxSpot(q[1], q[2])\n",
							name = "Draw",
							uuid = "f40161ce-509c-3acc-9732-91833ee78025",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 3157.7,
				name = "[Draw] Valigarmanda - Ice Talon role spot",
				timeRange = true,
				timelineIndex = 86,
				timerStartOffset = -5,
				uuid = "6a87ff9d-7076-ec31-8338-48288fcf8e6a",
				version = 2,
			},
		},
	},
	[90] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "31cd4b4b-a7ea-ac82-9d73-17980923ab70",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"0599741c-f4cf-4504-8dc9-4e6bef3272ef",
									true,
								},
							},
							name = "Capture",
							uuid = "41459546-ece8-dbdd-9517-b59dd1d36f2e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "0599741c-f4cf-4504-8dc9-4e6bef3272ef",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 4018.9,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 90,
				timerEndOffset = 1,
				timerStartOffset = -5,
				uuid = "bb5b47db-57b4-1d56-83dc-04ca666ae16c",
				version = 2,
			},
		},
	},
	[91] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "850ed79b-36c9-3d15-8365-ee6b122e5595",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"4bca9be8-5d52-3db3-9f94-443bcf71bd62",
									true,
								},
							},
							name = "Capture",
							uuid = "5150350d-6b67-bebe-894e-a1dd50973e7d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "4bca9be8-5d52-3db3-9f94-443bcf71bd62",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 4024.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 91,
				timerStartOffset = -4.5,
				uuid = "98aae187-23f0-3974-b1ca-fabc1e3b35a5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"92f47f23-53c1-5f81-a5d4-9ff86c1f279a",
									true,
								},
							},
							name = "Capture",
							uuid = "cc967d24-2a5a-1335-bbcb-525286d9494d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "92f47f23-53c1-5f81-a5d4-9ff86c1f279a",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 4024.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 91,
				timerStartOffset = -4.5,
				uuid = "7172346a-5b73-c26f-aa79-6705d26809bf",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"149594d5-1f4a-8f08-b718-64afdebbcfdb",
									true,
								},
							},
							name = "Capture",
							uuid = "b95c8056-21b4-7e07-92f9-22b62f1f7eb9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "149594d5-1f4a-8f08-b718-64afdebbcfdb",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 4024.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 91,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "12fa24ef-ba6c-08a5-8cdd-6a2ba1b61649",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "91dbce85-3f51-45b5-87fa-3f420d0cc0c9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 4024.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 91,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "ac64cedd-897f-8dd5-a9b8-2637f373ddb0",
				version = 2,
			},
		},
	},
	[92] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "786e2f1d-feef-3a37-a1e0-997511fc169e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"b6891f15-992a-49b2-af71-255fe8b571d0",
									true,
								},
							},
							name = "Capture",
							uuid = "9ae42db7-eef5-66ee-8cef-1dfd2ee72bb3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "b6891f15-992a-49b2-af71-255fe8b571d0",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 4029.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 92,
				timerStartOffset = -4.5,
				uuid = "b8f22b3e-b83c-cff5-8772-05412e65a592",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"43661be6-24b5-9217-a272-0dc9b35df46c",
									true,
								},
							},
							name = "Capture",
							uuid = "21dc69ee-ecfd-dbd8-8540-b3f6d27a7e43",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "43661be6-24b5-9217-a272-0dc9b35df46c",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 4029.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 92,
				timerStartOffset = -4.5,
				uuid = "9cb937f1-20f2-e042-9c08-57a78bb3d09b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"e26b9907-06f6-8acc-bd81-022a0744194f",
									true,
								},
							},
							name = "Capture",
							uuid = "b98a28bf-87bb-e17c-8353-e2d6bc5b66eb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "e26b9907-06f6-8acc-bd81-022a0744194f",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 4029.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 92,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "56c3ee90-15c1-57c2-a98e-3a5aa2618926",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "814baa94-4c99-e0de-b0d9-0fd9b433307c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 4029.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 92,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "06b5a47c-553a-1899-a433-65d3917a0d59",
				version = 2,
			},
		},
	},
	[93] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "b4d91485-0b18-e61c-a1a1-4cc633d5003c",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"a2f7abe2-130c-3b63-8f86-fa2689b82620",
									true,
								},
							},
							name = "Capture",
							uuid = "ecf9d4c7-a01d-f76c-a64b-56305a8c6f3c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "a2f7abe2-130c-3b63-8f86-fa2689b82620",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 4034.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 93,
				timerStartOffset = -4.5,
				uuid = "43619eba-6046-8423-b374-98b14dbe6f79",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"04f4a2df-1287-9feb-a2c6-7683d65bcb7c",
									true,
								},
							},
							name = "Capture",
							uuid = "e2a616cb-4901-e675-977f-654807638bc4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "04f4a2df-1287-9feb-a2c6-7683d65bcb7c",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 4034.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 93,
				timerStartOffset = -4.5,
				uuid = "8936a003-7220-dab3-b07e-1c18db539580",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"d8fe0f53-13d2-6ed8-bb79-f2806ab35a34",
									true,
								},
							},
							name = "Capture",
							uuid = "dbf85b4b-14b3-54d5-bc88-54389b989931",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "d8fe0f53-13d2-6ed8-bb79-f2806ab35a34",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 4034.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "021724b6-2395-2896-908b-01645673d957",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "5030f9c0-eac9-a54a-bc84-3798799ba6b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 4034.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "d7fc4e02-8c32-9332-847d-992a8cd6481a",
				version = 2,
			},
		},
	},
	[94] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "49eb2858-1258-5ae2-a1a3-e4212a83224d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"2d7c9e76-e940-5d3e-8c54-bb6044bc6047",
									true,
								},
							},
							name = "Capture",
							uuid = "fd4c072f-cdb6-7320-88f0-782f187eacb4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "2d7c9e76-e940-5d3e-8c54-bb6044bc6047",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 4039.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 94,
				timerStartOffset = -4.5,
				uuid = "4405088d-9f86-a871-bc41-37aa928a1bde",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"c590f233-ea88-d28d-8ad9-2217721653ca",
									true,
								},
							},
							name = "Capture",
							uuid = "df528db0-3413-1512-966f-70108dd0980e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "c590f233-ea88-d28d-8ad9-2217721653ca",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 4039.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 94,
				timerStartOffset = -4.5,
				uuid = "d0c04ee6-d8d9-c17f-9d38-104f9b21f15d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"bd4a8e44-c42d-fec9-9a39-cb3c9f731677",
									true,
								},
							},
							name = "Capture",
							uuid = "82901e0a-fad5-4180-9b6e-f482549dd47e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "bd4a8e44-c42d-fec9-9a39-cb3c9f731677",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 4039.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 94,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "b8ea0c7c-0972-6dfa-a97e-b2f28af55b67",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "3246b993-b6c2-50ff-9532-4a2f3a5232d0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 4039.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 94,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "e9782570-6667-e368-808a-ce949a88bf9c",
				version = 2,
			},
		},
	},
	[95] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "e385ec11-74ce-56e1-9182-cbd46255d7cc",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"6b3191e3-7274-7b3f-b64d-edc6de101f9d",
									true,
								},
							},
							name = "Capture",
							uuid = "6c2784e7-2057-af66-93c7-44cb9cbbe62a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "6b3191e3-7274-7b3f-b64d-edc6de101f9d",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 4044.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 95,
				timerStartOffset = -4.5,
				uuid = "d8de38e3-0872-3652-a870-2e9de27942cf",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"7f0319bf-a5d3-e499-ae03-cad312aac7f3",
									true,
								},
							},
							name = "Capture",
							uuid = "37cc7a17-0db6-e9de-8580-50e1f8abaf7f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "7f0319bf-a5d3-e499-ae03-cad312aac7f3",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 4044.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 95,
				timerStartOffset = -4.5,
				uuid = "71c55a50-6ed6-d9bc-b533-3be826b74be8",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"3fdcc1a5-b37f-ce6e-bd6a-ee71792f656c",
									true,
								},
							},
							name = "Capture",
							uuid = "fd84bb90-96a1-8a92-81b7-f8b54f17ff2b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "3fdcc1a5-b37f-ce6e-bd6a-ee71792f656c",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 4044.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 95,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "99e6d050-6c0c-ea3b-9a73-27c7a8d0a970",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "0d1f6019-d566-cfe5-bfce-788729cf868a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 4044.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 95,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "97e27b16-a8f1-f77c-95ae-21af296dd349",
				version = 2,
			},
		},
	},
	[96] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Draws",
				uuid = "57c2d751-4494-f911-8081-557168365712",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnAOECreate = Argus cast location): 36889 Mountain Fire tower (x/z/heading),\n--   36893 first Hail of Feathers drop, 36861 Ruinfall tower, 36808/36812/36816 stance AoE origin.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal id = eventArgs.aoeID\nlocal x, z, h = eventArgs.x, eventArgs.z, eventArgs.heading\nif not (x and z) then return end\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif id == 36889 then\n  mfTower(V, now, x, z, h, \"aoe\")\nelseif id >= 36893 and id <= 36898 then\n  -- Hail of Feathers: all six drops are created at once (36893..36898 land 5.7 / 8.7 / ... / 20.7 s later)\n  local H = V.hofd\n  if not H or now - H.t > 3000 then\n    H = {t = now, d = {}}\n    V.hofd = H\n  end\n  H.d[id - 36892] = {x = x, z = z}\n  if id == 36893 then V.hof = {x = x, z = z, t = now, src = \"aoe\"} end\nelseif id == 36861 then\n  V.rf = {x = x, z = z, t = now, src = \"aoe\"}\nelseif V.st and now - V.st.t < 3000 then\n  V.st.cx, V.st.cz, V.st.h, V.st.src = x, z, h, \"aoe\"\nend\n",
							conditions = 
							{
								
								{
									"b47bf185-eb06-7bc4-9d77-37f7c277357b",
									true,
								},
							},
							name = "Capture",
							uuid = "d26b7830-cac3-1657-95d5-42158c193ed8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnAOECreate, Dequeue Action if False = on).\nlocal s = eventArgs.aoeID\nreturn s == 36889 or (s >= 36893 and s <= 36898) or s == 36861 or s == 36808 or s == 36812 or s == 36816\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "b47bf185-eb06-7bc4-9d77-37f7c277357b",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 4049.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture AoE locations)",
				timeRange = true,
				timelineIndex = 96,
				timerStartOffset = -4.5,
				uuid = "2196adff-7c68-973e-9d51-1078d7f73fe9",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityChannel = cast start):\n--   36850 Spikesicle (boss position for the boss-relative lines), stances 36805-36816 (cone/out/donut + helper),\n--   36876 Mountain Fire (boss id), 36889 Mountain Fire tower (fallback position), 36893 first Hail of Feathers drop\n--   (fallback position), 36861 Ruinfall tower (fallback), 36827/36828 Northern Cross (avalanche) cast start.\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal e = TensorCore.mGetEntity(eventArgs.entityID)\nlocal ex, ez, eh\nif e and e.pos then ex, ez, eh = e.pos.x, e.pos.z, e.pos.h end\nlocal function spGet(V, now)\n  local s = V.sp\n  if not s or now - s.t0 > 45000 then\n    s = {t0 = now, me = {}, lines = 0, shat = 0, bould = {}, bx = 100, bz = 85}\n    V.sp = s\n  end\n  return s\nend\nlocal function mfTower(V, now, x, z, h, src)\n  local m = V.mf\n  if not m or now - (m.tl or m.t) > 15000 then\n    m = {t = now, n = 0}\n    V.mf = m\n  end\n  local tw = m.tw\n  if tw and now - tw.t < 1500 then\n    if src == \"aoe\" then tw.x, tw.z, tw.h, tw.src = x, z, h, src end\n    return\n  end\n  m.n = m.n + 1\n  m.tw = {x = x, z = z, h = h, t = now, src = src}\n  m.tl = now\nend\nif sp == 36850 then\n  local s = spGet(V, now)\n  s.castStart = now\n  if ex then s.bx, s.bz = ex, ez end\nelseif sp >= 36805 and sp <= 36816 then\n  local k\n  if sp <= 36808 then k = \"cone\" elseif sp <= 36812 then k = \"out\" else k = \"donut\" end\n  local st = V.st\n  if not (st and st.k == k and now - st.t < 3000) then\n    st = {k = k, t = now}\n    V.st = st\n  end\n  if (sp == 36808 or sp == 36812 or sp == 36816) and ex and not st.src then st.cx, st.cz, st.h = ex, ez, eh end\nelseif sp == 36876 then\n  V.mf = {t = now, n = 0, boss = eventArgs.entityID}\nelseif sp == 36889 then\n  if ex then mfTower(V, now, ex, ez, eh, \"ch\") end\nelseif sp == 36893 then\n  if ex and not (V.hof and now - V.hof.t < 10000) then V.hof = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36861 then\n  if ex and not (V.rf and now - V.rf.t < 10000) then V.rf = {x = ex, z = ez, t = now, src = \"ch\"} end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then V.aval.nc = now end\nend\n",
							conditions = 
							{
								
								{
									"c5c90699-f2e7-e607-9fd3-6299c202e525",
									true,
								},
							},
							name = "Capture",
							uuid = "5935beda-eb2c-8a68-92ce-8d022d81ec3d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityChannel, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36805 and s <= 36816) or s == 36876 or s == 36889 or s == 36893\n  or s == 36861 or s == 36827 or s == 36828\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "c5c90699-f2e7-e607-9fd3-6299c202e525",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 4049.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture cast starts)",
				timeRange = true,
				timelineIndex = 96,
				timerStartOffset = -4.5,
				uuid = "734ad7ba-0b5f-1c34-a50f-ae3fc188aec5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda capture (OnEntityCast = resolve): Spikesicle cast/lines/Sphere Shatter counts, avalanche\n--   resolve, stance resolve, Charring Cataclysm, Mountain Fire tower/cone, Scourge of Fire hits, Crackling\n--   Cataclysm, boss return (38323).\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\ndata.valx = data.valx or {}\nlocal V = data.valx\nlocal now = Now()\nlocal sp = eventArgs.spellID\nlocal s = V.sp\nif s and now - s.t0 > 45000 then s = nil end\nif sp == 36850 then\n  if s then\n    s.castEnd = now\n    s.plan = nil\n  end\nelseif sp >= 36853 and sp <= 36857 then\n  if s then\n    s.lines = s.lines + 1\n    s.lt = now -- last line resolve: pending lines are timed from it (no drift from the cast-end estimate)\n    s.plan = nil\n  end\nelseif sp == 39261 then\n  if s then\n    s.shat = s.shat + 1\n    s.plan = nil\n  end\nelseif sp == 36827 or sp == 36828 then\n  if V.aval and not V.aval.done then\n    V.aval.done = now\n    if s then s.plan = nil end\n  end\nelseif sp == 36808 or sp == 36812 or sp == 36816 then\n  if V.st and now - V.st.t < 12000 and not V.st.res then V.st.res = now end\nelseif sp == 36804 then\n  if V.st and now - V.st.t < 12000 then V.st.done = now end\nelseif sp == 36801 then\n  if V.st and now - V.st.t < 15000 and not V.st.crack then V.st.crack = now end\nelseif sp == 36889 then\n  if V.mf and V.mf.tw then V.mf.tw.res = now end\nelseif sp == 36890 then\n  if V.mf and V.mf.tw then V.mf.tw.done = now end\nelseif sp == 36847 then\n  local f = V.sof\n  if not f or now - f.t > 10000 then\n    f = {n = 0, t = now, tl = 0}\n    V.sof = f\n  end\n  if now - f.tl > 1000 then\n    f.n = f.n + 1\n    f.tl = now\n  end\n  f.t = now\nelseif sp == 38323 then\n  V.ret = now\nend\n",
							conditions = 
							{
								
								{
									"7bee79b4-0e25-0db2-aa26-5c6a03eaa6bf",
									true,
								},
							},
							name = "Capture",
							uuid = "586792e1-5cc6-f55c-b4e6-c6a3dce2c869",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- [Draw] Valigarmanda capture condition (OnEntityCast, Dequeue Action if False = on).\nlocal s = eventArgs.spellID\nreturn s == 36850 or (s >= 36853 and s <= 36857) or s == 39261 or s == 36827 or s == 36828\n  or s == 36808 or s == 36812 or s == 36816 or s == 36804 or s == 36889 or s == 36890\n  or s == 36847 or s == 36801 or s == 38323\n",
							dequeueIfLuaFalse = true,
							name = "event ids",
							uuid = "7bee79b4-0e25-0db2-aa26-5c6a03eaa6bf",
							version = 3,
						},
					},
				},
				displayPath = "Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 4049.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot (capture resolves)",
				timeRange = true,
				timelineIndex = 96,
				timerEndOffset = 1.2,
				timerStartOffset = -1,
				uuid = "9479165d-5f67-803a-a05a-19e8b44d94ee",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- [Draw] Valigarmanda - Mountain Fire role spot. Tower 36889 r3 at the cast location; the cone (36890, 40 y,\n-- 330 deg) leaves a 30 deg wedge behind the tower as seen from the boss (MountainFire.cs:24-27,53-93). Previous\n-- soakers are forbidden, so tanks alternate: T1 soaks towers 1/3/5, T2 2/4/6 (strat 75.webp: MT first).\n-- Soaker: into the tower. Everyone else: 4.5 y from the tower centre in the safe wedge, which points opposite the\n-- tower cast's rotation (cast heading + 180 deg; BossMod MountainFire.cs cone rot, Splatoon EX1 preset\n-- AdditionalRotation pi). Boss moving left/right turns the cast, so the wedge is left/middle/right (cactbot).\nlocal function vxSlot()\n  local Ro = AnyoneCore and AnyoneCore.Roster\n  if not (Ro and Ro.mySlot) then return nil end\n  local ok, s = pcall(Ro.mySlot)\n  if not ok then return nil end\n  if s == \"MT\" then s = \"T1\" elseif s == \"OT\" then s = \"T2\" end\n  if type(s) ~= \"string\" or not s:match(\"^[THMR][12]$\") then return nil end\n  return s\nend\nlocal function vxSpot(x, z, r)\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.pos and x and z) then return end\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(x, p.pos.y, z, r or 0.8, false, flags)\nend\nlocal V = data.valx\nlocal m = V and V.mf\nlocal tw = m and m.tw\nlocal now = Now()\nif not tw or tw.done or now - tw.t > 4500 then return end\nlocal slot = vxSlot()\nif not slot then return end\nlocal soaker = (m.n % 2 == 1) and \"T1\" or \"T2\"\nif slot == soaker then\n  vxSpot(tw.x, tw.z, 1.2)\n  return\nend\nlocal ux, uz\nif tw.h then\n  -- game heading h faces (sin h, cos h); the safe wedge faces h + pi\n  ux, uz = -math.sin(tw.h), -math.cos(tw.h)\nend\nif not ux then\n  local dx, dz = tw.x - 100, tw.z - 85\n  local d = math.sqrt(dx * dx + dz * dz)\n  if d < 1 then return end\n  ux, uz = dx / d, dz / d\nend\nvxSpot(tw.x + 4.5 * ux, tw.z + 4.5 * uz)\n",
							name = "Draw",
							uuid = "d3a04630-25d1-a6e9-877c-e74cee61a54e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 4049.6,
				name = "[Draw] Valigarmanda - Mountain Fire role spot",
				timeRange = true,
				timelineIndex = 96,
				timerEndOffset = 0.8,
				timerStartOffset = -3.8,
				uuid = "5eee9c6c-7cb5-811c-b65d-e13035d9ec1b",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "valigarmanda-ex",
	version = "1.0.2",
}



return tbl