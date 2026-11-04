local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "7ad49c69-0046-6bdb-9e71-6671ab9ee284",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "a92f57b5-26ed-132e-b32a-2d36417f461c",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Wipe phases from any other AutoSim setup first\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimUncertainty)\napi.setAutoSimKillTime(404)\nACR_TensorViper4_Burn = false\nTensorZelVPRBurn = nil\n-- Encircling Thorns / Banish III: estimate for a ~142s return, re-timed later\nTensorZelVPR = {kill = 404, bn = api.addAutoSimPhase(\"MeleeDowntime\", 372.0, 377.0)}\n-- Add phase length depends on add kill speed\napi.addAutoSimUncertainty(94, 12)\nself.used = true\n",
							conditions = 
							{
								
								{
									"f7ad68a2-696c-dc27-86cd-510f89dfa2e6",
									true,
								},
							},
							name = "[VPR] AutoSim - Zelenia EX",
							uuid = "38b2899d-1730-f8ad-b1f0-a5bdec6bd595",
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
							uuid = "f7ad68a2-696c-dc27-86cd-510f89dfa2e6",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 16,
				mechanicTime = 11.4,
				name = "[VPR] AutoSim - Zelenia EX",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "15f2041f-a2fc-c212-b6f2-5347a0094c31",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- BLM caster downtime (no hardcasts): local damage-caster movement + top BLM FFLogs kills; re-timed by the sync reactions\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimUncertainty)\n-- Kill time: average of our last 3 kills (394.5 / 392.6 / 402.8 s, 2026-11-04); re-timed when Zelenia returns\npcall(api.setAutoSimKillTime, 397)\n-- Add phase length depends on add kill speed\npcall(api.addAutoSimUncertainty, 94, 12)\nlocal function add(a, b)\n  local ok, id = pcall(api.addAutoSimPhase, \"CasterDowntime\", a, b)\n  if ok then return id end\nend\nTensorZelBLM = {\n  kill = 397,\n  sp = add(40.4, 43.4),     -- Specter of the Lost 1: +2.5..+5.5\n  th3 = add(186.0, 188.0),  -- Alexandrian Thunder III 1 (Bloom 2): +1.5..+3.5\n  qc2 = add(217.9, 220.4),  -- Queen's Crusade 2 (Bloom 2 Thunder Slash cleave): +13.5..+16\n  et = add(357.0, 359.8),   -- Encircling Thorns: move to the stack spot, +0.75..+3.5\n  b3 = add(365.2, 368.0),   -- Banish III: chain break run, +0.75..+3.5\n}\nself.used = true\n",
							conditions = 
							{
								
								{
									"ff09b605-6e35-2253-a585-fbdb73cc784f",
									true,
								},
							},
							name = "[BLM] AutoSim - Caster Downtime",
							uuid = "a9743b43-e164-0145-bc2c-b5b58f9738b9",
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
							uuid = "ff09b605-6e35-2253-a585-fbdb73cc784f",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 16,
				mechanicTime = 11.4,
				name = "[BLM] AutoSim - Caster Downtime",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "04019354-f5ab-3443-bb51-9e023f98dd7b",
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
							actionLua = "-- Re-time the Specter 1, Thunder III 1 and Queen's Crusade 2 caster downtime on the real cast start\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 43167 and sp ~= 43235 and sp ~= 43236 and sp ~= 43194 then return end\nlocal s = TensorZelBLM\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not (s and t) then return end\nlocal function place(key, a, b)\n  if s[key] then\n    local ok, id = pcall(api.setAutoSimPhase, s[key], t + a, t + b)\n    if ok then s[key] = id end\n  else\n    local ok, id = pcall(api.addAutoSimPhase, \"CasterDowntime\", t + a, t + b)\n    if ok then s[key] = id end\n  end\nend\nif sp == 43167 and not s.spS then\n  s.spS = true\n  place(\"sp\", 2.5, 5.5)\nelseif (sp == 43235 or sp == 43236) and not s.th3S then\n  s.th3S = true\n  place(\"th3\", 1.5, 3.5)\nelseif sp == 43194 then\n  -- count Queen's Crusade casts (5s debounce); only the 2nd one gets a window\n  if not s.qcT or t - s.qcT > 5 then\n    s.qcT = t\n    s.qcN = (s.qcN or 0) + 1\n    if s.qcN == 2 then place(\"qc2\", 13.5, 16.0) end\n  end\nend\n",
							conditions = 
							{
								
								{
									"0954851d-7a14-a14c-ae10-02e3ba07e30d",
									true,
								},
							},
							name = "Extra caster downtime syncs",
							uuid = "0b3cbb9d-0724-4a45-98da-81c1197edf0f",
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
							uuid = "0954851d-7a14-a14c-ae10-02e3ba07e30d",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 3,
				loop = true,
				mechanicTime = 11.4,
				name = "[BLM] AutoSim - Specter / Thunder III / Queen's Crusade 2 Sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 600,
				timerStartOffset = -11.4,
				uuid = "017cb66b-d8a8-4a91-ae41-55eccaa357ad",
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
							actionLua = "ACR_TensorViper4_Burn = false\nTensorZelVPRBurn = nil\nself.used = true\n",
							conditions = 
							{
								
								{
									"4476e00d-6b26-d367-8201-d77602804cd5",
									true,
								},
							},
							name = "[VPR] Burn Off (wipe)",
							uuid = "7bb124e5-dab2-7416-b9ba-146c4f598060",
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
							uuid = "4476e00d-6b26-d367-8201-d77602804cd5",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 9,
				mechanicTime = 11.4,
				name = "[VPR] Burn Off (wipe)",
				timelineIndex = 1,
				uuid = "96043537-1e13-170c-b070-c5951d3fd791",
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
				name = "VPR Optimization",
				uuid = "dedbc712-5c77-84b8-bca0-50015a3d5c11",
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
							actionLua = "-- [Opti] Disable CDs (store, no job check) turns CDs off during the adds.\n-- AutoSim handles burst timing for Viper, so undo it.\nif ACR_TensorViper4_CD == false then ACR_TensorViper4_CD = true end\nself.used = true\n",
							conditions = 
							{
								
								{
									"fad58da6-edf4-188f-9d0f-40b95767194f",
									true,
								},
							},
							name = "[VPR] Keep CD on (adds)",
							uuid = "5c95ca1a-60e9-5e3c-ad4c-7e7d43d552c8",
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
							uuid = "fad58da6-edf4-188f-9d0f-40b95767194f",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				loop = true,
				mechanicTime = 105.7,
				name = "[VPR] Keep CD on (adds)",
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = 60,
				timerStartOffset = -2,
				uuid = "9646fc52-a24c-02b9-8775-11c68bce605b",
				version = 2,
			},
		},
	},
	[23] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "db9e2378-8c93-8c2d-be03-86a63b319af0",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "88f646ae-fb5f-87c5-96fd-e250144c68f1",
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
							actionLua = "-- Zelenia back from the add phase (Perfumed Quietus cast start): re-time kill + Thorns window\nlocal e = eventArgs\nif not (e and e.spellID == 43191) then return end\nlocal s = TensorZelVPR\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 110 and not s.ret then\n  s.ret = t\n  -- fast adds (~136 return) kill ~390, slow adds (~148 return) kill ~418\n  if t < 142 then s.kill = 390 + (t - 136.3) else s.kill = 418 + (t - 148.3) end\n  pcall(api.setAutoSimKillTime, s.kill)\n  pcall(api.addAutoSimUncertainty, t, 3)\n  if s.bn then local ok, id = pcall(api.setAutoSimPhase, s.bn, t + 230.0, t + 235.0); if ok then s.bn = id end end\n  self.used = true\nend\n",
							conditions = 
							{
								
								{
									"16635176-32e2-2680-bd02-68f08df4869b",
									true,
								},
							},
							name = "[VPR] AutoSim - Zelenia Return Sync",
							uuid = "58c06e61-1cc2-bb67-8964-ad5fdff272e6",
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
							uuid = "16635176-32e2-2680-bd02-68f08df4869b",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 3,
				mechanicTime = 155.9,
				name = "[VPR] AutoSim - Zelenia Return Sync",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 15,
				timerStartOffset = -45,
				uuid = "2cb5a6a4-283d-0181-8236-2f7d9afe7b63",
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
							actionLua = "local s = TensorZelVPR\nif s and s.kill and not TensorZelVPRBurn then\n  local t = TensorCore.API.TensorACR.getAutoSimTime()\n  if t and t > s.kill then ACR_TensorViper4_Burn = true; TensorZelVPRBurn = true; self.used = true end\nend\n",
							conditions = 
							{
								
								{
									"6015bb95-5f9e-36d0-930b-8567c525d470",
									true,
								},
							},
							name = "[VPR] Burn Past Kill Time",
							uuid = "ada0e121-01e7-9d96-84ed-37503b14e896",
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
							uuid = "6015bb95-5f9e-36d0-930b-8567c525d470",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				loop = true,
				mechanicTime = 155.9,
				name = "[VPR] Burn Past Kill Time",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 600,
				uuid = "73fa788a-9a03-72c9-a672-86a3c4d906bb",
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
							actionLua = "-- Zelenia back from the add phase (Perfumed Quietus cast start): re-time the BLM kill time\nlocal e = eventArgs\nif not (e and e.spellID == 43191) then return end\nlocal s = TensorZelBLM\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 110 and not s.ret then\n  s.ret = t\n  -- our last 3 kills: Zelenia back at ~147.5 s, dead 249.1 s later on average\n  s.kill = t + 249.1\n  pcall(api.setAutoSimKillTime, s.kill)\n  pcall(api.addAutoSimUncertainty, t, 3)\n  self.used = true\nend\n",
							conditions = 
							{
								
								{
									"cebce7ec-a9d4-6ead-9490-b6e072ed7b72",
									true,
								},
							},
							name = "[BLM] AutoSim - Zelenia Return Sync",
							uuid = "a27a2ca7-cfb6-e70a-984b-a6f8c51034aa",
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
							uuid = "cebce7ec-a9d4-6ead-9490-b6e072ed7b72",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 3,
				mechanicTime = 155.9,
				name = "[BLM] AutoSim - Zelenia Return Sync",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 15,
				timerStartOffset = -45,
				uuid = "c1b6af66-e89f-6115-b320-0f66d12bca76",
				version = 2,
			},
		},
	},
	[26] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "d8927ae8-9d68-c1ab-bab0-38e2d8811cd3",
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
							actionLua = "-- Queen's Crusade 1 cast start: re-time the matching caster downtime\nlocal e = eventArgs\nif not (e and e.spellID == 43194) then return end\nlocal s = TensorZelBLM\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not (s and t) or s.qcs then return end\ns.qcs = true\nif s.qc then\n  local ok, id = pcall(api.setAutoSimPhase, s.qc, t + 5.75, t + 8.5)\n  if ok then s.qc = id end\nelse\n  local ok, id = pcall(api.addAutoSimPhase, \"CasterDowntime\", t + 5.75, t + 8.5)\n  if ok then s.qc = id end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"0fccf0a7-615b-c2d9-91f1-ece6a8a6bbb4",
									true,
								},
							},
							name = "[BLM] AutoSim - Queen's Crusade 1 Sync",
							uuid = "b4437176-65eb-d8e3-9724-302b3d46a3dc",
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
							uuid = "0fccf0a7-615b-c2d9-91f1-ece6a8a6bbb4",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				enabled = false,
				eventType = 3,
				mechanicTime = 171.7,
				name = "[BLM] AutoSim - Queen's Crusade 1 Sync (old)",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 4,
				timerStartOffset = -12,
				uuid = "2cceae77-64c9-678f-b2ea-20574f9c71a6",
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
				name = "BLM Optimization",
				uuid = "6177f6cf-99fe-949a-b74f-8dab374fa1d1",
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
							actionLua = "-- Encircling Thorns cast start: re-time the matching caster downtime\nlocal e = eventArgs\nif not (e and e.spellID == 43203) then return end\nlocal s = TensorZelBLM\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not (s and t) or s.ets then return end\ns.ets = true\nif s.et then\n  local ok, id = pcall(api.setAutoSimPhase, s.et, t + 0.75, t + 3.5)\n  if ok then s.et = id end\nelse\n  local ok, id = pcall(api.addAutoSimPhase, \"CasterDowntime\", t + 0.75, t + 3.5)\n  if ok then s.et = id end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"4c683eb7-e1be-d02c-93b9-b7c1c1aa8d4f",
									true,
								},
							},
							name = "[BLM] AutoSim - Encircling Thorns Sync",
							uuid = "461e1089-dc09-faa7-a5d9-edc4b1fc91d3",
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
							uuid = "4c683eb7-e1be-d02c-93b9-b7c1c1aa8d4f",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 3,
				mechanicTime = 369.8,
				name = "[BLM] AutoSim - Encircling Thorns Sync",
				timeRange = true,
				timelineIndex = 69,
				timerEndOffset = 5,
				timerStartOffset = -8,
				uuid = "54f90d81-62b0-f669-bbd2-db497b7e8c00",
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
				name = "VPR Optimization",
				uuid = "d261206c-e050-bba0-93c8-ef8b0b0f1193",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "0a5c8875-22e5-6ca8-8373-20c59fec1a41",
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
							actionLua = "-- Alexandrian Banish III cast start: exact out-of-melee window for Encircling Thorns\nlocal e = eventArgs\nif not (e and e.spellID == 43240) then return end\nlocal s = TensorZelVPR\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and not s.bsync then\n  s.bsync = true\n  local hit = t + (e.channelTimeMax or 4.0)\n  if s.bn then local ok, id = pcall(api.setAutoSimPhase, s.bn, hit - 2.1, hit + 2.9); if ok then s.bn = id end\n  else pcall(api.addAutoSimPhase, \"MeleeDowntime\", hit - 2.1, hit + 2.9) end\n  self.used = true\nend\n",
							conditions = 
							{
								
								{
									"fdf94f9d-c803-2907-ba11-154902a67a75",
									true,
								},
							},
							name = "[VPR] AutoSim - Encircling Thorns Sync",
							uuid = "61ecde47-97d8-d716-a9f9-4451b2e2597e",
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
							uuid = "fdf94f9d-c803-2907-ba11-154902a67a75",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				eventType = 3,
				mechanicTime = 377.9,
				name = "[VPR] AutoSim - Encircling Thorns Sync",
				timeRange = true,
				timelineIndex = 70,
				timerEndOffset = 5,
				timerStartOffset = -15,
				uuid = "0b98a0e1-1874-e36f-98fa-a8e566aeaadd",
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
							actionLua = "-- Alexandrian Banish III cast start: re-time the matching caster downtime\nlocal e = eventArgs\nif not (e and e.spellID == 43240) then return end\nlocal s = TensorZelBLM\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not (s and t) or s.b3s then return end\ns.b3s = true\nif s.b3 then\n  local ok, id = pcall(api.setAutoSimPhase, s.b3, t + 0.75, t + 3.5)\n  if ok then s.b3 = id end\nelse\n  local ok, id = pcall(api.addAutoSimPhase, \"CasterDowntime\", t + 0.75, t + 3.5)\n  if ok then s.b3 = id end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"e1a5451e-fea0-0cd2-85a7-72655f7ea760",
									true,
								},
							},
							name = "[BLM] AutoSim - Banish III Sync",
							uuid = "6277aafc-dfc8-ddf1-b8ed-567ad00a5098",
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
							uuid = "e1a5451e-fea0-0cd2-85a7-72655f7ea760",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 3,
				mechanicTime = 377.9,
				name = "[BLM] AutoSim - Banish III Sync",
				timeRange = true,
				timelineIndex = 70,
				timerEndOffset = 5,
				timerStartOffset = -8,
				uuid = "2b91f960-b5bf-f8b7-8071-d513f20d9420",
				version = 2,
			},
		},
	},
	timelineName = "zelenia-ex",
	version = "1.0.1",
	inheritedProfiles = 
	{
	},
}

return tbl
