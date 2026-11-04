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
	},
	timelineName = "necron-ex",
	version = "1.0.1",
	inheritedProfiles = 
	{
	},
}

return tbl
