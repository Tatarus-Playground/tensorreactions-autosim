local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "6b7dd0d5-da4c-eef0-976d-6dd28dfc95a8",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Wipe phases from any other AutoSim setup first\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimUncertainty)\napi.setAutoSimKillTime(480)\n-- New pull: make sure Burn starts off\nACR_TensorViper4_Burn = false\nTensorNecronVPRBurn = nil\n-- Darkness of Eternity (median hit 243.2s): no target from +6 to +21.3,\n-- something hittable for ~8s, then no target until Necron returns (~+60.6)\nTensorNecronVPR = {\n  kill = 480,\n  g1 = api.addAutoSimPhase(\"FullDowntime\", 249.2, 264.5),\n  g2s = 272.7,\n  g2 = api.addAutoSimPhase(\"FullDowntime\", 272.7, 303.9),\n  -- Mass Macabre (median cast 439.9): M1 2-person tower west is out of melee\n  mm = api.addAutoSimPhase(\"MeleeDowntime\", 442.4, 450.4),\n}\napi.addAutoSimUncertainty(200, 5)\nself.used = true\n",
							conditions = 
							{
								
								{
									"c8e4ad4b-6615-9edb-97c7-24337e9ff5b4",
									true,
								},
							},
							name = "[VPR] AutoSim - Necron EX",
							uuid = "02a70544-200a-a66a-94b4-bc301df41400",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "c8e4ad4b-6615-9edb-97c7-24337e9ff5b4",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 16,
				mechanicTime = 8,
				name = "[VPR] AutoSim - Necron EX",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "deac76c8-117d-e203-8ccb-c9e7f08e49bb",
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
							actionLua = "ACR_TensorViper4_Burn = false\nTensorNecronVPRBurn = nil\nself.used = true\n",
							conditions = 
							{
								
								{
									"908302e2-7ac2-58fe-89f1-c8b8a0e56789",
									true,
								},
							},
							name = "[VPR] Burn Off (wipe)",
							uuid = "c3570edd-629b-8aaf-b574-6510208487c8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "908302e2-7ac2-58fe-89f1-c8b8a0e56789",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 9,
				mechanicTime = 8,
				name = "[VPR] Burn Off (wipe)",
				timelineIndex = 1,
				uuid = "ff0cd514-3ec0-2235-a1e0-8d7d34615794",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "0d72c2d3-e6f4-5d43-928e-745aa9e0fc8f",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- BLM AutoSim for Necron EX. Kill time and no-target phases match the Viper setup.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 480)\nlocal function add(a, b, kind)\n  local ok, id = pcall(api.addAutoSimPhase, kind or \"CasterDowntime\", a, b)\n  if ok then return id end\nend\n-- Darkness of Eternity (median hit 243.2s): no target from +6 to +21.3,\n-- something hittable for ~8s, then no target until Necron returns (~+60.6)\nTensorNecronBLM = {\n  kill = 480,\n  g1 = add(249.2, 264.5, \"FullDowntime\"),\n  g2s = 272.7,\n  g2 = add(272.7, 303.9, \"FullDowntime\"),\n  -- caster downtime (no hardcasts): local damage casters + 68 top BLM FFLogs kills; re-timed on the real casts\n  cg1 = add(38.40, 42.90), -- Cold Grip 1: +4.0..+8.5\n  ed1 = add(50.00, 52.50), -- Existential Dread 1: +9.0..+11.5\n  ee1 = add(107.90, 110.40), -- The End's Embrace 1: +8.5..+11.0\n  gc1 = add(146.80, 149.80), -- Grand Cross 1: +13.0..+16.0\n  gc2 = add(170.85, 173.60), -- Grand Cross end: +0.75..+3.5\n  ee2 = add(326.30, 331.80), -- The End's Embrace 2: +9.0..+14.5\n  sd2a = add(401.40, 404.40), -- Specter of Death 2 (a): +5.5..+8.5\n  sd2b = add(406.40, 409.40), -- Specter of Death 2 (b): +10.5..+13.5\n  sr3a = add(412.10, 414.10), -- Soul Reaping 3 (a): +4.5..+6.5\n  sr3b = add(416.60, 419.10), -- Soul Reaping 3 (b): +9.0..+11.5\n}\npcall(api.addAutoSimUncertainty, 200, 5)\nself.used = true\n",
							conditions = 
							{
								
								{
									"0089984b-80bc-1600-8846-2b627c0e4d2b",
									true,
								},
							},
							name = "[BLM] AutoSim - Necron EX",
							uuid = "a1f91cb6-0667-771b-adaa-9bf5c08ee0e5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "0089984b-80bc-1600-8846-2b627c0e4d2b",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 16,
				mechanicTime = 8,
				name = "[BLM] AutoSim - Necron EX",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "6cb62885-4e5b-89ec-a893-c6fadc6c8abb",
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
							actionLua = "-- Re-time each BLM caster downtime window on the real boss cast start\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorNecronBLM\nif not s then return end\nlocal SPEC = {\n  {44612, 1, \"cg1\", 4.0, 8.5},\n  {44555, 1, \"ed1\", 9.0, 11.5},\n  {44597, 1, \"ee1\", 8.5, 11.0},\n  {44568, 1, \"gc1\", 13.0, 16.0},\n  {44571, 2, \"gc2\", 0.75, 3.5},\n  {44597, 2, \"ee2\", 9.0, 14.5},\n  {44606, 2, \"sd2a\", 5.5, 8.5},\n  {44606, 2, \"sd2b\", 10.5, 13.5},\n  {44556, 3, \"sr3a\", 4.5, 6.5},\n  {44556, 3, \"sr3b\", 9.0, 11.5}\n}\nlocal sp = e.spellID\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not t then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nlocal counted = false\nfor _, w in ipairs(SPEC) do\n  if w[1] == sp then\n    if not counted then\n      if not s.lastC[sp] or t - s.lastC[sp] > 5 then\n        s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1\n      end\n      counted = true\n    end\n    local key = w[3]\n    if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n      s.done = s.done or {}; s.done[key] = true\n      if s[key] then\n        local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5]); if ok then s[key] = id end\n      else\n        local ok, id = pcall(api.addAutoSimPhase, \"CasterDowntime\", t + w[4], t + w[5]); if ok then s[key] = id end\n      end\n    end\n  end\nend\n",
							conditions = 
							{
								
								{
									"8a297720-7d47-023d-a219-27adcb44234b",
									true,
								},
							},
							name = "[BLM] AutoSim - Caster Downtime Sync",
							uuid = "d517bcc9-66c6-5d38-b429-b48b28e3fc6c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "8a297720-7d47-023d-a219-27adcb44234b",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 3,
				loop = true,
				mechanicTime = 8,
				name = "[BLM] AutoSim - Caster Downtime Sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 600,
				timerStartOffset = -8,
				uuid = "d7f713c3-f11e-f5f6-a42b-fcd4dc8f854a",
				version = 2,
			},
		},
	}, 
	[4] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "544efed2-2e90-e7dc-9353-4e272a5af52c",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"a566fe2e-415c-73ca-ae05-49cf85573242",
									true,
								},
								
								{
									"fd20c458-370d-6207-9ff7-9495a5a4a6c3",
									true,
								},
								
								{
									"07953b25-865b-4fbf-a2b9-e56153786bde",
									true,
								},
								
								{
									"75047ed1-16d8-d7a0-ba1d-3c04f8e4e467",
									true,
								},
							},
							gVar = "ACR_TensorViper4_Hotbar_Feint",
							uuid = "30516df8-6ecd-8d0b-8bcb-0d714f9127cc",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "a566fe2e-415c-73ca-ae05-49cf85573242",
							version = 3,
						},
					},
					
					{
						data = 
						{
							actionCDValue = 1,
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Feint ready",
							uuid = "fd20c458-370d-6207-9ff7-9495a5a4a6c3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "07953b25-865b-4fbf-a2b9-e56153786bde",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "75047ed1-16d8-d7a0-ba1d-3c04f8e4e467",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 28.9,
				name = "[VPR] Feint - Fear of Death",
				timeRange = true,
				timelineIndex = 4,
				timerEndOffset = -2,
				timerStartOffset = -6,
				uuid = "b35f5cb6-7e8e-5fb5-8e4e-f3bca100c6a4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "0b02c859-db70-da1d-a2f7-e280bf18cb61",
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
							actionLua = "-- Fear of Death 1 - spread spot: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-16.8,-11.7},M1={-6.1,-11.7},M2={5.3,-11.7},T2={16.6,-11.7},R1={-16.8,0.1},H1={-6.1,0.1},H2={5.3,0.1},R2={16.6,0.1}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Fear of Death 1 - spread spot",
							uuid = "75d6e5d2-6dbc-143e-b3a7-0b6398bae7fa",
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
				mechanicTime = 28.9,
				name = "[Draw] Fear of Death 1 - spread spot",
				timeRange = true,
				timelineIndex = 4,
				timerEndOffset = 3,
				timerStartOffset = -10,
				uuid = "7b274e9b-451e-071f-b8f7-99a8d4f77e1a",
				version = 2,
			},
		},
	},
	[9] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "2c5265fb-33bf-de5a-a654-4eebe5851a59",
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
							actionLua = "-- Memento Mori cast started: 44566 = dark side west, 44565 = dark side east (from 40 pulls of logs)\nlocal e = eventArgs\nif not e then return end\nlocal id = e.spellID\nif id ~= 44565 and id ~= 44566 then return end\nTensorNecMM = {darkWest = (id == 44566), t = Now()}\nself.used = true\n",
							name = "[Draw] Memento Mori - side (cast start)",
							uuid = "fbe1d02b-741d-ac3d-81ed-7727b0f33e23",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 52.4,
				name = "[Draw] Memento Mori - side (cast start)",
				timeRange = true,
				timelineIndex = 9,
				timerEndOffset = 1,
				timerStartOffset = -9,
				uuid = "5bbc3d18-e85f-fecc-9ca2-01df47c636b0",
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
							actionLua = "-- Memento Mori spread spot: arrow + circle to your own spot for Smite of Gloom.\n-- Tanks spread on the dark side, everyone else on the light side (player positions from logs, center 100,100).\n-- Offsets are for dark side west; x is mirrored when the dark side is east.\nlocal s = TensorNecMM\nif not s or Now() - s.t > 16000 then return end\nlocal SPOTS = {T1={-17,4},T2={-7,4},M1={6.5,-14.5},M2={17.3,-14.5},H1={6.5,1},H2={17.3,1},R1={6.5,14.5},R2={17.3,14.5}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal ox = s.darkWest and o[1] or -o[1]\nlocal dest = {x = 100 + ox, y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Memento Mori - spread spot",
							uuid = "82aa3efc-c9e9-669b-87ad-14786eb5b012",
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
				mechanicTime = 52.4,
				name = "[Draw] Memento Mori - spread spot",
				timeRange = true,
				timelineIndex = 9,
				timerEndOffset = 8,
				timerStartOffset = -5,
				uuid = "a5cbcae2-1176-049d-a0fd-0ea31d7eec64",
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
				name = "Role Draws",
				uuid = "e4155baf-f3e0-b779-b4ac-5afae8e198c7",
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
							actionLua = "-- Stack cast started: remember type and when it lands\nlocal e = eventArgs\nif not e then return end\nlocal K = {[44557] = {\"LP\", 6.3}, [44558] = {\"PAIR\", 6.3}, [45167] = {\"LP\", 18.0}, [45168] = {\"PAIR\", 18.0}}\nlocal k = K[e.spellID]\nif not k then return end\nlocal due = Now() + k[2] * 1000\nTensorNecStack = {kind = k[1], due = due}\nlocal p = TensorCore.mGetPlayer()\nif p then\n  local txt = (k[1] == \"LP\") and \"LIGHT PARTY STACK\" or \"PARTNER STACK\"\n  local col = (k[1] == \"LP\") and 0xFF00D7FF or 0xFFFF66FF\n  pcall(AnyoneCore.addTimedWorldTextOnEnt, k[2] * 1000, txt, p.id, col, true, 2.4, 3.2)\nend\nself.used = true\n",
							name = "[Draw] Stack alert - Blight 1 (cast start)",
							uuid = "20c3483b-9f74-be8f-b293-d324ddc086a2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 77.7,
				name = "[Draw] Stack alert - Blight 1 (cast start)",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = -1,
				timerStartOffset = -12,
				uuid = "f2f7f5f1-fc9f-00c2-8b07-e0738e53c6e8",
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
							actionLua = "-- Tether to who you stack with, until the stack lands\nlocal s = TensorNecStack\nif not s or Now() > s.due + 400 then return end\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal p = TensorCore.mGetPlayer()\nif not (slot and p and p.pos) then return end\nlocal PAIR = {T1 = \"M1\", M1 = \"T1\", T2 = \"M2\", M2 = \"T2\", H1 = \"R1\", R1 = \"H1\", H2 = \"R2\", R2 = \"H2\"}\nlocal LP = {T1 = \"H1\", M1 = \"H1\", R1 = \"H1\", H1 = nil, T2 = \"H2\", M2 = \"H2\", R2 = \"H2\", H2 = nil}\nlocal want = (s.kind == \"PAIR\") and PAIR[slot] or LP[slot]\nlocal role = want and ((want == \"T1\" and \"MT\") or (want == \"T2\" and \"OT\") or want)\nlocal mate = role and GetRole and GetRole(role)\nlocal left = (s.due - Now()) / 1000\nlocal col = (s.kind == \"LP\") and 0x00D7FF or 0xFF66FF\nlocal a = left < 2 and 0xFF000000 or 0xAA000000\nlocal ring = TensorCore.getCachedDrawer(0x22000000 + col, 0x44000000 + col, a + col, a + col, 3)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nring:addCircle(p.pos.x, p.pos.y, p.pos.z, (s.kind == \"LP\") and 2.0 or 1.4, false, flags)\nif mate and mate.pos and mate.id ~= p.id then\n  local line = TensorCore.getStaticDrawer(a + col, 5)\n  line:addLine(p.pos.x, p.pos.y, p.pos.z, mate.pos.x, mate.pos.y, mate.pos.z, 5)\n  ring:addCircle(mate.pos.x, mate.pos.y, mate.pos.z, 1.4, false, flags)\nend\n",
							name = "[Draw] Stack tether - Blight 1",
							uuid = "1b0b5045-f05b-7da4-9136-e9a02d807ee3",
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
				mechanicTime = 77.7,
				name = "[Draw] Stack tether - Blight 1",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 3,
				timerStartOffset = -9,
				uuid = "463ec216-c8db-f90d-a112-d8416a348eef",
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
				name = "Role Draws",
				uuid = "afb045b8-0efe-4f04-b13f-54764930ac0b",
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
							actionLua = "-- Fear of Death 2 - spread spot: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-16.8,-11.7},M1={-6.1,-11.7},M2={5.3,-11.7},T2={16.6,-11.7},R1={-16.8,0.1},H1={-6.1,0.1},H2={5.3,0.1},R2={16.6,0.1}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Fear of Death 2 - spread spot",
							uuid = "2bc0d51f-98d7-c200-8697-292e9cfa273a",
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
				mechanicTime = 92.8,
				name = "[Draw] Fear of Death 2 - spread spot",
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = 3,
				timerStartOffset = -10,
				uuid = "22ba7faf-e726-024c-8fe6-a9f3c4e2f37a",
				version = 2,
			},
		},
	},
	[24] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "8cd7c949-52fe-6dc7-8105-a3b64afc9e47",
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
							actionLua = "-- Stack cast started: remember type and when it lands\nlocal e = eventArgs\nif not e then return end\nlocal K = {[44557] = {\"LP\", 6.3}, [44558] = {\"PAIR\", 6.3}, [45167] = {\"LP\", 18.0}, [45168] = {\"PAIR\", 18.0}}\nlocal k = K[e.spellID]\nif not k then return end\nlocal due = Now() + k[2] * 1000\nTensorNecStack = {kind = k[1], due = due}\nlocal p = TensorCore.mGetPlayer()\nif p then\n  local txt = (k[1] == \"LP\") and \"LIGHT PARTY STACK\" or \"PARTNER STACK\"\n  local col = (k[1] == \"LP\") and 0xFF00D7FF or 0xFFFF66FF\n  pcall(AnyoneCore.addTimedWorldTextOnEnt, k[2] * 1000, txt, p.id, col, true, 2.4, 3.2)\nend\nself.used = true\n",
							name = "[Draw] Stack alert - Blight 2 (cast start)",
							uuid = "77cca2b2-ae23-a04c-824c-63af87315fa8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 124.1,
				name = "[Draw] Stack alert - Blight 2 (cast start)",
				timeRange = true,
				timelineIndex = 24,
				timerEndOffset = -1,
				timerStartOffset = -12,
				uuid = "ca485d6b-f886-5abf-a81c-68be2393463b",
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
							actionLua = "-- Tether to who you stack with, until the stack lands\nlocal s = TensorNecStack\nif not s or Now() > s.due + 400 then return end\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal p = TensorCore.mGetPlayer()\nif not (slot and p and p.pos) then return end\nlocal PAIR = {T1 = \"M1\", M1 = \"T1\", T2 = \"M2\", M2 = \"T2\", H1 = \"R1\", R1 = \"H1\", H2 = \"R2\", R2 = \"H2\"}\nlocal LP = {T1 = \"H1\", M1 = \"H1\", R1 = \"H1\", H1 = nil, T2 = \"H2\", M2 = \"H2\", R2 = \"H2\", H2 = nil}\nlocal want = (s.kind == \"PAIR\") and PAIR[slot] or LP[slot]\nlocal role = want and ((want == \"T1\" and \"MT\") or (want == \"T2\" and \"OT\") or want)\nlocal mate = role and GetRole and GetRole(role)\nlocal left = (s.due - Now()) / 1000\nlocal col = (s.kind == \"LP\") and 0x00D7FF or 0xFF66FF\nlocal a = left < 2 and 0xFF000000 or 0xAA000000\nlocal ring = TensorCore.getCachedDrawer(0x22000000 + col, 0x44000000 + col, a + col, a + col, 3)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nring:addCircle(p.pos.x, p.pos.y, p.pos.z, (s.kind == \"LP\") and 2.0 or 1.4, false, flags)\nif mate and mate.pos and mate.id ~= p.id then\n  local line = TensorCore.getStaticDrawer(a + col, 5)\n  line:addLine(p.pos.x, p.pos.y, p.pos.z, mate.pos.x, mate.pos.y, mate.pos.z, 5)\n  ring:addCircle(mate.pos.x, mate.pos.y, mate.pos.z, 1.4, false, flags)\nend\n",
							name = "[Draw] Stack tether - Blight 2",
							uuid = "78e0a4d2-0ef4-727a-875b-f4848cf51c78",
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
				mechanicTime = 124.1,
				name = "[Draw] Stack tether - Blight 2",
				timeRange = true,
				timelineIndex = 24,
				timerEndOffset = 3,
				timerStartOffset = -9,
				uuid = "df321cc3-5eff-8c70-b729-b12c79b0dba2",
				version = 2,
			},
		},
	},
	[27] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "e9031f2e-79c1-1e9f-961a-b8397d64f221",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"b53fb192-f45e-1431-a9b1-336d05150421",
									true,
								},
								
								{
									"ae26d71f-9e80-fc9b-abd1-7c2ebcc43b17",
									true,
								},
								
								{
									"28f113a1-d4b9-526a-939c-bb4caf6286ff",
									true,
								},
								
								{
									"0da8e3ac-0cb6-baad-8a89-0d52bf38d3db",
									true,
								},
							},
							gVar = "ACR_TensorViper4_Hotbar_Feint",
							uuid = "2e57a038-ad7a-da50-b3eb-219bf49794a5",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "b53fb192-f45e-1431-a9b1-336d05150421",
							version = 3,
						},
					},
					
					{
						data = 
						{
							actionCDValue = 1,
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Feint ready",
							uuid = "ae26d71f-9e80-fc9b-abd1-7c2ebcc43b17",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "28f113a1-d4b9-526a-939c-bb4caf6286ff",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "0da8e3ac-0cb6-baad-8a89-0d52bf38d3db",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 140.2,
				name = "[VPR] Feint - Grand Cross",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = -2,
				timerStartOffset = -6,
				uuid = "8746fa58-8112-a86c-abad-34b1047a5a93",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "2db0e4f2-6c7d-32b3-887a-2fdba75a9bb8",
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
							actionLua = "-- Grand Cross 1 - stack middle: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={0,0},T2={0,0},H1={0,0},H2={0,0},M1={0,0},M2={0,0},R1={0,0},R2={0,0}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 1 - stack middle",
							uuid = "9202350f-58c1-88f2-bb65-ef89f6eaf9ef",
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
				mechanicTime = 140.2,
				name = "[Draw] Grand Cross 1 - stack middle",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "3a51ee78-b529-ec26-abba-45627c35e2b6",
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
							actionLua = "-- Grand Cross 1 - color intercard: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-8,-8},M1={-8,-8},T2={8,-8},M2={8,-8},H2={8,8},R2={8,8},H1={-8,8},R1={-8,8}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 1 - color intercard",
							uuid = "0327c1e9-15b0-273e-8c4c-ca870042e408",
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
				mechanicTime = 140.2,
				name = "[Draw] Grand Cross 1 - color intercard",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = 14,
				timerStartOffset = 5,
				uuid = "ce0d6668-d40e-8f5e-a6ff-e951a3eaefe0",
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
							actionLua = "-- Grand Cross raidwide cast start: start the route clock\ndata.necgc = {t0 = Now()}\nself.used = true\n",
							conditions = 
							{
								
								{
									"9aa3df47-78a3-513d-b566-2778502b83c3",
									true,
								},
							},
							name = "[Draw] Grand Cross 1 - route clock",
							uuid = "e7d73850-b6d9-2c06-9cbb-e9002fc5e95e",
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
							eventSpellID = 44568,
							name = "Grand Cross raidwide",
							uuid = "9aa3df47-78a3-513d-b566-2778502b83c3",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 140.2,
				name = "[Draw] Grand Cross 1 - route clock",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = -5,
				timerStartOffset = -9,
				uuid = "7b237a96-2218-1d55-9d37-7c075e47bb11",
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
							actionLua = "-- Grand Cross: green circle where you stood in your clears, arrow, countdown to the next move\nlocal s = data.necgc\nif not s then return end\nlocal el = (Now() - s.t0) / 1000\nlocal R = {{0, 13.8, 100, 100}, {13.8, 17.8, 95, 95}, {17.8, 32.0, 100.8, 93.4},\n           {32.0, 37.6, 100, 100}, {37.6, 42.8, 94.5, 94.5}, {42.8, 48.0, 100, 100}}\nlocal cur, nxt\nfor i = 1, #R do\n  if el >= R[i][1] and el < R[i][2] then cur, nxt = R[i], R[i + 1] break end\nend\nif not cur then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal px, py, pz = p.pos.x, p.pos.y, p.pos.z\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal g = TensorCore.getCachedDrawer(0x5533FF33, 0x8833FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal x, z = cur[3], cur[4]\nlocal d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(x, py, z, 1.0, false, flags)\nif nxt then\n  TensorCore.getCachedDrawer(0x1133FF33, 0x2233FF33, 0x4433FF33, 0x8833FF33, 1):addCircle(nxt[3], py, nxt[4], 0.8, false, flags)\nend\n-- countdown (seconds until you move to the next spot), drawn under the green circle\nlocal n = math.max(0, math.ceil(cur[2] - el))\nif n > 99 then n = 99 end\nlocal A, B, C, Dd, E, F, G = {-1,1,1,1}, {1,1,1,0}, {1,0,1,-1}, {-1,-1,1,-1}, {-1,0,-1,-1}, {-1,1,-1,0}, {-1,0,1,0}\nlocal DIG = data.necgcDig\nif not DIG then\n  DIG = {[0]={A,B,C,Dd,E,F}, [1]={B,C}, [2]={A,B,G,E,Dd}, [3]={A,B,G,C,Dd}, [4]={F,G,B,C}, [5]={A,F,G,C,Dd},\n         [6]={A,F,G,E,C,Dd}, [7]={A,B,C}, [8]={A,B,C,Dd,E,F,G}, [9]={A,B,C,Dd,F,G}}\n  data.necgcDig = DIG\nend\nlocal dr = TensorCore.getStaticDrawer(0xFF33FF33, 4)\nlocal function digit(k, cx, cz)\n  for _, sg in ipairs(DIG[k]) do dr:addLine(cx + sg[1] * 0.45, py, cz - sg[2] * 0.8, cx + sg[3] * 0.45, py, cz - sg[4] * 0.8, 4) end\nend\nif n >= 10 then digit(math.floor(n / 10), x - 0.6, z + 2.2); digit(n % 10, x + 0.6, z + 2.2) else digit(n, x, z + 2.2) end\n",
							name = "[Draw] Grand Cross 1 - your route (from clears)",
							uuid = "619ec442-86db-88ef-983c-f6beeaa6ae40",
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
				mechanicTime = 140.2,
				name = "[Draw] Grand Cross 1 - your route (from clears)",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = 41,
				timerStartOffset = -7.5,
				uuid = "807bb018-e292-8d81-925e-320e33ec5c60",
				version = 2,
			},
		},
	},
	[37] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "ec7ab435-7c4b-44a9-8213-f6ce23880ddc",
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
							actionLua = "-- Grand Cross 1 - back to middle: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={0,0},T2={0,0},H1={0,0},H2={0,0},M1={0,0},M2={0,0},R1={0,0},R2={0,0}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 1 - back to middle",
							uuid = "7211408d-69a3-c579-9a4f-96e363d876b7",
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
				mechanicTime = 165.2,
				name = "[Draw] Grand Cross 1 - back to middle",
				timeRange = true,
				timelineIndex = 37,
				timerEndOffset = 3.5,
				timerStartOffset = 0.5,
				uuid = "4ba98fb6-d56b-c5c0-9270-b5bc703c01c7",
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
							actionLua = "-- Grand Cross 1 - intercard (proximity): arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-8,-8},M1={-8,-8},T2={8,-8},M2={8,-8},H2={8,8},R2={8,8},H1={-8,8},R1={-8,8}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 1 - intercard (proximity)",
							uuid = "88654641-7ed2-2b17-a5ff-768fc4c82f35",
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
				mechanicTime = 165.2,
				name = "[Draw] Grand Cross 1 - intercard (proximity)",
				timeRange = true,
				timelineIndex = 37,
				timerEndOffset = 9.7,
				timerStartOffset = 3.5,
				uuid = "b7a2cb77-0da0-c79f-9e2b-3a51c31716b2",
				version = 2,
			},
		},
	},
	[50] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "803ce491-5fa9-b5cb-bbff-bb2d766e1e85",
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
							actionLua = "-- Darkness of Eternity landed: re-time both intermission downtimes\nlocal e = eventArgs\nif not (e and e.spellID == 44580) then return end\nlocal s = TensorNecronVPR\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 150 and not s.doe then\n  s.doe = t\n  if s.g1 then local ok, id = pcall(api.setAutoSimPhase, s.g1, t + 6.0, t + 21.3); if ok then s.g1 = id end end\n  if s.g2 then local ok, id = pcall(api.setAutoSimPhase, s.g2, t + 29.5, t + 60.6); if ok then s.g2 = id; s.g2s = t + 29.5 end end\n  self.used = true\nend\n",
							conditions = 
							{
								
								{
									"e82381f5-affc-e743-b531-9cff110a6a63",
									true,
								},
							},
							name = "[VPR] AutoSim - Darkness of Eternity Sync",
							uuid = "ba342659-c5e1-320f-b6ee-2401e9da91b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "e82381f5-affc-e743-b531-9cff110a6a63",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 2,
				mechanicTime = 250.8,
				name = "[VPR] AutoSim - Darkness of Eternity Sync",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 8,
				timerStartOffset = -20,
				uuid = "703f9f98-c2a4-b07a-ba73-214f605b79e7",
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
							actionLua = "-- Necron targetable again after the intermission: end downtime, re-time kill\nlocal e = eventArgs\nif not (e and e.isTargetable) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nif not (ent and ent.name == \"Necron\") then return end\nlocal s = TensorNecronVPR\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 260 and not s.ret then\n  s.ret = t\n  if s.g2 and s.g2s and t > s.g2s + 1 then\n    local ok, id = pcall(api.setAutoSimPhase, s.g2, s.g2s, t); if ok then s.g2 = id end\n  end\n  -- Mass Macabre comes ~135.6s after the boss returns\n  if s.mm then local ok, id = pcall(api.setAutoSimPhase, s.mm, t + 138.1, t + 146.1); if ok then s.mm = id end end\n  s.kill = 480 + (t - 303.9)\n  pcall(api.setAutoSimKillTime, s.kill)\n  pcall(api.addAutoSimUncertainty, t, 3)\n  self.used = true\nend\n",
							conditions = 
							{
								
								{
									"a51fff83-fc00-051c-8c8e-7ffb4697fc8c",
									true,
								},
							},
							name = "[VPR] AutoSim - Necron Return Sync",
							uuid = "8c23f6be-4d70-e907-8d99-6dd57cf74cb9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "a51fff83-fc00-051c-8c8e-7ffb4697fc8c",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 26,
				mechanicTime = 250.8,
				name = "[VPR] AutoSim - Necron Return Sync",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 75,
				timerStartOffset = 20,
				uuid = "31d92a17-5ede-5b0e-929e-5f0218bc3a5d",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"c57e3a25-8e77-5194-9cde-37f23c723efd",
									true,
								},
								
								{
									"aaba7491-97d6-3b87-8bb5-bf089cf75401",
									true,
								},
								
								{
									"ea77ab85-99c9-2a91-bf3e-13834c7e7534",
									true,
								},
								
								{
									"89c56b93-161d-861b-a7e1-6dd3e5bacf74",
									true,
								},
							},
							gVar = "ACR_TensorViper4_Hotbar_Feint",
							uuid = "336b450d-3742-656e-9542-75ce1e9ae44e",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "c57e3a25-8e77-5194-9cde-37f23c723efd",
							version = 3,
						},
					},
					
					{
						data = 
						{
							actionCDValue = 1,
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Feint ready",
							uuid = "aaba7491-97d6-3b87-8bb5-bf089cf75401",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "ea77ab85-99c9-2a91-bf3e-13834c7e7534",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "89c56b93-161d-861b-a7e1-6dd3e5bacf74",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 250.8,
				name = "[VPR] Feint - Darkness of Eternity",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = -5,
				timerStartOffset = -12,
				uuid = "63513746-d566-6502-8198-ebb6b09dc041",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "9387f3e2-812b-004c-bde8-3f0f2ff39f9b",
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
							actionLua = "-- Darkness of Eternity landed: re-time both intermission downtimes (same as Viper)\nlocal e = eventArgs\nif not (e and e.spellID == 44580) then return end\nlocal s = TensorNecronBLM\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 150 and not s.doe then\n  s.doe = t\n  if s.g1 then local ok, id = pcall(api.setAutoSimPhase, s.g1, t + 6.0, t + 21.3); if ok then s.g1 = id end end\n  if s.g2 then local ok, id = pcall(api.setAutoSimPhase, s.g2, t + 29.5, t + 60.6); if ok then s.g2 = id; s.g2s = t + 29.5 end end\n  self.used = true\nend\n",
							conditions = 
							{
								
								{
									"3ca14c4d-0ecb-9781-a1e9-bd5524c6b149",
									true,
								},
							},
							name = "[BLM] AutoSim - Darkness of Eternity Sync",
							uuid = "ccd7a0bc-8a75-be30-8474-9b4c8d9f921d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "3ca14c4d-0ecb-9781-a1e9-bd5524c6b149",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 2,
				mechanicTime = 250.8,
				name = "[BLM] AutoSim - Darkness of Eternity Sync",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 8,
				timerStartOffset = -20,
				uuid = "3bf7298f-e5ac-e80c-ad60-3f903e43086c",
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
							actionLua = "-- Necron targetable again after the intermission: end downtime, re-time kill (same as Viper)\nlocal e = eventArgs\nif not (e and e.isTargetable) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nif not (ent and ent.name == \"Necron\") then return end\nlocal s = TensorNecronBLM\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 260 and not s.ret then\n  s.ret = t\n  if s.g2 and s.g2s and t > s.g2s + 1 then\n    local ok, id = pcall(api.setAutoSimPhase, s.g2, s.g2s, t); if ok then s.g2 = id end\n  end\n  s.kill = 480 + (t - 303.9)\n  pcall(api.setAutoSimKillTime, s.kill)\n  pcall(api.addAutoSimUncertainty, t, 3)\n  -- move the later caster downtime forecasts by the same amount (the cast syncs fine-tune them)\n  local d = t - 303.9\n  if s.ee2 then local ok, id = pcall(api.setAutoSimPhase, s.ee2, 326.30 + d, 331.80 + d); if ok then s.ee2 = id end end\n  if s.sd2a then local ok, id = pcall(api.setAutoSimPhase, s.sd2a, 401.40 + d, 404.40 + d); if ok then s.sd2a = id end end\n  if s.sd2b then local ok, id = pcall(api.setAutoSimPhase, s.sd2b, 406.40 + d, 409.40 + d); if ok then s.sd2b = id end end\n  if s.sr3a then local ok, id = pcall(api.setAutoSimPhase, s.sr3a, 412.10 + d, 414.10 + d); if ok then s.sr3a = id end end\n  if s.sr3b then local ok, id = pcall(api.setAutoSimPhase, s.sr3b, 416.60 + d, 419.10 + d); if ok then s.sr3b = id end end\n  self.used = true\nend\n",
							conditions = 
							{
								
								{
									"b7a0a184-a8bb-8546-b63a-67be48ada755",
									true,
								},
							},
							name = "[BLM] AutoSim - Necron Return Sync",
							uuid = "9efdd213-9e5b-14c2-92b5-3fc8d84cb768",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "b7a0a184-a8bb-8546-b63a-67be48ada755",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 26,
				mechanicTime = 250.8,
				name = "[BLM] AutoSim - Necron Return Sync",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 75,
				timerStartOffset = 20,
				uuid = "1368c279-6e38-525d-a5f7-bc8406520995",
				version = 2,
			},
		},
	},
	[56] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "9a38531a-cb14-ed16-84cc-fb8cc34e09a0",
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
							actionLua = "local s = TensorNecronVPR\nif s and s.kill and not TensorNecronVPRBurn then\n  local t = TensorCore.API.TensorACR.getAutoSimTime()\n  if t and t > s.kill then ACR_TensorViper4_Burn = true; TensorNecronVPRBurn = true; self.used = true end\nend\n",
							conditions = 
							{
								
								{
									"0515de29-af6a-6b1f-a50e-df0f946e6fc8",
									true,
								},
							},
							name = "[VPR] Burn Past Kill Time",
							uuid = "b9c109e0-2871-6cb8-8c22-67be32fca550",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "0515de29-af6a-6b1f-a50e-df0f946e6fc8",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				loop = true,
				mechanicTime = 321,
				name = "[VPR] Burn Past Kill Time",
				timeRange = true,
				timelineIndex = 56,
				timerEndOffset = 360,
				uuid = "4e6d0729-2875-c467-bf2e-8b43fbfebf72",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "c5c098f0-0d4e-5f75-abd3-b6eefe5f1a99",
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
							actionLua = "-- End's Embrace 2 - Specter spread (front lane): arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-17.1,-13.4},M1={-5.6,-13.4},M2={6.5,-13.4},T2={16.6,-13.4},R1={-17.1,-6.1},H1={-5.6,-6.1},H2={6.5,-6.1},R2={16.6,-6.1}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] End's Embrace 2 - Specter spread (front lane)",
							uuid = "d85a32e1-bb2a-c123-bdf6-32bec02f8df0",
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
				mechanicTime = 321,
				name = "[Draw] End's Embrace 2 - Specter spread (front lane)",
				timeRange = true,
				timelineIndex = 56,
				timerEndOffset = 2,
				timerStartOffset = -8,
				uuid = "126d6771-99fe-3bd2-acd8-a21e36a525c4",
				version = 2,
			},
		},
	},
	[57] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "0fc45343-72be-d730-986c-657958e19a80",
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
							actionLua = "-- End's Embrace 2 - hand bait: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-11.6,-14.5},M1={-11.6,-14.5},T2={11.6,-14.5},M2={11.6,-14.5},H1={-11.6,1.7},R1={-11.6,1.7},H2={11.1,1.7},R2={11.1,1.7}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] End's Embrace 2 - hand bait",
							uuid = "83d26686-f51c-1765-9d98-0e5372f0454a",
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
				mechanicTime = 329.1,
				name = "[Draw] End's Embrace 2 - hand bait",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = 5,
				timerStartOffset = -3,
				uuid = "c3f285bc-bb30-5618-8393-9547883c5f8d",
				version = 2,
			},
		},
	},
	[63] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "925b29ff-282b-238e-93ae-97d5300c155e",
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
							actionLua = "-- Stack cast started: remember type and when it lands\nlocal e = eventArgs\nif not e then return end\nlocal K = {[44557] = {\"LP\", 6.3}, [44558] = {\"PAIR\", 6.3}, [45167] = {\"LP\", 18.0}, [45168] = {\"PAIR\", 18.0}}\nlocal k = K[e.spellID]\nif not k then return end\nlocal due = Now() + k[2] * 1000\nTensorNecStack = {kind = k[1], due = due}\nlocal p = TensorCore.mGetPlayer()\nif p then\n  local txt = (k[1] == \"LP\") and \"LIGHT PARTY STACK\" or \"PARTNER STACK\"\n  local col = (k[1] == \"LP\") and 0xFF00D7FF or 0xFFFF66FF\n  pcall(AnyoneCore.addTimedWorldTextOnEnt, k[2] * 1000, txt, p.id, col, true, 2.4, 3.2)\nend\nself.used = true\n",
							name = "[Draw] Stack alert - Season 1 (cast start)",
							uuid = "e34d879f-8fea-35df-b3b7-986d862112b1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 377.7,
				name = "[Draw] Stack alert - Season 1 (cast start)",
				timeRange = true,
				timelineIndex = 63,
				timerEndOffset = 2,
				timerStartOffset = -16,
				uuid = "c34e2593-40a9-107a-9199-a2f2acf57191",
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
							actionLua = "-- Tether to who you stack with, until the stack lands\nlocal s = TensorNecStack\nif not s or Now() > s.due + 400 then return end\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal p = TensorCore.mGetPlayer()\nif not (slot and p and p.pos) then return end\nlocal PAIR = {T1 = \"M1\", M1 = \"T1\", T2 = \"M2\", M2 = \"T2\", H1 = \"R1\", R1 = \"H1\", H2 = \"R2\", R2 = \"H2\"}\nlocal LP = {T1 = \"H1\", M1 = \"H1\", R1 = \"H1\", H1 = nil, T2 = \"H2\", M2 = \"H2\", R2 = \"H2\", H2 = nil}\nlocal want = (s.kind == \"PAIR\") and PAIR[slot] or LP[slot]\nlocal role = want and ((want == \"T1\" and \"MT\") or (want == \"T2\" and \"OT\") or want)\nlocal mate = role and GetRole and GetRole(role)\nlocal left = (s.due - Now()) / 1000\nlocal col = (s.kind == \"LP\") and 0x00D7FF or 0xFF66FF\nlocal a = left < 2 and 0xFF000000 or 0xAA000000\nlocal ring = TensorCore.getCachedDrawer(0x22000000 + col, 0x44000000 + col, a + col, a + col, 3)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nring:addCircle(p.pos.x, p.pos.y, p.pos.z, (s.kind == \"LP\") and 2.0 or 1.4, false, flags)\nif mate and mate.pos and mate.id ~= p.id then\n  local line = TensorCore.getStaticDrawer(a + col, 5)\n  line:addLine(p.pos.x, p.pos.y, p.pos.z, mate.pos.x, mate.pos.y, mate.pos.z, 5)\n  ring:addCircle(mate.pos.x, mate.pos.y, mate.pos.z, 1.4, false, flags)\nend\n",
							name = "[Draw] Stack tether - Season 1",
							uuid = "4499a47d-3636-abbf-a86e-a7f07a859d77",
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
				mechanicTime = 377.7,
				name = "[Draw] Stack tether - Season 1",
				timeRange = true,
				timelineIndex = 63,
				timerEndOffset = 13,
				timerStartOffset = -12,
				uuid = "1d8b6b81-1c9e-0cef-b9e1-a6e0deceaac9",
				version = 2,
			},
		},
	},
	[77] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "ca203d41-76e5-62a5-8735-f433fb7cdcb5",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"d97f52bd-cf72-62ad-a52b-ce814ac42950",
									true,
								},
								
								{
									"932cdd30-39ec-0bdb-bd0c-719a89527448",
									true,
								},
								
								{
									"902e27a7-cc18-a304-acaf-f15207b309a8",
									true,
								},
								
								{
									"60cc06fc-1a2d-4807-a3b8-a9b3745c62e2",
									true,
								},
							},
							gVar = "ACR_TensorViper4_Hotbar_Feint",
							uuid = "e8606424-b7ae-148d-8077-b7d45bd5b11f",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "d97f52bd-cf72-62ad-a52b-ce814ac42950",
							version = 3,
						},
					},
					
					{
						data = 
						{
							actionCDValue = 1,
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Feint ready",
							uuid = "932cdd30-39ec-0bdb-bd0c-719a89527448",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "902e27a7-cc18-a304-acaf-f15207b309a8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "60cc06fc-1a2d-4807-a3b8-a9b3745c62e2",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 434,
				name = "[VPR] Feint - Twofold/Fourfold Blight",
				timeRange = true,
				timelineIndex = 77,
				timerEndOffset = -5,
				timerStartOffset = -9,
				uuid = "2ae693ef-e52f-7371-ac88-e70d201d99f4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "6e65614c-9aa8-1c4e-9193-e56c79fb2983",
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
							actionLua = "-- Stack cast started: remember type and when it lands\nlocal e = eventArgs\nif not e then return end\nlocal K = {[44557] = {\"LP\", 6.3}, [44558] = {\"PAIR\", 6.3}, [45167] = {\"LP\", 18.0}, [45168] = {\"PAIR\", 18.0}}\nlocal k = K[e.spellID]\nif not k then return end\nlocal due = Now() + k[2] * 1000\nTensorNecStack = {kind = k[1], due = due}\nlocal p = TensorCore.mGetPlayer()\nif p then\n  local txt = (k[1] == \"LP\") and \"LIGHT PARTY STACK\" or \"PARTNER STACK\"\n  local col = (k[1] == \"LP\") and 0xFF00D7FF or 0xFFFF66FF\n  pcall(AnyoneCore.addTimedWorldTextOnEnt, k[2] * 1000, txt, p.id, col, true, 2.4, 3.2)\nend\nself.used = true\n",
							name = "[Draw] Stack alert - Blight 3 (cast start)",
							uuid = "3c17ce78-7936-e40b-a7b4-e6b079cf8b3e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 434,
				name = "[Draw] Stack alert - Blight 3 (cast start)",
				timeRange = true,
				timelineIndex = 77,
				timerEndOffset = -1,
				timerStartOffset = -12,
				uuid = "ae610afc-1fdb-82b6-9f81-94c86c2dd36e",
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
							actionLua = "-- Tether to who you stack with, until the stack lands\nlocal s = TensorNecStack\nif not s or Now() > s.due + 400 then return end\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal p = TensorCore.mGetPlayer()\nif not (slot and p and p.pos) then return end\nlocal PAIR = {T1 = \"M1\", M1 = \"T1\", T2 = \"M2\", M2 = \"T2\", H1 = \"R1\", R1 = \"H1\", H2 = \"R2\", R2 = \"H2\"}\nlocal LP = {T1 = \"H1\", M1 = \"H1\", R1 = \"H1\", H1 = nil, T2 = \"H2\", M2 = \"H2\", R2 = \"H2\", H2 = nil}\nlocal want = (s.kind == \"PAIR\") and PAIR[slot] or LP[slot]\nlocal role = want and ((want == \"T1\" and \"MT\") or (want == \"T2\" and \"OT\") or want)\nlocal mate = role and GetRole and GetRole(role)\nlocal left = (s.due - Now()) / 1000\nlocal col = (s.kind == \"LP\") and 0x00D7FF or 0xFF66FF\nlocal a = left < 2 and 0xFF000000 or 0xAA000000\nlocal ring = TensorCore.getCachedDrawer(0x22000000 + col, 0x44000000 + col, a + col, a + col, 3)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nring:addCircle(p.pos.x, p.pos.y, p.pos.z, (s.kind == \"LP\") and 2.0 or 1.4, false, flags)\nif mate and mate.pos and mate.id ~= p.id then\n  local line = TensorCore.getStaticDrawer(a + col, 5)\n  line:addLine(p.pos.x, p.pos.y, p.pos.z, mate.pos.x, mate.pos.y, mate.pos.z, 5)\n  ring:addCircle(mate.pos.x, mate.pos.y, mate.pos.z, 1.4, false, flags)\nend\n",
							name = "[Draw] Stack tether - Blight 3",
							uuid = "77be3995-53ee-12d5-b980-e81952f04b84",
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
				mechanicTime = 434,
				name = "[Draw] Stack tether - Blight 3",
				timeRange = true,
				timelineIndex = 77,
				timerEndOffset = 3,
				timerStartOffset = -9,
				uuid = "df4b2d96-eb81-ef9c-b6af-d440d71dfe25",
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
				name = "VPR Optimization",
				uuid = "5e19fe5b-2818-11ac-9936-a944655ea250",
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
							actionLua = "-- Mass Macabre cast finished: M1 leaves melee for the west 2-person tower\nlocal e = eventArgs\nif not (e and e.spellID == 44595) then return end\nlocal s = TensorNecronVPR\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not (s and t and t > 300) or s.mmDone then return end\ns.mmDone = true\nif s.mm then\n  local ok, id = pcall(api.setAutoSimPhase, s.mm, t + 2.5, t + 10.5); if ok then s.mm = id end\nelse\n  local ok, id = pcall(api.addAutoSimPhase, \"MeleeDowntime\", t + 2.5, t + 10.5); if ok then s.mm = id end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"a6199d05-dc3e-62aa-96c2-34e241f0778d",
									true,
								},
							},
							name = "Mass Macabre sync",
							uuid = "0b224dc2-0dc3-aa23-97aa-46accc732c77",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "a6199d05-dc3e-62aa-96c2-34e241f0778d",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 2,
				mechanicTime = 447.1,
				name = "[VPR] AutoSim - Mass Macabre Sync",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 8,
				timerStartOffset = -15,
				uuid = "56e9565f-f3a8-8ae5-b9e4-2b13fcd15eb1",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "937b312a-59dc-11e6-8863-b042ad5c83a2",
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
							actionLua = "-- Mass Macabre channel start: fresh tower state for this pull\nlocal e = eventArgs\nif not e then return end\nlocal id = e.spellID or e.channelID or e.actionID\nif id ~= 44595 then return end\nTensorNecronMM = {t = Now(), done = {}}\nself.used = true\n",
							name = "[Draw] Mass Macabre - tower state (channel)",
							uuid = "2c5bb302-7526-9fcb-acd3-6d82ec735f6f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 447.1,
				name = "[Draw] Mass Macabre - tower state (channel)",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 6,
				timerStartOffset = -20,
				uuid = "b622fd27-1472-774e-94c7-27c541a54274",
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
							actionLua = "-- Mass Macabre towers are map effects 26..35; flags 4|8 = tower resolved/gone\nlocal e = eventArgs\nif not e or not e.a1 or e.a1 < 26 or e.a1 > 35 then return end\nlocal s = TensorNecronMM\nif not s or Now() - s.t > 60000 then s = {t = Now(), done = {}}; TensorNecronMM = s end\nif e.a2 == 4 then s.done[e.a1] = true end\n",
							name = "[Draw] Mass Macabre - tower state (map effects)",
							uuid = "286aa62a-74b4-d07a-b60a-6a89d11f58e2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 14,
				loop = true,
				mechanicTime = 447.1,
				name = "[Draw] Mass Macabre - tower state (map effects)",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 35,
				timerStartOffset = -12,
				uuid = "225a5147-ca78-ed26-a833-aa35f62ed368",
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
							actionLua = "-- Mass Macabre: numbered route (1-4) on your towers, tether to the current one\nlocal s = TensorNecronMM\nif not s or Now() - s.t > 40000 then return end\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\n-- map effect index -> tower position\nlocal T = {[26]={91,88},[27]={109,88},[28]={100,94},[29]={85,97},[30]={115,97},\n           [31]={85,103},[32]={115,103},[33]={100,106},[34]={91,112},[35]={109,112}}\n-- route per slot (number = map index, table = tankbuster corner)\nlocal NWC, NEC = {81.6,84.9}, {119.0,84.9}\nlocal ROUTE = {\n  T1={28,29,NWC}, T2={28,30,NEC},\n  M1={28,32,27,26}, M2={28,30,27,26},\n  H2={33,32,27,26}, H1={33,31,34,35},\n  R1={33,31,34,35}, R2={33,29,34,35}}\nlocal route = slot and ROUTE[slot]\nif not route then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal y = p.pos.y\nlocal cur\nfor i, st in ipairs(route) do\n  if type(st) == \"table\" or not s.done[st] then cur = i; break end\nend\nif not cur then return end\nlocal SEG = {a={-1,1,1,1}, b={1,1,1,0}, c={1,0,1,-1}, d={-1,-1,1,-1}, e={-1,0,-1,-1}, f={-1,1,-1,0}, g={-1,0,1,0}}\nlocal DIG = {[1]={{0,1,0,-1}}, [2]={SEG.a,SEG.b,SEG.g,SEG.e,SEG.d}, [3]={SEG.a,SEG.b,SEG.g,SEG.c,SEG.d}, [4]={SEG.f,SEG.g,SEG.b,SEG.c}}\nlocal hot = TensorCore.getStaticDrawer(0xFF33FF33, 6)\nlocal cold = TensorCore.getStaticDrawer(0xCCFFFFFF, 5)\nlocal W, H = 0.8, 1.4\nlocal function digit(dr, n, cx, cz)\n  for _, sg in ipairs(DIG[n]) do\n    dr:addLine(cx + sg[1]*W, y, cz - sg[2]*H, cx + sg[3]*W, y, cz - sg[4]*H, dr == hot and 6 or 5)\n  end\nend\nfor i = cur, #route do\n  local st = route[i]\n  local pos = type(st) == \"table\" and st or T[st]\n  local dr = (i == cur) and hot or cold\n  if type(st) == \"table\" then\n    if i == cur then\n      local g = TensorCore.getCachedDrawer(0x5533FF33, 0x7733FF33, 0x9933FF33, 0xFF33FF33, 2)\n      g:addCircle(pos[1], y, pos[2], 1, false, Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n    end\n  else\n    digit(dr, i, pos[1], pos[2])\n  end\n  if i == cur then\n    hot:addLine(p.pos.x, y, p.pos.z, pos[1], y, pos[2], 4)\n  end\nend\n",
							name = "[Draw] Mass Macabre - numbered towers + tether",
							uuid = "b79d5338-598c-03cb-b85b-cdca697e6e96",
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
				mechanicTime = 447.1,
				name = "[Draw] Mass Macabre - numbered towers + tether",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 35,
				timerStartOffset = -12,
				uuid = "356cc27e-3763-c08c-9595-7b6e937306e7",
				version = 2,
			},
		},
	},
	[89] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "ef87fdd8-01e0-b1e9-96d8-2b0da7bb4a20",
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
							actionLua = "-- Stack cast started: remember type and when it lands\nlocal e = eventArgs\nif not e then return end\nlocal K = {[44557] = {\"LP\", 6.3}, [44558] = {\"PAIR\", 6.3}, [45167] = {\"LP\", 18.0}, [45168] = {\"PAIR\", 18.0}}\nlocal k = K[e.spellID]\nif not k then return end\nlocal due = Now() + k[2] * 1000\nTensorNecStack = {kind = k[1], due = due}\nlocal p = TensorCore.mGetPlayer()\nif p then\n  local txt = (k[1] == \"LP\") and \"LIGHT PARTY STACK\" or \"PARTNER STACK\"\n  local col = (k[1] == \"LP\") and 0xFF00D7FF or 0xFFFF66FF\n  pcall(AnyoneCore.addTimedWorldTextOnEnt, k[2] * 1000, txt, p.id, col, true, 2.4, 3.2)\nend\nself.used = true\n",
							name = "[Draw] Stack alert - Season 2 (cast start)",
							uuid = "ad120d4a-b077-150c-b214-1d9285de2904",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 516.5,
				name = "[Draw] Stack alert - Season 2 (cast start)",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = 2,
				timerStartOffset = -16,
				uuid = "3e73fd2a-500e-0aac-af8d-4db319aea427",
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
							actionLua = "-- Tether to who you stack with, until the stack lands\nlocal s = TensorNecStack\nif not s or Now() > s.due + 400 then return end\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal p = TensorCore.mGetPlayer()\nif not (slot and p and p.pos) then return end\nlocal PAIR = {T1 = \"M1\", M1 = \"T1\", T2 = \"M2\", M2 = \"T2\", H1 = \"R1\", R1 = \"H1\", H2 = \"R2\", R2 = \"H2\"}\nlocal LP = {T1 = \"H1\", M1 = \"H1\", R1 = \"H1\", H1 = nil, T2 = \"H2\", M2 = \"H2\", R2 = \"H2\", H2 = nil}\nlocal want = (s.kind == \"PAIR\") and PAIR[slot] or LP[slot]\nlocal role = want and ((want == \"T1\" and \"MT\") or (want == \"T2\" and \"OT\") or want)\nlocal mate = role and GetRole and GetRole(role)\nlocal left = (s.due - Now()) / 1000\nlocal col = (s.kind == \"LP\") and 0x00D7FF or 0xFF66FF\nlocal a = left < 2 and 0xFF000000 or 0xAA000000\nlocal ring = TensorCore.getCachedDrawer(0x22000000 + col, 0x44000000 + col, a + col, a + col, 3)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nring:addCircle(p.pos.x, p.pos.y, p.pos.z, (s.kind == \"LP\") and 2.0 or 1.4, false, flags)\nif mate and mate.pos and mate.id ~= p.id then\n  local line = TensorCore.getStaticDrawer(a + col, 5)\n  line:addLine(p.pos.x, p.pos.y, p.pos.z, mate.pos.x, mate.pos.y, mate.pos.z, 5)\n  ring:addCircle(mate.pos.x, mate.pos.y, mate.pos.z, 1.4, false, flags)\nend\n",
							name = "[Draw] Stack tether - Season 2",
							uuid = "d0102b6e-04ac-148b-92d2-bdba78fa9997",
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
				mechanicTime = 516.5,
				name = "[Draw] Stack tether - Season 2",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = 13,
				timerStartOffset = -12,
				uuid = "610fdfcb-f50a-8d12-853c-ab147c58da39",
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
				name = "Role Draws",
				uuid = "d4aefbab-abca-a242-8d33-d8a3da3e62ba",
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
							actionLua = "-- Fear of Death 3 - spread spot: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-16.8,-11.7},M1={-6.1,-11.7},M2={5.3,-11.7},T2={16.6,-11.7},R1={-16.8,0.1},H1={-6.1,0.1},H2={5.3,0.1},R2={16.6,0.1}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Fear of Death 3 - spread spot",
							uuid = "08538e24-5543-0f4c-abba-f71cf5fdd497",
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
				mechanicTime = 533.2,
				name = "[Draw] Fear of Death 3 - spread spot",
				timeRange = true,
				timelineIndex = 95,
				timerEndOffset = 3,
				timerStartOffset = -10,
				uuid = "631c2605-831d-0448-8032-677499471891",
				version = 2,
			},
		},
	},
	[110] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "541cce20-43a8-5e78-afa2-9222bd31e328",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"80563e46-15b2-2edd-9e58-fe7889968405",
									true,
								},
								
								{
									"70d079d2-9ff2-c74e-aa05-f2541227bb3f",
									true,
								},
								
								{
									"0d0619db-7a8e-2baa-95f8-6d028fce2119",
									true,
								},
								
								{
									"2506678a-f066-ce68-a8b5-73cbbf5dd29c",
									true,
								},
							},
							gVar = "ACR_TensorViper4_Hotbar_Feint",
							uuid = "11931909-8b49-d08a-98a9-429fe29aa0f1",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "80563e46-15b2-2edd-9e58-fe7889968405",
							version = 3,
						},
					},
					
					{
						data = 
						{
							actionCDValue = 1,
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Feint ready",
							uuid = "70d079d2-9ff2-c74e-aa05-f2541227bb3f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "0d0619db-7a8e-2baa-95f8-6d028fce2119",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "2506678a-f066-ce68-a8b5-73cbbf5dd29c",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 605.2,
				name = "[VPR] Feint - Grand Cross 2",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = -8,
				timerStartOffset = -12,
				uuid = "fd19813b-a4a3-b644-a2fb-79540cd78116",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "4b6b7b17-b0a2-01e4-afb6-2cd437a3dd8a",
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
							actionLua = "-- Grand Cross 2 - stack middle: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={0,0},T2={0,0},H1={0,0},H2={0,0},M1={0,0},M2={0,0},R1={0,0},R2={0,0}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 2 - stack middle",
							uuid = "4e11bd72-b4e9-4768-8296-a2554d4c8f22",
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
				mechanicTime = 605.2,
				name = "[Draw] Grand Cross 2 - stack middle",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "c1f7aa32-5a21-b053-bead-1e0833fd4def",
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
							actionLua = "-- Grand Cross 2 - color intercard: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-8,-8},M1={-8,-8},T2={8,-8},M2={8,-8},H2={8,8},R2={8,8},H1={-8,8},R1={-8,8}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 2 - color intercard",
							uuid = "7489f8b1-ce77-d666-95d1-1e13074f977b",
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
				mechanicTime = 605.2,
				name = "[Draw] Grand Cross 2 - color intercard",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = 14,
				timerStartOffset = 5,
				uuid = "34a09dd1-9f6e-ece5-8560-6a3cd3b9e1b7",
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
							actionLua = "-- Grand Cross raidwide cast start: start the route clock\ndata.necgc = {t0 = Now()}\nself.used = true\n",
							conditions = 
							{
								
								{
									"55da1e18-f51c-ef93-bc27-4954bd80f6ec",
									true,
								},
							},
							name = "[Draw] Grand Cross 2 - route clock",
							uuid = "3fb09eff-e060-9ced-8cff-57579a6e2953",
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
							eventSpellID = 44568,
							name = "Grand Cross raidwide",
							uuid = "55da1e18-f51c-ef93-bc27-4954bd80f6ec",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 605.2,
				name = "[Draw] Grand Cross 2 - route clock",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = -5,
				timerStartOffset = -9,
				uuid = "e1f767ac-5dd4-f36a-870a-86ee99467436",
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
							actionLua = "-- Grand Cross: green circle where you stood in your clears, arrow, countdown to the next move\nlocal s = data.necgc\nif not s then return end\nlocal el = (Now() - s.t0) / 1000\nlocal R = {{0, 13.8, 100, 100}, {13.8, 17.8, 95, 95}, {17.8, 32.0, 100.8, 93.4},\n           {32.0, 37.6, 100, 100}, {37.6, 42.8, 94.5, 94.5}, {42.8, 48.0, 100, 100}}\nlocal cur, nxt\nfor i = 1, #R do\n  if el >= R[i][1] and el < R[i][2] then cur, nxt = R[i], R[i + 1] break end\nend\nif not cur then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal px, py, pz = p.pos.x, p.pos.y, p.pos.z\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal g = TensorCore.getCachedDrawer(0x5533FF33, 0x8833FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal x, z = cur[3], cur[4]\nlocal d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(x, py, z, 1.0, false, flags)\nif nxt then\n  TensorCore.getCachedDrawer(0x1133FF33, 0x2233FF33, 0x4433FF33, 0x8833FF33, 1):addCircle(nxt[3], py, nxt[4], 0.8, false, flags)\nend\n-- countdown (seconds until you move to the next spot), drawn under the green circle\nlocal n = math.max(0, math.ceil(cur[2] - el))\nif n > 99 then n = 99 end\nlocal A, B, C, Dd, E, F, G = {-1,1,1,1}, {1,1,1,0}, {1,0,1,-1}, {-1,-1,1,-1}, {-1,0,-1,-1}, {-1,1,-1,0}, {-1,0,1,0}\nlocal DIG = data.necgcDig\nif not DIG then\n  DIG = {[0]={A,B,C,Dd,E,F}, [1]={B,C}, [2]={A,B,G,E,Dd}, [3]={A,B,G,C,Dd}, [4]={F,G,B,C}, [5]={A,F,G,C,Dd},\n         [6]={A,F,G,E,C,Dd}, [7]={A,B,C}, [8]={A,B,C,Dd,E,F,G}, [9]={A,B,C,Dd,F,G}}\n  data.necgcDig = DIG\nend\nlocal dr = TensorCore.getStaticDrawer(0xFF33FF33, 4)\nlocal function digit(k, cx, cz)\n  for _, sg in ipairs(DIG[k]) do dr:addLine(cx + sg[1] * 0.45, py, cz - sg[2] * 0.8, cx + sg[3] * 0.45, py, cz - sg[4] * 0.8, 4) end\nend\nif n >= 10 then digit(math.floor(n / 10), x - 0.6, z + 2.2); digit(n % 10, x + 0.6, z + 2.2) else digit(n, x, z + 2.2) end\n",
							name = "[Draw] Grand Cross 2 - your route (from clears)",
							uuid = "3bcd59cd-f8cf-f39a-8487-772c8f61ccbb",
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
				mechanicTime = 605.2,
				name = "[Draw] Grand Cross 2 - your route (from clears)",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = 41,
				timerStartOffset = -7.5,
				uuid = "a4c5ad7a-05df-d11a-9059-1c5022d3eceb",
				version = 2,
			},
		},
	},
	[120] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "a0db6acd-5a95-72e1-8804-9c6c044c926d",
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
							actionLua = "-- Grand Cross 2 - back to middle: arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={0,0},T2={0,0},H1={0,0},H2={0,0},M1={0,0},M2={0,0},R1={0,0},R2={0,0}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 2 - back to middle",
							uuid = "18459d14-2eb8-a06f-ba10-37463f89c5b2",
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
				mechanicTime = 630.4,
				name = "[Draw] Grand Cross 2 - back to middle",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = 3.5,
				timerStartOffset = 0.5,
				uuid = "d72b32b0-440b-13e1-9518-b6278e30c2da",
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
							actionLua = "-- Grand Cross 2 - intercard (proximity): arrow + circle to your own spot (screenshot positions, center assumed 100,100)\nlocal SPOTS = {T1={-8,-8},M1={-8,-8},T2={8,-8},M2={8,-8},H2={8,8},R2={8,8},H1={-8,8},R1={-8,8}}\nlocal R = AnyoneCore and AnyoneCore.Roster\nlocal slot = R and R.mySlot and R.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nlocal o = slot and SPOTS[slot]\nif not o then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal dest = {x = 100 + o[1], y = p.pos.y, z = 100 + o[2]}\nlocal g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\nlocal flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal d = TensorCore.getDistance2d(p.pos, dest)\nif d > 0.8 then\n  local tip = math.min(1.5, d * 0.35)\n  g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\nend\ng:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\n",
							name = "[Draw] Grand Cross 2 - intercard (proximity)",
							uuid = "7aa24a63-ad0a-3f50-8fea-52abd5687b3c",
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
				mechanicTime = 630.4,
				name = "[Draw] Grand Cross 2 - intercard (proximity)",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = 9.7,
				timerStartOffset = 3.5,
				uuid = "11a18a31-b787-4a92-ae07-3cdf219e4306",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "necron-ex",
	version = "1.0.1",
}



return tbl