local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "f8759383-bc45-8cd4-9805-e38becd0ac16",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Universal AutoSim for M11S (The Tyrant): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 633s = raalm median of 199 top kills (local kills 631, FFLogs 637; enrage 659). The boss is always\n-- targetable (no full downtime) and the timeline is fixed. Windows are re-timed on the real casts.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 633)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM11 = {\n  kill = 633, stamp = Now(), cd = true,\n  m_ir = add(\"MeleeDowntime\", 223.51, 227.26), -- Immortal Reign / Powerful Gust\n  m_tt = add(\"MeleeDowntime\", 342.28, 347.22), -- Triple Tyrannhilation shockwaves\n  m_fl = add(\"MeleeDowntime\", 361.54, 364.48), -- Flatliner knockback onto platforms\n  m_mm = add(\"MeleeDowntime\", 386.01, 391.74), -- Majestic Meteor platform phase\n  m_fb1 = add(\"MeleeDowntime\", 400.34, 405.75), -- Fire Breath 1 / meteors\n  m_mm2 = add(\"MeleeDowntime\", 418.18, 424.07), -- Platform swap before Fire Breath 2\n  m_fb2 = add(\"MeleeDowntime\", 432.09, 437.65), -- Fire Breath 2 / meteors\n  m_aa1 = add(\"MeleeDowntime\", 457.03, 461.18), -- Arcadion Avalanche part 1\n  m_aa2 = add(\"MeleeDowntime\", 465.92, 470.06), -- Arcadion Avalanche part 2\n  s_fl = add(\"Stun\", 361.00, 363.80), -- Flatliner: knocked into the air\n  s_ex1 = add(\"Stun\", 388.28, 391.08), -- Platform Explosion 1: knocked into the air\n  s_ex2 = add(\"Stun\", 420.38, 423.18), -- Platform Explosion 2: knocked into the air\n  s_ex3 = add(\"Stun\", 458.32, 461.57), -- Platform Explosion 3: knocked into the air (lands less evenly)\n  c_ae1 = add(\"CasterDowntime\", 50.22, 53.36), -- Assault Evolved 1 dodge\n  c_vs = add(\"CasterDowntime\", 80.83, 87.37), -- Void Stardust / Cometite baits\n  c_ae2 = add(\"CasterDowntime\", 99.96, 102.95), -- Assault Evolved 2 third hit\n  c_cm = add(\"CasterDowntime\", 106.92, 113.40), -- Cometite / Comet spread\n  c_dod = add(\"CasterDowntime\", 145.86, 149.26), -- Dance of Domination pair stacks\n  c_pg = add(\"CasterDowntime\", 219.64, 223.31), -- Tornado baits / Powerful Gust\n  c_ff3 = add(\"CasterDowntime\", 320.62, 323.34), -- Fearsome Fireball 3 move\n  c_tt = add(\"CasterDowntime\", 330.25, 337.00), -- Explosions / Triple Tyrannhilation\n  c_fl = add(\"CasterDowntime\", 360.82, 363.53), -- Flatliner knockback\n  c_mm = add(\"CasterDowntime\", 388.21, 393.99), -- Majestic Meteor platform swap\n  c_fb1 = add(\"CasterDowntime\", 397.11, 402.36), -- Fire Breath 1 meteor drops\n  c_ps2 = add(\"CasterDowntime\", 420.27, 425.98), -- Platform swap 2\n  c_fb2 = add(\"CasterDowntime\", 429.23, 434.57), -- Fire Breath 2 meteor drops\n  c_aa = add(\"CasterDowntime\", 458.15, 466.57), -- Arcadion Avalanche move\n  c_es = add(\"CasterDowntime\", 544.39, 554.89), -- Ecliptic Stampede meteors / Atomic Impact\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 580, 15)\nself.used = true\n",
							name = "[AutoSim] M11S - setup (any job)",
							uuid = "ab1f8f02-f5e0-f4ab-97b7-5aba54bf5f6e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 10.203,
				name = "[AutoSim] M11S - setup (any job)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "31b022e5-a8c6-8f20-9430-dcaff0c9adf1",
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
							actionLua = "-- No countdown this pull? Set the schedule up at pull start instead (skip only if the countdown setup just ran).\nif TensorM11 and TensorM11.cd and TensorM11.stamp and Now() - TensorM11.stamp < 75000 then TensorM11.cd = nil; return end\nlocal api = TensorCore.API.TensorACR\n-- Universal AutoSim for M11S (The Tyrant): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 633s = raalm median of 199 top kills (local kills 631, FFLogs 637; enrage 659). The boss is always\n-- targetable (no full downtime) and the timeline is fixed. Windows are re-timed on the real casts.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 633)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM11 = {\n  kill = 633, stamp = Now(),\n  m_ir = add(\"MeleeDowntime\", 223.51, 227.26), -- Immortal Reign / Powerful Gust\n  m_tt = add(\"MeleeDowntime\", 342.28, 347.22), -- Triple Tyrannhilation shockwaves\n  m_fl = add(\"MeleeDowntime\", 361.54, 364.48), -- Flatliner knockback onto platforms\n  m_mm = add(\"MeleeDowntime\", 386.01, 391.74), -- Majestic Meteor platform phase\n  m_fb1 = add(\"MeleeDowntime\", 400.34, 405.75), -- Fire Breath 1 / meteors\n  m_mm2 = add(\"MeleeDowntime\", 418.18, 424.07), -- Platform swap before Fire Breath 2\n  m_fb2 = add(\"MeleeDowntime\", 432.09, 437.65), -- Fire Breath 2 / meteors\n  m_aa1 = add(\"MeleeDowntime\", 457.03, 461.18), -- Arcadion Avalanche part 1\n  m_aa2 = add(\"MeleeDowntime\", 465.92, 470.06), -- Arcadion Avalanche part 2\n  s_fl = add(\"Stun\", 361.00, 363.80), -- Flatliner: knocked into the air\n  s_ex1 = add(\"Stun\", 388.28, 391.08), -- Platform Explosion 1: knocked into the air\n  s_ex2 = add(\"Stun\", 420.38, 423.18), -- Platform Explosion 2: knocked into the air\n  s_ex3 = add(\"Stun\", 458.32, 461.57), -- Platform Explosion 3: knocked into the air (lands less evenly)\n  c_ae1 = add(\"CasterDowntime\", 50.22, 53.36), -- Assault Evolved 1 dodge\n  c_vs = add(\"CasterDowntime\", 80.83, 87.37), -- Void Stardust / Cometite baits\n  c_ae2 = add(\"CasterDowntime\", 99.96, 102.95), -- Assault Evolved 2 third hit\n  c_cm = add(\"CasterDowntime\", 106.92, 113.40), -- Cometite / Comet spread\n  c_dod = add(\"CasterDowntime\", 145.86, 149.26), -- Dance of Domination pair stacks\n  c_pg = add(\"CasterDowntime\", 219.64, 223.31), -- Tornado baits / Powerful Gust\n  c_ff3 = add(\"CasterDowntime\", 320.62, 323.34), -- Fearsome Fireball 3 move\n  c_tt = add(\"CasterDowntime\", 330.25, 337.00), -- Explosions / Triple Tyrannhilation\n  c_fl = add(\"CasterDowntime\", 360.82, 363.53), -- Flatliner knockback\n  c_mm = add(\"CasterDowntime\", 388.21, 393.99), -- Majestic Meteor platform swap\n  c_fb1 = add(\"CasterDowntime\", 397.11, 402.36), -- Fire Breath 1 meteor drops\n  c_ps2 = add(\"CasterDowntime\", 420.27, 425.98), -- Platform swap 2\n  c_fb2 = add(\"CasterDowntime\", 429.23, 434.57), -- Fire Breath 2 meteor drops\n  c_aa = add(\"CasterDowntime\", 458.15, 466.57), -- Arcadion Avalanche move\n  c_es = add(\"CasterDowntime\", 544.39, 554.89), -- Ecliptic Stampede meteors / Atomic Impact\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 580, 15)\nself.used = true\n",
							name = "[AutoSim] M11S - setup without countdown",
							uuid = "35d86296-c963-6c81-b741-2d803d9de230",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 10.203,
				name = "[AutoSim] M11S - setup without countdown",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -4,
				timerStartOffset = -9,
				uuid = "1fb9755f-470b-a9fa-9b1e-e8e1d066fd78",
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
							actionLua = "-- Re-time each AutoSim window on the real boss cast start\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorM11\nif not s then return end\nlocal BY = s.spec\nif not BY then\n  BY = {}\n  for _, w in ipairs({\n  {46120, 1, \"m_ir\", 0.36, 4.11, \"MeleeDowntime\"},\n  {46140, 1, \"m_tt\", 7.74, 12.68, \"MeleeDowntime\"},\n  {46143, 1, \"m_fl\", 6.54, 9.48, \"MeleeDowntime\"},\n  {46144, 1, \"m_mm\", 15.81, 21.54, \"MeleeDowntime\"},\n  {46150, 1, \"m_fb1\", 6.06, 11.47, \"MeleeDowntime\"},\n  {46150, 1, \"m_mm2\", 23.9, 29.79, \"MeleeDowntime\"},\n  {46150, 2, \"m_fb2\", 5.63, 11.19, \"MeleeDowntime\"},\n  {46152, 1, \"m_aa1\", 17.55, 21.7, \"MeleeDowntime\"},\n  {46152, 1, \"m_aa2\", 26.44, 30.58, \"MeleeDowntime\"},\n  {46143, 1, \"s_fl\", 6.0, 8.8, \"Stun\"},\n  {46148, 1, \"s_ex1\", 10.0, 12.8, \"Stun\"},\n  {46148, 2, \"s_ex2\", 10.0, 12.8, \"Stun\"},\n  {46148, 3, \"s_ex3\", 10.05, 13.3, \"Stun\"},\n  {46103, 1, \"c_ae1\", 8.6, 11.74, \"CasterDowntime\"},\n  {46098, 1, \"c_vs\", 5.72, 12.26, \"CasterDowntime\"},\n  {46103, 2, \"c_ae2\", 14.06, 17.05, \"CasterDowntime\"},\n  {46103, 2, \"c_cm\", 21.02, 27.5, \"CasterDowntime\"},\n  {47035, 1, \"c_dod\", 13.89, 17.29, \"CasterDowntime\"},\n  {47086, 1, \"c_pg\", 32.75, 36.42, \"CasterDowntime\"},\n  {46137, 3, \"c_ff3\", 7.01, 9.73, \"CasterDowntime\"},\n  {46137, 4, \"c_tt\", 6.71, 13.46, \"CasterDowntime\"},\n  {46143, 1, \"c_fl\", 5.82, 8.53, \"CasterDowntime\"},\n  {46144, 1, \"c_mm\", 18.01, 23.79, \"CasterDowntime\"},\n  {46150, 1, \"c_fb1\", 2.83, 8.08, \"CasterDowntime\"},\n  {46150, 1, \"c_ps2\", 25.99, 31.7, \"CasterDowntime\"},\n  {46150, 2, \"c_fb2\", 2.77, 8.11, \"CasterDowntime\"},\n  {46152, 1, \"c_aa\", 18.67, 27.09, \"CasterDowntime\"},\n  {46162, 1, \"c_es\", 15.1, 25.6, \"CasterDowntime\"}\n  }) do BY[w[1]] = BY[w[1]] or {}; table.insert(BY[w[1]], w) end\n  s.spec = BY\nend\nlocal sp = e.spellID\nlocal ws = BY[sp]\nif not ws then return end\nlocal api = TensorCore.API.TensorACR\nlocal okT, t = pcall(api.getAutoSimTime)\nif not (okT and t) then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nif not s.lastC[sp] or t - s.lastC[sp] > 5 then s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1 end\nfor _, w in ipairs(ws) do\n  local key = w[3]\n  if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n    s.done = s.done or {}; s.done[key] = true\n    if s[key] then\n      local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5])\n      if not ok then ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]) end\n      if ok then s[key] = id end\n    else\n      local ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]); if ok then s[key] = id end\n    end\n  end\nend\n",
							name = "[AutoSim] M11S - cast sync",
							uuid = "1516770b-5b85-2f5e-8098-fd311e3aa846",
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
				mechanicTime = 10.203,
				name = "[AutoSim] M11S - cast sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 680,
				timerStartOffset = -8,
				uuid = "5286e093-b908-6e00-89e8-8ee609df7713",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "508938c8-f518-9e9d-a4d1-258907dba45e",
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
							actionLua = "-- M11S draws: weapon resolves (helper 46104 axe / 46105 scythe / 46106 sword at the weapon), Dance of Domination\n-- lines (46112, 6 casters)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nlocal TYPES = {[46104] = \"axe\", [46105] = \"scythe\", [46106] = \"sword\"}\nif not (TYPES[sp] or sp == 46112) then return end\ndata.m11 = data.m11 or {}\nlocal m = data.m11\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nif not ps then return end\nif sp == 46112 then\n  if not m.dod or Now() - m.dod.t > 3000 then m.dod = {t = Now(), lines = {}} end\n  local L = m.dod.lines\n  L[#L + 1] = {x = ps.x, z = ps.z, h = ps.h or 0}\n  return\nend\n-- weapon type is known now: tag the weapon at this spot\nlocal q = m.q\nif not q then return end\nfor _, w in ipairs(q) do\n  if not w.done and math.abs(w.x - ps.x) < 2.5 and math.abs(w.z - ps.z) < 2.5 then\n    w.type = TYPES[sp]; w.active = Now(); break\n  end\nend\n",
							name = "[Draw] M11S - capture casts (channels)",
							uuid = "916af86d-5fe2-9c60-97c4-279c790fecfd",
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
				mechanicTime = 10.203,
				name = "[Draw] M11S - capture casts (channels)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 680,
				timerStartOffset = -8,
				uuid = "c9906d96-0516-4784-a3a5-1609deebd042",
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
							actionLua = "-- M11S draws: weapon damage (46107 axe / 46108 scythe / 46109 sword) marks the current weapon done\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 46107 and sp ~= 46108 and sp ~= 46109 then return end\nlocal m = data.m11\nif not (m and m.q) then return end\nif m.lastHit and Now() - m.lastHit < 1000 then return end\nm.lastHit = Now()\nlocal TYPES = {[46107] = \"axe\", [46108] = \"scythe\", [46109] = \"sword\"}\nfor _, w in ipairs(m.q) do\n  if not w.done then w.done = true; w.type = w.type or TYPES[sp]; break end\nend\n",
							name = "[Draw] M11S - capture weapon hits",
							uuid = "cdbf52a1-6bc8-1292-913c-34a3a723c401",
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
				mechanicTime = 10.203,
				name = "[Draw] M11S - capture weapon hits",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 680,
				timerStartOffset = -8,
				uuid = "e64f38c0-d9e3-f513-8cd7-6986da666727",
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
							actionLua = "-- M11S draws: weapons (ContentID 108) appear. Sets of 3 appear together (order: the one facing outward first,\n-- then clockwise); Ultimate Trophy Weapons appear one by one in resolve order.\nlocal e = eventArgs\nif not (e and e.isVisible and e.entityContentID == 108) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nif not ps then return end\ndata.m11 = data.m11 or {}\nlocal m = data.m11\nlocal now = Now()\nif not m.q or now - (m.lastVis or 0) > 20000 then m.q = {}; m.pend = nil; m.nvis = 0 end\nm.lastVis = now\nm.nvis = (m.nvis or 0) + 1\nm.pend = m.pend or {}\nlocal TY = {[19184] = \"axe\", [19185] = \"scythe\", [19186] = \"sword\"}\nm.pend[#m.pend + 1] = {id = e.entityID, x = ps.x, z = ps.z, h = ps.h or 0, t = now, n = m.nvis, type = TY[ent.modelid]}\n",
							name = "[Draw] M11S - capture weapons appearing",
							uuid = "4fbea91a-5c4c-883d-83b3-e5c379fc30c2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 22,
				loop = true,
				mechanicTime = 10.203,
				name = "[Draw] M11S - capture weapons appearing",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 680,
				timerStartOffset = -8,
				uuid = "062b61a6-5257-8e22-ae6b-a613f448acce",
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
							actionLua = "-- M11S draws: tornadoes (Maelstrom, ContentID 14307) for the bait after Ultimate Trophy Weapons\nlocal e = eventArgs\nif not (e and e.entityContentID == 14307) then return end\ndata.m11 = data.m11 or {}\nlocal m = data.m11\nif not m.tor or Now() - m.tor.t > 30000 then m.tor = {t = Now(), ids = {}} end\nm.tor.ids[#m.tor.ids + 1] = e.entityID\n",
							name = "[Draw] M11S - capture tornadoes",
							uuid = "555f3ac2-7978-580e-9045-1eaa3472cc5b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 5,
				loop = true,
				mechanicTime = 10.203,
				name = "[Draw] M11S - capture tornadoes",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 680,
				timerStartOffset = -8,
				uuid = "41c8b385-a920-c6e7-ad80-cb9ba43a8c2a",
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
				name = "Role Draws",
				uuid = "9830e2bd-b0d4-8b2d-b42f-82698d43f318",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Assault Evolved 1: Sword = your light party's stack (G1 left / G2 right of the boss, behind it); Scythe = your role's\n-- protean spot around the boss. Axe: nothing. Frame = the weapon's spot and heading (the boss jumps onto it).\n-- From 63 / 54 logged pulls.\nlocal m = data.m11\nif not (m and m.q) then return end\n-- finish a batch of appeared weapons: 3 at once = order by outward-facing first, then clockwise\nif m.pend and #m.pend > 0 and Now() - m.pend[#m.pend].t > 1000 then\n  local B = m.pend\n  m.pend = nil\n  if #B == 3 then\n    local function brg(w) return math.atan2(w.x - 100, w.z - 100) end\n    local function wrap(a) while a > math.pi do a = a - 2 * math.pi end while a < -math.pi do a = a + 2 * math.pi end return a end\n    local first = 1\n    for i, w in ipairs(B) do if math.abs(wrap(w.h - brg(w))) < 0.12 then first = i end end\n    local a0 = brg(B[first])\n    table.sort(B, function(u, v)\n      local du = (a0 - brg(u)) % (2 * math.pi); local dv = (a0 - brg(v)) % (2 * math.pi)\n      return du < dv end)\n    m.grp = (m.grp or 0) + 1\n    for _, w in ipairs(B) do w.grp = m.grp; m.q[#m.q + 1] = w end\n  else\n    for _, w in ipairs(B) do w.grp = 100 + math.floor((w.n - 1) / 3); m.q[#m.q + 1] = w end\n  end\nend\nlocal cur\nfor _, w in ipairs(m.q) do if not w.done then cur = w; break end end\nif not cur then return end\nlocal typ = cur.type\nif not typ then\n  -- each group of 3 holds one axe, one sword and one scythe: the last one is known once the other two are\n  local seen, n = {}, 0\n  for _, w in ipairs(m.q) do if w.grp == cur.grp and w ~= cur and w.type then seen[w.type] = true; n = n + 1 end end\n  if n == 2 then for _, t in ipairs({\"axe\", \"sword\", \"scythe\"}) do if not seen[t] then typ = t end end end\nend\nif typ ~= \"sword\" and typ ~= \"scythe\" then return end\nlocal h = cur.h\nlocal o\nif typ == \"sword\" then\n  local g1 = (slot == \"T1\" or slot == \"H1\" or slot == \"M1\" or slot == \"R1\")\n  o = g1 and {-7, -8} or {7, -8}\nelse\n  local SC = {T1 = {0, 3.4}, R1 = {-2.4, 2.4}, H1 = {-3.4, 0}, M1 = {-2.7, -2.7}, T2 = {0, -3.7}, M2 = {2.7, -2.7}, H2 = {3.5, 0}, R2 = {2.4, 2.4}}\n  o = SC[slot]\nend\nif not o then return end\n-- o = {right, forward} in the boss frame; right = (-cos h, sin h), forward = (sin h, cos h)\ngo(cur.x - o[1] * math.cos(h) + o[2] * math.sin(h), cur.z + o[1] * math.sin(h) + o[2] * math.cos(h))\n",
							name = "[Draw] Assault Evolved 1 - sword / scythe spot",
							uuid = "8ed4289a-bec8-54ea-9d6b-9f08ca207200",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 12,
				loop = true,
				mechanicTime = 47.765,
				name = "[Draw] Assault Evolved 1 - sword / scythe spot",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 12.5,
				timerStartOffset = -9,
				uuid = "3ddbfb6c-880c-dad0-9937-9d3c6e25fa90",
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
				name = "Role Draws",
				uuid = "f88625fe-579b-6ba0-a99a-a975891cb966",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Assault Evolved 2: Sword = your light party's stack (G1 left / G2 right of the boss, behind it); Scythe = your role's\n-- protean spot around the boss. Axe: nothing. Frame = the weapon's spot and heading (the boss jumps onto it).\n-- From 63 / 54 logged pulls.\nlocal m = data.m11\nif not (m and m.q) then return end\n-- finish a batch of appeared weapons: 3 at once = order by outward-facing first, then clockwise\nif m.pend and #m.pend > 0 and Now() - m.pend[#m.pend].t > 1000 then\n  local B = m.pend\n  m.pend = nil\n  if #B == 3 then\n    local function brg(w) return math.atan2(w.x - 100, w.z - 100) end\n    local function wrap(a) while a > math.pi do a = a - 2 * math.pi end while a < -math.pi do a = a + 2 * math.pi end return a end\n    local first = 1\n    for i, w in ipairs(B) do if math.abs(wrap(w.h - brg(w))) < 0.12 then first = i end end\n    local a0 = brg(B[first])\n    table.sort(B, function(u, v)\n      local du = (a0 - brg(u)) % (2 * math.pi); local dv = (a0 - brg(v)) % (2 * math.pi)\n      return du < dv end)\n    m.grp = (m.grp or 0) + 1\n    for _, w in ipairs(B) do w.grp = m.grp; m.q[#m.q + 1] = w end\n  else\n    for _, w in ipairs(B) do w.grp = 100 + math.floor((w.n - 1) / 3); m.q[#m.q + 1] = w end\n  end\nend\nlocal cur\nfor _, w in ipairs(m.q) do if not w.done then cur = w; break end end\nif not cur then return end\nlocal typ = cur.type\nif not typ then\n  -- each group of 3 holds one axe, one sword and one scythe: the last one is known once the other two are\n  local seen, n = {}, 0\n  for _, w in ipairs(m.q) do if w.grp == cur.grp and w ~= cur and w.type then seen[w.type] = true; n = n + 1 end end\n  if n == 2 then for _, t in ipairs({\"axe\", \"sword\", \"scythe\"}) do if not seen[t] then typ = t end end end\nend\nif typ ~= \"sword\" and typ ~= \"scythe\" then return end\nlocal h = cur.h\nlocal o\nif typ == \"sword\" then\n  local g1 = (slot == \"T1\" or slot == \"H1\" or slot == \"M1\" or slot == \"R1\")\n  o = g1 and {-7, -8} or {7, -8}\nelse\n  local SC = {T1 = {0, 3.4}, R1 = {-2.4, 2.4}, H1 = {-3.4, 0}, M1 = {-2.7, -2.7}, T2 = {0, -3.7}, M2 = {2.7, -2.7}, H2 = {3.5, 0}, R2 = {2.4, 2.4}}\n  o = SC[slot]\nend\nif not o then return end\n-- o = {right, forward} in the boss frame; right = (-cos h, sin h), forward = (sin h, cos h)\ngo(cur.x - o[1] * math.cos(h) + o[2] * math.sin(h), cur.z + o[1] * math.sin(h) + o[2] * math.cos(h))\n",
							name = "[Draw] Assault Evolved 2 - sword / scythe spot",
							uuid = "2204ebb7-ad62-9139-9090-9ec1f347e8e7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 12,
				loop = true,
				mechanicTime = 92.436,
				name = "[Draw] Assault Evolved 2 - sword / scythe spot",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 12.5,
				timerStartOffset = -20,
				uuid = "83c99906-7d2e-9f75-8fee-8fd84fb0dd70",
				version = 2,
			},
		},
	},
	[40] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "32cfcf0e-d8fa-da72-bde9-dd6212a7858b",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Dance of Domination: the open side (no line on that edge) is the new SOUTH. Pair stacks in the gaps:\n-- MT + M1 new west, OT + M2 new east (middle), H1 + R1 new south-west, H2 + R2 new south-east. 57 logged pulls.\nlocal m = data.m11\nlocal d = m and m.dod\nif not d or Now() - d.t > 6500 or #d.lines < 6 then return end\nlocal has = {}\nfor _, L in ipairs(d.lines) do\n  local vert = math.abs(math.sin(L.h)) < 0.3\n  local horiz = math.abs(math.cos(L.h)) < 0.3\n  if vert and math.abs(L.x - 85) < 3 then has.W = true end\n  if vert and math.abs(L.x - 115) < 3 then has.E = true end\n  if horiz and math.abs(L.z - 85) < 3 then has.N = true end\n  if horiz and math.abs(L.z - 115) < 3 then has.S = true end\nend\nlocal S = {W = {-1, 0}, E = {1, 0}, N = {0, -1}, S = {0, 1}}\nlocal open\nfor k in pairs(S) do if not has[k] then open = k end end\nif not open then return end\nlocal s = S[open]\nlocal ex, ez = s[2], -s[1]\nlocal UV = {T1 = {-8, 0}, M1 = {-8, 0}, T2 = {8, 0}, M2 = {8, 0}, H1 = {-6.5, 15.5}, R1 = {-6.5, 15.5}, H2 = {6.5, 15.5}, R2 = {6.5, 15.5}}\nlocal o = UV[slot]\nif not o then return end\ngo(100 + o[1] * ex + o[2] * s[1], 100 + o[1] * ez + o[2] * s[2])\n",
							name = "[Draw] Dance of Domination - pair stack",
							uuid = "49e04a07-8b9e-f6ad-b864-71cac9a1de3a",
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
				mechanicTime = 149.637,
				name = "[Draw] Dance of Domination - pair stack",
				timeRange = true,
				timelineIndex = 40,
				timerEndOffset = 1,
				timerStartOffset = -5,
				uuid = "872bd900-d765-b839-a6d0-c9d4c75d45a9",
				version = 2,
			},
		},
	},
	[48] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "04d41fde-4c50-cdb8-9651-e25018d84fec",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Ultimate Trophy Weapons: Sword = your light party's stack (G1 left / G2 right of the boss, behind it); Scythe = your role's\n-- protean spot around the boss. Axe: nothing. Frame = the weapon's spot and heading (the boss jumps onto it).\n-- From 63 / 54 logged pulls.\nlocal m = data.m11\nif not (m and m.q) then return end\n-- finish a batch of appeared weapons: 3 at once = order by outward-facing first, then clockwise\nif m.pend and #m.pend > 0 and Now() - m.pend[#m.pend].t > 1000 then\n  local B = m.pend\n  m.pend = nil\n  if #B == 3 then\n    local function brg(w) return math.atan2(w.x - 100, w.z - 100) end\n    local function wrap(a) while a > math.pi do a = a - 2 * math.pi end while a < -math.pi do a = a + 2 * math.pi end return a end\n    local first = 1\n    for i, w in ipairs(B) do if math.abs(wrap(w.h - brg(w))) < 0.12 then first = i end end\n    local a0 = brg(B[first])\n    table.sort(B, function(u, v)\n      local du = (a0 - brg(u)) % (2 * math.pi); local dv = (a0 - brg(v)) % (2 * math.pi)\n      return du < dv end)\n    m.grp = (m.grp or 0) + 1\n    for _, w in ipairs(B) do w.grp = m.grp; m.q[#m.q + 1] = w end\n  else\n    for _, w in ipairs(B) do w.grp = 100 + math.floor((w.n - 1) / 3); m.q[#m.q + 1] = w end\n  end\nend\nlocal cur\nfor _, w in ipairs(m.q) do if not w.done then cur = w; break end end\nif not cur then return end\nlocal typ = cur.type\nif not typ then\n  -- each group of 3 holds one axe, one sword and one scythe: the last one is known once the other two are\n  local seen, n = {}, 0\n  for _, w in ipairs(m.q) do if w.grp == cur.grp and w ~= cur and w.type then seen[w.type] = true; n = n + 1 end end\n  if n == 2 then for _, t in ipairs({\"axe\", \"sword\", \"scythe\"}) do if not seen[t] then typ = t end end end\nend\nif typ ~= \"sword\" and typ ~= \"scythe\" then return end\nlocal h = cur.h\nlocal o\nif typ == \"sword\" then\n  local g1 = (slot == \"T1\" or slot == \"H1\" or slot == \"M1\" or slot == \"R1\")\n  o = g1 and {-7, -8} or {7, -8}\nelse\n  local SC = {T1 = {0, 3.4}, R1 = {-2.4, 2.4}, H1 = {-3.4, 0}, M1 = {-2.7, -2.7}, T2 = {0, -3.7}, M2 = {2.7, -2.7}, H2 = {3.5, 0}, R2 = {2.4, 2.4}}\n  o = SC[slot]\nend\nif not o then return end\n-- o = {right, forward} in the boss frame; right = (-cos h, sin h), forward = (sin h, cos h)\ngo(cur.x - o[1] * math.cos(h) + o[2] * math.sin(h), cur.z + o[1] * math.sin(h) + o[2] * math.cos(h))\n",
							name = "[Draw] Ultimate Trophy Weapons - sword / scythe spot",
							uuid = "a21727f5-941b-0549-bc5c-a1ed6048cd42",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 12,
				loop = true,
				mechanicTime = 191.903,
				name = "[Draw] Ultimate Trophy Weapons - sword / scythe spot",
				timeRange = true,
				timelineIndex = 48,
				timerEndOffset = 28,
				timerStartOffset = -8,
				uuid = "f5d191f9-539c-ddd1-a59a-168fa13eff2c",
				version = 2,
			},
		},
	},
	[61] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "8f9b6b8e-2213-83bc-b255-a959e3b04cbe",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Ultimate Trophy Weapons tornado bait: stand diagonally out from your tornado (N: R1 NW, MT NE; W: H1 NW, M1 SW;\n-- E: R2 NE, H2 SE; S: OT SW, M2 SE). Tornadoes from the Maelstrom spawns, else the usual cardinal spots. 54 pulls.\nlocal MAP = {R1 = {\"N\", -1, -1}, T1 = {\"N\", 1, -1}, H1 = {\"W\", -1, -1}, M1 = {\"W\", -1, 1},\n             R2 = {\"E\", 1, -1}, H2 = {\"E\", 1, 1}, T2 = {\"S\", -1, 1}, M2 = {\"S\", 1, 1}}\nlocal o = MAP[slot]\nif not o then return end\nlocal T = {N = {100, 88}, W = {90.2, 99.6}, E = {109.8, 99.6}, S = {100, 112.1}}\nlocal m = data.m11\nif m and m.tor then\n  for _, id in ipairs(m.tor.ids) do\n    local ent = TensorCore.mGetEntity(id)\n    if ent and ent.pos then\n      local dx, dz = ent.pos.x - 100, ent.pos.z - 100\n      local c = (math.abs(dx) > math.abs(dz)) and (dx > 0 and \"E\" or \"W\") or (dz > 0 and \"S\" or \"N\")\n      T[c] = {ent.pos.x, ent.pos.z}\n    end\n  end\nend\nlocal t = T[o[1]]\ngo(t[1] + 4.5 * o[2], t[2] + 4.5 * o[3])\n",
							name = "[Draw] Ultimate Trophy Weapons - tornado bait",
							uuid = "1d8b1ce5-6577-d090-ae58-ae40677d8f66",
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
				mechanicTime = 225.152,
				name = "[Draw] Ultimate Trophy Weapons - tornado bait",
				timeRange = true,
				timelineIndex = 61,
				timerEndOffset = 0.5,
				timerStartOffset = -6.5,
				uuid = "492d4618-1413-f241-acc8-9d251d374dc0",
				version = 2,
			},
		},
	},
	[79] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "c8a76174-d10b-ad15-b174-b4c450043e1d",
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
							actionLua = "data.m11 = data.m11 or {}\ndata.m11.mr0 = Now()\nself.used = true\n",
							conditions = 
							{
								
								{
									"b8588eee-e228-ee4f-96c5-9d6215bd5b3b",
									true,
								},
							},
							name = "Record Meteorain start",
							uuid = "a04469c0-f018-d6ad-bcc0-b168a7fcaf04",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 46132,
							name = "Meteorain 46132",
							uuid = "b8588eee-e228-ee4f-96c5-9d6215bd5b3b",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 291.105,
				name = "[Draw] Meteorain - record start",
				timeRange = true,
				timelineIndex = 79,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "720098c6-9dc9-a21c-a911-467ce4ef4958",
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
							actionLua = "-- M11S draws: Meteorain clone tethers (356) - clone cardinal + which meteor (north or south-west)\nlocal e = eventArgs\nlocal c = TensorCore.mGetEntity(e.sourceEntityID)\nlocal mt = TensorCore.mGetEntity(e.newTargetID)\nif not (c and c.pos and mt and mt.pos) then return end\ndata.m11 = data.m11 or {}\nlocal m = data.m11\nm.teth = m.teth or {}\nm.srcN = m.srcN or {}\n-- which meteor this clone's tether belongs to is decided when it targets the Comet (ContentID 14306);\n-- once a player holds it, keep that answer instead of the holder's position\nlocal north\nif e.newTargetContentID == 14306 then north = mt.pos.z < 100; m.srcN[e.sourceEntityID] = north\nelse north = m.srcN[e.sourceEntityID] end\nif north == nil then return end\nm.teth[#m.teth + 1] = {t = Now(), cx = c.pos.x, cz = c.pos.z, north = north}\nself.used = true\n",
							conditions = 
							{
								
								{
									"f7bc1077-deda-f287-a70d-3a07c4261b9a",
									true,
								},
							},
							name = "Capture Meteorain tether",
							uuid = "4bac6d20-f273-a90d-b420-2feb3d5e6fdc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 356,
							name = "Tether 356",
							uuid = "f7bc1077-deda-f287-a70d-3a07c4261b9a",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 291.105,
				name = "[Draw] Meteorain - capture tethers",
				timeRange = true,
				timelineIndex = 79,
				timerEndOffset = 56,
				uuid = "12139b20-eaea-b546-b3a2-a776a841504a",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Meteorain: your spot for each step (bait order M > H > R, meteors NE + SW, line stacks NW then behind the NE / NW / NE\n-- meteor, hide SW behind the 3 meteors). Tanks: stand 7y toward the clone that tethers your meteor (MT north meteor,\n-- OT south-west meteor). Never mirrors (32 clean logged pulls). Times are seconds after Meteorain starts casting.\n-- Third set (until 34.08 s): R1 hides SW (by 4), R2 NE, same as the R1 / R2 image markers.\nlocal m = data.m11\nlocal t0 = m and m.mr0\nif not t0 then return end\nlocal el = (Now() - t0) / 1000\nlocal ST = {\n  M1 = {{6.09, 101, 99.2}, {14.08, 104.8, 95.4}, {15.97, 105.9, 94.2}, {22.82, 106.8, 93.3}, {32.77, 93, 93.5}, {42.77, 107.3, 92.5}, {55.32, 94.7, 105.5}, {61.32, 83.3, 117.2}},\n  M2 = {{6.09, 99, 101.4}, {14.08, 95.5, 104.7}, {22.82, 106.8, 93.3}, {32.77, 93, 93.5}, {42.77, 107.3, 92.5}, {55.32, 94.7, 105.5}, {61.32, 83.3, 117.2}},\n  H1 = {{12.87, 93.1, 93.2}, {15.97, 98.5, 99.0}, {24.05, 95.6, 95.7}, {32.77, 93, 93.5}, {42.77, 107.3, 92.5}, {61.32, 83.3, 117.2}},\n  H2 = {{12.87, 93.1, 93.2}, {15.97, 98.5, 99.0}, {24.05, 90.4, 110.3}, {32.77, 93, 93.5}, {42.77, 107.3, 92.5}, {61.32, 83.3, 117.2}},\n  R1 = {{12.87, 93.1, 93.2}, {22.82, 106.8, 93.3}, {25.93, 99, 101.5}, {34.08, 85.1, 115.3}, {42.77, 107.3, 92.5}, {61.32, 83.3, 117.2}},\n  R2 = {{12.87, 93.1, 93.2}, {22.82, 106.8, 93.3}, {25.93, 99, 101.5}, {34.08, 105.3, 95.0}, {42.77, 107.3, 92.5}, {61.32, 83.3, 117.2}},\n  T1 = {{12.87, 95.2, 95.3}, {16.42}, {22.02, \"T\"}, {26.32}, {32.02, \"T\"}, {36.37}, {41.97, \"T\"}, {47.82}, {55.32, 94.7, 105.5}, {61.32, 83.3, 117.2}},\n  T2 = {{12.87, 95.2, 95.3}, {16.42}, {22.02, \"T\"}, {26.32}, {32.02, \"T\"}, {36.37}, {41.97, \"T\"}, {47.82}, {55.32, 94.7, 105.5}, {61.32, 83.3, 117.2}}\n}\nlocal steps = ST[slot]\nif not steps then return end\nlocal cur\nfor _, s in ipairs(steps) do if el < s[1] then cur = s; break end end\nif not cur or not cur[2] then return end\nif cur[2] == \"T\" then\n  local tt = m.teth\n  if not tt then return end\n  local north = (slot == \"T1\")\n  for i = #tt, 1, -1 do\n    local r = tt[i]\n    if Now() - r.t < 7000 and r.north == north then\n      local dx, dz = r.cx - 100, r.cz - 100\n      local L = math.sqrt(dx * dx + dz * dz)\n      if L < 1 then return end\n      if not north and dx > 10 and math.abs(dz) < 5 then go(106, 105) return end\n      go(100 + 7 * dx / L, 100 + 7 * dz / L)\n      return\n    end\n  end\n  return\nend\ngo(cur[2], cur[3])\n",
							name = "Draw role destination",
							uuid = "ef034ca1-4abf-24c2-b93f-08dedca9e0a4",
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
				mechanicTime = 291.105,
				name = "[Draw] Meteorain - your spot",
				timeRange = true,
				timelineIndex = 79,
				timerEndOffset = 56,
				timerStartOffset = -5,
				uuid = "7c28a7ba-06e7-477b-aae2-e1df25af3924",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				execute = "local player = TensorCore.mGetPlayer()\nif not player or not player.pos or not TensorCore.isMelee(player, true) then\n    self.used = true\n    return\nend\n-- your Party Roster slot (AnyoneCore); only your own spot is shown\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then slot = GetCurrentRole() end\nif slot ~= \"M1\" and slot ~= \"M2\" then\n    self.used = true\n    return\nend\n\nlocal state = data.m11s_meteorain_melee_spots\nif not state then\n    -- images ship with the profile in TimelineReactions\\Tataru\\assets\\M11S\\Meteorain (any LuaMods folder)\n    local dir = GetLuaModsPath() .. [[TensorReactions\\TimelineReactions\\Tataru\\assets\\M11S\\Meteorain\\]]\n    state = {\n        drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        groundFlags = Argus2.RenderFlags.FLAG_WARP_TERRAIN | Argus2.RenderFlags.FLAG_RENDER_OVERLAY,\n        labelFlags = Argus2.RenderFlags.FLAG_RENDER_UI | Argus2.RenderFlags.FLAG_RENDER_OVERLAY,\n        blue = dir .. \"spot-blue.png\",\n        green = dir .. \"spot-green.png\",\n        m1 = dir .. \"M1.png\",\n        m2 = dir .. \"M2.png\",\n    }\n    data.m11s_meteorain_melee_spots = state\nend\n\nlocal px, pz = player.pos.x, player.pos.z\nlocal m1x, m1z = 104.753, 95.360\nlocal m2x, m2z = 95.384, 105.638\nlocal radius = 1.2\n\nlocal dx1, dz1 = px - m1x, pz - m1z\nlocal dx2, dz2 = px - m2x, pz - m2z\nlocal m1Inside = dx1 * dx1 + dz1 * dz1 <= radius * radius\nlocal m2Inside = dx2 * dx2 + dz2 * dz2 <= radius * radius\n\nif slot == \"M1\" then\n    state.drawer:addTexture(m1x, 0.02, m1z, 0, m1Inside and state.green or state.blue, 0, 0, 2.85, 2.85, state.groundFlags)\n    state.drawer:addScreenFacingTexture(m1x, 0.5, m1z, 0, state.m1, 0, 0, 2.0, 1.0, state.labelFlags)\nelse\n    state.drawer:addTexture(m2x, 0.02, m2z, 0, m2Inside and state.green or state.blue, 0, 0, 2.85, 2.85, state.groundFlags)\n    state.drawer:addScreenFacingTexture(m2x, 0.5, m2z, 0, state.m2, 0, 0, 2.0, 1.0, state.labelFlags)\nend\n\nself.used = true",
				executeType = 2,
				mechanicTime = 291.105,
				name = "[Draw] Meteorain M1/M2 Spots",
				timeRange = true,
				timelineIndex = 79,
				timerEndOffset = 19.095,
				uuid = "dec24395-3f6a-5f17-8f01-024ed1a71c47",
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
				name = "Role Draws",
				uuid = "e81b515d-87a7-0122-8db1-07f90ddec8b0",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				execute = "local player = TensorCore.mGetPlayer()\nif not player or not player.pos then self.used = true; return end\nlocal job = TensorCore.getJobNameByID(player.job)\nif job ~= \"BLM\" and job ~= \"BRD\" and job ~= \"DNC\" and job ~= \"MCH\"\n    and job ~= \"SMN\" and job ~= \"PCT\" and job ~= \"RDM\" then\n    self.used = true; return\nend\n-- your Party Roster slot (AnyoneCore); only your own spot is shown\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then slot = GetCurrentRole() end\nif slot ~= \"R1\" and slot ~= \"R2\" then self.used = true; return end\nlocal spots = data.m11s_ranged_spots\nif not spots then\n    -- images ship with the profile in TimelineReactions\\Tataru\\assets\\M11S\\Meteorain (any LuaMods folder)\n    local dir = GetLuaModsPath() .. [[TensorReactions\\TimelineReactions\\Tataru\\assets\\M11S\\Meteorain\\]]\n    spots = {\n        drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        groundFlags = Argus2.RenderFlags.FLAG_WARP_TERRAIN | Argus2.RenderFlags.FLAG_RENDER_OVERLAY,\n        labelFlags = Argus2.RenderFlags.FLAG_RENDER_UI | Argus2.RenderFlags.FLAG_RENDER_OVERLAY,\n        blue = dir .. \"spot-blue.png\",\n        green = dir .. \"spot-green.png\",\n        r1 = dir .. \"R1.png\",\n        r2 = dir .. \"R2.png\",\n    }\n    data.m11s_ranged_spots = spots\nend\nlocal function drawSpot(x, z, label)\n    local dx, dz = player.pos.x - x, player.pos.z - z\n    local inside = dx * dx + dz * dz <= 1.2 * 1.2\n    spots.drawer:addTexture(x, 0.02, z, 0, inside and spots.green or spots.blue,\n        0, 0, 2.85, 2.85, spots.groundFlags)\n    spots.drawer:addScreenFacingTexture(x, 0.5, z, 0, label == \"R1\" and spots.r1 or spots.r2,\n        0, 0, 2.0, 1.0, spots.labelFlags)\nend\nif slot == \"R1\" then drawSpot(84.500, 116.500, \"R1\") else drawSpot(105.500, 95.000, \"R2\") end\nself.used = true\n",
				executeType = 2,
				mechanicTime = 310.246,
				name = "[Ranged Draw] Meteorain third set R1/R2",
				timeRange = true,
				timelineIndex = 86,
				timerEndOffset = 12.45,
				uuid = "8ef6e09f-8bd4-262b-b276-cad67b47ff0f",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "r11s",
	version = "1.5.0",
}



return tbl