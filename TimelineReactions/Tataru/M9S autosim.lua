local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "4a9c35ac-eda1-2cce-aaa7-0f8e4a93648f",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Universal AutoSim for M9S (Vamp Fatale): works for any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 549s = FFLogs median of ~3700 kills (p25 521, p75 574). No full downtime: during the Coffinmaker add\n-- (67.7 to ~113) there is always a target. Windows are re-timed on the real boss casts by the sync reaction.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 549)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM9S = {\n  kill = 549,\n  m_vs1 = add(\"MeleeDowntime\", 30.0, 37.5), -- Vamp Stomp 1 / bats\n  m_ae = add(\"MeleeDowntime\", 192.0, 199.0), -- Aetherletting puddles\n  m_vs2 = add(\"MeleeDowntime\", 229.8, 237.3), -- Vamp Stomp 2 / bats\n  m_vs3 = add(\"MeleeDowntime\", 509.8, 517.3), -- Vamp Stomp 3 / bats\n  c_vs1a = add(\"CasterDowntime\", 26.5, 30.0), -- Vamp Stomp 1 dodge\n  c_vs1b = add(\"CasterDowntime\", 38.0, 42.5), -- Blast Beat 1 into Brutal Rain\n  c_cof = add(\"CasterDowntime\", 67.0, 70.5), -- Coffinmaker spawn\n  c_ae = add(\"CasterDowntime\", 192.0, 200.0), -- Aetherletting drops\n  c_vs2a = add(\"CasterDowntime\", 226.3, 229.8), -- Vamp Stomp 2 dodge\n  c_vs2b = add(\"CasterDowntime\", 237.8, 242.3), -- Blast Beat 2\n  c_hm2 = add(\"CasterDowntime\", 246.3, 249.3), -- Half Moon 2 side swap\n  c_pl1 = add(\"CasterDowntime\", 297.2, 301.2), -- Plummet 1 / chains\n  c_hc1 = add(\"CasterDowntime\", 397.0, 399.5), -- Hell in a Cell 1 positioning\n  c_hc2 = add(\"CasterDowntime\", 418.0, 421.5), -- Hell in a Cell 2 positioning\n  c_ud = add(\"CasterDowntime\", 447.5, 451.5), -- Undead Deathmatch positioning\n  c_sg1 = add(\"CasterDowntime\", 460.0, 470.6), -- Sanguine Scratch 1 dodges\n  c_sg2 = add(\"CasterDowntime\", 478.0, 489.0), -- Sanguine Scratch 2 dodges\n  c_vs3a = add(\"CasterDowntime\", 506.3, 509.8), -- Vamp Stomp 3 dodge\n  c_vs3b = add(\"CasterDowntime\", 517.8, 522.3), -- Blast Beat 3\n  c_hm3 = add(\"CasterDowntime\", 526.3, 529.3), -- Half Moon 3 side swap\n}\n-- timing: fixed boss timeline, +-5s while the Coffinmaker add is up, kill-time spread at the end\npcall(api.addAutoSimUncertainty, 0, 0.5)\nTensorM9S.u_cof = select(2, pcall(api.addAutoSimUncertainty, 100, 5))\npcall(api.addAutoSimUncertainty, 125, 0.5)\npcall(api.addAutoSimUncertainty, 480, 15)\nself.used = true\n",
							name = "[AutoSim] M9S - setup (any job)",
							uuid = "b4c8165d-e5e4-1807-a69c-00b1542b71da",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 10.172,
				name = "[AutoSim] M9S - setup (any job)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "71fabac0-92ab-0854-a107-d9d6acdf1239",
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
							actionLua = "-- Re-time each AutoSim window on the real boss cast start (universal, any job)\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorM9S\nif not s then return end\nlocal SPEC = {\n  {45940, 1, \"m_vs1\", 4.5, 12.0, \"MeleeDowntime\"},\n  {45967, 1, \"m_ae\", 14.2, 21.2, \"MeleeDowntime\"},\n  {45940, 2, \"m_vs2\", 4.5, 12.0, \"MeleeDowntime\"},\n  {45940, 3, \"m_vs3\", 4.5, 12.0, \"MeleeDowntime\"},\n  {45940, 1, \"c_vs1a\", 1.0, 4.5, \"CasterDowntime\"},\n  {45940, 1, \"c_vs1b\", 12.5, 17.0, \"CasterDowntime\"},\n  {45875, 1, \"c_cof\", 12.0, 15.5, \"CasterDowntime\"},\n  {45967, 1, \"c_ae\", 14.2, 22.2, \"CasterDowntime\"},\n  {45940, 2, \"c_vs2a\", 1.0, 4.5, \"CasterDowntime\"},\n  {45940, 2, \"c_vs2b\", 12.5, 17.0, \"CasterDowntime\"},\n  {45940, 2, \"c_hm2\", 21.0, 24.0, \"CasterDowntime\"},\n  {45963, 1, \"c_pl1\", 8.0, 12.0, \"CasterDowntime\"},\n  {45973, 1, \"c_hc1\", 1.2, 3.7, \"CasterDowntime\"},\n  {45973, 2, \"c_hc2\", 0.2, 3.7, \"CasterDowntime\"},\n  {45984, 1, \"c_ud\", 0.0, 4.0, \"CasterDowntime\"},\n  {45989, 1, \"c_sg1\", 3.4, 14.0, \"CasterDowntime\"},\n  {45989, 2, \"c_sg2\", 3.2, 14.2, \"CasterDowntime\"},\n  {45940, 3, \"c_vs3a\", 1.0, 4.5, \"CasterDowntime\"},\n  {45940, 3, \"c_vs3b\", 12.5, 17.0, \"CasterDowntime\"},\n  {45940, 3, \"c_hm3\", 21.0, 24.0, \"CasterDowntime\"}\n}\nlocal sp = e.spellID\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not t then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nlocal counted = false\nfor _, w in ipairs(SPEC) do\n  if w[1] == sp then\n    if not counted then\n      if not s.lastC[sp] or t - s.lastC[sp] > 5 then\n        s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1\n      end\n      counted = true\n    end\n    local key = w[3]\n    if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n      s.done = s.done or {}; s.done[key] = true\n      if s[key] then\n        local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5]); if ok then s[key] = id end\n      else\n        local ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]); if ok then s[key] = id end\n      end\n    end\n  end\nend\n",
							name = "[AutoSim] M9S - cast sync",
							uuid = "04656872-74df-a278-a37c-9c253d139139",
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
				mechanicTime = 10.172,
				name = "[AutoSim] M9S - cast sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 600,
				timerStartOffset = -8,
				uuid = "077f14d5-eef0-374d-b8ed-dc4dad0679e9",
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
				name = "AutoSim",
				uuid = "e0526525-3e91-a0a5-954f-296fa9f6f823",
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
							actionLua = "-- Vamp Fatale targetable again after the Coffinmaker add: drop the +-5s uncertainty\nlocal e = eventArgs\nif not (e and e.isTargetable) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nif not (ent and ent.name == \"Vamp Fatale\") then return end\nlocal s = TensorM9S\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 90 and not s.ret then\n  s.ret = t\n  if s.u_cof then pcall(api.setAutoSimUncertainty, s.u_cof, t, 0.5) end\n  self.used = true\nend\n",
							name = "[AutoSim] M9S - Vamp Fatale return",
							uuid = "68dc5bb4-c7b9-ab2e-9f56-d76351027a19",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 26,
				mechanicTime = 67.704,
				name = "[AutoSim] M9S - Vamp Fatale return",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 60,
				timerStartOffset = 30,
				uuid = "1a11e1ca-fff0-bfd1-a817-6c3c36cf67ce",
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
				name = "Role Draws",
				uuid = "93a3df41-e8cd-df37-a0ef-3f1bec9c7724",
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
							actionLua = "-- M9S capture (boss / helper channel starts, Vamp Fatale contentid 14300):\n--   45974 Bloody Bondage x4 = Hell in a Cell towers (the helper stands on the tower centre), set 1 then set 2\n--   45980 Ultrasonic Spread / 45981 Ultrasonic Amp (boss) = which Ultrasonic comes next\n--   45985 Bloody Bondage x2 = Undead Deathmatch share towers\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e or e.entityContentID ~= 14300 then return end\nlocal sp = e.spellID\nif sp ~= 45974 and sp ~= 45980 and sp ~= 45981 and sp ~= 45985 then return end\ndata.m9 = data.m9 or {}\nlocal m = data.m9\nlocal now = Now()\nif sp == 45980 or sp == 45981 then\n  m.us = {k = (sp == 45980) and \"S\" or \"A\", t = now}\n  return\nend\nlocal en = TensorCore.mGetEntity(e.entityID)\nif not (en and en.pos) then return end\nlocal key = (sp == 45974) and \"hic\" or \"dm\"\nlocal c = m[key]\nif not c or now - c.t > 8000 then\n  -- new batch; Hell in a Cell set 2 starts ~22 s after set 1 (G1 takes set 1, G2 takes set 2)\n  local n = 1\n  if key == \"hic\" and c and now - c.t < 40000 then n = (c.n or 1) + 1 end\n  c = {t = now, n = n, tw = {}, done = {}}\n  m[key] = c\nend\nfor _, t in ipairs(c.tw) do\n  if t.id == e.entityID then return end\nend\nc.tw[#c.tw + 1] = {id = e.entityID, x = en.pos.x, z = en.pos.z}\nc.ord = nil\nc.gap = nil\n",
							name = "[Draw] M9S - capture channels",
							uuid = "2e5fbdd7-20ab-ab61-8003-a17373164460",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 399.595,
				name = "[Draw] M9S - capture channels",
				timeRange = true,
				timelineIndex = 92,
				timerEndOffset = 14,
				timerStartOffset = -7,
				uuid = "5ee4396c-5401-4973-9020-d37c5040e383",
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
							actionLua = "-- M9S capture (resolves, Vamp Fatale contentid 14300 helpers):\n--   45974 = that Hell in a Cell tower went off; 47235 / 45982 / 45983 = the Ultrasonic cones went off;\n--   45985 = the Undead Deathmatch towers went off\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e or e.entityContentID ~= 14300 then return end\nlocal m = data.m9\nif not m then return end\nlocal sp = e.spellID\nif sp == 45974 then\n  if m.hic then m.hic.done[e.entityID] = Now() end\nelseif sp == 47235 or sp == 45982 or sp == 45983 then\n  if m.us and not m.us.done then m.us.done = Now() end\nelseif sp == 45985 then\n  if m.dm and not m.dm.fin then m.dm.fin = Now() end\nend\n",
							name = "[Draw] M9S - capture resolves",
							uuid = "11b99ecc-588b-a436-a854-dee727a00f62",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 399.595,
				name = "[Draw] M9S - capture resolves",
				timeRange = true,
				timelineIndex = 92,
				timerEndOffset = 18.5,
				timerStartOffset = -3.5,
				uuid = "112808b6-153a-4fb2-bbfd-220e24b11636",
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
							actionLua = "-- Hell in a Cell: line from you to YOUR tower + ring on it, hidden while you stand inside it (r4 tower).\n-- Set 1 = G1 (T1 H1 M1 R1), set 2 = G2 (T2 H2 M2 R2). Towers clockwise from true north: T > H > M > R.\nlocal m = data.m9\nlocal c = m and m.hic\nif not (c and c.tw and #c.tw == 4) then return end\nif Now() - c.t > 6500 then return end\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif type(slot) ~= \"string\" then return end\nif tonumber(slot:sub(2, 2)) ~= c.n then return end\nlocal idx = ({T = 1, H = 2, M = 3, R = 4})[slot:sub(1, 1)]\nif not idx then return end\nif not c.ord then\n  local o = {}\n  for i, t in ipairs(c.tw) do\n    local b = math.deg(math.atan2(t.x - 100, 100 - t.z)) % 360\n    if b > 359.5 then b = 0 end\n    o[i] = {id = t.id, x = t.x, z = t.z, b = b}\n  end\n  table.sort(o, function(a, b) return a.b < b.b end)\n  c.ord = o\nend\nlocal t = c.ord[idx]\nif not t or c.done[t.id] then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal px, py, pz = p.pos.x, p.pos.y, p.pos.z\nif TensorCore.getDistance2d2(px, py, pz, t.x, py, t.z) < 3.5 then return end\nlocal col = 0x33FF33\nTensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, t.x, py, t.z, 3)\nTensorCore.getCachedDrawer(0x22000000 + col, 0x33000000 + col, 0x55000000 + col, 0xFF000000 + col, 3):addCircle(t.x, py, t.z, 4, false, Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n",
							name = "[Draw] Hell in a Cell - your tower",
							uuid = "ad07055e-e17d-f0c2-a05d-9369f5818cec",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 399.595,
				name = "[Draw] Hell in a Cell - your tower",
				timeRange = true,
				timelineIndex = 92,
				timerEndOffset = 3.5,
				timerStartOffset = -6,
				uuid = "5c6b44f3-1214-964e-9c42-e0d782fdd9ef",
				version = 2,
			},
		},
	},
	[98] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "b7d213a3-4e9e-974a-922e-2cd04d0c040b",
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
							actionLua = "-- Hell in a Cell, group under the boss (set 1 = G2, set 2 = G1): your Ultrasonic spot from the tower gaps.\n-- Gaps between the 4 towers: one 135 (wide), two 90 (medium), one 45 (narrow, never used).\n-- Spread (role stack): tank = wide gap, healer = first 90 gap clockwise of it, DPS (both) = first 90 gap counter-clockwise.\n-- Amp: whole light party stacks in the wide gap. Shown from the boss's channel until the cones go off.\nlocal m = data.m9\nlocal c = m and m.hic\nlocal u = m and m.us\nif not (c and u and c.tw and #c.tw == 4) then return end\nlocal now = Now()\nif u.done or now - u.t > 7000 or u.t < c.t or u.t - c.t > 20000 then return end\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif type(slot) ~= \"string\" then return end\nlocal g = tonumber(slot:sub(2, 2))\nif not g or g == c.n or (c.n ~= 1 and c.n ~= 2) then return end\nlocal role = slot:sub(1, 1)\nif not c.gap then\n  local b = {}\n  for i, t in ipairs(c.tw) do\n    local v = math.deg(math.atan2(t.x - 100, 100 - t.z)) % 360\n    if v > 359.5 then v = 0 end\n    b[i] = v\n  end\n  table.sort(b)\n  local gs, w = {}, 1\n  for i = 1, 4 do\n    local sz = ((i < 4) and b[i + 1] or (b[1] + 360)) - b[i]\n    gs[i] = {sz = sz, mid = (b[i] + sz / 2) % 360}\n    if sz > gs[w].sz then w = i end\n  end\n  local function med(step)\n    for k = 1, 3 do\n      local j = (w - 1 + step * k) % 4 + 1\n      if gs[j].sz > 67 and gs[j].sz < 113 then return gs[j].mid end\n    end\n    return nil\n  end\n  c.gap = {w = gs[w].mid, cw = med(1), ccw = med(-1)}\nend\nlocal b, r\nif u.k == \"A\" then\n  b, r = c.gap.w, 5\nelseif role == \"T\" then\n  b, r = c.gap.w, 6\nelseif role == \"H\" then\n  b, r = c.gap.cw, 6\nelseif role == \"M\" or role == \"R\" then\n  b, r = c.gap.ccw, 6\nend\nif not b then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal a = math.rad(b)\nlocal dest = {x = 100 + r * math.sin(a), y = p.pos.y, z = 100 - r * math.cos(a)}\nlocal g2 = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g2:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng2:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Hell in a Cell - Ultrasonic spot",
							uuid = "1eb049f4-5325-e59e-a4fe-15508ad947ed",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 407.876,
				name = "[Draw] Hell in a Cell - Ultrasonic spot",
				timeRange = true,
				timelineIndex = 98,
				timerEndOffset = 11,
				timerStartOffset = -7,
				uuid = "0abe8f85-a19a-baf8-ba3e-fdb3558654b7",
				version = 2,
			},
		},
	},
	[104] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "b2023c0c-78fa-5766-9728-75df0a615856",
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
							actionLua = "-- M9S capture (boss / helper channel starts, Vamp Fatale contentid 14300):\n--   45974 Bloody Bondage x4 = Hell in a Cell towers (the helper stands on the tower centre), set 1 then set 2\n--   45980 Ultrasonic Spread / 45981 Ultrasonic Amp (boss) = which Ultrasonic comes next\n--   45985 Bloody Bondage x2 = Undead Deathmatch share towers\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e or e.entityContentID ~= 14300 then return end\nlocal sp = e.spellID\nif sp ~= 45974 and sp ~= 45980 and sp ~= 45981 and sp ~= 45985 then return end\ndata.m9 = data.m9 or {}\nlocal m = data.m9\nlocal now = Now()\nif sp == 45980 or sp == 45981 then\n  m.us = {k = (sp == 45980) and \"S\" or \"A\", t = now}\n  return\nend\nlocal en = TensorCore.mGetEntity(e.entityID)\nif not (en and en.pos) then return end\nlocal key = (sp == 45974) and \"hic\" or \"dm\"\nlocal c = m[key]\nif not c or now - c.t > 8000 then\n  -- new batch; Hell in a Cell set 2 starts ~22 s after set 1 (G1 takes set 1, G2 takes set 2)\n  local n = 1\n  if key == \"hic\" and c and now - c.t < 40000 then n = (c.n or 1) + 1 end\n  c = {t = now, n = n, tw = {}, done = {}}\n  m[key] = c\nend\nfor _, t in ipairs(c.tw) do\n  if t.id == e.entityID then return end\nend\nc.tw[#c.tw + 1] = {id = e.entityID, x = en.pos.x, z = en.pos.z}\nc.ord = nil\nc.gap = nil\n",
							name = "[Draw] M9S - capture channels",
							uuid = "be785b4f-33a6-1dc3-af71-2cf86045a714",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 421.641,
				name = "[Draw] M9S - capture channels",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 14,
				timerStartOffset = -7,
				uuid = "c43a1649-0059-4eb8-84f1-f1d49b0b2538",
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
							actionLua = "-- M9S capture (resolves, Vamp Fatale contentid 14300 helpers):\n--   45974 = that Hell in a Cell tower went off; 47235 / 45982 / 45983 = the Ultrasonic cones went off;\n--   45985 = the Undead Deathmatch towers went off\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e or e.entityContentID ~= 14300 then return end\nlocal m = data.m9\nif not m then return end\nlocal sp = e.spellID\nif sp == 45974 then\n  if m.hic then m.hic.done[e.entityID] = Now() end\nelseif sp == 47235 or sp == 45982 or sp == 45983 then\n  if m.us and not m.us.done then m.us.done = Now() end\nelseif sp == 45985 then\n  if m.dm and not m.dm.fin then m.dm.fin = Now() end\nend\n",
							name = "[Draw] M9S - capture resolves",
							uuid = "2f8fe2ed-af49-0a6a-9b39-b28fd81af2cd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 421.641,
				name = "[Draw] M9S - capture resolves",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 18.5,
				timerStartOffset = -3.5,
				uuid = "cb692aa6-5a77-a66f-87ab-9ce37d23f616",
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
							actionLua = "-- Hell in a Cell: line from you to YOUR tower + ring on it, hidden while you stand inside it (r4 tower).\n-- Set 1 = G1 (T1 H1 M1 R1), set 2 = G2 (T2 H2 M2 R2). Towers clockwise from true north: T > H > M > R.\nlocal m = data.m9\nlocal c = m and m.hic\nif not (c and c.tw and #c.tw == 4) then return end\nif Now() - c.t > 6500 then return end\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif type(slot) ~= \"string\" then return end\nif tonumber(slot:sub(2, 2)) ~= c.n then return end\nlocal idx = ({T = 1, H = 2, M = 3, R = 4})[slot:sub(1, 1)]\nif not idx then return end\nif not c.ord then\n  local o = {}\n  for i, t in ipairs(c.tw) do\n    local b = math.deg(math.atan2(t.x - 100, 100 - t.z)) % 360\n    if b > 359.5 then b = 0 end\n    o[i] = {id = t.id, x = t.x, z = t.z, b = b}\n  end\n  table.sort(o, function(a, b) return a.b < b.b end)\n  c.ord = o\nend\nlocal t = c.ord[idx]\nif not t or c.done[t.id] then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal px, py, pz = p.pos.x, p.pos.y, p.pos.z\nif TensorCore.getDistance2d2(px, py, pz, t.x, py, t.z) < 3.5 then return end\nlocal col = 0x33FF33\nTensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, t.x, py, t.z, 3)\nTensorCore.getCachedDrawer(0x22000000 + col, 0x33000000 + col, 0x55000000 + col, 0xFF000000 + col, 3):addCircle(t.x, py, t.z, 4, false, Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n",
							name = "[Draw] Hell in a Cell - your tower",
							uuid = "a030a4af-c3f4-b8b9-9a1f-c6e908969289",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 421.641,
				name = "[Draw] Hell in a Cell - your tower",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 3.5,
				timerStartOffset = -6,
				uuid = "4be8146b-794a-c52d-8829-7748b7f77fbb",
				version = 2,
			},
		},
	},
	[109] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "63f47a26-e174-896e-b1c5-9d3afc3f6f5b",
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
							actionLua = "-- Hell in a Cell, group under the boss (set 1 = G2, set 2 = G1): your Ultrasonic spot from the tower gaps.\n-- Gaps between the 4 towers: one 135 (wide), two 90 (medium), one 45 (narrow, never used).\n-- Spread (role stack): tank = wide gap, healer = first 90 gap clockwise of it, DPS (both) = first 90 gap counter-clockwise.\n-- Amp: whole light party stacks in the wide gap. Shown from the boss's channel until the cones go off.\nlocal m = data.m9\nlocal c = m and m.hic\nlocal u = m and m.us\nif not (c and u and c.tw and #c.tw == 4) then return end\nlocal now = Now()\nif u.done or now - u.t > 7000 or u.t < c.t or u.t - c.t > 20000 then return end\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif type(slot) ~= \"string\" then return end\nlocal g = tonumber(slot:sub(2, 2))\nif not g or g == c.n or (c.n ~= 1 and c.n ~= 2) then return end\nlocal role = slot:sub(1, 1)\nif not c.gap then\n  local b = {}\n  for i, t in ipairs(c.tw) do\n    local v = math.deg(math.atan2(t.x - 100, 100 - t.z)) % 360\n    if v > 359.5 then v = 0 end\n    b[i] = v\n  end\n  table.sort(b)\n  local gs, w = {}, 1\n  for i = 1, 4 do\n    local sz = ((i < 4) and b[i + 1] or (b[1] + 360)) - b[i]\n    gs[i] = {sz = sz, mid = (b[i] + sz / 2) % 360}\n    if sz > gs[w].sz then w = i end\n  end\n  local function med(step)\n    for k = 1, 3 do\n      local j = (w - 1 + step * k) % 4 + 1\n      if gs[j].sz > 67 and gs[j].sz < 113 then return gs[j].mid end\n    end\n    return nil\n  end\n  c.gap = {w = gs[w].mid, cw = med(1), ccw = med(-1)}\nend\nlocal b, r\nif u.k == \"A\" then\n  b, r = c.gap.w, 5\nelseif role == \"T\" then\n  b, r = c.gap.w, 6\nelseif role == \"H\" then\n  b, r = c.gap.cw, 6\nelseif role == \"M\" or role == \"R\" then\n  b, r = c.gap.ccw, 6\nend\nif not b then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal a = math.rad(b)\nlocal dest = {x = 100 + r * math.sin(a), y = p.pos.y, z = 100 - r * math.cos(a)}\nlocal g2 = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g2:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng2:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Hell in a Cell - Ultrasonic spot",
							uuid = "56cbf596-19a5-64a1-9297-8c00a2f51514",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 429.516,
				name = "[Draw] Hell in a Cell - Ultrasonic spot",
				timeRange = true,
				timelineIndex = 109,
				timerEndOffset = 11,
				timerStartOffset = -7,
				uuid = "3ff78d7a-4096-20eb-ae03-d8603ff3647e",
				version = 2,
			},
		},
	},
	[118] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "68db5720-85a4-317d-a5c1-c3cf2f569a19",
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
							actionLua = "-- M9S capture (boss / helper channel starts, Vamp Fatale contentid 14300):\n--   45974 Bloody Bondage x4 = Hell in a Cell towers (the helper stands on the tower centre), set 1 then set 2\n--   45980 Ultrasonic Spread / 45981 Ultrasonic Amp (boss) = which Ultrasonic comes next\n--   45985 Bloody Bondage x2 = Undead Deathmatch share towers\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e or e.entityContentID ~= 14300 then return end\nlocal sp = e.spellID\nif sp ~= 45974 and sp ~= 45980 and sp ~= 45981 and sp ~= 45985 then return end\ndata.m9 = data.m9 or {}\nlocal m = data.m9\nlocal now = Now()\nif sp == 45980 or sp == 45981 then\n  m.us = {k = (sp == 45980) and \"S\" or \"A\", t = now}\n  return\nend\nlocal en = TensorCore.mGetEntity(e.entityID)\nif not (en and en.pos) then return end\nlocal key = (sp == 45974) and \"hic\" or \"dm\"\nlocal c = m[key]\nif not c or now - c.t > 8000 then\n  -- new batch; Hell in a Cell set 2 starts ~22 s after set 1 (G1 takes set 1, G2 takes set 2)\n  local n = 1\n  if key == \"hic\" and c and now - c.t < 40000 then n = (c.n or 1) + 1 end\n  c = {t = now, n = n, tw = {}, done = {}}\n  m[key] = c\nend\nfor _, t in ipairs(c.tw) do\n  if t.id == e.entityID then return end\nend\nc.tw[#c.tw + 1] = {id = e.entityID, x = en.pos.x, z = en.pos.z}\nc.ord = nil\nc.gap = nil\n",
							name = "[Draw] M9S - capture channels",
							uuid = "8d7a956d-0ced-ae8d-84f9-0e4904f71db9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 451.266,
				name = "[Draw] M9S - capture channels",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = -1,
				timerStartOffset = -8,
				uuid = "037ba858-0ba7-4ec4-b2a0-4eb231df5e44",
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
							actionLua = "-- M9S capture (resolves, Vamp Fatale contentid 14300 helpers):\n--   45974 = that Hell in a Cell tower went off; 47235 / 45982 / 45983 = the Ultrasonic cones went off;\n--   45985 = the Undead Deathmatch towers went off\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e or e.entityContentID ~= 14300 then return end\nlocal m = data.m9\nif not m then return end\nlocal sp = e.spellID\nif sp == 45974 then\n  if m.hic then m.hic.done[e.entityID] = Now() end\nelseif sp == 47235 or sp == 45982 or sp == 45983 then\n  if m.us and not m.us.done then m.us.done = Now() end\nelseif sp == 45985 then\n  if m.dm and not m.dm.fin then m.dm.fin = Now() end\nend\n",
							name = "[Draw] M9S - capture resolves",
							uuid = "106ea8df-9cda-0566-afc2-9b16587be99a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 451.266,
				name = "[Draw] M9S - capture resolves",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 5,
				timerStartOffset = -2.5,
				uuid = "46479443-e1fb-e088-89fd-887034c0f718",
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
							actionLua = "-- Undead Deathmatch: arrow to your group's share tower (r6). G1 (T1 H1 M1 R1) = the N or W tower,\n-- G2 (T2 H2 M2 R2) = the S or E tower. Gone when the towers go off.\nlocal m = data.m9\nlocal c = m and m.dm\nif not (c and c.tw and #c.tw == 2) or c.fin then return end\nif Now() - c.t > 6500 then return end\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif type(slot) ~= \"string\" then return end\nlocal g = tonumber(slot:sub(2, 2))\nif g ~= 1 and g ~= 2 then return end\nlocal t1, t2 = c.tw[1], c.tw[2]\nif (t2.x + t2.z) < (t1.x + t1.z) then t1, t2 = t2, t1 end -- t1 = N or W tower\nlocal t = (g == 1) and t1 or t2\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\n-- spot 3 y inside the tower on the boss side (tower centre at r12)\nlocal a = math.atan2(t.x - 100, t.z - 100)\nlocal dest = {x = 100 + 9 * math.sin(a), y = p.pos.y, z = 100 + 9 * math.cos(a)}\nlocal g2 = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g2:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng2:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Undead Deathmatch - group tower",
							uuid = "31391002-3eaa-0b12-8956-6ee948924860",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 451.266,
				name = "[Draw] Undead Deathmatch - group tower",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 3.5,
				timerStartOffset = -6,
				uuid = "3422b7cc-9045-3a61-ba51-021f2b240ac1",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "r9s",
	version = "1.5.0",
}



return tbl