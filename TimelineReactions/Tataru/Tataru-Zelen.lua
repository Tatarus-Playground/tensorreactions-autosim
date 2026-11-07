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
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "244973bd-2b2d-0f53-9f79-cd8853d36b39",
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
							actionLua = "-- [Draw] Floor tiles tracker (map effects) | OnMapEffect | None..None loop=None enabled=True\r\ndata.zel = data.zel or {}\r\nlocal Z = data.zel\r\nif not Z.initV then\r\n  Z.initV = true\r\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\r\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\r\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\r\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\r\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\r\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\r\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\r\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\r\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\r\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\r\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\r\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\r\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\r\n  function Z.slot()\r\n    local R = AnyoneCore and AnyoneCore.Roster\r\n    local s = R and R.mySlot and R.mySlot()\r\n    if not s and GetCurrentRole then\r\n      local r = GetCurrentRole()\r\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\r\n    end\r\n    return s\r\n  end\r\n  function Z.slotOf(id)\r\n    local R = AnyoneCore and AnyoneCore.Roster\r\n    return R and R.slotOf and R.slotOf(id)\r\n  end\r\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\r\n  function Z.supOf(id)\r\n    local s = Z.slotOf(id)\r\n    if s then return Z.isSup(s) end\r\n    local e = TensorCore.mGetEntity(id)\r\n    return (e and Z.SUPJOB[e.job]) and true or false\r\n  end\r\n  function Z.tankOf(id)\r\n    local s = Z.slotOf(id)\r\n    if s then return s == \"T1\" or s == \"T2\" end\r\n    local e = TensorCore.mGetEntity(id)\r\n    return (e and Z.TANKJOB[e.job]) and true or false\r\n  end\r\n  function Z.pt(cx, cz, deg, r)\r\n    local a = math.rad(deg)\r\n    return cx + r * math.sin(a), cz - r * math.cos(a)\r\n  end\r\n  function Z.goTo(x, z, col, rad)\r\n    local p = TensorCore.mGetPlayer()\r\n    if not (p and p.pos) then return end\r\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\r\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\r\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\r\n    if d > 0.8 then\r\n      -- tether from you to your spot\r\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\r\n      local tip = math.min(1.5, d * 0.35)\r\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\r\n    end\r\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\r\n  end\r\n  function Z.say(ms, txt, col)\r\n    local p = TensorCore.mGetPlayer()\r\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\r\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\r\n    end\r\n  end\r\n  function Z.dirName(deg)\r\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\r\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\r\n  end\r\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\r\n  function Z.efState(k)\r\n    local ef = Z.ef\r\n    if not ef then return nil end\r\n    local sym = ef.sym\r\n    if not sym[k] then return nil end\r\n    local mySup = Z.isSup(Z.slot())\r\n    local supFirst\r\n    if ef.mode == 2 and Z.donutSup ~= nil then\r\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\r\n      supFirst = not Z.donutSup\r\n    else\r\n      if not sym[1] then return nil end\r\n      supFirst = (sym[1] == \"F\")\r\n    end\r\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\r\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\r\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\r\n  end\r\nend\r\n-- Floor tiles: map-effect index = tile + 4 (0-7 inner ring, 8-15 outer). a2 = low16, a3 = high16 (cactbot flags high..low):\r\n-- red 01000040 = (0x40, 0x100), grey to red 00800040 = (0x40, 0x80); cleared: despawn 00200004 = (0x04, 0x20), grey 00020001 = (0x01, 0x02),\r\n-- wipe 00040004 = (0x04, 0x04). Swapped halves (BossMod 0x00400100 / 0x00040020) are also accepted.\r\n-- Bloom 1 pulse (0x40, 0x1000): time per index in Z.b1pT (outer NNW 19 / outer SSE 15 predict the Bloom 2 floor).\r\nlocal e = eventArgs\r\nif not e then self.used = true return end\r\nlocal idx, lo, hi = tonumber(e.a1), tonumber(e.a2), tonumber(e.a3)\r\nZ.tiles = Z.tiles or {}\r\nZ.tileT = Z.tileT or {}\r\nZ.mfx = Z.mfx or {}\r\nif #Z.mfx < 400 then Z.mfx[#Z.mfx + 1] = {Now(), idx, lo, hi} end\r\nif idx and lo and hi then\r\n  local t = idx - 4\r\n  if t >= 0 and t <= 15 then\r\n    if (lo == 0x40 and (hi == 0x100 or hi == 0x80)) or (hi == 0x40 and (lo == 0x100 or lo == 0x80)) then\r\n      Z.tiles[t] = true; Z.tileT[t] = Now(); Z.tilesKnown = true\r\n    elseif (lo == 0x04 and hi == 0x20) or (lo == 0x20 and hi == 0x04) or (lo == 0x01 and hi == 0x02) or (lo == 0x04 and hi == 0x04) then\r\n      Z.tiles[t] = false; Z.tileT[t] = Now(); Z.tilesKnown = true\r\n    elseif lo == 0x40 and hi == 0x1000 then\r\n      Z.b1pT = Z.b1pT or {}\r\n      Z.b1pT[idx] = Now()\r\n    end\r\n  end\r\nend\r\nself.used = true\r\n",
							name = "[Draw] Floor tiles tracker (map effects)",
							uuid = "9dedcbe7-6b4d-6e61-bfef-70ff11b14143",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 14,
				mechanicTime = 11.4,
				name = "[Draw] Floor tiles tracker (map effects)",
				timelineIndex = 1,
				uuid = "0ecdbc67-6b88-b072-a481-741b04f52b21",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Centre void: map effect index 1, on = (a2 1, a3 2), off = (a2 4, a3 8)\nlocal e = eventArgs\nif e and tonumber(e.a1) == 1 then\n  local lo, hi = tonumber(e.a2), tonumber(e.a3)\n  if lo == 1 and hi == 2 then Z.voidOn = Now()\n  elseif lo == 4 and hi == 8 then Z.voidOn = nil; Z.voidOff = Now() end\nend\nself.used = true\n",
							name = "[Draw] Centre void tracker (map effect)",
							uuid = "c720d526-262a-5098-affc-d48617ef783f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 14,
				mechanicTime = 11.4,
				name = "[Draw] Centre void tracker (map effect)",
				timelineIndex = 1,
				uuid = "b9b71b55-a9a4-4ab8-8adf-417ac95d1add",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Centre void fallback: Queen's Crusade 43194 starts it\nif eventArgs and eventArgs.spellID == 43194 then Z.voidCast = Now() end\nself.used = true\n",
							name = "[Draw] Centre void tracker (Queen's Crusade)",
							uuid = "1388ae37-d291-e7f6-bfb9-f8d021167f15",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				mechanicTime = 11.4,
				name = "[Draw] Centre void tracker (Queen's Crusade)",
				timelineIndex = 1,
				uuid = "45c08066-2256-585a-abe2-4fecd2fd4a3b",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Centre void: red 2.5 y circle while active, callout if you stand in it\nlocal on = Z.voidOn ~= nil\nif not on and Z.voidCast and Now() - Z.voidCast < 30000 and not (Z.voidOff and Z.voidOff > Z.voidCast + 2000) then on = true end\nif not on then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nTensorCore.getCachedDrawer(0x203333FF, 0x403333FF, 0x803333FF, 0xFF3333FF, 2):addCircle(100, p.pos.y, 100, 2.5, false, Z.flags)\nlocal dx, dz = p.pos.x - 100, p.pos.z - 100\nif dx * dx + dz * dz < 6.25 and (not Z.voidSaid or Now() - Z.voidSaid > 4000) then\n  Z.voidSaid = Now(); hush(2500, \"OUT OF THE MIDDLE\", 0xFF3333FF)\nend\n",
							name = "[Draw] Centre void - stay out of the middle",
							uuid = "b78c31a6-e151-ba8a-b9ab-466c6eda7927",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				mechanicTime = 11.4,
				name = "[Draw] Centre void - stay out of the middle",
				timelineIndex = 1,
				uuid = "9c84c894-a1a4-1703-9ebb-0dd38822ea50",
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
							actionLua = "-- Zelenia: hide every on-screen text (ours and the store's) except SWAP / STAND STILL / GO.\n-- Runs every frame while this timeline is active; the filter switches itself off 2 s after the timeline stops.\nlocal F = _G.__ZTXTF\nif not F then\n  F = {orig = {}, untilT = 0}\n  _G.__ZTXTF = F\n  local KEEP = {SWAP = true, [\"STAND STILL\"] = true, GO = true}\n  local function allowed(txt)\n    if type(txt) ~= \"string\" then return true end\n    local t = txt:upper():gsub(\"[^%a ]\", \"\"):gsub(\"^%s+\", \"\"):gsub(\"%s+$\", \"\"):gsub(\"%s+\", \" \")\n    return KEEP[t] == true\n  end\n  for _, n in ipairs({\"addTimedWorldText\", \"addTimedWorldTextOnEnt\", \"addWorldTextCountdown\",\n                      \"addWorldTextCountdownFormatted\", \"addWorldTextCountdownOnEnt\", \"addWorldTextCountdownOnEntFormatted\"}) do\n    local f = AnyoneCore and AnyoneCore[n]\n    if type(f) == \"function\" then\n      F.orig[n] = f\n      AnyoneCore[n] = function(...)\n        if Now() < F.untilT then\n          local a = {...}\n          for i = 1, #a do\n            if type(a[i]) == \"string\" then\n              if not allowed(a[i]) then return nil end\n              break\n            end\n          end\n        end\n        return F.orig[n](...)\n      end\n    end\n  end\nend\nF.untilT = Now() + 2000\nself.used = true\n",
							name = "[Draw] Text filter - only SWAP / STAND STILL / GO",
							uuid = "c5fbd061-2962-edc1-92e6-aa40fafe7541",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				mechanicTime = 11.4,
				name = "[Draw] Text filter - only SWAP / STAND STILL / GO",
				timelineIndex = 1,
				uuid = "1711036d-b260-f1a0-8b90-4af4a5ca95af",
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
							actionLua = "-- Settings window: Bloom 4 Thorns DPS side (B = east, D = west). Saved with FileSave/FileLoad.\nlocal S = TataruZelenSettings\nif not S then\n  local folder = GetLuaModsPath() .. [[TensorReactions\\Settings\\]]\n  S = {b4dps = \"B\", folder = folder, path = folder .. [[Tataru-Zelen.settings.lua]]}\n  if FileExists(S.path) then\n    local t = FileLoad(S.path)\n    if type(t) == \"table\" and (t.b4dps == \"B\" or t.b4dps == \"D\") then S.b4dps = t.b4dps end\n  end\n  function S.save()\n    if not FolderExists(S.folder) then FolderCreate(S.folder) end\n    FileSave(S.path, {b4dps = S.b4dps})\n  end\n  TataruZelenSettings = S\nend\nlocal p = TensorCore.mGetPlayer()\nif p and p.incombat then\n  S.combatT = S.combatT or Now()\n  S.closed = nil\n  if Now() - S.combatT > 3000 then return end -- hide 3 s after combat starts\nelse\n  S.combatT = nil\nend\nif S.closed then return end\nlocal visible, open = GUI:Begin(\"Tataru Zelenia settings##TataruZelenSet\", true, GUI.WindowFlags_AlwaysAutoResize + GUI.WindowFlags_NoCollapse)\nif visible then\n  GUI:Text(\"Bloom 4 Thorns - where do DPS go?\")\n  if GUI:RadioButton(\"DPS B (east)##tzB\", S.b4dps == \"B\") and S.b4dps ~= \"B\" then\n    S.b4dps = \"B\"\n    S.save()\n  end\n  GUI:SameLine()\n  if GUI:RadioButton(\"DPS D (west)##tzD\", S.b4dps == \"D\") and S.b4dps ~= \"D\" then\n    S.b4dps = \"D\"\n    S.save()\n  end\n  GUI:TextColored(0.7, 0.7, 0.7, 1, (S.b4dps == \"B\") and \"Supports go D (west)\" or \"Supports go B (east)\")\nend\nGUI:End()\nif open == false then S.closed = true end\n",
							name = "Bloom 4 settings window",
							uuid = "f9cd967e-fffa-ab3f-83b3-6069efe566dd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 13,
				loop = true,
				mechanicTime = 11.4,
				name = "[Settings] Bloom 4 Thorns DPS side (B / D)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -8.4,
				timerStartOffset = -111.4,
				uuid = "e6ba4834-771d-71d4-beac-cf7c38113cde",
				version = 2,
			},
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
	}, 
	[3] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "318a944e-380d-85af-bb47-3bd8767f851e",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Shock: 580 = donut (take tower, stand still), 581 = puddles (move out)\nlocal e = eventArgs\nif not (e and (e.markerID == 580 or e.markerID == 581)) then self.used = true return end\n-- fresh state each pull (all 8 markers land in the same tick; a stale table from a previous pull is dropped)\nif not Z.shockT or Now() - Z.shockT > 20000 then\n  Z.shock = {}\n  Z.shockT = Now()\nend\nZ.shock[e.entityID] = e.markerID\nself.used = true\n",
							name = "[Draw] Shock - markers",
							uuid = "3e739074-95ac-8fec-b782-e97775e7ac4c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 21.7,
				name = "[Draw] Shock - markers",
				timeRange = true,
				timelineIndex = 3,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "da833a80-1bad-7a8b-8ba7-64b4acd5998c",
				version = 2,
			},
		},
	},
	[5] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "f93866c6-71e1-ad62-889f-75e00343118c",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Shock: draw ONLY your own spot from the moment markers land (~3 s before the towers spawn)\n-- donut (580) -> your colour-pair tower (intercard), puddles (581) -> your colour-pair cardinal; no text\nlocal S, t0 = Z.shock, Z.shockT\nlocal p = TensorCore.mGetPlayer()\nif not (S and t0 and p and p.pos) then return end\nif Now() - t0 > 12000 then return end -- markers from an earlier pull\nlocal m, s = S[p.id], Z.slot()\nif not (m and s) then return end\nif m == 580 then\n  -- donut holder: nothing once the donut dropped (moving makes you hit yourself)\n  if Z.shDn and Now() - Z.shDn.t < 6000 then return end\n  local T = Z.SHOCK_TOWER[s]\n  if not T then return end\n  local dx, dz = p.pos.x - T[1], p.pos.z - T[2]\n  if dx * dx + dz * dz > 6.25 then Z.goTo(T[1], T[2], 0x33FF33, 3.0)\n  else TensorCore.getCachedDrawer(0x5533FF33, 0x8833FF33, 0xFF33FF33, 0xFF000000, 2):addCircle(T[1], p.pos.y, T[2], 3.0, false, Z.flags) end\nelseif m == 581 then\n  -- puddle holder: cardinal until your first puddle drops (then \"step out\" takes over)\n  if Z.shPd and Now() - Z.shPd.t < 3000 then return end\n  if Now() - t0 > 7800 then return end -- same cap as before: ends just before the first puddle drops (~8 s after markers)\n  local a = Z.SHOCK_CARD[s]\n  if a then\n    local x, z = Z.pt(100, 100, a, 13)\n    Z.goTo(x, z, 0x0099FF, 1.0)\n  end\nend\n",
							name = "[Draw] Shock - your tower / cardinal",
							uuid = "0c7612f7-5fcb-9b79-8677-ee3f96823184",
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
				mechanicTime = 31.8,
				name = "[Draw] Shock - your tower / cardinal",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 0.30000001192093,
				timerStartOffset = -10.5,
				uuid = "57260ac1-0ef3-3a5e-b143-a45ce189c9ab",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Shock: my donut (43178) / puddle (43171) dropped at my spot\nif not eventArgs then self.used = true return end\nlocal id = eventArgs.spellID\nif id == 43178 or id == 43171 then\n  local c = TensorCore.mGetEntity(eventArgs.entityID)\n  local p = TensorCore.mGetPlayer()\n  if c and c.pos and p and p.pos then\n    local dx, dz = c.pos.x - p.pos.x, c.pos.z - p.pos.z\n    if dx * dx + dz * dz < 6.25 then\n      local v = {t = Now(), x = c.pos.x, z = c.pos.z}\n      if id == 43178 then Z.shDn = v else Z.shPd = v end\n    end\n  end\nend\nself.used = true\n",
							name = "[Draw] Shock - my donut / puddle tracker",
							uuid = "7ab512a1-1154-bc01-81a7-cc402f507992",
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
				mechanicTime = 31.8,
				name = "[Draw] Shock - my donut / puddle tracker",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 1,
				timerStartOffset = -4,
				uuid = "51b32e76-c5f3-ed96-9c37-40b4055737db",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Shock: donut holder STAND STILL (ticks ~5.6 s), puddle holder step 5 y out toward the centre\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal py = p.pos.y\nlocal D = Z.shDn\nif D and Now() - D.t < 5600 then\n  TensorCore.getCachedDrawer(0x3300FFFF, 0x5500FFFF, 0x8800FFFF, 0xFF00FFFF, 2):addCircle(D.x, py, D.z, 0.5, false, Z.flags)\n  if not Z.shDnSaid then Z.shDnSaid = true; Z.say(4000, \"STAND STILL\", 0xFF00FFFF) end\nend\nlocal P = Z.shPd\nif P and Now() - P.t < 1500 then\n  TensorCore.getCachedDrawer(0x283333FF, 0x483333FF, 0x803333FF, 0xFF3333FF, 2):addCircle(P.x, py, P.z, 4.0, false, Z.flags)\n  local dx, dz = 100 - P.x, 100 - P.z\n  local r = math.sqrt(dx * dx + dz * dz)\n  if r > 0.1 then Z.goTo(P.x + dx / r * 5, P.z + dz / r * 5, 0x33FF33, 0.8) end\nend\n",
							name = "[Draw] Shock - stand still / step out",
							uuid = "916fbbb3-453d-eef7-8e6a-6b5cfa1aed2b",
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
				mechanicTime = 31.8,
				name = "[Draw] Shock - stand still / step out",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 4.6,
				timerStartOffset = -2,
				uuid = "c17387e4-35d0-8cf0-add9-5c00055eef50",
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
				name = "Role Draws",
				uuid = "295d58c6-af7f-eeb1-8a56-86803eaf43dc",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tankbuster tethers (89) from players to the boss\nlocal e = eventArgs\nif not e then self.used = true return end\nZ.spec = Z.spec or {}\nif e.newTetherID == 89 then\n  Z.spec[e.sourceEntityID] = true\n  local p = TensorCore.mGetPlayer()\n  if p and e.sourceEntityID == p.id and not Z.tankOf(p.id) then hush(4000, \"BUSTER TETHER: let a tank take it\", 0xFF3333FF) end\nelseif e.oldTetherID == 89 then\n  Z.spec[e.sourceEntityID] = nil\nend\nself.used = true\n",
							name = "[Draw] Specter - tether tracker",
							uuid = "30ba549c-8df3-3eaa-9bd0-fa5bc37471a0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 44.7,
				name = "[Draw] Specter - tether tracker",
				timeRange = true,
				timelineIndex = 6,
				timerEndOffset = 0.30000001192093,
				timerStartOffset = -9,
				uuid = "a00cbcd2-898d-a617-a14d-53ebb690a55d",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tanks get a line to any non-tank holding a tether\nlocal S = Z.spec\nlocal p = TensorCore.mGetPlayer()\nif not (S and p and p.pos) then return end\nlocal tank = Z.tankOf(p.id)\nfor id in pairs(S) do\n  if not Z.tankOf(id) then\n    local ent = TensorCore.mGetEntity(id)\n    if ent and ent.pos then\n      if tank then\n        TensorCore.getStaticDrawer(0xFF00FFFF, 4):addLine(p.pos.x, p.pos.y, p.pos.z, ent.pos.x, ent.pos.y, ent.pos.z, 6)\n        TensorCore.getCachedDrawer(0x3300FFFF, 0x5500FFFF, 0x8800FFFF, 0xFF00FFFF, 3):addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 1.5, false, Z.flags)\n      elseif id == p.id then\n        TensorCore.getCachedDrawer(0x333333FF, 0x553333FF, 0x883333FF, 0xFF3333FF, 3):addCircle(p.pos.x, p.pos.y, p.pos.z, 1.5, false, Z.flags)\n      end\n    end\n  end\nend\n",
							name = "[Draw] Specter - tanks grab tethers",
							uuid = "8b9ea762-1eaf-3131-9f2c-c6e1ee377438",
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
				mechanicTime = 44.7,
				name = "[Draw] Specter - tanks grab tethers",
				timeRange = true,
				timelineIndex = 6,
				timerEndOffset = 0.20000000298023,
				timerStartOffset = -8.5,
				uuid = "c70b2a43-3faa-6962-83ef-dcf74e104dfc",
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
				name = "Role Draws",
				uuid = "ce225a00-d9fa-e69d-92fb-afc59258fd82",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall cast start: new symbol list\nZ.ef = {t0 = Now(), sym = {}, boss = eventArgs.entityID, mode = 1}\nself.used = true\n",
							conditions = 
							{
								
								{
									"8cff8599-3355-21fa-9de6-3e3bd01e4fd4",
									true,
								},
							},
							name = "[Draw] Escelons' Fall 1 - cast start",
							uuid = "b9f55069-007f-05db-accf-4a0291496b2f",
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
							eventSpellID = 43181,
							name = "Escelons' Fall",
							uuid = "8cff8599-3355-21fa-9de6-3e3bd01e4fd4",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 64.2,
				name = "[Draw] Escelons' Fall 1 - cast start",
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = -11.5,
				timerStartOffset = -14.5,
				uuid = "77db30f1-4016-fdee-a1b9-885642be60cb",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall symbols on the boss: 2127 = near, 2128 = far\nlocal e, ef = eventArgs, Z.ef\nif not (e and ef and e.entityID == ef.boss) then self.used = true return end\nlocal v = e.newActiveAura1\nif (v == 2127 or v == 2128) and #ef.sym < 4 then\n  ef.sym[#ef.sym + 1] = (v == 2127) and \"N\" or \"F\"\n  if #ef.sym == 4 then\n    local a, b, c, d = Z.efState(1), Z.efState(2), Z.efState(3), Z.efState(4)\n    if a and b and c and d then hush(9000, \"EF: \" .. a .. \" > \" .. b .. \" > \" .. c .. \" > \" .. d, 0xFF00FFFF) end\n  end\nend\nself.used = true\n",
							name = "[Draw] Escelons' Fall 1 - symbols",
							uuid = "b22d30ce-ceac-5164-aecb-f1a896af0f5b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 25,
				loop = true,
				mechanicTime = 64.2,
				name = "[Draw] Escelons' Fall 1 - symbols",
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = -0.5,
				timerStartOffset = -13,
				uuid = "746480b6-ccc4-eeed-b5ad-171f1fa62bdc",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall 1/3: clock spot, DPS start in, supports out, then follow the symbols\nlocal ef = Z.ef\nlocal p = TensorCore.mGetPlayer()\nlocal s = Z.slot()\nif not (ef and p and p.pos and s and ef.mode == 1) then return end\nlocal el = (Now() - ef.t0) / 1000\nlocal k\nfor i = 1, 4 do if el < Z.EF_HIT[i] + 0.3 then k = i break end end\nif not k then return end\nlocal st = Z.efState(k)\nif not st then\n  if k ~= 1 then return end\n  st = Z.isSup(s) and \"OUT\" or \"IN\"\nend\nlocal cx, cz = 100, 100\nlocal b = TensorCore.mGetEntity(ef.boss)\nif b and b.pos then cx, cz = b.pos.x, b.pos.z end\nlocal x, z = Z.pt(cx, cz, Z.EF_CLOCK[s] or 0, st == \"IN\" and 3.0 or 10.0)\nZ.goTo(x, z, st == \"IN\" and 0x33FF33 or 0x0099FF, 0.8)\n",
							name = "[Draw] Escelons' Fall 1 - in/out spot",
							uuid = "a9b3783b-e30e-26c8-804a-e54249d369f8",
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
				mechanicTime = 64.2,
				name = "[Draw] Escelons' Fall 1 - in/out spot",
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = 10.4,
				timerStartOffset = -12.8,
				uuid = "e7af0d60-2fcb-fb6d-8bde-bcce8d64147e",
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
				name = "VPR Optimization",
				uuid = "1640618e-287a-8d97-a1ed-0e6f58c13835",
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
							actionID = 7549,
							conditions = 
							{
								
								{
									"cae44a11-3e91-720a-8f72-970e20d698a0",
									true,
								},
								
								{
									"a4f25bd1-34da-819e-9d07-6bb8422471e4",
									true,
								},
								
								{
									"f99e7ac5-a927-eac5-8058-9df27812369d",
									true,
								},
								
								{
									"fbb54ee4-127a-5d1d-b492-9b388163f794",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Enemy",
							uuid = "4f957082-89ee-2e61-9b01-f44148457fe7",
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
							uuid = "cae44a11-3e91-720a-8f72-970e20d698a0",
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
							uuid = "a4f25bd1-34da-819e-9d07-6bb8422471e4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "f99e7ac5-a927-eac5-8058-9df27812369d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "fbb54ee4-127a-5d1d-b492-9b388163f794",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 83.4,
				name = "[VPR] Feint - Stock Break x5",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = -2,
				timerStartOffset = -6,
				uuid = "8232aeeb-4e45-c6dd-b5c2-9ab9b8e95a19",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "7c9e3330-7735-bc0b-9edb-3e85695f8831",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: ring on the stack target for all 5 hits\nlocal e = eventArgs\nif not (e and e.markerID == 590) then self.used = true return end\nZ.sb = {id = e.entityID, t = Now()}\nTensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xFF00FFFF, 3):addTimedCircleOnEnt(11500, e.entityID, 5.0, 0, false, true, Z.flags)\nself.used = true\n",
							name = "[Draw] Stock Break - stack ring",
							uuid = "ef0ee347-1291-47a7-a5d8-36fd2f87145d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 83.4,
				name = "[Draw] Stock Break - stack ring",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = -5.5,
				timerStartOffset = -8.5,
				uuid = "c2522ae3-5786-3afd-b629-1e071cfff5a4",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: arrow to the stack target when you are not in it\nlocal sb = Z.sb\nlocal p = TensorCore.mGetPlayer()\nif not (sb and p and p.pos) or sb.id == p.id or Now() - sb.t > 11500 then return end\nlocal t = TensorCore.mGetEntity(sb.id)\nif not (t and t.pos) then return end\nif TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, t.pos.x, p.pos.y, t.pos.z) > 3.0 then\n  Z.goTo(t.pos.x, t.pos.z, 0x00FFFF, 0.6)\nend\n",
							name = "[Draw] Stock Break - go stack",
							uuid = "5370ce94-f18b-2684-92b7-8ac659e370a1",
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
				mechanicTime = 83.4,
				name = "[Draw] Stock Break - go stack",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 4.6,
				timerStartOffset = -7.2,
				uuid = "c7d794d3-f4f8-21d0-9079-6a61b2ab0cfd",
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
				name = "Role Draws",
				uuid = "e6886797-2058-b595-b0ad-3807e9d3e536",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nlocal s = Z.slot()\nif s then hush(6000, Z.isSup(s) and \"ADDS: supports WEST\" or \"ADDS: DPS EAST\", 0xFFFFFF00) end\nself.used = true\n",
							conditions = 
							{
								
								{
									"75119d7e-8989-e451-9ea6-6a512bc9d970",
									true,
								},
							},
							name = "[Draw] Adds - side callout",
							uuid = "27721b97-141d-a07b-b919-48e8a750bb8a",
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
							eventSpellID = 43189,
							name = "Blessed Barricade",
							uuid = "75119d7e-8989-e451-9ea6-6a512bc9d970",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 93.5,
				name = "[Draw] Adds - side callout",
				timeRange = true,
				timelineIndex = 15,
				timerEndOffset = -1.5,
				timerStartOffset = -4,
				uuid = "c8e629a5-7256-4198-b548-6649748f75e1",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Adds: supports west, DPS east\nlocal s = Z.slot()\nif s then Z.goTo(Z.isSup(s) and 91 or 109, 100, 0xFFFF00, 1.5) end\n",
							name = "[Draw] Adds - go to your side",
							uuid = "85080146-0bcc-5f21-a4d5-cbc42cde4f90",
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
				mechanicTime = 93.5,
				name = "[Draw] Adds - go to your side",
				timeRange = true,
				timelineIndex = 15,
				timerEndOffset = 5.1999998092651,
				timerStartOffset = -2.7999999523163,
				uuid = "82ce5d19-c5e9-3b6d-b84e-29de5ced7e94",
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
				name = "Role Draws",
				uuid = "be477a5e-c71b-05b9-be78-8d6c28f2653e",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Adds: 3-man tower on each side; count tower rounds (1..3) so the next one can be pre-marked\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif ent and ent.pos then\n  local now = Now()\n  if not Z.atwT or now - Z.atwT > 30000 then Z.atn = 0 end\n  if not Z.atwT or now - Z.atwT > 3000 then Z.atn = (Z.atn or 0) + 1 end\n  Z.atwT = now\n  Z.atw = Z.atw or {}\n  Z.atw[(ent.pos.x < 100) and \"W\" or \"E\"] = {x = ent.pos.x, z = ent.pos.z, t = now}\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"20add025-1757-b528-812e-6d0051dac8cd",
									true,
								},
							},
							name = "[Draw] Adds - tower tracker",
							uuid = "92998119-d2a9-5e34-a859-7dfc53447752",
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
							eventSpellID = 43068,
							name = "Adds tower",
							uuid = "20add025-1757-b528-812e-6d0051dac8cd",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 105.4,
				name = "[Draw] Adds - tower tracker",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 36,
				timerStartOffset = -8,
				uuid = "e7186c9c-336c-f48b-b06b-bc78caefa0a8",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Adds: shade tether (17); remember which shade has you, dodge inward when it ends\nlocal e = eventArgs\nif not e then self.used = true return end\nZ.at = Z.at or {}\nlocal p = TensorCore.mGetPlayer()\nif e.newTetherID == 17 then\n  Z.at[e.newTargetID] = e.sourceEntityID\n  if p and e.newTargetID == p.id then hush(5000, \"ADD TETHER: follow the arrow (sword points OUT), then step in\", 0xFF3333FF) end\nelseif e.oldTetherID == 17 then\n  if p and e.oldTargetID == p.id then\n    local sh = TensorCore.mGetEntity(e.sourceEntityID)\n    if sh and sh.pos then Z.adodge = {x = sh.pos.x + ((sh.pos.x < 100) and 5 or -5), t = Now()} end\n  end\n  Z.at[e.oldTargetID] = nil\nend\nself.used = true\n",
							name = "[Draw] Adds - tethers",
							uuid = "61e8ebe7-56bd-50c7-9157-f67b20ea295e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 105.4,
				name = "[Draw] Adds - tethers",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 36,
				timerStartOffset = -8,
				uuid = "3b1a01e4-944e-574f-b505-328770d85354",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Adds: tethered -> only the sword spot (N/S of your shade so the sword points out)\n-- everyone else -> only your side's tower, pre-marked before it spawns\nlocal p = TensorCore.mGetPlayer()\nlocal s = Z.slot()\nif not (p and p.pos and s) then return end\nlocal shid = Z.at and Z.at[p.id]\nif shid then\n  local sh = TensorCore.mGetEntity(shid)\n  if sh and sh.pos then\n    local an = Z.slash and Z.slash[shid]\n    if an then\n      local north = ((an == 3217) == (sh.pos.x < 100))\n      Z.goTo(sh.pos.x, sh.pos.z + (north and -6 or 6), 0x3333FF, 1.0)\n    end\n    return\n  end\nend\nlocal dg = Z.adodge\nif dg and Now() - dg.t < 2500 then\n  Z.goTo(dg.x, p.pos.z, 0x33FF33, 1.0)\n  return\nend\nlocal side = Z.isSup(s) and \"W\" or \"E\"\nlocal now = Now()\nlocal tw = Z.atw and Z.atw[side]\nif tw and now - tw.t < 6000 then Z.goTo(tw.x, tw.z, 0x33FF33, 3.0) return end\n-- not spawned yet: fixed pattern in every pull, rounds 1+3 W(93,104) E(107,96), round 2 swapped; no towers in round 4\nlocal n = (Z.atwT and now - Z.atwT < 30000) and (Z.atn or 0) or 0\nif n >= 3 then return end\nlocal south = (n % 2 == 0)\nif side == \"W\" then Z.goTo(93.072, south and 104 or 96, 0x33FF33, 3.0)\nelse Z.goTo(106.928, south and 96 or 104, 0x33FF33, 3.0) end\n",
							name = "[Draw] Adds - your tower / sword spot",
							uuid = "f01321cc-97a4-302a-96a9-3c31d3c0ff40",
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
				mechanicTime = 105.4,
				name = "[Draw] Adds - your tower / sword spot",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 36,
				timerStartOffset = -14.7,
				uuid = "55d9fe40-5160-125e-b369-2b6f4ef585a1",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Adds: shade slash hand (3216 right / 3217 left) shows where its sword will swing\nlocal e = eventArgs\nif not (e and e.entityContentID == 13864 and (e.newAnimID == 3216 or e.newAnimID == 3217)) then self.used = true return end\nZ.slash = Z.slash or {}\nZ.slash[e.entityID] = e.newAnimID\nself.used = true\n",
							name = "[Draw] Adds - sword side",
							uuid = "3b2841cc-bffe-7d73-9133-045411bb73f5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 23,
				loop = true,
				mechanicTime = 105.4,
				name = "[Draw] Adds - sword side",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 36,
				timerStartOffset = -8,
				uuid = "ef160324-5716-ef10-8518-a7d048f93409",
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
	[25] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "9cc67937-08c8-7a03-8bd1-c9920ce084b2",
			},
			objectType = "folder",
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
	[27] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "fcd4272e-834f-ad2e-8700-4b36b7717984",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nZ.say(6000, \"THUNDER II: 3 inner safe tiles, stay BEHIND the rotation\", 0xFF00FFFF)\nself.used = true\n",
							conditions = 
							{
								
								{
									"f6a027f8-b98c-7dff-97a7-86c85b1fea62",
									true,
								},
							},
							name = "[Draw] Bloom 1 - Thunder II callout",
							uuid = "973e1a6b-55e5-b848-b7b5-e31436219c0e",
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
							eventSpellID = 43198,
							name = "Thunder II",
							uuid = "f6a027f8-b98c-7dff-97a7-86c85b1fea62",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 179.1,
				name = "[Draw] Bloom 1 - Thunder II callout (old)",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = -3.5,
				timerStartOffset = -6,
				uuid = "775d312d-7598-17ed-bb05-034159deeb68",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not eventArgs then self.used = true return end\n-- Bloom 1: rotation icon on Zelenia (167 = clockwise, 168 = counter-clockwise)\nlocal m = eventArgs.markerID\nif m == 167 or m == 168 then\n  local now = Now()\n  local b = Z.b1\n  if not (b and b.t0 and now - b.t0 < 40000) then\n    b = {t0 = now, cones = {}, nc = 0, k = 0}\n    Z.b1 = b\n  end\n  b.dir = (m == 167) and 1 or -1\nend\nself.used = true",
							name = "[Draw] Bloom 1 - Thunder II rotation tracker",
							uuid = "891cdc01-54be-1cca-a1d0-2ed9b18a47e0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 179.1,
				name = "[Draw] Bloom 1 - Thunder II rotation tracker",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "7c98ef5b-9d67-2ee0-888b-e902dade244e",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not eventArgs then self.used = true return end\n-- Bloom 1: the three Alexandrian Thunder II cones (43199, 5.4s) start; store each helper's facing\nif eventArgs.spellID == 43199 then\n  local now = Now()\n  local b = Z.b1\n  if not (b and b.t0 and now - b.t0 < 40000) then\n    b = {t0 = now, cones = {}, nc = 0, k = 0}\n    Z.b1 = b\n  end\n  b.cones = b.cones or {}\n  b.chanT = b.chanT or now\n  local id = eventArgs.entityID\n  if id and b.cones[id] == nil and (b.nc or 0) < 3 then\n    local e = TensorCore.mGetEntity(id)\n    if e and e.pos and e.pos.h then\n      b.cones[id] = (180 - math.deg(e.pos.h)) % 360\n      b.nc = (b.nc or 0) + 1\n    end\n  end\nend\nself.used = true",
							name = "[Draw] Bloom 1 - Thunder II cone tracker",
							uuid = "7d269793-9ea1-64b1-978d-cd87b7c0f882",
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
				mechanicTime = 179.1,
				name = "[Draw] Bloom 1 - Thunder II cone tracker",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "cfa2a720-6709-d449-9dcf-6cf0623d7d80",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not eventArgs then self.used = true return end\n-- Bloom 1: count Thunder II snapshots (43199 = 1st hit, 43064 = repeats; 3 casts per step, 15 steps)\nlocal sid = eventArgs.spellID\nif sid == 43199 or sid == 43064 then\n  local b = Z.b1\n  local now = Now()\n  if b and b.t0 and now - b.t0 < 40000 then\n    if not b.stepT or now - b.stepT > 450 then\n      b.k = (b.k or 0) + 1\n      b.stepT = now\n      if b.k == 1 then b.T0 = now end\n    end\n    -- late direction fallback: a 2nd-step heading is a start cone +-10 degrees\n    if not b.dir and b.k == 2 and eventArgs.heading and b.cones then\n      local a = (180 - math.deg(eventArgs.heading)) % 360\n      for _, c in pairs(b.cones) do\n        if math.abs((a - c - 10 + 540) % 360 - 180) < 3 then b.dir = 1 break end\n        if math.abs((a - c + 10 + 540) % 360 - 180) < 3 then b.dir = -1 break end\n      end\n    end\n  end\nend\nself.used = true",
							name = "[Draw] Bloom 1 - Thunder II step counter",
							uuid = "bf429d09-c81b-4f4d-b29f-f045b7a42ba3",
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
				mechanicTime = 179.1,
				name = "[Draw] Bloom 1 - Thunder II step counter",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = 16,
				timerStartOffset = -0.5,
				uuid = "cfcc983a-7016-c2b8-9add-26a8dd487419",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 1 Thunder II: arrow to the start spot just behind a cone, then follow the rotation on plain tiles\n-- (plan = 15 snapshot phases x 16 tiles, solved once; afterwards each frame only looks up the phase)\nlocal b = Z.b1\nlocal now = Now()\nif not (b and b.t0 and now - b.t0 < 40000) then return end\nif not b.plan and not b.planFail then\n  local cones = {}\n  if b.cones then for _, c in pairs(b.cones) do cones[#cones + 1] = c end end\n  if #cones < 3 then\n    if b.chanT and now - b.chanT < 400 then return end\n    if not b.chanT and now - b.t0 < 1000 then return end\n  end\n  local dir = b.dir\n  if not dir and #cones == 3 then\n    -- every log: CW starts {22.5,142.5,262.5}, CCW starts {67.5,187.5,307.5}\n    local m = cones[1] % 120\n    if math.abs(m - 22.5) < 4 then dir = 1 elseif math.abs(m - 67.5) < 4 then dir = -1 end\n  end\n  if not dir then\n    if not b.said0 and b.chanT and now - b.chanT > 1500 then\n      b.said0 = true\n      hush(6000, \"THUNDER II: 3 inner safe tiles, stay BEHIND the rotation\", 0xFF00FFFF)\n    end\n    return\n  end\n  if #cones ~= 3 then cones = (dir > 0) and {22.5, 142.5, 262.5} or {67.5, 187.5, 307.5} end\n  -- floor: live tile tracker when fresh and plausible, else the floor seen in every log for this rotation\n  local red, useT, newest = {}, false, 0\n  if Z.tilesKnown and type(Z.tiles) == \"table\" then\n    local nr = 0\n    for t = 0, 15 do\n      if Z.tiles[t] then nr = nr + 1 end\n      local tt = type(Z.tileT) == \"table\" and Z.tileT[t]\n      if tt and tt > newest then newest = tt end\n    end\n    useT = (nr >= 4 and nr <= 13 and now - newest < 25000)\n    -- floor still changing: wait for it to settle (max 2.5s after the rotation marker)\n    if useT and now - newest < 400 and now - b.t0 < 2500 then return end\n  end\n  b.planNewest = newest\n  if useT then\n    for t = 0, 15 do red[t] = Z.tiles[t] and true or false end\n  else\n    local plain = (dir > 0) and {[2] = 1, [3] = 1, [4] = 1, [9] = 1, [10] = 1, [12] = 1}\n      or {[0] = 1, [3] = 1, [6] = 1, [7] = 1, [13] = 1, [14] = 1}\n    for t = 0, 15 do red[t] = not plain[t] end\n  end\n  -- node(n, u): safe arc of tile u for snapshot n (outside the cones at n-1 and n), target = its forward end\n  local function node(n, u)\n    local inner = u < 8\n    local k = u % 8\n    local s = 45 * k\n    -- start spot (before the 1st hit, held ~5 s): wider margin; afterwards 8 deg behind the cone that just fired\n    local mg = (n == 0) and (inner and 15 or 9) or (inner and 8 or 5)\n    local em = inner and 9 or 5.5\n    local base = inner and 0 or 8\n    local a, bb = s, s + 45\n    if red[base + (k + 7) % 8] then a = a + em end\n    if red[base + (k + 1) % 8] then bb = bb - em end\n    local arcs = {}\n    for i = 1, 3 do\n      local p2 = cones[i] + 10 * dir * n\n      local p1 = (n > 0) and (cones[i] + 10 * dir * (n - 1)) or p2\n      local x0 = math.min(p1, p2) - 22.5 - mg\n      local x1 = math.max(p1, p2) + 22.5 + mg\n      arcs[i] = {x0, x1}\n      local w = x1 - x0\n      local p = (x0 - s) % 360\n      if p < 45 then\n        if s + p <= a then a = math.max(a, s + p + w) else bb = math.min(bb, s + p) end\n      end\n      if p + w > 360 then a = math.max(a, s + p + w - 360) end\n    end\n    if bb - a < (inner and 2 or 1.5) then return nil end\n    local t = (dir > 0) and bb or a\n    local lag = 999\n    for i = 1, 3 do\n      local g = (dir > 0) and ((arcs[i][1] - t) % 360) or ((t - arcs[i][2]) % 360)\n      if g < lag then lag = g end\n    end\n    if lag > 180 then lag = 0 end\n    local x, z = Z.pt(100, 100, t, inner and 5.5 or 10)\n    return {u = u, ang = t, inner = inner, lag = lag, x = x, z = z}\n  end\n  local N, INF = 15, 1e9\n  local nodes, best, nxt = {}, {}, {}\n  for n = 0, N - 1 do\n    nodes[n], best[n], nxt[n] = {}, {}, {}\n    for u = 0, 15 do nodes[n][u] = node(n, u) end\n  end\n  local function ncost(q)\n    local c = q.lag / 10 + (q.inner and 0 or 0.3)\n    if red[q.u] then c = c + 25 end\n    return c\n  end\n  for u = 0, 15 do\n    local q = nodes[N - 1][u]\n    best[N - 1][u] = q and ncost(q) or INF\n  end\n  for n = N - 2, 0, -1 do\n    for u = 0, 15 do\n      local q = nodes[n][u]\n      local bc, bv = INF, nil\n      if q then\n        local k = u % 8\n        local base = (u < 8) and 0 or 8\n        local cand = {u, base + (k + 7) % 8, base + (k + 1) % 8, (u < 8) and (u + 8) or (u - 8)}\n        for j = 1, 4 do\n          local v = cand[j]\n          local w = nodes[n + 1][v]\n          if w and best[n + 1][v] < INF then\n            local dx, dz = q.x - w.x, q.z - w.z\n            local dist = math.sqrt(dx * dx + dz * dz)\n            local okm = dist <= 6.5\n            local tc = 0\n            if v ~= u then\n              tc = (v % 8 == k) and 1.5 or 0.5\n              if math.abs((q.ang - w.ang + 540) % 360 - 180) > 30 then okm = false end\n            end\n            if dist > 4 then tc = tc + dist - 4 end\n            if okm and tc + best[n + 1][v] < bc then bc, bv = tc + best[n + 1][v], v end\n          end\n        end\n      end\n      if bv then\n        best[n][u] = ncost(q) + bc\n        nxt[n][u] = bv\n      else\n        best[n][u] = INF\n      end\n    end\n  end\n  local u0, c0 = nil, INF\n  for u = 0, 15 do\n    local c = best[0][u] + ((u < 8) and 0 or 0.5)\n    if c < c0 then u0, c0 = u, c end\n  end\n  if not u0 then\n    b.planFail = true\n    return\n  end\n  local plan = {dir = dir, cones = cones, useT = useT, red = red}\n  local u = u0\n  for n = 0, N - 1 do\n    local q = u and nodes[n][u]\n    if not q then break end\n    plan[n] = q\n    u = nxt[n][u]\n  end\n  b.plan = plan\n  local q0 = plan[0]\n  if q0 and b.saidU ~= q0.u then\n    b.saidU = q0.u\n    hush(7000, \"THUNDER II: rotates \" .. ((dir > 0) and \"CLOCKWISE\" or \"COUNTER-CLOCKWISE\") .. \" - start \" ..\n      Z.dirName(q0.ang) .. (q0.inner and \" inner\" or \" outer\") .. \", follow the arrow\", 0xFF00FFFF)\n  end\nend\nlocal plan = b.plan\nif not plan then return end\n-- phase = next snapshot index: counted casts, or time since the first hit when a cast event was missed\nlocal n = b.k or 0\nlocal T0 = b.T0 or (b.chanT and (b.chanT + 5540))\nif T0 and now > T0 + 300 then\n  local nt = math.floor((now - T0 - 300) / 1007) + 1\n  if nt > n then n = nt end\nend\nif n > 14 then return end\n-- before the first hit: if the floor changed after planning, plan again next frame\nif n == 0 and Z.tilesKnown and type(Z.tileT) == \"table\" then\n  local nw = 0\n  for t = 0, 15 do\n    local tt = Z.tileT[t]\n    if tt and tt > nw then nw = tt end\n  end\n  if nw > (b.planNewest or 0) + 50 then\n    b.plan = nil\n    return\n  end\nend\nlocal q = plan[n]\nif not q then return end\nZ.goTo(q.x, q.z, 0x33FF33, 0.7)\nlocal p = TensorCore.mGetPlayer()\nlocal y = (p and p.pos) and p.pos.y or 0\nlocal q2 = plan[n + 1]\nif q2 then\n  TensorCore.getCachedDrawer(0x4400FFFF, 0x6600FFFF, 0x9900FFFF, 0xFF00FFFF, 1.5):addCircle(q2.x, y, q2.z, 0.45, false, Z.flags)\nend\n-- edges of the three cones that hit next\nlocal dl = TensorCore.getStaticDrawer(0xCC3333FF, 2)\nlocal cs = plan.cones\nfor i = 1, 3 do\n  local c = cs[i] + 10 * plan.dir * n\n  local xa, za = Z.pt(100, 100, c - 22.5, 2.5)\n  local xb, zb = Z.pt(100, 100, c - 22.5, 16)\n  dl:addLine(xa, y, za, xb, y, zb, 2)\n  xa, za = Z.pt(100, 100, c + 22.5, 2.5)\n  xb, zb = Z.pt(100, 100, c + 22.5, 16)\n  dl:addLine(xa, y, za, xb, y, zb, 2)\nend",
							name = "[Draw] Bloom 1 - Thunder II follow the rotation",
							uuid = "5ad6f725-292d-f1d0-9916-ea5bdf31c540",
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
				mechanicTime = 179.1,
				name = "[Draw] Bloom 1 - Thunder II follow the rotation",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = 15.5,
				timerStartOffset = -5.3,
				uuid = "cad5c238-65bc-ff57-a129-f1a652996289",
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
				name = "Role Draws",
				uuid = "78336ecc-455b-3845-95b9-0c8c353fe0e0",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nhush(6000, \"SPREAD anywhere, but NOT on a red (vine) tile when it goes off\", 0xFF00FFFF)\nself.used = true\n",
							name = "[Draw] Bloom 1 - spread callout",
							uuid = "61bd33cc-7f8d-7f1e-99d1-6577eb8fed81",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				mechanicTime = 198.9,
				name = "[Draw] Bloom 1 - spread callout",
				timeRange = true,
				timelineIndex = 29,
				timerEndOffset = -3,
				timerStartOffset = -4.3,
				uuid = "033b13dd-1aec-700f-bbbf-c0355c749871",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 1 Thunder III: per-slot spread spot on a plain (non-vine) tile, >= 5.2y from every other slot's spot\nlocal s = Z.slot()\nif not s then return end\nlocal now = Now()\n-- wait until the last Thunder II snapshot is out (15 steps) before pulling people off the rotation path\nlocal b0 = Z.b1\nif b0 and b0.t0 and now - b0.t0 < 45000 and (b0.k or 0) < 15 then\n  local T0 = b0.T0 or (b0.chanT and (b0.chanT + 5540))\n  if T0 and now - T0 < 14400 then return end\nend\nlocal c = Z.b1s\nif not (c and c.t and now - c.t < 12000) then\n  c = nil\n  local b = Z.b1\n  local plan = (b and b.t0 and now - b.t0 < 45000) and b.plan or nil\n  local dir = plan and plan.dir or ((b and b.t0 and now - b.t0 < 45000) and b.dir or nil)\n  local red, useT = {}, false\n  if plan and plan.red then\n    red, useT = plan.red, plan.useT\n  else\n    if Z.tilesKnown and type(Z.tiles) == \"table\" then\n      local nr, newest = 0, 0\n      for t = 0, 15 do\n        if Z.tiles[t] then nr = nr + 1 end\n        local tt = type(Z.tileT) == \"table\" and Z.tileT[t]\n        if tt and tt > newest then newest = tt end\n      end\n      useT = (nr >= 4 and nr <= 13 and now - newest < 45000)\n    end\n    if not dir and useT then\n      local cw = not (Z.tiles[2] or Z.tiles[3] or Z.tiles[4])\n      local ccw = not (Z.tiles[6] or Z.tiles[7] or Z.tiles[0])\n      if cw and not ccw then dir = 1 elseif ccw and not cw then dir = -1 end\n    end\n    if dir then\n      if useT then\n        for t = 0, 15 do red[t] = Z.tiles[t] and true or false end\n      else\n        local plain = (dir > 0) and {[2] = 1, [3] = 1, [4] = 1, [9] = 1, [10] = 1, [12] = 1}\n          or {[0] = 1, [3] = 1, [6] = 1, [7] = 1, [13] = 1, [14] = 1}\n        for t = 0, 15 do red[t] = not plain[t] end\n      end\n    end\n  end\n  if dir then\n    -- {angle clockwise from N, radius}: the spots this PF used (CCW = marker 168, CW = marker 167)\n    local DES = (dir > 0) and {T1 = {103, 4.5}, T2 = {62, 12.0}, H1 = {219, 14.8}, H2 = {203, 10.0},\n        M1 = {211, 4.8}, M2 = {157, 6.5}, R1 = {116, 12.5}, R2 = {192, 15.0}}\n      or {T1 = {33, 5.5}, T2 = {152, 6.0}, H1 = {230, 14.8}, H2 = {308, 14.5},\n        M1 = {232, 9.5}, M2 = {299, 5.5}, R1 = {277, 14.5}, R2 = {254, 13.2}}\n    local function good(x, z)\n      local dx, dz = x - 100, z - 100\n      local r = math.sqrt(dx * dx + dz * dz)\n      if r < 3 or r > 15.3 then return false end\n      local ang = math.deg(math.atan2(dx, -dz)) % 360\n      local k = math.floor(ang / 45) % 8\n      local base = (r <= 8) and 0 or 8\n      local t = base + k\n      if red[t] then return false end\n      local rel = ang - 45 * k\n      if red[base + (k + 7) % 8] and math.rad(rel) * r < 0.9 then return false end\n      if red[base + (k + 1) % 8] and math.rad(45 - rel) * r < 0.9 then return false end\n      if base == 0 and red[t + 8] and 8 - r < 0.9 then return false end\n      if base == 8 and red[t - 8] and r - 8 < 0.9 then return false end\n      return true\n    end\n    local placed = {}\n    local function free(x, z)\n      for i = 1, #placed do\n        local dx, dz = placed[i][1] - x, placed[i][2] - z\n        if dx * dx + dz * dz < 27.04 then return false end\n      end\n      return true\n    end\n    local sp = {}\n    local ORDER = {\"T1\", \"T2\", \"H1\", \"H2\", \"M1\", \"M2\", \"R1\", \"R2\"}\n    for i = 1, 8 do\n      local sl = ORDER[i]\n      local d = DES[sl]\n      local x, z = Z.pt(100, 100, d[1], d[2])\n      if not (good(x, z) and free(x, z)) then\n        local bx, bz, bd\n        for t = 0, 15 do\n          if not red[t] then\n            local ca = 22.5 + 45 * (t % 8)\n            local rs = (t < 8) and {4.8, 6.6} or {9.6, 12.4, 15.0}\n            for j = 1, #rs do\n              for da = -14, 14, 7 do\n                local cx, cz = Z.pt(100, 100, ca + da, rs[j])\n                if good(cx, cz) and free(cx, cz) then\n                  local dd = (cx - x) * (cx - x) + (cz - z) * (cz - z)\n                  if not bd or dd < bd then bx, bz, bd = cx, cz, dd end\n                end\n              end\n            end\n          end\n        end\n        if bx then x, z = bx, bz end\n      end\n      sp[sl] = {x, z}\n      placed[#placed + 1] = {x, z}\n    end\n    c = {t = now, sp = sp, dir = dir, useT = useT}\n    Z.b1s = c\n  end\nend\nif not c then return end\nlocal q = c.sp[s]\nif q then Z.goTo(q[1], q[2], 0xFF66FF, 0.8) end",
							name = "[Draw] Bloom 1 - Thunder III your spread spot",
							uuid = "b4e2030a-d9c3-f7ab-9d0d-da1bcb935a56",
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
				mechanicTime = 198.9,
				name = "[Draw] Bloom 1 - Thunder III your spread spot",
				timeRange = true,
				timelineIndex = 29,
				timerEndOffset = 1.2,
				timerStartOffset = -5.3,
				uuid = "9916fca7-fbdc-4e15-ace7-882c1d9b2fe9",
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
				name = "VPR Optimization",
				uuid = "f7ebdfe4-8c28-9842-8da0-a83a4d858fff",
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
							actionID = 7549,
							conditions = 
							{
								
								{
									"582b36b2-914a-6437-9796-14a7fd284a39",
									true,
								},
								
								{
									"2ec40ae8-2d78-4b47-a911-dce8ef45edd9",
									true,
								},
								
								{
									"a4540ca0-344f-363c-88f4-911e8761aee6",
									true,
								},
								
								{
									"93b2d573-a2d2-9330-8e87-809445e31de3",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Enemy",
							uuid = "8192f3b4-f63d-d0d0-a9ed-f53e1ded6dfd",
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
							uuid = "582b36b2-914a-6437-9796-14a7fd284a39",
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
							uuid = "2ec40ae8-2d78-4b47-a911-dce8ef45edd9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "a4540ca0-344f-363c-88f4-911e8761aee6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "93b2d573-a2d2-9330-8e87-809445e31de3",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 207,
				name = "[VPR] Feint - Thorned Catharsis (207)",
				timeRange = true,
				timelineIndex = 30,
				timerEndOffset = -2,
				timerStartOffset = -6,
				uuid = "ad18dfb2-8117-bfd1-ab28-bb01be06c970",
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
				name = "Role Draws",
				uuid = "43791911-d696-34e7-af3f-f9ec1970778e",
			},
			objectType = "folder",
		},
	},
	[35] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "39133ad7-2917-2053-8eca-96db76b3ca46",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Thunder IV: which is safe first (43450 = OUT first, 43451 = IN first)\nlocal id = eventArgs and eventArgs.spellID\nif id == 43450 then Z.say(7000, \"OUT first: go to the side with 2 INNER safe tiles\", 0xFF00FFFF)\nelseif id == 43451 then Z.say(7000, \"IN first: go to the side with 2 OUTER safe tiles\", 0xFF00FFFF) end\nself.used = true\n",
							name = "[Draw] Bloom 2 - in/out first callout",
							uuid = "405a7104-9991-9af6-809c-654e0908a0d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 227.2,
				name = "[Draw] Bloom 2 - in/out first callout (old)",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = -5.8,
				timerStartOffset = -7.6,
				uuid = "33b25e3d-6225-7195-97a5-181b5cab9985",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 2 (Roseblood: 2nd Bloom): Thunder Slash cones + Alexandrian Thunder IV route =====\nif Z.b2V ~= 2 then\n  Z.b2V = 2\n  -- Thunder Slash hit order, deg clockwise from N (same in all 9 logged pulls; one cone per second)\n  Z.B2_CONES = {0, 180, 60, 240, 120, 300}\n  -- seconds after the 1st Thunder IV channel start until hit k resolves (T4 #1 = hit 1, T4 #2 = hit 4)\n  Z.B2_HIT = {6.72, 7.64, 8.63, 9.63, 10.64, 11.60}\n  -- side sectors k (inner tile k, outer tile k+8): E = 1 ENE / 2 ESE, W = 5 WSW / 6 WNW\n  Z.B2_SIDE = {E = {1, 2}, W = {5, 6}}\n  Z.B2_NAME = {[1] = \"ENE\", [2] = \"ESE\", [5] = \"WSW\", [6] = \"WNW\"}\n  -- standing spot of sector k: \"IN\" = tile centre angle, r 6; \"OUT\" = 13 deg off the E/W line, r 10\n  function Z.b2Spot(k, ring)\n    local c = 22.5 + 45 * k\n    if ring == \"OUT\" then\n      if k == 1 or k == 2 then return (c > 90) and 103 or 77, 10.0 end\n      if k == 5 or k == 6 then return (c > 270) and 283 or 257, 10.0 end\n      return c, 12.0\n    end\n    return c, 6.0\n  end\n  -- index (1..6) of the cone whose direction is within 30 deg of angle a\n  function Z.b2ConeIdx(cs, a)\n    local best, bd = nil, 31\n    for i = 1, #cs do\n      local d = math.abs((a - cs[i] + 180) % 360 - 180)\n      if d < bd then best, bd = i, d end\n    end\n    return best\n  end\n  -- per-pull state (t0 = first Thunder IV / cone channel seen)\n  function Z.b2New()\n    local now = Now()\n    local b = Z.b2\n    if not (b and b.t0) or now - b.t0 > 20000 then\n      b = {t0 = now, cones = {}, cid = {}, nc = 0, n4 = 0, hc = {}, h4 = {}}\n      Z.b2 = b\n    end\n    return b\n  end\n  -- has hit k resolved? counted cast events (never earlier than 0.6 s before the expected time), else time fallback\n  function Z.b2Res(b, k, el)\n    local H = Z.B2_HIT[k]\n    if not H then return true end\n    local n = b.nc or 0\n    local n4 = b.n4 or 0\n    if (k == 1 and n4 >= 1) or (k == 4 and n4 >= 2) then n = math.max(n, k) end\n    return (n >= k and el > H - 0.6) or el > H + 0.4\n  end\n  -- route from the floor + first safe ring. force = \"E\"/\"W\" builds the route for that side without the floor.\n  -- returns {side, r1, r2, p1k, late, early, iE, iL, known} or nil\n  function Z.b2Route(b, force)\n    if not (b and b.first) then return nil end\n    local r1 = b.first\n    local r2 = (r1 == \"OUT\") and \"IN\" or \"OUT\"\n    local o1 = (r1 == \"OUT\") and 8 or 0\n    local o2 = 8 - o1\n    local side, p1k\n    if force then\n      side = force\n      p1k = (force == \"E\") and 2 or 5\n    else\n      local T = Z.tiles\n      local other\n      if not (Z.tilesKnown and T) then return nil end\n      -- Hector: OUT first -> side with 2 INNER safe (1 outer safe); IN first -> side with 2 OUTER safe (1 inner safe)\n      for s, ks in pairs(Z.B2_SIDE) do\n        local n1, n2, k1 = 0, 0, nil\n        for i = 1, 2 do\n          local k = ks[i]\n          if not T[o1 + k] then n1 = n1 + 1; k1 = k end\n          if not T[o2 + k] then n2 = n2 + 1 end\n        end\n        if n1 == 1 and n2 == 2 then\n          if side then return nil end\n          side, p1k = s, k1\n        elseif n1 == 2 and n2 == 1 then\n          -- the other side: 2 safe in the 1st ring, 1 safe in the 2nd ring (Hector: 3 safe tiles per side)\n          other = (other or 0) + 1\n        end\n      end\n      -- both sides must match the pattern, else the floor reading is stale/incomplete -> fallback\n      if not side or other ~= 1 then return nil end\n    end\n    local ks = Z.B2_SIDE[side]\n    if not (ks and p1k) then return nil end\n    local cs = (b.cones and #b.cones == 6) and b.cones or Z.B2_CONES\n    local iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    if not (iA and iB) or iA == iB then\n      cs = Z.B2_CONES\n      iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    end\n    if not (iA and iB) or Z.b2ConeIdx(cs, 22.5 + 45 * p1k) == 1 then return nil end\n    local R = {side = side, r1 = r1, r2 = r2, p1k = p1k, known = not force}\n    if iA < iB then\n      R.early, R.late, R.iE, R.iL = ks[1], ks[2], iA, iB\n    else\n      R.early, R.late, R.iE, R.iL = ks[2], ks[1], iB, iA\n    end\n    return R\n  end\n  function Z.b2Text(R)\n    local N = Z.B2_NAME\n    return string.format(\"%s first > %s: %s %s, then %s %s, then %s %s\", R.r1, (R.side == \"E\") and \"EAST\" or \"WEST\",\n      R.r1, N[R.p1k] or \"?\", R.r2, N[R.late] or \"?\", R.r2, N[R.early] or \"?\")\n  end\nend\n-- [Draw] Bloom 2 - Thunder IV first + route callout | timeline_index 35 | OnEntityChannel | window -7.8..-5.0\n-- 43450 circle = OUT safe first, 43451 donut = IN safe first; boss visual 43448 / 43449 = same info (backup)\nlocal id = eventArgs and eventArgs.spellID\nif id == 43450 or id == 43451 or id == 43448 or id == 43449 then\n  local now = Now()\n  local f = (id == 43450 or id == 43448) and \"OUT\" or \"IN\"\n  local b\n  if Z.b2New then\n    b = Z.b2New()\n    if id == 43450 or id == 43451 then\n      b.first, b.byT4 = f, true\n    elseif not b.byT4 then\n      b.first = f\n    end\n    b.rT, b.route, b.fr = nil, nil, nil\n  end\n  if not (Z.b2SayT and now - Z.b2SayT < 20000) then\n    Z.b2SayT = now\n    local R = b and Z.b2Route and Z.b2Route(b)\n    if R and Z.b2Text then\n      b.said = R.side\n      hush(7000, Z.b2Text(R), 0xFF00FFFF)\n    elseif f == \"OUT\" then\n      hush(7000, \"OUT first: go to the side with 2 INNER safe tiles\", 0xFF00FFFF)\n    else\n      hush(7000, \"IN first: go to the side with 2 OUTER safe tiles\", 0xFF00FFFF)\n    end\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 2 - Thunder IV first + route callout",
							uuid = "5ec49dcd-b97f-f0af-991b-2e4ac1f8d248",
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
				mechanicTime = 227.2,
				name = "[Draw] Bloom 2 - Thunder IV first + route callout",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = -5,
				timerStartOffset = -7.8,
				uuid = "b697ff24-fa39-f0fc-8551-8c461a1f93d7",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 2 (Roseblood: 2nd Bloom): Thunder Slash cones + Alexandrian Thunder IV route =====\nif Z.b2V ~= 2 then\n  Z.b2V = 2\n  -- Thunder Slash hit order, deg clockwise from N (same in all 9 logged pulls; one cone per second)\n  Z.B2_CONES = {0, 180, 60, 240, 120, 300}\n  -- seconds after the 1st Thunder IV channel start until hit k resolves (T4 #1 = hit 1, T4 #2 = hit 4)\n  Z.B2_HIT = {6.72, 7.64, 8.63, 9.63, 10.64, 11.60}\n  -- side sectors k (inner tile k, outer tile k+8): E = 1 ENE / 2 ESE, W = 5 WSW / 6 WNW\n  Z.B2_SIDE = {E = {1, 2}, W = {5, 6}}\n  Z.B2_NAME = {[1] = \"ENE\", [2] = \"ESE\", [5] = \"WSW\", [6] = \"WNW\"}\n  -- standing spot of sector k: \"IN\" = tile centre angle, r 6; \"OUT\" = 13 deg off the E/W line, r 10\n  function Z.b2Spot(k, ring)\n    local c = 22.5 + 45 * k\n    if ring == \"OUT\" then\n      if k == 1 or k == 2 then return (c > 90) and 103 or 77, 10.0 end\n      if k == 5 or k == 6 then return (c > 270) and 283 or 257, 10.0 end\n      return c, 12.0\n    end\n    return c, 6.0\n  end\n  -- index (1..6) of the cone whose direction is within 30 deg of angle a\n  function Z.b2ConeIdx(cs, a)\n    local best, bd = nil, 31\n    for i = 1, #cs do\n      local d = math.abs((a - cs[i] + 180) % 360 - 180)\n      if d < bd then best, bd = i, d end\n    end\n    return best\n  end\n  -- per-pull state (t0 = first Thunder IV / cone channel seen)\n  function Z.b2New()\n    local now = Now()\n    local b = Z.b2\n    if not (b and b.t0) or now - b.t0 > 20000 then\n      b = {t0 = now, cones = {}, cid = {}, nc = 0, n4 = 0, hc = {}, h4 = {}}\n      Z.b2 = b\n    end\n    return b\n  end\n  -- has hit k resolved? counted cast events (never earlier than 0.6 s before the expected time), else time fallback\n  function Z.b2Res(b, k, el)\n    local H = Z.B2_HIT[k]\n    if not H then return true end\n    local n = b.nc or 0\n    local n4 = b.n4 or 0\n    if (k == 1 and n4 >= 1) or (k == 4 and n4 >= 2) then n = math.max(n, k) end\n    return (n >= k and el > H - 0.6) or el > H + 0.4\n  end\n  -- route from the floor + first safe ring. force = \"E\"/\"W\" builds the route for that side without the floor.\n  -- returns {side, r1, r2, p1k, late, early, iE, iL, known} or nil\n  function Z.b2Route(b, force)\n    if not (b and b.first) then return nil end\n    local r1 = b.first\n    local r2 = (r1 == \"OUT\") and \"IN\" or \"OUT\"\n    local o1 = (r1 == \"OUT\") and 8 or 0\n    local o2 = 8 - o1\n    local side, p1k\n    if force then\n      side = force\n      p1k = (force == \"E\") and 2 or 5\n    else\n      local T = Z.tiles\n      local other\n      if not (Z.tilesKnown and T) then return nil end\n      -- Hector: OUT first -> side with 2 INNER safe (1 outer safe); IN first -> side with 2 OUTER safe (1 inner safe)\n      for s, ks in pairs(Z.B2_SIDE) do\n        local n1, n2, k1 = 0, 0, nil\n        for i = 1, 2 do\n          local k = ks[i]\n          if not T[o1 + k] then n1 = n1 + 1; k1 = k end\n          if not T[o2 + k] then n2 = n2 + 1 end\n        end\n        if n1 == 1 and n2 == 2 then\n          if side then return nil end\n          side, p1k = s, k1\n        elseif n1 == 2 and n2 == 1 then\n          -- the other side: 2 safe in the 1st ring, 1 safe in the 2nd ring (Hector: 3 safe tiles per side)\n          other = (other or 0) + 1\n        end\n      end\n      -- both sides must match the pattern, else the floor reading is stale/incomplete -> fallback\n      if not side or other ~= 1 then return nil end\n    end\n    local ks = Z.B2_SIDE[side]\n    if not (ks and p1k) then return nil end\n    local cs = (b.cones and #b.cones == 6) and b.cones or Z.B2_CONES\n    local iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    if not (iA and iB) or iA == iB then\n      cs = Z.B2_CONES\n      iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    end\n    if not (iA and iB) or Z.b2ConeIdx(cs, 22.5 + 45 * p1k) == 1 then return nil end\n    local R = {side = side, r1 = r1, r2 = r2, p1k = p1k, known = not force}\n    if iA < iB then\n      R.early, R.late, R.iE, R.iL = ks[1], ks[2], iA, iB\n    else\n      R.early, R.late, R.iE, R.iL = ks[2], ks[1], iB, iA\n    end\n    return R\n  end\n  function Z.b2Text(R)\n    local N = Z.B2_NAME\n    return string.format(\"%s first > %s: %s %s, then %s %s, then %s %s\", R.r1, (R.side == \"E\") and \"EAST\" or \"WEST\",\n      R.r1, N[R.p1k] or \"?\", R.r2, N[R.late] or \"?\", R.r2, N[R.early] or \"?\")\n  end\nend\n-- [Draw] Bloom 2 - Thunder Slash cone order | timeline_index 35 | OnEntityChannel | window -7.8..-1.0\n-- records the 6 cone directions in cast order (deg clockwise from N)\nlocal id = eventArgs and eventArgs.spellID\nif id == 43216 and Z.b2New then\n  local b = Z.b2New()\n  local eid = eventArgs.entityID\n  b.cid = b.cid or {}\n  b.cones = b.cones or {}\n  if eid and not b.cid[eid] and #b.cones < 6 then\n    local e = TensorCore.mGetEntity(eid)\n    if e and e.pos and e.pos.h then\n      b.cid[eid] = true\n      b.cones[#b.cones + 1] = (180 - math.deg(e.pos.h)) % 360\n      b.rT, b.fr = nil, nil\n    end\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 2 - Thunder Slash cone order",
							uuid = "34a9474b-c3aa-392b-b120-7a7aa76ffbc8",
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
				mechanicTime = 227.2,
				name = "[Draw] Bloom 2 - Thunder Slash cone order",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = -1,
				timerStartOffset = -7.8,
				uuid = "b8702989-196c-9786-974d-a15e5a78b4e2",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 2 (Roseblood: 2nd Bloom): Thunder Slash cones + Alexandrian Thunder IV route =====\nif Z.b2V ~= 2 then\n  Z.b2V = 2\n  -- Thunder Slash hit order, deg clockwise from N (same in all 9 logged pulls; one cone per second)\n  Z.B2_CONES = {0, 180, 60, 240, 120, 300}\n  -- seconds after the 1st Thunder IV channel start until hit k resolves (T4 #1 = hit 1, T4 #2 = hit 4)\n  Z.B2_HIT = {6.72, 7.64, 8.63, 9.63, 10.64, 11.60}\n  -- side sectors k (inner tile k, outer tile k+8): E = 1 ENE / 2 ESE, W = 5 WSW / 6 WNW\n  Z.B2_SIDE = {E = {1, 2}, W = {5, 6}}\n  Z.B2_NAME = {[1] = \"ENE\", [2] = \"ESE\", [5] = \"WSW\", [6] = \"WNW\"}\n  -- standing spot of sector k: \"IN\" = tile centre angle, r 6; \"OUT\" = 13 deg off the E/W line, r 10\n  function Z.b2Spot(k, ring)\n    local c = 22.5 + 45 * k\n    if ring == \"OUT\" then\n      if k == 1 or k == 2 then return (c > 90) and 103 or 77, 10.0 end\n      if k == 5 or k == 6 then return (c > 270) and 283 or 257, 10.0 end\n      return c, 12.0\n    end\n    return c, 6.0\n  end\n  -- index (1..6) of the cone whose direction is within 30 deg of angle a\n  function Z.b2ConeIdx(cs, a)\n    local best, bd = nil, 31\n    for i = 1, #cs do\n      local d = math.abs((a - cs[i] + 180) % 360 - 180)\n      if d < bd then best, bd = i, d end\n    end\n    return best\n  end\n  -- per-pull state (t0 = first Thunder IV / cone channel seen)\n  function Z.b2New()\n    local now = Now()\n    local b = Z.b2\n    if not (b and b.t0) or now - b.t0 > 20000 then\n      b = {t0 = now, cones = {}, cid = {}, nc = 0, n4 = 0, hc = {}, h4 = {}}\n      Z.b2 = b\n    end\n    return b\n  end\n  -- has hit k resolved? counted cast events (never earlier than 0.6 s before the expected time), else time fallback\n  function Z.b2Res(b, k, el)\n    local H = Z.B2_HIT[k]\n    if not H then return true end\n    local n = b.nc or 0\n    local n4 = b.n4 or 0\n    if (k == 1 and n4 >= 1) or (k == 4 and n4 >= 2) then n = math.max(n, k) end\n    return (n >= k and el > H - 0.6) or el > H + 0.4\n  end\n  -- route from the floor + first safe ring. force = \"E\"/\"W\" builds the route for that side without the floor.\n  -- returns {side, r1, r2, p1k, late, early, iE, iL, known} or nil\n  function Z.b2Route(b, force)\n    if not (b and b.first) then return nil end\n    local r1 = b.first\n    local r2 = (r1 == \"OUT\") and \"IN\" or \"OUT\"\n    local o1 = (r1 == \"OUT\") and 8 or 0\n    local o2 = 8 - o1\n    local side, p1k\n    if force then\n      side = force\n      p1k = (force == \"E\") and 2 or 5\n    else\n      local T = Z.tiles\n      local other\n      if not (Z.tilesKnown and T) then return nil end\n      -- Hector: OUT first -> side with 2 INNER safe (1 outer safe); IN first -> side with 2 OUTER safe (1 inner safe)\n      for s, ks in pairs(Z.B2_SIDE) do\n        local n1, n2, k1 = 0, 0, nil\n        for i = 1, 2 do\n          local k = ks[i]\n          if not T[o1 + k] then n1 = n1 + 1; k1 = k end\n          if not T[o2 + k] then n2 = n2 + 1 end\n        end\n        if n1 == 1 and n2 == 2 then\n          if side then return nil end\n          side, p1k = s, k1\n        elseif n1 == 2 and n2 == 1 then\n          -- the other side: 2 safe in the 1st ring, 1 safe in the 2nd ring (Hector: 3 safe tiles per side)\n          other = (other or 0) + 1\n        end\n      end\n      -- both sides must match the pattern, else the floor reading is stale/incomplete -> fallback\n      if not side or other ~= 1 then return nil end\n    end\n    local ks = Z.B2_SIDE[side]\n    if not (ks and p1k) then return nil end\n    local cs = (b.cones and #b.cones == 6) and b.cones or Z.B2_CONES\n    local iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    if not (iA and iB) or iA == iB then\n      cs = Z.B2_CONES\n      iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    end\n    if not (iA and iB) or Z.b2ConeIdx(cs, 22.5 + 45 * p1k) == 1 then return nil end\n    local R = {side = side, r1 = r1, r2 = r2, p1k = p1k, known = not force}\n    if iA < iB then\n      R.early, R.late, R.iE, R.iL = ks[1], ks[2], iA, iB\n    else\n      R.early, R.late, R.iE, R.iL = ks[2], ks[1], iB, iA\n    end\n    return R\n  end\n  function Z.b2Text(R)\n    local N = Z.B2_NAME\n    return string.format(\"%s first > %s: %s %s, then %s %s, then %s %s\", R.r1, (R.side == \"E\") and \"EAST\" or \"WEST\",\n      R.r1, N[R.p1k] or \"?\", R.r2, N[R.late] or \"?\", R.r2, N[R.early] or \"?\")\n  end\nend\n-- [Draw] Bloom 2 - hit tracker | timeline_index 35 | OnEntityCast | window -1.5..6.0\n-- counts resolved Thunder Slash cones (43216) and Thunder IV hits (43450/43451), once per helper\nlocal id = eventArgs and eventArgs.spellID\nlocal b = Z.b2\nif b and b.t0 and (id == 43216 or id == 43450 or id == 43451) then\n  local eid = eventArgs.entityID\n  if eid then\n    if id == 43216 then\n      b.hc = b.hc or {}\n      if not b.hc[eid] then\n        b.hc[eid] = true\n        b.nc = (b.nc or 0) + 1\n      end\n    else\n      b.h4 = b.h4 or {}\n      if not b.h4[eid] then\n        b.h4[eid] = true\n        b.n4 = (b.n4 or 0) + 1\n      end\n    end\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 2 - hit tracker",
							uuid = "5e3e093c-a5e0-c90b-b309-6c6cbaf0584e",
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
				mechanicTime = 227.2,
				name = "[Draw] Bloom 2 - hit tracker",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = 6,
				timerStartOffset = -1.5,
				uuid = "afd0ac10-70dd-6311-9a95-7a0333ae4425",
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
							actionLua = "-- [Draw] Bloom 2 - Thunder route arrows | OnFrame | -6.9..5.8 loop=True enabled=True\nlocal function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 2 (Roseblood: 2nd Bloom): Thunder Slash cones + Alexandrian Thunder IV route =====\nif Z.b2V ~= 2 then\n  Z.b2V = 2\n  -- Thunder Slash hit order, deg clockwise from N (same in all 9 logged pulls; one cone per second)\n  Z.B2_CONES = {0, 180, 60, 240, 120, 300}\n  -- seconds after the 1st Thunder IV channel start until hit k resolves (T4 #1 = hit 1, T4 #2 = hit 4)\n  Z.B2_HIT = {6.72, 7.64, 8.63, 9.63, 10.64, 11.60}\n  -- side sectors k (inner tile k, outer tile k+8): E = 1 ENE / 2 ESE, W = 5 WSW / 6 WNW\n  Z.B2_SIDE = {E = {1, 2}, W = {5, 6}}\n  Z.B2_NAME = {[1] = \"ENE\", [2] = \"ESE\", [5] = \"WSW\", [6] = \"WNW\"}\n  -- standing spot of sector k: \"IN\" = tile centre angle, r 6; \"OUT\" = 13 deg off the E/W line, r 10\n  function Z.b2Spot(k, ring)\n    local c = 22.5 + 45 * k\n    if ring == \"OUT\" then\n      if k == 1 or k == 2 then return (c > 90) and 103 or 77, 10.0 end\n      if k == 5 or k == 6 then return (c > 270) and 283 or 257, 10.0 end\n      return c, 12.0\n    end\n    return c, 6.0\n  end\n  -- index (1..6) of the cone whose direction is within 30 deg of angle a\n  function Z.b2ConeIdx(cs, a)\n    local best, bd = nil, 31\n    for i = 1, #cs do\n      local d = math.abs((a - cs[i] + 180) % 360 - 180)\n      if d < bd then best, bd = i, d end\n    end\n    return best\n  end\n  -- per-pull state (t0 = first Thunder IV / cone channel seen)\n  function Z.b2New()\n    local now = Now()\n    local b = Z.b2\n    if not (b and b.t0) or now - b.t0 > 20000 then\n      b = {t0 = now, cones = {}, cid = {}, nc = 0, n4 = 0, hc = {}, h4 = {}}\n      Z.b2 = b\n    end\n    return b\n  end\n  -- has hit k resolved? counted cast events (never earlier than 0.6 s before the expected time), else time fallback\n  function Z.b2Res(b, k, el)\n    local H = Z.B2_HIT[k]\n    if not H then return true end\n    local n = b.nc or 0\n    local n4 = b.n4 or 0\n    if (k == 1 and n4 >= 1) or (k == 4 and n4 >= 2) then n = math.max(n, k) end\n    return (n >= k and el > H - 0.6) or el > H + 0.4\n  end\n  -- route from the floor + first safe ring. force = \"E\"/\"W\" builds the route for that side without the floor.\n  -- returns {side, r1, r2, p1k, late, early, iE, iL, known} or nil\n  function Z.b2Route(b, force)\n    if not (b and b.first) then return nil end\n    local r1 = b.first\n    local r2 = (r1 == \"OUT\") and \"IN\" or \"OUT\"\n    local o1 = (r1 == \"OUT\") and 8 or 0\n    local o2 = 8 - o1\n    local side, p1k\n    if force then\n      side = force\n      p1k = (force == \"E\") and 2 or 5\n    else\n      local T = Z.tiles\n      local other\n      if not (Z.tilesKnown and T) then return nil end\n      -- Hector: OUT first -> side with 2 INNER safe (1 outer safe); IN first -> side with 2 OUTER safe (1 inner safe)\n      for s, ks in pairs(Z.B2_SIDE) do\n        local n1, n2, k1 = 0, 0, nil\n        for i = 1, 2 do\n          local k = ks[i]\n          if not T[o1 + k] then n1 = n1 + 1; k1 = k end\n          if not T[o2 + k] then n2 = n2 + 1 end\n        end\n        if n1 == 1 and n2 == 2 then\n          if side then return nil end\n          side, p1k = s, k1\n        elseif n1 == 2 and n2 == 1 then\n          -- the other side: 2 safe in the 1st ring, 1 safe in the 2nd ring (Hector: 3 safe tiles per side)\n          other = (other or 0) + 1\n        end\n      end\n      -- both sides must match the pattern, else the floor reading is stale/incomplete -> fallback\n      if not side or other ~= 1 then return nil end\n    end\n    local ks = Z.B2_SIDE[side]\n    if not (ks and p1k) then return nil end\n    local cs = (b.cones and #b.cones == 6) and b.cones or Z.B2_CONES\n    local iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    if not (iA and iB) or iA == iB then\n      cs = Z.B2_CONES\n      iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    end\n    if not (iA and iB) or Z.b2ConeIdx(cs, 22.5 + 45 * p1k) == 1 then return nil end\n    local R = {side = side, r1 = r1, r2 = r2, p1k = p1k, known = not force}\n    if iA < iB then\n      R.early, R.late, R.iE, R.iL = ks[1], ks[2], iA, iB\n    else\n      R.early, R.late, R.iE, R.iL = ks[2], ks[1], iB, iA\n    end\n    return R\n  end\n  function Z.b2Text(R)\n    local N = Z.B2_NAME\n    return string.format(\"%s first > %s: %s %s, then %s %s, then %s %s\", R.r1, (R.side == \"E\") and \"EAST\" or \"WEST\",\n      R.r1, N[R.p1k] or \"?\", R.r2, N[R.late] or \"?\", R.r2, N[R.early] or \"?\")\n  end\nend\n-- ===== Bloom 2 safe side v2 (cactbot 'ZeleniaEx Bloom 2' + BossMod Bloom2.cs): floor pattern + first Thunder IV =====\n-- Floor A = inner WNW red (also inner SSW, outer ENE, outer SSE). Floor B = inner ENE red (also inner SSE, outer WNW, outer SSW).\n-- IN first: A -> W, B -> E.  OUT first: A -> E, B -> W.\n-- The Bloom 2 floor never arrives as OnMapEffect, so it is read from the tiles' floor VFX render state.\n-- The read is trusted only when 4 tiles (inner ENE/WNW, outer ENE/WNW) match floor A or B exactly; otherwise the side stays unknown\n-- and the route arrows use the EAST fallback (ESE is never red on either floor; clean in all 44 logged pulls).\n-- The Bloom 1 pulse rule is gone (right in only 26/44 logged pulls).\nif Z.b2sV ~= 3 then\n  Z.b2sV = 3\n  Z.B2_USE_PULSE, Z.B2_POLL, Z.B2_POLL_TRUST = false, false, false\n  -- Floor read from each tile's floor VFX (map effect slot tile+4, subresource 0 = b358[67]mag01_y1.avfx):\n  -- render state 10 = plain tile, 11 = coloured tile (checked live 2026-11-07 on floor A: 10 on 1,2,5,10,13,14).\n  -- Argus.getCurrentMapEffects() returns an empty list in this arena, so the per-slot calls are used.\n  -- Floor A: inner WNW (6) and outer ENE (9) coloured, inner ENE (1) and outer WNW (14) plain. Floor B is the mirror.\n  function Z.b2TileRS(t)\n    local r = Argus.getMapEffectResource(t + 4)\n    if not r then return nil end\n    local s = Argus.getEffectSubresource(r, 0)\n    if not s then return nil end\n    local _, path = Argus.getEffectResourceInfo(s)\n    if type(path) ~= \"string\" or not path:find(\"mag01\", 1, true) then return nil end\n    local _, rs = Argus.getEffectResourceRenderInfo(s)\n    return rs\n  end\n  -- returns \"A\", \"B\" or nil. Throttled to 4 reads per second.\n  function Z.b2Floor()\n    local now = Now()\n    if Z.b2fT and now - Z.b2fT < 250 then return Z.b2fP end\n    Z.b2fT, Z.b2fP = now, nil\n    if not (Argus and Argus.getMapEffectResource and Argus.getEffectSubresource and Argus.getEffectResourceInfo\n      and Argus.getEffectResourceRenderInfo) then return nil end\n    local ok, rs = pcall(function()\n      local v = {}\n      for t = 0, 15 do v[t] = Z.b2TileRS(t) or -1 end\n      return v\n    end)\n    if not ok or type(rs) ~= \"table\" then return nil end\n    local got\n    if rs[6] == 11 and rs[9] == 11 and rs[1] == 10 and rs[14] == 10 then got = \"A\"\n    elseif rs[1] == 11 and rs[14] == 11 and rs[6] == 10 and rs[9] == 10 then got = \"B\" end\n    Z.b2fP = got\n    -- keep the last readings for checking after a pull (read with execute_lua)\n    local parts = {}\n    for t = 0, 15 do parts[#parts + 1] = tostring(rs[t]) end\n    local line = string.format(\"%.1f %s %s\", (Z.b2 and Z.b2.t0) and (now - Z.b2.t0) / 1000 or -1, got or \"-\", table.concat(parts, \",\"))\n    Z.b2fLog = Z.b2fLog or {}\n    if Z.b2fLast ~= line then\n      Z.b2fLast = line\n      Z.b2fLog[#Z.b2fLog + 1] = line\n      if #Z.b2fLog > 40 then table.remove(Z.b2fLog, 1) end\n    end\n    return got\n  end\n  function Z.b2Pattern(b)\n    if not (b and b.t0) then return nil end\n    return Z.b2Floor()\n  end\n  -- \"E\" (waymark B) / \"W\" (waymark D) or nil (floor not read)\n  function Z.b2Side(b)\n    if not (b and (b.first == \"IN\" or b.first == \"OUT\")) then return nil end\n    local pat = Z.b2Pattern(b)\n    if not pat then return nil end\n    if b.first == \"IN\" then return (pat == \"A\") and \"W\" or \"E\" end\n    return (pat == \"A\") and \"E\" or \"W\"\n  end\n  -- EAST fallback route when the floor is unknown: ESE first ring -> ESE other ring, hold it through the 2nd Thunder IV\n  -- (hit 4; ENE of the other ring can be red), then ENE before the 120 cone (hit 5).\n  function Z.b2Fallback(b)\n    local R = Z.b2RouteRaw and Z.b2RouteRaw(b, \"E\")\n    if not R then return nil end\n    local F = {}\n    for k, v in pairs(R) do F[k] = v end\n    F.iE = math.max(F.iE or 4, 4)\n    F.known, F.fb = true, true\n    return F\n  end\n  -- floor-only routes (callout text, route arrows) count only when they agree with b2Side\n  Z.b2RouteRaw = Z.b2RouteRaw or Z.b2Route\n  function Z.b2Route(b, force)\n    local R = Z.b2RouteRaw and Z.b2RouteRaw(b, force)\n    if R and not force and R.side ~= Z.b2Side(b) then return nil end\n    return R\n  end\nend\n-- [Draw] Bloom 2 - Thunder route arrows | timeline_index 35 | OnFrame | window -6.9..5.8\n-- whole party: 1st spot (ring safe from the 1st Thunder IV) -> after hit 1 change ring (late-cone half)\n-- -> after the early cone of your side, slide to the other half. Green = IN spot, orange = OUT spot.\nlocal b = Z.b2\nif not (b and b.first and b.t0 and Z.b2Route and Z.b2Spot and Z.b2Res) then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal now = Now()\nlocal el = (now - b.t0) / 1000\nif el < 0 or el > 13 then return end\nlocal px, py, pz = p.pos.x, p.pos.y, p.pos.z\nlocal dx, dz = px - 100, pz - 100\nlocal h1 = Z.b2Res(b, 1, el)\nlocal R = b.lock\nif not R then\n  if not b.rT or now - b.rT > 250 then\n    b.route = Z.b2Route(b)\n    b.rT, b.fr = now, nil\n  end\n  R = b.route\n  -- safe side from floor pattern + 1st Thunder IV (same decision as the safe side arrow); never the side you stand on\n  if Z.b2Side and (not b.sT or now - b.sT > 200) then b.sT, b.side = now, Z.b2Side(b) end\n  local s = b.side\n  if s and not (R and R.side == s) then\n    b.fr = b.fr or {}\n    R = b.fr[s] or Z.b2Route(b, s)\n    if R then R.known = true end\n    b.fr[s] = R\n  end\n  -- floor unknown: EAST fallback route (hold ESE through the 2nd Thunder IV)\n  if not s and not R and Z.b2Fallback then\n    b.fbR = b.fbR or Z.b2Fallback(b)\n    R = b.fbR\n  end\n  if R and not h1 and b.said ~= R.side and Z.b2Text then\n    b.said = R.side\n    hush(5000, Z.b2Text(R), 0xFF00FFFF)\n  end\n  if h1 and R then b.lock = R end\nend\nif not R then\n  -- floor not read and you are in the middle: show both possible first spots\n  if h1 then return end\n  local g = TensorCore.getStaticDrawer(0xFF00FFFF, 2)\n  local a, r = Z.b2Spot(2, b.first)\n  local x, z = Z.pt(100, 100, a, r)\n  g:addCircle(x, py, z, 1.0, false, Z.flags)\n  a, r = Z.b2Spot(5, b.first)\n  x, z = Z.pt(100, 100, a, r)\n  g:addCircle(x, py, z, 1.0, false, Z.flags)\n  return\nend\nlocal tk, tr, nk, nr, wp\nif not h1 then\n  tk, tr, nk, nr = R.p1k, R.r1, R.late, R.r2\nelseif not Z.b2Res(b, R.iE, el) then\n  -- no preview of the next half here: in the logs people stepped into it before its cone went off\n  tk, tr = R.late, R.r2\n  wp = (R.p1k ~= R.late)\nelseif not Z.b2Res(b, R.iL, el) then\n  tk, tr = R.early, R.r2\nelse\n  return\nend\nlocal a, r = Z.b2Spot(tk, tr)\nlocal tx, tz = Z.pt(100, 100, a, r)\nlocal gx, gz = tx, tz\nlocal pr = math.sqrt(dx * dx + dz * dz)\nlocal pa = math.deg(math.atan2(dx, -dz)) % 360\nif wp then\n  -- still in the first ring: go straight in/out inside your half first (the other half of that ring is red)\n  local inR2 = (R.r2 == \"IN\" and pr <= 7.0) or (R.r2 == \"OUT\" and pr >= 9.0)\n  if not inR2 then\n    local lo, hi = 45 * R.p1k + 8, 45 * R.p1k + 37\n    local wa = pa\n    if wa < lo then wa = lo elseif wa > hi then wa = hi end\n    local _, wr = Z.b2Spot(R.p1k, R.r2)\n    gx, gz = Z.pt(100, 100, wa, wr)\n  end\nelseif not h1 and pr > 3.5 then\n  -- going to the first spot: do not cut through the middle\n  local ex, ez = tx - px, tz - pz\n  local L2 = ex * ex + ez * ez\n  if L2 > 1 then\n    local t = -(dx * ex + dz * ez) / L2\n    if t > 0 and t < 1 then\n      local cx, cz = dx + t * ex, dz + t * ez\n      if cx * cx + cz * cz < 9 then\n        local d = (a - pa + 180) % 360 - 180\n        gx, gz = Z.pt(100, 100, pa + d / 2, 6)\n      end\n    end\n  end\nend\nZ.goTo(gx, gz, (tr == \"IN\") and 0x33FF33 or 0x0099FF, 0.9)\nif gx ~= tx or gz ~= tz then\n  TensorCore.getStaticDrawer(0xCCFFFFFF, 2):addCircle(tx, py, tz, 0.9, false, Z.flags)\nelseif nk then\n  local na, nr2 = Z.b2Spot(nk, nr)\n  local qx, qz = Z.pt(100, 100, na, nr2)\n  TensorCore.getStaticDrawer(0x88FFFFFF, 2):addCircle(qx, py, qz, 0.6, false, Z.flags)\nend\nif not R.known then\n  -- floor not read: route for the side you are on - check the red tiles yourself\n  local yd = TensorCore.getStaticDrawer(0xFF00FFFF, 2)\n  yd:addCircle(tx, py, tz, 1.6, false, Z.flags)\n  if not h1 then\n    local oa, orr = Z.b2Spot((R.side == \"E\") and 5 or 2, R.r1)\n    local ox, oz = Z.pt(100, 100, oa, orr)\n    yd:addCircle(ox, py, oz, 1.0, false, Z.flags)\n  end\nend\n",
							name = "[Draw] Bloom 2 - Thunder route arrows",
							uuid = "cf1e68e3-b956-4293-a5c1-6a393c71abe4",
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
				mechanicTime = 227.2,
				name = "[Draw] Bloom 2 - Thunder route arrows",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = 5.8,
				timerStartOffset = -6.9,
				uuid = "ef5ac899-0276-6905-b207-fb6af3322681",
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
							actionLua = "-- [Draw] Bloom 2 - safe side arrow | OnFrame | -6.9..0.6 loop=True enabled=True\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 2 (Roseblood: 2nd Bloom): Thunder Slash cones + Alexandrian Thunder IV route =====\nif Z.b2V ~= 2 then\n  Z.b2V = 2\n  -- Thunder Slash hit order, deg clockwise from N (same in all 9 logged pulls; one cone per second)\n  Z.B2_CONES = {0, 180, 60, 240, 120, 300}\n  -- seconds after the 1st Thunder IV channel start until hit k resolves (T4 #1 = hit 1, T4 #2 = hit 4)\n  Z.B2_HIT = {6.72, 7.64, 8.63, 9.63, 10.64, 11.60}\n  -- side sectors k (inner tile k, outer tile k+8): E = 1 ENE / 2 ESE, W = 5 WSW / 6 WNW\n  Z.B2_SIDE = {E = {1, 2}, W = {5, 6}}\n  Z.B2_NAME = {[1] = \"ENE\", [2] = \"ESE\", [5] = \"WSW\", [6] = \"WNW\"}\n  -- standing spot of sector k: \"IN\" = tile centre angle, r 6; \"OUT\" = 13 deg off the E/W line, r 10\n  function Z.b2Spot(k, ring)\n    local c = 22.5 + 45 * k\n    if ring == \"OUT\" then\n      if k == 1 or k == 2 then return (c > 90) and 103 or 77, 10.0 end\n      if k == 5 or k == 6 then return (c > 270) and 283 or 257, 10.0 end\n      return c, 12.0\n    end\n    return c, 6.0\n  end\n  -- index (1..6) of the cone whose direction is within 30 deg of angle a\n  function Z.b2ConeIdx(cs, a)\n    local best, bd = nil, 31\n    for i = 1, #cs do\n      local d = math.abs((a - cs[i] + 180) % 360 - 180)\n      if d < bd then best, bd = i, d end\n    end\n    return best\n  end\n  -- per-pull state (t0 = first Thunder IV / cone channel seen)\n  function Z.b2New()\n    local now = Now()\n    local b = Z.b2\n    if not (b and b.t0) or now - b.t0 > 20000 then\n      b = {t0 = now, cones = {}, cid = {}, nc = 0, n4 = 0, hc = {}, h4 = {}}\n      Z.b2 = b\n    end\n    return b\n  end\n  -- has hit k resolved? counted cast events (never earlier than 0.6 s before the expected time), else time fallback\n  function Z.b2Res(b, k, el)\n    local H = Z.B2_HIT[k]\n    if not H then return true end\n    local n = b.nc or 0\n    local n4 = b.n4 or 0\n    if (k == 1 and n4 >= 1) or (k == 4 and n4 >= 2) then n = math.max(n, k) end\n    return (n >= k and el > H - 0.6) or el > H + 0.4\n  end\n  -- route from the floor + first safe ring. force = \"E\"/\"W\" builds the route for that side without the floor.\n  -- returns {side, r1, r2, p1k, late, early, iE, iL, known} or nil\n  function Z.b2Route(b, force)\n    if not (b and b.first) then return nil end\n    local r1 = b.first\n    local r2 = (r1 == \"OUT\") and \"IN\" or \"OUT\"\n    local o1 = (r1 == \"OUT\") and 8 or 0\n    local o2 = 8 - o1\n    local side, p1k\n    if force then\n      side = force\n      p1k = (force == \"E\") and 2 or 5\n    else\n      local T = Z.tiles\n      local other\n      if not (Z.tilesKnown and T) then return nil end\n      -- Hector: OUT first -> side with 2 INNER safe (1 outer safe); IN first -> side with 2 OUTER safe (1 inner safe)\n      for s, ks in pairs(Z.B2_SIDE) do\n        local n1, n2, k1 = 0, 0, nil\n        for i = 1, 2 do\n          local k = ks[i]\n          if not T[o1 + k] then n1 = n1 + 1; k1 = k end\n          if not T[o2 + k] then n2 = n2 + 1 end\n        end\n        if n1 == 1 and n2 == 2 then\n          if side then return nil end\n          side, p1k = s, k1\n        elseif n1 == 2 and n2 == 1 then\n          -- the other side: 2 safe in the 1st ring, 1 safe in the 2nd ring (Hector: 3 safe tiles per side)\n          other = (other or 0) + 1\n        end\n      end\n      -- both sides must match the pattern, else the floor reading is stale/incomplete -> fallback\n      if not side or other ~= 1 then return nil end\n    end\n    local ks = Z.B2_SIDE[side]\n    if not (ks and p1k) then return nil end\n    local cs = (b.cones and #b.cones == 6) and b.cones or Z.B2_CONES\n    local iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    if not (iA and iB) or iA == iB then\n      cs = Z.B2_CONES\n      iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])\n    end\n    if not (iA and iB) or Z.b2ConeIdx(cs, 22.5 + 45 * p1k) == 1 then return nil end\n    local R = {side = side, r1 = r1, r2 = r2, p1k = p1k, known = not force}\n    if iA < iB then\n      R.early, R.late, R.iE, R.iL = ks[1], ks[2], iA, iB\n    else\n      R.early, R.late, R.iE, R.iL = ks[2], ks[1], iB, iA\n    end\n    return R\n  end\n  function Z.b2Text(R)\n    local N = Z.B2_NAME\n    return string.format(\"%s first > %s: %s %s, then %s %s, then %s %s\", R.r1, (R.side == \"E\") and \"EAST\" or \"WEST\",\n      R.r1, N[R.p1k] or \"?\", R.r2, N[R.late] or \"?\", R.r2, N[R.early] or \"?\")\n  end\nend\n-- ===== Bloom 2 safe side v2 (cactbot 'ZeleniaEx Bloom 2' + BossMod Bloom2.cs): floor pattern + first Thunder IV =====\n-- Floor A = inner WNW red (also inner SSW, outer ENE, outer SSE). Floor B = inner ENE red (also inner SSE, outer WNW, outer SSW).\n-- IN first: A -> W, B -> E.  OUT first: A -> E, B -> W.\n-- The Bloom 2 floor never arrives as OnMapEffect, so it is read from the tiles' floor VFX render state.\n-- The read is trusted only when 4 tiles (inner ENE/WNW, outer ENE/WNW) match floor A or B exactly; otherwise the side stays unknown\n-- and the route arrows use the EAST fallback (ESE is never red on either floor; clean in all 44 logged pulls).\n-- The Bloom 1 pulse rule is gone (right in only 26/44 logged pulls).\nif Z.b2sV ~= 3 then\n  Z.b2sV = 3\n  Z.B2_USE_PULSE, Z.B2_POLL, Z.B2_POLL_TRUST = false, false, false\n  -- Floor read from each tile's floor VFX (map effect slot tile+4, subresource 0 = b358[67]mag01_y1.avfx):\n  -- render state 10 = plain tile, 11 = coloured tile (checked live 2026-11-07 on floor A: 10 on 1,2,5,10,13,14).\n  -- Argus.getCurrentMapEffects() returns an empty list in this arena, so the per-slot calls are used.\n  -- Floor A: inner WNW (6) and outer ENE (9) coloured, inner ENE (1) and outer WNW (14) plain. Floor B is the mirror.\n  function Z.b2TileRS(t)\n    local r = Argus.getMapEffectResource(t + 4)\n    if not r then return nil end\n    local s = Argus.getEffectSubresource(r, 0)\n    if not s then return nil end\n    local _, path = Argus.getEffectResourceInfo(s)\n    if type(path) ~= \"string\" or not path:find(\"mag01\", 1, true) then return nil end\n    local _, rs = Argus.getEffectResourceRenderInfo(s)\n    return rs\n  end\n  -- returns \"A\", \"B\" or nil. Throttled to 4 reads per second.\n  function Z.b2Floor()\n    local now = Now()\n    if Z.b2fT and now - Z.b2fT < 250 then return Z.b2fP end\n    Z.b2fT, Z.b2fP = now, nil\n    if not (Argus and Argus.getMapEffectResource and Argus.getEffectSubresource and Argus.getEffectResourceInfo\n      and Argus.getEffectResourceRenderInfo) then return nil end\n    local ok, rs = pcall(function()\n      local v = {}\n      for t = 0, 15 do v[t] = Z.b2TileRS(t) or -1 end\n      return v\n    end)\n    if not ok or type(rs) ~= \"table\" then return nil end\n    local got\n    if rs[6] == 11 and rs[9] == 11 and rs[1] == 10 and rs[14] == 10 then got = \"A\"\n    elseif rs[1] == 11 and rs[14] == 11 and rs[6] == 10 and rs[9] == 10 then got = \"B\" end\n    Z.b2fP = got\n    -- keep the last readings for checking after a pull (read with execute_lua)\n    local parts = {}\n    for t = 0, 15 do parts[#parts + 1] = tostring(rs[t]) end\n    local line = string.format(\"%.1f %s %s\", (Z.b2 and Z.b2.t0) and (now - Z.b2.t0) / 1000 or -1, got or \"-\", table.concat(parts, \",\"))\n    Z.b2fLog = Z.b2fLog or {}\n    if Z.b2fLast ~= line then\n      Z.b2fLast = line\n      Z.b2fLog[#Z.b2fLog + 1] = line\n      if #Z.b2fLog > 40 then table.remove(Z.b2fLog, 1) end\n    end\n    return got\n  end\n  function Z.b2Pattern(b)\n    if not (b and b.t0) then return nil end\n    return Z.b2Floor()\n  end\n  -- \"E\" (waymark B) / \"W\" (waymark D) or nil (floor not read)\n  function Z.b2Side(b)\n    if not (b and (b.first == \"IN\" or b.first == \"OUT\")) then return nil end\n    local pat = Z.b2Pattern(b)\n    if not pat then return nil end\n    if b.first == \"IN\" then return (pat == \"A\") and \"W\" or \"E\" end\n    return (pat == \"A\") and \"E\" or \"W\"\n  end\n  -- EAST fallback route when the floor is unknown: ESE first ring -> ESE other ring, hold it through the 2nd Thunder IV\n  -- (hit 4; ENE of the other ring can be red), then ENE before the 120 cone (hit 5).\n  function Z.b2Fallback(b)\n    local R = Z.b2RouteRaw and Z.b2RouteRaw(b, \"E\")\n    if not R then return nil end\n    local F = {}\n    for k, v in pairs(R) do F[k] = v end\n    F.iE = math.max(F.iE or 4, 4)\n    F.known, F.fb = true, true\n    return F\n  end\n  -- floor-only routes (callout text, route arrows) count only when they agree with b2Side\n  Z.b2RouteRaw = Z.b2RouteRaw or Z.b2Route\n  function Z.b2Route(b, force)\n    local R = Z.b2RouteRaw and Z.b2RouteRaw(b, force)\n    if R and not force and R.side ~= Z.b2Side(b) then return nil end\n    return R\n  end\nend\n-- [Draw] Bloom 2 - safe side arrow | timeline_index 35 | OnFrame | window -6.9..0.6\n-- big cyan arrow from you to the safe side (E = B, W = D) + marker there, from the 1st Thunder IV cast until hit 1.\n-- Draws nothing while the side is unknown.\nlocal b = Z.b2\nif not (b and b.first and b.t0 and Z.b2Side and Z.b2Res) then return end\nlocal now = Now()\nlocal el = (now - b.t0) / 1000\nif el < 0 or el > 8 or Z.b2Res(b, 1, el) then return end\nif not b.sT or now - b.sT > 200 then\n  b.sT, b.side = now, Z.b2Side(b)\nend\n-- floor unknown: EAST fallback (white), ESE is never red on either floor\nlocal s, fb = b.side, false\nif s ~= \"E\" and s ~= \"W\" then s, fb = \"E\", true end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal px, py, pz = p.pos.x, p.pos.y, p.pos.z\nlocal col = fb and 0xFFFFFF or 0xFFFF00\nlocal mx, mz = Z.pt(100, 100, (s == \"E\") and 90 or 270, 12)\nlocal g = TensorCore.getCachedDrawer(0x55000000 + col, 0x99000000 + col, 0xFF000000 + col, 0xFF000000, 3)\ng:addCircle(mx, py, mz, 2.2, false, Z.flags)\nTensorCore.getStaticDrawer(0xFF000000 + col, 3):addCircle(mx, py, mz, 3.0, false, Z.flags)\nlocal onSide = (s == \"E\" and px > 103) or (s == \"W\" and px < 97)\nlocal d = TensorCore.getDistance2d2(px, py, pz, mx, py, mz)\nif not onSide and d > 3.5 then\n  local len = math.min(12, d - 2.5)\n  local tip = math.min(3.0, len * 0.4)\n  g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, mx, py, mz), math.max(0.5, len - tip), 1.3, tip, 3.0, false, Z.flags)\nend\n",
							name = "[Draw] Bloom 2 - safe side arrow",
							uuid = "07ae9c4e-f23e-483a-9fc2-a2801cfa5c89",
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
				mechanicTime = 227.2,
				name = "[Draw] Bloom 2 - safe side arrow",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = 0.6,
				timerStartOffset = -6.9,
				uuid = "90327839-29de-fac7-a6ba-310e54970a52",
				version = 2,
			},
		},
	},
	[42] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "1b1f0992-1ea4-be81-ba77-723a629c5072",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tankbuster tethers (89) from players to the boss\nlocal e = eventArgs\nif not e then self.used = true return end\nZ.spec = Z.spec or {}\nif e.newTetherID == 89 then\n  Z.spec[e.sourceEntityID] = true\n  local p = TensorCore.mGetPlayer()\n  if p and e.sourceEntityID == p.id and not Z.tankOf(p.id) then hush(4000, \"BUSTER TETHER: let a tank take it\", 0xFF3333FF) end\nelseif e.oldTetherID == 89 then\n  Z.spec[e.sourceEntityID] = nil\nend\nself.used = true\n",
							name = "[Draw] Specter - tether tracker",
							uuid = "35227bcb-833a-7e37-9ef8-9d2f100f927d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 242.3,
				name = "[Draw] Specter - tether tracker",
				timeRange = true,
				timelineIndex = 42,
				timerEndOffset = 0.3,
				timerStartOffset = -9,
				uuid = "540bda01-127c-a7a2-ac1f-d24b5c3a6384",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tanks get a line to any non-tank holding a tether\nlocal S = Z.spec\nlocal p = TensorCore.mGetPlayer()\nif not (S and p and p.pos) then return end\nlocal tank = Z.tankOf(p.id)\nfor id in pairs(S) do\n  if not Z.tankOf(id) then\n    local ent = TensorCore.mGetEntity(id)\n    if ent and ent.pos then\n      if tank then\n        TensorCore.getStaticDrawer(0xFF00FFFF, 4):addLine(p.pos.x, p.pos.y, p.pos.z, ent.pos.x, ent.pos.y, ent.pos.z, 6)\n        TensorCore.getCachedDrawer(0x3300FFFF, 0x5500FFFF, 0x8800FFFF, 0xFF00FFFF, 3):addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 1.5, false, Z.flags)\n      elseif id == p.id then\n        TensorCore.getCachedDrawer(0x333333FF, 0x553333FF, 0x883333FF, 0xFF3333FF, 3):addCircle(p.pos.x, p.pos.y, p.pos.z, 1.5, false, Z.flags)\n      end\n    end\n  end\nend\n",
							name = "[Draw] Specter - tanks grab tethers",
							uuid = "9b6e8429-1248-3547-a9ed-735c88e38fdd",
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
				mechanicTime = 242.3,
				name = "[Draw] Specter - tanks grab tethers",
				timeRange = true,
				timelineIndex = 42,
				timerEndOffset = 0.2,
				timerStartOffset = -8.5,
				uuid = "4a9a740a-0f2b-31b3-a41e-851f03dbb684",
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
				name = "Role Draws",
				uuid = "fa6f6644-c934-2d96-8fb0-55603eadbeee",
			},
			objectType = "folder",
		},
	},
	[48] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "418c62fb-3e52-cb07-a0a8-e2f696cf90f5",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 3 rose markers (592): all supports or all DPS\nlocal e = eventArgs\nif not (e and e.markerID == 592) then self.used = true return end\nZ.b3 = Z.b3 or {}\nif Z.b3.roseSup == nil then\n  Z.b3.roseSup = Z.supOf(e.entityID)\n  Z.b3.markT = Now()\n  local s = Z.slot()\n  if s and Z.b3.relN then\n    local mine = (Z.b3.roseSup == Z.isSup(s)) and \"ROSE: inner tile\" or \"TOWER: outer tile\"\n    Z.say(7000, mine .. \" (new north = \" .. Z.dirName(Z.b3.relN) .. \")\", 0xFFFF66FF)\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 3 - rose markers",
							uuid = "62552d3c-e75f-8ec6-8ace-02e08e8beea4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 4,
				loop = true,
				mechanicTime = 266.1,
				name = "[Draw] Bloom 3 - rose markers (old)",
				timeRange = true,
				timelineIndex = 48,
				timerEndOffset = 3.5,
				timerStartOffset = -1,
				uuid = "5e9c4b27-8a4d-4d48-b65f-7e808a88036e",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 3 helpers (add to the shared PRE anywhere after `local Z = data.zel`; self-guarded, defined once per pull) =====\n-- Uses at call time: Z.pt, Z.slot, Z.slotOf, Z.isSup, Z.say, Z.dirName (existing PRE), and optionally Z.tiles / Z.tilesKnown / Z.tileT (tile tracker).\nif not Z.b3fnV2 then\n  Z.b3fnV2 = true\n  -- offsets in 45-degree tile steps from the NEW NORTH inner tile n (colour pairs T1/R1 N, H2/R2 E, T2/M2 S, H1/M1 W):\n  --   ro = inner rose tile, to = outer tower tile, wr/wo = plain tile to walk to after the drop (wr 1 = outer, 0 = inner)\n  Z.B3_K = {\n    T1 = {ro = 0, to = 0, wr = 0, wo = 2}, R1 = {ro = 0, to = 0, wr = 1, wo = 1},\n    H2 = {ro = 3, to = 2, wr = 1, wo = 3}, R2 = {ro = 3, to = 2, wr = 1, wo = 3},\n    T2 = {ro = 4, to = 4, wr = 0, wo = 6}, M2 = {ro = 4, to = 4, wr = 1, wo = 5},\n    H1 = {ro = 5, to = 6, wr = 0, wo = 6}, M1 = {ro = 5, to = 6, wr = 0, wo = 6}}\n  Z.B3_RANK = {[0] = 1, [3] = 2, [4] = 3, [5] = 4}\n  Z.B3_ROSEOFF = {[0] = true, [3] = true, [4] = true, [5] = true}\n  -- tiles {ring, offset} a correctly placed player of each slot stands on (votes for the party-position inference)\n  local XN, XE, XS, XW = {{0, 0}, {1, 0}}, {{0, 3}, {1, 2}, {1, 3}}, {{0, 4}, {1, 4}}, {{0, 5}, {1, 6}}\n  Z.B3_EXP = {T1 = XN, R1 = XN, H2 = XE, R2 = XE, T2 = XS, M2 = XS, H1 = XW, M1 = XW}\n\n  -- BossMod tile index of a world point (0-7 inner r<=8, 8-15 outer; k spans [45k, 45k+45) clockwise from north)\n  function Z.b3tile(x, z)\n    if not (x and z) then return nil end\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n\n  -- Bloom 3 pull state; a table older than 30 s (left over from an earlier pull if data was not reset) is replaced\n  function Z.b3get()\n    local now = Now()\n    local b = Z.b3\n    if type(b) ~= \"table\" or not b.t0 or now - b.t0 > 30000 then\n      b = {t0 = now}\n      Z.b3 = b\n    end\n    return b\n  end\n\n  -- point on the centre line of tile t at radius r\n  function Z.b3spot(t, r)\n    return Z.pt(100, 100, 22.5 + 45 * (t % 8), r)\n  end\n\n  -- new north from the tile tracker: the plain inner tile between the only two red inner tiles\n  function Z.b3fromTiles(par)\n    local T, TT, b = Z.tiles, Z.tileT, Z.b3\n    if not (Z.tilesKnown and type(T) == \"table\" and type(TT) == \"table\" and b and b.t0) then return nil end\n    -- only tiles that changed this bloom (from ~15 s before this state was created) count; stale tiles from earlier blooms are ignored\n    local since = b.t0 - 15000\n    local F, cnt = {}, 0\n    for t = 0, 7 do\n      if T[t] and TT[t] and TT[t] >= since then F[t] = true cnt = cnt + 1 end\n    end\n    if cnt ~= 2 then return nil end\n    local found\n    for n = 0, 7 do\n      if (par == nil or n % 2 == par) and not F[n] and F[(n + 7) % 8] and F[(n + 1) % 8] then\n        if found then return nil end\n        found = n\n      end\n    end\n    return found\n  end\n\n  -- new north from where the other 7 players stand (pairs pre-position on their rose tile relative to new north)\n  function Z.b3fromParty(par)\n    if not TensorCore.getEntityGroupList then return nil end\n    local list = TensorCore.getEntityGroupList(\"Party\")\n    if type(list) ~= \"table\" then return nil end\n    local me = TensorCore.mGetPlayer()\n    local myId = me and me.id\n    local sc, sf, nv = {}, {}, 0\n    for n = 0, 7 do sc[n] = 0 sf[n] = 0 end\n    for k, v in pairs(list) do\n      local id = (type(v) == \"table\") and (v.id or k) or v\n      local e = (type(v) == \"table\") and v or TensorCore.mGetEntity(v)\n      if type(e) == \"table\" and id and id ~= myId and e.pos then\n        local t = Z.b3tile(e.pos.x, e.pos.z)\n        local s = Z.slotOf(id)\n        local o = s and Z.B3_EXP[s]\n        if t then\n          if o then nv = nv + 1 end\n          for n = 0, 7 do\n            if par == nil or n % 2 == par then\n              if o then\n                for i = 1, #o do\n                  local q = o[i]\n                  if t == q[1] * 8 + (n + q[2]) % 8 then sc[n] = sc[n] + 1 break end\n                end\n              end\n              if t < 8 and Z.B3_ROSEOFF[(t - n) % 8] then sf[n] = sf[n] + 1 end\n            end\n          end\n        end\n      end\n    end\n    local S, needB, needM = sc, 3, 2\n    if nv < 4 then\n      if par == nil then return nil end\n      S, needB, needM = sf, 4, 2\n    elseif par == nil then\n      needB, needM = 4, 3\n    end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if par == nil or n % 2 == par then\n        local v = S[n]\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN ~= nil and best >= needB and best - second >= needM then return bestN end\n    return nil\n  end\n\n  -- new north from the 4 rose drops (correct drops land on inner n, n+3, n+4, n+5); real evidence, so it overrides every other source\n  function Z.b3fromDrops()\n    local b = Z.b3\n    if not (b and b.drops) then return end\n    local inner, m = {}, 0\n    for _, t in pairs(b.drops) do\n      if t and t < 8 and not inner[t] then inner[t] = true m = m + 1 end\n    end\n    if m < 3 then return end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if b.par == nil or n % 2 == b.par then\n        local v = 0\n        for o in pairs(Z.B3_ROSEOFF) do if inner[(n + o) % 8] then v = v + 1 end end\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN == nil or best < 3 or best <= second then return end\n    local old = b.nn\n    b.nn, b.nnSrc, b.relN, b.rtFor = bestN, \"drops\", 22.5 + 45 * bestN, nil\n    if old ~= nil and old ~= bestN then\n      local s = Z.slot()\n      local K = s and Z.B3_K[s]\n      if K and b.roseSup ~= nil and b.roseSup ~= Z.isSup(s) then\n        hush(4000, \"Bloom 3: new north was wrong -> your tower is \" .. Z.dirName(22.5 + 45 * ((bestN + K.to) % 8)), 0xFFFF3333)\n      end\n    end\n  end\n\n  -- pick the new north: tiles > party positions > tower parity guess (22.5 / 337.5); frozen once the roses drop\n  function Z.b3resolve()\n    local b = Z.b3\n    if not b then return end\n    local now = Now()\n    if b.resT and now - b.resT < 250 then return end\n    b.resT = now\n    if b.par ~= nil and b.nn ~= nil and b.nn % 2 ~= b.par then b.nn, b.nnSrc = nil, nil end\n    if b.nnSrc == \"tiles\" or b.nnSrc == \"drops\" then return end\n    if b.dropT and b.nn ~= nil then return end\n    local n, src = Z.b3fromTiles(b.par), \"tiles\"\n    if n == nil then n, src = Z.b3fromParty(b.par), \"party\" end\n    if n == nil then\n      if b.nnSrc == \"party\" or b.par == nil then return end\n      n, src = (b.par == 0) and 0 or 7, \"guess\"\n    end\n    if n ~= b.nn then b.rtFor = nil end\n    b.nn, b.nnSrc, b.relN = n, src, 22.5 + 45 * n\n  end\n\n  -- is tile t active (red / tower) right now? strict boolean\n  function Z.b3act(t)\n    local b = Z.b3\n    if not b or t == nil then return false end\n    if b.tw and b.tw[t] then return true end\n    if b.drops then for _, d in pairs(b.drops) do if d == t then return true end end end\n    local T = Z.tiles\n    if b.nnSrc == \"tiles\" then return (type(T) == \"table\" and T[t]) and true or false end\n    local n = b.nn\n    if n ~= nil then\n      if t < 8 then\n        local r = (t - n) % 8\n        if r == 1 or r == 7 then return true end\n      elseif (t - n) % 2 == 0 then\n        return true\n      end\n    end\n    if type(T) == \"table\" and T[t] and b.markT and type(Z.tileT) == \"table\" and Z.tileT[t] and Z.tileT[t] > b.markT then return true end\n    return false\n  end\n\n  -- BossMod Bloom3Emblazon.DangerTile: outer ring, active tiles, and inner \"side tiles\" are unsafe for roses\n  function Z.b3danger(t)\n    if t >= 8 then return true end\n    local A = Z.b3act\n    if A(t) then return true end\n    return A(t + 8) and (A((t + 1) % 8) ~= A((t + 7) % 8))\n  end\n\n  -- your rose tile: pair tile relative to new north; if DangerTile forbids it, the allowed tile of the same rank\n  function Z.b3roseTile(s)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local n = b.nn\n    local R = (n + K.ro) % 8\n    if not Z.b3danger(R) then return R end\n    local L = {}\n    for o = 0, 7 do\n      local t = (n + o) % 8\n      if not Z.b3danger(t) then L[#L + 1] = t end\n    end\n    return L[Z.B3_RANK[K.ro] or 1] or L[1] or R\n  end\n\n  -- plain tile to walk to after the drop (pair default; nearest plain tile if that one is red)\n  function Z.b3walkTile(s, px, pz)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local W = (b.nn + K.wo) % 8 + 8 * K.wr\n    if not Z.b3act(W) or not (px and pz) then return W end\n    local best, bd\n    for t = 0, 15 do\n      if not Z.b3act(t) then\n        local x, z = Z.b3spot(t, (t < 8) and 5.0 or 10.0)\n        local d = (x - px) * (x - px) + (z - pz) * (z - pz)\n        if bd == nil or d < bd then best, bd = t, d end\n      end\n    end\n    return best or W\n  end\nend\n-- Bloom 3 rose markers (592): all supports or all DPS. Callout names your exact tile and how the new north was found.\nlocal e = eventArgs\nif not (e and e.markerID == 592 and Z.b3get) then self.used = true return end\nlocal b = Z.b3get()\nif b.roseSup == nil then\n  b.roseSup = Z.supOf(e.entityID)\n  b.markT = Now()\n  b.resT = nil\n  if Z.b3resolve then Z.b3resolve() end\n  local s = Z.slot()\n  local K = s and Z.B3_K and Z.B3_K[s]\n  if K and b.nn ~= nil then\n    local nN = 22.5 + 45 * b.nn\n    local src = (b.nnSrc == \"guess\") and \"GUESS - check the plain inner tile between the 2 red ones\" or b.nnSrc\n    if b.roseSup == Z.isSup(s) then\n      local rt = Z.b3roseTile(s) or ((b.nn + K.ro) % 8)\n      hush(7000, \"ROSE: inner \" .. Z.dirName(22.5 + 45 * rt) .. \"   (new N \" .. Z.dirName(nN) .. \", \" .. src .. \")\", 0xFFFF66FF)\n    else\n      hush(7000, \"TOWER: outer \" .. Z.dirName(nN + 45 * K.to) .. \"   (new N \" .. Z.dirName(nN) .. \", \" .. src .. \")\", 0xFF33FF33)\n    end\n  end\nend\nself.used = true",
							name = "[Draw] Bloom 3 - rose markers",
							uuid = "8b9e8207-192b-ee33-b1fb-72cd36707310",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 266.1,
				name = "[Draw] Bloom 3 - rose markers",
				timeRange = true,
				timelineIndex = 48,
				timerEndOffset = 3.5,
				timerStartOffset = -1,
				uuid = "22cb360e-2200-d99a-a9b6-f3164e1f981e",
				version = 2,
			},
		},
	},
	[49] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "5343d0dc-440f-6a9f-b91d-d75a0d6252a4",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 3: rose players walk off the red tile once the roses drop\nlocal b, s = Z.b3, Z.slot()\nif b and s and b.roseSup ~= nil and b.roseSup == Z.isSup(s) then Z.say(5000, \"Roses dropped: walk OFF the red tile\", 0xFFFF66FF) end\nself.used = true\n",
							name = "[Draw] Bloom 3 - walk off red callout",
							uuid = "dc17a757-e42d-f002-ad94-ca69a7ff4ee0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				mechanicTime = 273.7,
				name = "[Draw] Bloom 3 - walk off red callout (old)",
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 1.5,
				timerStartOffset = 0.2,
				uuid = "a20fb92a-eb64-248e-bda5-df55264a6cff",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 3 helpers (add to the shared PRE anywhere after `local Z = data.zel`; self-guarded, defined once per pull) =====\n-- Uses at call time: Z.pt, Z.slot, Z.slotOf, Z.isSup, Z.say, Z.dirName (existing PRE), and optionally Z.tiles / Z.tilesKnown / Z.tileT (tile tracker).\nif not Z.b3fnV2 then\n  Z.b3fnV2 = true\n  -- offsets in 45-degree tile steps from the NEW NORTH inner tile n (colour pairs T1/R1 N, H2/R2 E, T2/M2 S, H1/M1 W):\n  --   ro = inner rose tile, to = outer tower tile, wr/wo = plain tile to walk to after the drop (wr 1 = outer, 0 = inner)\n  Z.B3_K = {\n    T1 = {ro = 0, to = 0, wr = 0, wo = 2}, R1 = {ro = 0, to = 0, wr = 1, wo = 1},\n    H2 = {ro = 3, to = 2, wr = 1, wo = 3}, R2 = {ro = 3, to = 2, wr = 1, wo = 3},\n    T2 = {ro = 4, to = 4, wr = 0, wo = 6}, M2 = {ro = 4, to = 4, wr = 1, wo = 5},\n    H1 = {ro = 5, to = 6, wr = 0, wo = 6}, M1 = {ro = 5, to = 6, wr = 0, wo = 6}}\n  Z.B3_RANK = {[0] = 1, [3] = 2, [4] = 3, [5] = 4}\n  Z.B3_ROSEOFF = {[0] = true, [3] = true, [4] = true, [5] = true}\n  -- tiles {ring, offset} a correctly placed player of each slot stands on (votes for the party-position inference)\n  local XN, XE, XS, XW = {{0, 0}, {1, 0}}, {{0, 3}, {1, 2}, {1, 3}}, {{0, 4}, {1, 4}}, {{0, 5}, {1, 6}}\n  Z.B3_EXP = {T1 = XN, R1 = XN, H2 = XE, R2 = XE, T2 = XS, M2 = XS, H1 = XW, M1 = XW}\n\n  -- BossMod tile index of a world point (0-7 inner r<=8, 8-15 outer; k spans [45k, 45k+45) clockwise from north)\n  function Z.b3tile(x, z)\n    if not (x and z) then return nil end\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n\n  -- Bloom 3 pull state; a table older than 30 s (left over from an earlier pull if data was not reset) is replaced\n  function Z.b3get()\n    local now = Now()\n    local b = Z.b3\n    if type(b) ~= \"table\" or not b.t0 or now - b.t0 > 30000 then\n      b = {t0 = now}\n      Z.b3 = b\n    end\n    return b\n  end\n\n  -- point on the centre line of tile t at radius r\n  function Z.b3spot(t, r)\n    return Z.pt(100, 100, 22.5 + 45 * (t % 8), r)\n  end\n\n  -- new north from the tile tracker: the plain inner tile between the only two red inner tiles\n  function Z.b3fromTiles(par)\n    local T, TT, b = Z.tiles, Z.tileT, Z.b3\n    if not (Z.tilesKnown and type(T) == \"table\" and type(TT) == \"table\" and b and b.t0) then return nil end\n    -- only tiles that changed this bloom (from ~15 s before this state was created) count; stale tiles from earlier blooms are ignored\n    local since = b.t0 - 15000\n    local F, cnt = {}, 0\n    for t = 0, 7 do\n      if T[t] and TT[t] and TT[t] >= since then F[t] = true cnt = cnt + 1 end\n    end\n    if cnt ~= 2 then return nil end\n    local found\n    for n = 0, 7 do\n      if (par == nil or n % 2 == par) and not F[n] and F[(n + 7) % 8] and F[(n + 1) % 8] then\n        if found then return nil end\n        found = n\n      end\n    end\n    return found\n  end\n\n  -- new north from where the other 7 players stand (pairs pre-position on their rose tile relative to new north)\n  function Z.b3fromParty(par)\n    if not TensorCore.getEntityGroupList then return nil end\n    local list = TensorCore.getEntityGroupList(\"Party\")\n    if type(list) ~= \"table\" then return nil end\n    local me = TensorCore.mGetPlayer()\n    local myId = me and me.id\n    local sc, sf, nv = {}, {}, 0\n    for n = 0, 7 do sc[n] = 0 sf[n] = 0 end\n    for k, v in pairs(list) do\n      local id = (type(v) == \"table\") and (v.id or k) or v\n      local e = (type(v) == \"table\") and v or TensorCore.mGetEntity(v)\n      if type(e) == \"table\" and id and id ~= myId and e.pos then\n        local t = Z.b3tile(e.pos.x, e.pos.z)\n        local s = Z.slotOf(id)\n        local o = s and Z.B3_EXP[s]\n        if t then\n          if o then nv = nv + 1 end\n          for n = 0, 7 do\n            if par == nil or n % 2 == par then\n              if o then\n                for i = 1, #o do\n                  local q = o[i]\n                  if t == q[1] * 8 + (n + q[2]) % 8 then sc[n] = sc[n] + 1 break end\n                end\n              end\n              if t < 8 and Z.B3_ROSEOFF[(t - n) % 8] then sf[n] = sf[n] + 1 end\n            end\n          end\n        end\n      end\n    end\n    local S, needB, needM = sc, 3, 2\n    if nv < 4 then\n      if par == nil then return nil end\n      S, needB, needM = sf, 4, 2\n    elseif par == nil then\n      needB, needM = 4, 3\n    end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if par == nil or n % 2 == par then\n        local v = S[n]\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN ~= nil and best >= needB and best - second >= needM then return bestN end\n    return nil\n  end\n\n  -- new north from the 4 rose drops (correct drops land on inner n, n+3, n+4, n+5); real evidence, so it overrides every other source\n  function Z.b3fromDrops()\n    local b = Z.b3\n    if not (b and b.drops) then return end\n    local inner, m = {}, 0\n    for _, t in pairs(b.drops) do\n      if t and t < 8 and not inner[t] then inner[t] = true m = m + 1 end\n    end\n    if m < 3 then return end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if b.par == nil or n % 2 == b.par then\n        local v = 0\n        for o in pairs(Z.B3_ROSEOFF) do if inner[(n + o) % 8] then v = v + 1 end end\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN == nil or best < 3 or best <= second then return end\n    local old = b.nn\n    b.nn, b.nnSrc, b.relN, b.rtFor = bestN, \"drops\", 22.5 + 45 * bestN, nil\n    if old ~= nil and old ~= bestN then\n      local s = Z.slot()\n      local K = s and Z.B3_K[s]\n      if K and b.roseSup ~= nil and b.roseSup ~= Z.isSup(s) then\n        hush(4000, \"Bloom 3: new north was wrong -> your tower is \" .. Z.dirName(22.5 + 45 * ((bestN + K.to) % 8)), 0xFFFF3333)\n      end\n    end\n  end\n\n  -- pick the new north: tiles > party positions > tower parity guess (22.5 / 337.5); frozen once the roses drop\n  function Z.b3resolve()\n    local b = Z.b3\n    if not b then return end\n    local now = Now()\n    if b.resT and now - b.resT < 250 then return end\n    b.resT = now\n    if b.par ~= nil and b.nn ~= nil and b.nn % 2 ~= b.par then b.nn, b.nnSrc = nil, nil end\n    if b.nnSrc == \"tiles\" or b.nnSrc == \"drops\" then return end\n    if b.dropT and b.nn ~= nil then return end\n    local n, src = Z.b3fromTiles(b.par), \"tiles\"\n    if n == nil then n, src = Z.b3fromParty(b.par), \"party\" end\n    if n == nil then\n      if b.nnSrc == \"party\" or b.par == nil then return end\n      n, src = (b.par == 0) and 0 or 7, \"guess\"\n    end\n    if n ~= b.nn then b.rtFor = nil end\n    b.nn, b.nnSrc, b.relN = n, src, 22.5 + 45 * n\n  end\n\n  -- is tile t active (red / tower) right now? strict boolean\n  function Z.b3act(t)\n    local b = Z.b3\n    if not b or t == nil then return false end\n    if b.tw and b.tw[t] then return true end\n    if b.drops then for _, d in pairs(b.drops) do if d == t then return true end end end\n    local T = Z.tiles\n    if b.nnSrc == \"tiles\" then return (type(T) == \"table\" and T[t]) and true or false end\n    local n = b.nn\n    if n ~= nil then\n      if t < 8 then\n        local r = (t - n) % 8\n        if r == 1 or r == 7 then return true end\n      elseif (t - n) % 2 == 0 then\n        return true\n      end\n    end\n    if type(T) == \"table\" and T[t] and b.markT and type(Z.tileT) == \"table\" and Z.tileT[t] and Z.tileT[t] > b.markT then return true end\n    return false\n  end\n\n  -- BossMod Bloom3Emblazon.DangerTile: outer ring, active tiles, and inner \"side tiles\" are unsafe for roses\n  function Z.b3danger(t)\n    if t >= 8 then return true end\n    local A = Z.b3act\n    if A(t) then return true end\n    return A(t + 8) and (A((t + 1) % 8) ~= A((t + 7) % 8))\n  end\n\n  -- your rose tile: pair tile relative to new north; if DangerTile forbids it, the allowed tile of the same rank\n  function Z.b3roseTile(s)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local n = b.nn\n    local R = (n + K.ro) % 8\n    if not Z.b3danger(R) then return R end\n    local L = {}\n    for o = 0, 7 do\n      local t = (n + o) % 8\n      if not Z.b3danger(t) then L[#L + 1] = t end\n    end\n    return L[Z.B3_RANK[K.ro] or 1] or L[1] or R\n  end\n\n  -- plain tile to walk to after the drop (pair default; nearest plain tile if that one is red)\n  function Z.b3walkTile(s, px, pz)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local W = (b.nn + K.wo) % 8 + 8 * K.wr\n    if not Z.b3act(W) or not (px and pz) then return W end\n    local best, bd\n    for t = 0, 15 do\n      if not Z.b3act(t) then\n        local x, z = Z.b3spot(t, (t < 8) and 5.0 or 10.0)\n        local d = (x - px) * (x - px) + (z - pz) * (z - pz)\n        if bd == nil or d < bd then best, bd = t, d end\n      end\n    end\n    return best or W\n  end\nend\n-- Bloom 3 rose drops (Emblazon 43040, helper -> rose holder): record each drop tile; 3+ consistent drops confirm/correct the new north\nlocal e = eventArgs\nif not (e and e.spellID == 43040) then self.used = true return end\nlocal b = Z.b3get and Z.b3get()\nif not (b and b.markT and Z.b3tile) then self.used = true return end\nlocal x, z\nlocal h = TensorCore.mGetEntity(e.entityID)\nif h and h.pos then x, z = h.pos.x, h.pos.z end\nif not (x and z) or (x - 100) * (x - 100) + (z - 100) * (z - 100) > 400 then\n  local tg = e.targetID and TensorCore.mGetEntity(e.targetID)\n  if tg and tg.pos then x, z = tg.pos.x, tg.pos.z else x, z = nil, nil end\nend\nif x and z then\n  b.drops = b.drops or {}\n  b.nDrop = (b.nDrop or 0) + 1\n  b.drops[e.targetID or (-b.nDrop)] = Z.b3tile(x, z)\n  b.dropT = b.dropT or Now()\n  local p = TensorCore.mGetPlayer()\n  if p and e.targetID == p.id then b.myDropT = Now() end\n  if Z.b3fromDrops then Z.b3fromDrops() end\nend\nself.used = true",
							name = "[Draw] Bloom 3 - rose drop tracker",
							uuid = "0e520bfe-c3fc-bbca-9b57-6ca192b7d053",
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
				mechanicTime = 273.7,
				name = "[Draw] Bloom 3 - rose drop tracker",
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 2,
				timerStartOffset = -2.5,
				uuid = "e1a34e57-ad63-f775-964e-2440a3dfc3e4",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 3 helpers (add to the shared PRE anywhere after `local Z = data.zel`; self-guarded, defined once per pull) =====\n-- Uses at call time: Z.pt, Z.slot, Z.slotOf, Z.isSup, Z.say, Z.dirName (existing PRE), and optionally Z.tiles / Z.tilesKnown / Z.tileT (tile tracker).\nif not Z.b3fnV2 then\n  Z.b3fnV2 = true\n  -- offsets in 45-degree tile steps from the NEW NORTH inner tile n (colour pairs T1/R1 N, H2/R2 E, T2/M2 S, H1/M1 W):\n  --   ro = inner rose tile, to = outer tower tile, wr/wo = plain tile to walk to after the drop (wr 1 = outer, 0 = inner)\n  Z.B3_K = {\n    T1 = {ro = 0, to = 0, wr = 0, wo = 2}, R1 = {ro = 0, to = 0, wr = 1, wo = 1},\n    H2 = {ro = 3, to = 2, wr = 1, wo = 3}, R2 = {ro = 3, to = 2, wr = 1, wo = 3},\n    T2 = {ro = 4, to = 4, wr = 0, wo = 6}, M2 = {ro = 4, to = 4, wr = 1, wo = 5},\n    H1 = {ro = 5, to = 6, wr = 0, wo = 6}, M1 = {ro = 5, to = 6, wr = 0, wo = 6}}\n  Z.B3_RANK = {[0] = 1, [3] = 2, [4] = 3, [5] = 4}\n  Z.B3_ROSEOFF = {[0] = true, [3] = true, [4] = true, [5] = true}\n  -- tiles {ring, offset} a correctly placed player of each slot stands on (votes for the party-position inference)\n  local XN, XE, XS, XW = {{0, 0}, {1, 0}}, {{0, 3}, {1, 2}, {1, 3}}, {{0, 4}, {1, 4}}, {{0, 5}, {1, 6}}\n  Z.B3_EXP = {T1 = XN, R1 = XN, H2 = XE, R2 = XE, T2 = XS, M2 = XS, H1 = XW, M1 = XW}\n\n  -- BossMod tile index of a world point (0-7 inner r<=8, 8-15 outer; k spans [45k, 45k+45) clockwise from north)\n  function Z.b3tile(x, z)\n    if not (x and z) then return nil end\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n\n  -- Bloom 3 pull state; a table older than 30 s (left over from an earlier pull if data was not reset) is replaced\n  function Z.b3get()\n    local now = Now()\n    local b = Z.b3\n    if type(b) ~= \"table\" or not b.t0 or now - b.t0 > 30000 then\n      b = {t0 = now}\n      Z.b3 = b\n    end\n    return b\n  end\n\n  -- point on the centre line of tile t at radius r\n  function Z.b3spot(t, r)\n    return Z.pt(100, 100, 22.5 + 45 * (t % 8), r)\n  end\n\n  -- new north from the tile tracker: the plain inner tile between the only two red inner tiles\n  function Z.b3fromTiles(par)\n    local T, TT, b = Z.tiles, Z.tileT, Z.b3\n    if not (Z.tilesKnown and type(T) == \"table\" and type(TT) == \"table\" and b and b.t0) then return nil end\n    -- only tiles that changed this bloom (from ~15 s before this state was created) count; stale tiles from earlier blooms are ignored\n    local since = b.t0 - 15000\n    local F, cnt = {}, 0\n    for t = 0, 7 do\n      if T[t] and TT[t] and TT[t] >= since then F[t] = true cnt = cnt + 1 end\n    end\n    if cnt ~= 2 then return nil end\n    local found\n    for n = 0, 7 do\n      if (par == nil or n % 2 == par) and not F[n] and F[(n + 7) % 8] and F[(n + 1) % 8] then\n        if found then return nil end\n        found = n\n      end\n    end\n    return found\n  end\n\n  -- new north from where the other 7 players stand (pairs pre-position on their rose tile relative to new north)\n  function Z.b3fromParty(par)\n    if not TensorCore.getEntityGroupList then return nil end\n    local list = TensorCore.getEntityGroupList(\"Party\")\n    if type(list) ~= \"table\" then return nil end\n    local me = TensorCore.mGetPlayer()\n    local myId = me and me.id\n    local sc, sf, nv = {}, {}, 0\n    for n = 0, 7 do sc[n] = 0 sf[n] = 0 end\n    for k, v in pairs(list) do\n      local id = (type(v) == \"table\") and (v.id or k) or v\n      local e = (type(v) == \"table\") and v or TensorCore.mGetEntity(v)\n      if type(e) == \"table\" and id and id ~= myId and e.pos then\n        local t = Z.b3tile(e.pos.x, e.pos.z)\n        local s = Z.slotOf(id)\n        local o = s and Z.B3_EXP[s]\n        if t then\n          if o then nv = nv + 1 end\n          for n = 0, 7 do\n            if par == nil or n % 2 == par then\n              if o then\n                for i = 1, #o do\n                  local q = o[i]\n                  if t == q[1] * 8 + (n + q[2]) % 8 then sc[n] = sc[n] + 1 break end\n                end\n              end\n              if t < 8 and Z.B3_ROSEOFF[(t - n) % 8] then sf[n] = sf[n] + 1 end\n            end\n          end\n        end\n      end\n    end\n    local S, needB, needM = sc, 3, 2\n    if nv < 4 then\n      if par == nil then return nil end\n      S, needB, needM = sf, 4, 2\n    elseif par == nil then\n      needB, needM = 4, 3\n    end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if par == nil or n % 2 == par then\n        local v = S[n]\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN ~= nil and best >= needB and best - second >= needM then return bestN end\n    return nil\n  end\n\n  -- new north from the 4 rose drops (correct drops land on inner n, n+3, n+4, n+5); real evidence, so it overrides every other source\n  function Z.b3fromDrops()\n    local b = Z.b3\n    if not (b and b.drops) then return end\n    local inner, m = {}, 0\n    for _, t in pairs(b.drops) do\n      if t and t < 8 and not inner[t] then inner[t] = true m = m + 1 end\n    end\n    if m < 3 then return end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if b.par == nil or n % 2 == b.par then\n        local v = 0\n        for o in pairs(Z.B3_ROSEOFF) do if inner[(n + o) % 8] then v = v + 1 end end\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN == nil or best < 3 or best <= second then return end\n    local old = b.nn\n    b.nn, b.nnSrc, b.relN, b.rtFor = bestN, \"drops\", 22.5 + 45 * bestN, nil\n    if old ~= nil and old ~= bestN then\n      local s = Z.slot()\n      local K = s and Z.B3_K[s]\n      if K and b.roseSup ~= nil and b.roseSup ~= Z.isSup(s) then\n        hush(4000, \"Bloom 3: new north was wrong -> your tower is \" .. Z.dirName(22.5 + 45 * ((bestN + K.to) % 8)), 0xFFFF3333)\n      end\n    end\n  end\n\n  -- pick the new north: tiles > party positions > tower parity guess (22.5 / 337.5); frozen once the roses drop\n  function Z.b3resolve()\n    local b = Z.b3\n    if not b then return end\n    local now = Now()\n    if b.resT and now - b.resT < 250 then return end\n    b.resT = now\n    if b.par ~= nil and b.nn ~= nil and b.nn % 2 ~= b.par then b.nn, b.nnSrc = nil, nil end\n    if b.nnSrc == \"tiles\" or b.nnSrc == \"drops\" then return end\n    if b.dropT and b.nn ~= nil then return end\n    local n, src = Z.b3fromTiles(b.par), \"tiles\"\n    if n == nil then n, src = Z.b3fromParty(b.par), \"party\" end\n    if n == nil then\n      if b.nnSrc == \"party\" or b.par == nil then return end\n      n, src = (b.par == 0) and 0 or 7, \"guess\"\n    end\n    if n ~= b.nn then b.rtFor = nil end\n    b.nn, b.nnSrc, b.relN = n, src, 22.5 + 45 * n\n  end\n\n  -- is tile t active (red / tower) right now? strict boolean\n  function Z.b3act(t)\n    local b = Z.b3\n    if not b or t == nil then return false end\n    if b.tw and b.tw[t] then return true end\n    if b.drops then for _, d in pairs(b.drops) do if d == t then return true end end end\n    local T = Z.tiles\n    if b.nnSrc == \"tiles\" then return (type(T) == \"table\" and T[t]) and true or false end\n    local n = b.nn\n    if n ~= nil then\n      if t < 8 then\n        local r = (t - n) % 8\n        if r == 1 or r == 7 then return true end\n      elseif (t - n) % 2 == 0 then\n        return true\n      end\n    end\n    if type(T) == \"table\" and T[t] and b.markT and type(Z.tileT) == \"table\" and Z.tileT[t] and Z.tileT[t] > b.markT then return true end\n    return false\n  end\n\n  -- BossMod Bloom3Emblazon.DangerTile: outer ring, active tiles, and inner \"side tiles\" are unsafe for roses\n  function Z.b3danger(t)\n    if t >= 8 then return true end\n    local A = Z.b3act\n    if A(t) then return true end\n    return A(t + 8) and (A((t + 1) % 8) ~= A((t + 7) % 8))\n  end\n\n  -- your rose tile: pair tile relative to new north; if DangerTile forbids it, the allowed tile of the same rank\n  function Z.b3roseTile(s)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local n = b.nn\n    local R = (n + K.ro) % 8\n    if not Z.b3danger(R) then return R end\n    local L = {}\n    for o = 0, 7 do\n      local t = (n + o) % 8\n      if not Z.b3danger(t) then L[#L + 1] = t end\n    end\n    return L[Z.B3_RANK[K.ro] or 1] or L[1] or R\n  end\n\n  -- plain tile to walk to after the drop (pair default; nearest plain tile if that one is red)\n  function Z.b3walkTile(s, px, pz)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local W = (b.nn + K.wo) % 8 + 8 * K.wr\n    if not Z.b3act(W) or not (px and pz) then return W end\n    local best, bd\n    for t = 0, 15 do\n      if not Z.b3act(t) then\n        local x, z = Z.b3spot(t, (t < 8) and 5.0 or 10.0)\n        local d = (x - px) * (x - px) + (z - pz) * (z - pz)\n        if bd == nil or d < bd then best, bd = t, d end\n      end\n    end\n    return best or W\n  end\nend\n-- Bloom 3: rose players walk off the red tile once the roses drop (names the plain tile)\nlocal b, s = Z.b3get and Z.b3get(), Z.slot()\nif b and s and b.roseSup ~= nil and b.roseSup == Z.isSup(s) then\n  local txt = \"Roses dropped: walk OFF the red tile\"\n  local p = TensorCore.mGetPlayer()\n  if Z.b3walkTile and p and p.pos and b.nn ~= nil then\n    local w = Z.b3walkTile(s, p.pos.x, p.pos.z)\n    if w then txt = txt .. \" -> \" .. ((w < 8) and \"inner \" or \"outer \") .. Z.dirName(22.5 + 45 * (w % 8)) end\n  end\n  hush(4000, txt, 0xFFFF66FF)\nend\nself.used = true",
							name = "[Draw] Bloom 3 - walk off red callout",
							uuid = "00bc3ccf-dd21-2f7f-8fb6-07786e821425",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				mechanicTime = 273.7,
				name = "[Draw] Bloom 3 - walk off red callout",
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 1.5,
				timerStartOffset = 0.2,
				uuid = "0465c62d-1568-f47d-b555-e65179806851",
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
				name = "Role Draws",
				uuid = "b2e9e800-7951-593b-bf54-79f922b01cd7",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 3 towers: even set (22.5+90k) -> new north NNE, odd set -> NNW\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif ent and ent.pos then\n  local a = math.deg(math.atan2(ent.pos.x - 100, 100 - ent.pos.z)) % 360\n  local par = math.floor((a - 22.5) / 45 + 0.5) % 2\n  Z.b3 = Z.b3 or {}\n  Z.b3.relN = (par == 0) and 22.5 or 337.5\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"51b7e138-ecc8-780e-9051-239abfc911bd",
									true,
								},
							},
							name = "[Draw] Bloom 3 - towers / new north",
							uuid = "894418d3-9707-5b07-bd45-0b87b6468466",
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
							eventSpellID = 43201,
							name = "Bloom towers",
							uuid = "51b7e138-ecc8-780e-9051-239abfc911bd",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 278,
				name = "[Draw] Bloom 3 - towers / new north (old)",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = -11.5,
				timerStartOffset = -14,
				uuid = "e094b3be-75b8-76f2-9639-ad2098dbdb6a",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 3: rose -> inner N/S/SW/SE, tower -> outer N/E/S/W (relative to new north)\nlocal b = Z.b3\nlocal s = Z.slot()\nif not (b and b.relN and b.roseSup ~= nil and s) then return end\nif b.roseSup == Z.isSup(s) then\n  if b.markT and Now() - b.markT > 6800 then return end\n  local x, z = Z.pt(100, 100, b.relN + Z.B3_ROSE[s], 5.0)\n  Z.goTo(x, z, 0xFF66FF, 1.2)\nelse\n  local x, z = Z.pt(100, 100, b.relN + Z.B3_TOWER[s], 12.0)\n  Z.goTo(x, z, 0x33FF33, 2.0)\nend\n",
							name = "[Draw] Bloom 3 - your rose / tower spot",
							uuid = "67bf227f-29de-91f5-883d-d3ac29d07fa7",
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
				mechanicTime = 278,
				name = "[Draw] Bloom 3 - your rose / tower spot (old)",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 0.3,
				timerStartOffset = -12.6,
				uuid = "33d62913-e5fb-1833-b793-b383941981b4",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 3 helpers (add to the shared PRE anywhere after `local Z = data.zel`; self-guarded, defined once per pull) =====\n-- Uses at call time: Z.pt, Z.slot, Z.slotOf, Z.isSup, Z.say, Z.dirName (existing PRE), and optionally Z.tiles / Z.tilesKnown / Z.tileT (tile tracker).\nif not Z.b3fnV2 then\n  Z.b3fnV2 = true\n  -- offsets in 45-degree tile steps from the NEW NORTH inner tile n (colour pairs T1/R1 N, H2/R2 E, T2/M2 S, H1/M1 W):\n  --   ro = inner rose tile, to = outer tower tile, wr/wo = plain tile to walk to after the drop (wr 1 = outer, 0 = inner)\n  Z.B3_K = {\n    T1 = {ro = 0, to = 0, wr = 0, wo = 2}, R1 = {ro = 0, to = 0, wr = 1, wo = 1},\n    H2 = {ro = 3, to = 2, wr = 1, wo = 3}, R2 = {ro = 3, to = 2, wr = 1, wo = 3},\n    T2 = {ro = 4, to = 4, wr = 0, wo = 6}, M2 = {ro = 4, to = 4, wr = 1, wo = 5},\n    H1 = {ro = 5, to = 6, wr = 0, wo = 6}, M1 = {ro = 5, to = 6, wr = 0, wo = 6}}\n  Z.B3_RANK = {[0] = 1, [3] = 2, [4] = 3, [5] = 4}\n  Z.B3_ROSEOFF = {[0] = true, [3] = true, [4] = true, [5] = true}\n  -- tiles {ring, offset} a correctly placed player of each slot stands on (votes for the party-position inference)\n  local XN, XE, XS, XW = {{0, 0}, {1, 0}}, {{0, 3}, {1, 2}, {1, 3}}, {{0, 4}, {1, 4}}, {{0, 5}, {1, 6}}\n  Z.B3_EXP = {T1 = XN, R1 = XN, H2 = XE, R2 = XE, T2 = XS, M2 = XS, H1 = XW, M1 = XW}\n\n  -- BossMod tile index of a world point (0-7 inner r<=8, 8-15 outer; k spans [45k, 45k+45) clockwise from north)\n  function Z.b3tile(x, z)\n    if not (x and z) then return nil end\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n\n  -- Bloom 3 pull state; a table older than 30 s (left over from an earlier pull if data was not reset) is replaced\n  function Z.b3get()\n    local now = Now()\n    local b = Z.b3\n    if type(b) ~= \"table\" or not b.t0 or now - b.t0 > 30000 then\n      b = {t0 = now}\n      Z.b3 = b\n    end\n    return b\n  end\n\n  -- point on the centre line of tile t at radius r\n  function Z.b3spot(t, r)\n    return Z.pt(100, 100, 22.5 + 45 * (t % 8), r)\n  end\n\n  -- new north from the tile tracker: the plain inner tile between the only two red inner tiles\n  function Z.b3fromTiles(par)\n    local T, TT, b = Z.tiles, Z.tileT, Z.b3\n    if not (Z.tilesKnown and type(T) == \"table\" and type(TT) == \"table\" and b and b.t0) then return nil end\n    -- only tiles that changed this bloom (from ~15 s before this state was created) count; stale tiles from earlier blooms are ignored\n    local since = b.t0 - 15000\n    local F, cnt = {}, 0\n    for t = 0, 7 do\n      if T[t] and TT[t] and TT[t] >= since then F[t] = true cnt = cnt + 1 end\n    end\n    if cnt ~= 2 then return nil end\n    local found\n    for n = 0, 7 do\n      if (par == nil or n % 2 == par) and not F[n] and F[(n + 7) % 8] and F[(n + 1) % 8] then\n        if found then return nil end\n        found = n\n      end\n    end\n    return found\n  end\n\n  -- new north from where the other 7 players stand (pairs pre-position on their rose tile relative to new north)\n  function Z.b3fromParty(par)\n    if not TensorCore.getEntityGroupList then return nil end\n    local list = TensorCore.getEntityGroupList(\"Party\")\n    if type(list) ~= \"table\" then return nil end\n    local me = TensorCore.mGetPlayer()\n    local myId = me and me.id\n    local sc, sf, nv = {}, {}, 0\n    for n = 0, 7 do sc[n] = 0 sf[n] = 0 end\n    for k, v in pairs(list) do\n      local id = (type(v) == \"table\") and (v.id or k) or v\n      local e = (type(v) == \"table\") and v or TensorCore.mGetEntity(v)\n      if type(e) == \"table\" and id and id ~= myId and e.pos then\n        local t = Z.b3tile(e.pos.x, e.pos.z)\n        local s = Z.slotOf(id)\n        local o = s and Z.B3_EXP[s]\n        if t then\n          if o then nv = nv + 1 end\n          for n = 0, 7 do\n            if par == nil or n % 2 == par then\n              if o then\n                for i = 1, #o do\n                  local q = o[i]\n                  if t == q[1] * 8 + (n + q[2]) % 8 then sc[n] = sc[n] + 1 break end\n                end\n              end\n              if t < 8 and Z.B3_ROSEOFF[(t - n) % 8] then sf[n] = sf[n] + 1 end\n            end\n          end\n        end\n      end\n    end\n    local S, needB, needM = sc, 3, 2\n    if nv < 4 then\n      if par == nil then return nil end\n      S, needB, needM = sf, 4, 2\n    elseif par == nil then\n      needB, needM = 4, 3\n    end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if par == nil or n % 2 == par then\n        local v = S[n]\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN ~= nil and best >= needB and best - second >= needM then return bestN end\n    return nil\n  end\n\n  -- new north from the 4 rose drops (correct drops land on inner n, n+3, n+4, n+5); real evidence, so it overrides every other source\n  function Z.b3fromDrops()\n    local b = Z.b3\n    if not (b and b.drops) then return end\n    local inner, m = {}, 0\n    for _, t in pairs(b.drops) do\n      if t and t < 8 and not inner[t] then inner[t] = true m = m + 1 end\n    end\n    if m < 3 then return end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if b.par == nil or n % 2 == b.par then\n        local v = 0\n        for o in pairs(Z.B3_ROSEOFF) do if inner[(n + o) % 8] then v = v + 1 end end\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN == nil or best < 3 or best <= second then return end\n    local old = b.nn\n    b.nn, b.nnSrc, b.relN, b.rtFor = bestN, \"drops\", 22.5 + 45 * bestN, nil\n    if old ~= nil and old ~= bestN then\n      local s = Z.slot()\n      local K = s and Z.B3_K[s]\n      if K and b.roseSup ~= nil and b.roseSup ~= Z.isSup(s) then\n        hush(4000, \"Bloom 3: new north was wrong -> your tower is \" .. Z.dirName(22.5 + 45 * ((bestN + K.to) % 8)), 0xFFFF3333)\n      end\n    end\n  end\n\n  -- pick the new north: tiles > party positions > tower parity guess (22.5 / 337.5); frozen once the roses drop\n  function Z.b3resolve()\n    local b = Z.b3\n    if not b then return end\n    local now = Now()\n    if b.resT and now - b.resT < 250 then return end\n    b.resT = now\n    if b.par ~= nil and b.nn ~= nil and b.nn % 2 ~= b.par then b.nn, b.nnSrc = nil, nil end\n    if b.nnSrc == \"tiles\" or b.nnSrc == \"drops\" then return end\n    if b.dropT and b.nn ~= nil then return end\n    local n, src = Z.b3fromTiles(b.par), \"tiles\"\n    if n == nil then n, src = Z.b3fromParty(b.par), \"party\" end\n    if n == nil then\n      if b.nnSrc == \"party\" or b.par == nil then return end\n      n, src = (b.par == 0) and 0 or 7, \"guess\"\n    end\n    if n ~= b.nn then b.rtFor = nil end\n    b.nn, b.nnSrc, b.relN = n, src, 22.5 + 45 * n\n  end\n\n  -- is tile t active (red / tower) right now? strict boolean\n  function Z.b3act(t)\n    local b = Z.b3\n    if not b or t == nil then return false end\n    if b.tw and b.tw[t] then return true end\n    if b.drops then for _, d in pairs(b.drops) do if d == t then return true end end end\n    local T = Z.tiles\n    if b.nnSrc == \"tiles\" then return (type(T) == \"table\" and T[t]) and true or false end\n    local n = b.nn\n    if n ~= nil then\n      if t < 8 then\n        local r = (t - n) % 8\n        if r == 1 or r == 7 then return true end\n      elseif (t - n) % 2 == 0 then\n        return true\n      end\n    end\n    if type(T) == \"table\" and T[t] and b.markT and type(Z.tileT) == \"table\" and Z.tileT[t] and Z.tileT[t] > b.markT then return true end\n    return false\n  end\n\n  -- BossMod Bloom3Emblazon.DangerTile: outer ring, active tiles, and inner \"side tiles\" are unsafe for roses\n  function Z.b3danger(t)\n    if t >= 8 then return true end\n    local A = Z.b3act\n    if A(t) then return true end\n    return A(t + 8) and (A((t + 1) % 8) ~= A((t + 7) % 8))\n  end\n\n  -- your rose tile: pair tile relative to new north; if DangerTile forbids it, the allowed tile of the same rank\n  function Z.b3roseTile(s)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local n = b.nn\n    local R = (n + K.ro) % 8\n    if not Z.b3danger(R) then return R end\n    local L = {}\n    for o = 0, 7 do\n      local t = (n + o) % 8\n      if not Z.b3danger(t) then L[#L + 1] = t end\n    end\n    return L[Z.B3_RANK[K.ro] or 1] or L[1] or R\n  end\n\n  -- plain tile to walk to after the drop (pair default; nearest plain tile if that one is red)\n  function Z.b3walkTile(s, px, pz)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local W = (b.nn + K.wo) % 8 + 8 * K.wr\n    if not Z.b3act(W) or not (px and pz) then return W end\n    local best, bd\n    for t = 0, 15 do\n      if not Z.b3act(t) then\n        local x, z = Z.b3spot(t, (t < 8) and 5.0 or 10.0)\n        local d = (x - px) * (x - px) + (z - pz) * (z - pz)\n        if bd == nil or d < bd then best, bd = t, d end\n      end\n    end\n    return best or W\n  end\nend\n-- Bloom 3 towers (43201 cast from the 4 outer tile centres): record tower tiles + parity, then resolve the new north\nlocal e = eventArgs\nif not (e and e.spellID == 43201) then self.used = true return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nif ent and ent.pos and Z.b3tile and Z.b3get then\n  local b = Z.b3get()\n  local t = Z.b3tile(ent.pos.x, ent.pos.z)\n  if t and t >= 8 then\n    b.tw = b.tw or {}\n    b.tw[t] = true\n    b.par = t % 2\n    b.resT = nil\n    if Z.b3resolve then Z.b3resolve() end\n  end\nend\nself.used = true",
							name = "[Draw] Bloom 3 - towers / new north",
							uuid = "c0420f98-164f-9b25-bdd7-6d66a998b48c",
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
				mechanicTime = 278,
				name = "[Draw] Bloom 3 - towers / new north",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = -11.5,
				timerStartOffset = -14,
				uuid = "32bba1f5-38f3-b9b1-bcda-174b007fe4cd",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- ===== Bloom 3 helpers (add to the shared PRE anywhere after `local Z = data.zel`; self-guarded, defined once per pull) =====\n-- Uses at call time: Z.pt, Z.slot, Z.slotOf, Z.isSup, Z.say, Z.dirName (existing PRE), and optionally Z.tiles / Z.tilesKnown / Z.tileT (tile tracker).\nif not Z.b3fnV2 then\n  Z.b3fnV2 = true\n  -- offsets in 45-degree tile steps from the NEW NORTH inner tile n (colour pairs T1/R1 N, H2/R2 E, T2/M2 S, H1/M1 W):\n  --   ro = inner rose tile, to = outer tower tile, wr/wo = plain tile to walk to after the drop (wr 1 = outer, 0 = inner)\n  Z.B3_K = {\n    T1 = {ro = 0, to = 0, wr = 0, wo = 2}, R1 = {ro = 0, to = 0, wr = 1, wo = 1},\n    H2 = {ro = 3, to = 2, wr = 1, wo = 3}, R2 = {ro = 3, to = 2, wr = 1, wo = 3},\n    T2 = {ro = 4, to = 4, wr = 0, wo = 6}, M2 = {ro = 4, to = 4, wr = 1, wo = 5},\n    H1 = {ro = 5, to = 6, wr = 0, wo = 6}, M1 = {ro = 5, to = 6, wr = 0, wo = 6}}\n  Z.B3_RANK = {[0] = 1, [3] = 2, [4] = 3, [5] = 4}\n  Z.B3_ROSEOFF = {[0] = true, [3] = true, [4] = true, [5] = true}\n  -- tiles {ring, offset} a correctly placed player of each slot stands on (votes for the party-position inference)\n  local XN, XE, XS, XW = {{0, 0}, {1, 0}}, {{0, 3}, {1, 2}, {1, 3}}, {{0, 4}, {1, 4}}, {{0, 5}, {1, 6}}\n  Z.B3_EXP = {T1 = XN, R1 = XN, H2 = XE, R2 = XE, T2 = XS, M2 = XS, H1 = XW, M1 = XW}\n\n  -- BossMod tile index of a world point (0-7 inner r<=8, 8-15 outer; k spans [45k, 45k+45) clockwise from north)\n  function Z.b3tile(x, z)\n    if not (x and z) then return nil end\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n\n  -- Bloom 3 pull state; a table older than 30 s (left over from an earlier pull if data was not reset) is replaced\n  function Z.b3get()\n    local now = Now()\n    local b = Z.b3\n    if type(b) ~= \"table\" or not b.t0 or now - b.t0 > 30000 then\n      b = {t0 = now}\n      Z.b3 = b\n    end\n    return b\n  end\n\n  -- point on the centre line of tile t at radius r\n  function Z.b3spot(t, r)\n    return Z.pt(100, 100, 22.5 + 45 * (t % 8), r)\n  end\n\n  -- new north from the tile tracker: the plain inner tile between the only two red inner tiles\n  function Z.b3fromTiles(par)\n    local T, TT, b = Z.tiles, Z.tileT, Z.b3\n    if not (Z.tilesKnown and type(T) == \"table\" and type(TT) == \"table\" and b and b.t0) then return nil end\n    -- only tiles that changed this bloom (from ~15 s before this state was created) count; stale tiles from earlier blooms are ignored\n    local since = b.t0 - 15000\n    local F, cnt = {}, 0\n    for t = 0, 7 do\n      if T[t] and TT[t] and TT[t] >= since then F[t] = true cnt = cnt + 1 end\n    end\n    if cnt ~= 2 then return nil end\n    local found\n    for n = 0, 7 do\n      if (par == nil or n % 2 == par) and not F[n] and F[(n + 7) % 8] and F[(n + 1) % 8] then\n        if found then return nil end\n        found = n\n      end\n    end\n    return found\n  end\n\n  -- new north from where the other 7 players stand (pairs pre-position on their rose tile relative to new north)\n  function Z.b3fromParty(par)\n    if not TensorCore.getEntityGroupList then return nil end\n    local list = TensorCore.getEntityGroupList(\"Party\")\n    if type(list) ~= \"table\" then return nil end\n    local me = TensorCore.mGetPlayer()\n    local myId = me and me.id\n    local sc, sf, nv = {}, {}, 0\n    for n = 0, 7 do sc[n] = 0 sf[n] = 0 end\n    for k, v in pairs(list) do\n      local id = (type(v) == \"table\") and (v.id or k) or v\n      local e = (type(v) == \"table\") and v or TensorCore.mGetEntity(v)\n      if type(e) == \"table\" and id and id ~= myId and e.pos then\n        local t = Z.b3tile(e.pos.x, e.pos.z)\n        local s = Z.slotOf(id)\n        local o = s and Z.B3_EXP[s]\n        if t then\n          if o then nv = nv + 1 end\n          for n = 0, 7 do\n            if par == nil or n % 2 == par then\n              if o then\n                for i = 1, #o do\n                  local q = o[i]\n                  if t == q[1] * 8 + (n + q[2]) % 8 then sc[n] = sc[n] + 1 break end\n                end\n              end\n              if t < 8 and Z.B3_ROSEOFF[(t - n) % 8] then sf[n] = sf[n] + 1 end\n            end\n          end\n        end\n      end\n    end\n    local S, needB, needM = sc, 3, 2\n    if nv < 4 then\n      if par == nil then return nil end\n      S, needB, needM = sf, 4, 2\n    elseif par == nil then\n      needB, needM = 4, 3\n    end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if par == nil or n % 2 == par then\n        local v = S[n]\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN ~= nil and best >= needB and best - second >= needM then return bestN end\n    return nil\n  end\n\n  -- new north from the 4 rose drops (correct drops land on inner n, n+3, n+4, n+5); real evidence, so it overrides every other source\n  function Z.b3fromDrops()\n    local b = Z.b3\n    if not (b and b.drops) then return end\n    local inner, m = {}, 0\n    for _, t in pairs(b.drops) do\n      if t and t < 8 and not inner[t] then inner[t] = true m = m + 1 end\n    end\n    if m < 3 then return end\n    local best, bestN, second = -1, nil, -1\n    for n = 0, 7 do\n      if b.par == nil or n % 2 == b.par then\n        local v = 0\n        for o in pairs(Z.B3_ROSEOFF) do if inner[(n + o) % 8] then v = v + 1 end end\n        if v > best then second, best, bestN = best, v, n elseif v > second then second = v end\n      end\n    end\n    if bestN == nil or best < 3 or best <= second then return end\n    local old = b.nn\n    b.nn, b.nnSrc, b.relN, b.rtFor = bestN, \"drops\", 22.5 + 45 * bestN, nil\n    if old ~= nil and old ~= bestN then\n      local s = Z.slot()\n      local K = s and Z.B3_K[s]\n      if K and b.roseSup ~= nil and b.roseSup ~= Z.isSup(s) then\n        hush(4000, \"Bloom 3: new north was wrong -> your tower is \" .. Z.dirName(22.5 + 45 * ((bestN + K.to) % 8)), 0xFFFF3333)\n      end\n    end\n  end\n\n  -- pick the new north: tiles > party positions > tower parity guess (22.5 / 337.5); frozen once the roses drop\n  function Z.b3resolve()\n    local b = Z.b3\n    if not b then return end\n    local now = Now()\n    if b.resT and now - b.resT < 250 then return end\n    b.resT = now\n    if b.par ~= nil and b.nn ~= nil and b.nn % 2 ~= b.par then b.nn, b.nnSrc = nil, nil end\n    if b.nnSrc == \"tiles\" or b.nnSrc == \"drops\" then return end\n    if b.dropT and b.nn ~= nil then return end\n    local n, src = Z.b3fromTiles(b.par), \"tiles\"\n    if n == nil then n, src = Z.b3fromParty(b.par), \"party\" end\n    if n == nil then\n      if b.nnSrc == \"party\" or b.par == nil then return end\n      n, src = (b.par == 0) and 0 or 7, \"guess\"\n    end\n    if n ~= b.nn then b.rtFor = nil end\n    b.nn, b.nnSrc, b.relN = n, src, 22.5 + 45 * n\n  end\n\n  -- is tile t active (red / tower) right now? strict boolean\n  function Z.b3act(t)\n    local b = Z.b3\n    if not b or t == nil then return false end\n    if b.tw and b.tw[t] then return true end\n    if b.drops then for _, d in pairs(b.drops) do if d == t then return true end end end\n    local T = Z.tiles\n    if b.nnSrc == \"tiles\" then return (type(T) == \"table\" and T[t]) and true or false end\n    local n = b.nn\n    if n ~= nil then\n      if t < 8 then\n        local r = (t - n) % 8\n        if r == 1 or r == 7 then return true end\n      elseif (t - n) % 2 == 0 then\n        return true\n      end\n    end\n    if type(T) == \"table\" and T[t] and b.markT and type(Z.tileT) == \"table\" and Z.tileT[t] and Z.tileT[t] > b.markT then return true end\n    return false\n  end\n\n  -- BossMod Bloom3Emblazon.DangerTile: outer ring, active tiles, and inner \"side tiles\" are unsafe for roses\n  function Z.b3danger(t)\n    if t >= 8 then return true end\n    local A = Z.b3act\n    if A(t) then return true end\n    return A(t + 8) and (A((t + 1) % 8) ~= A((t + 7) % 8))\n  end\n\n  -- your rose tile: pair tile relative to new north; if DangerTile forbids it, the allowed tile of the same rank\n  function Z.b3roseTile(s)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local n = b.nn\n    local R = (n + K.ro) % 8\n    if not Z.b3danger(R) then return R end\n    local L = {}\n    for o = 0, 7 do\n      local t = (n + o) % 8\n      if not Z.b3danger(t) then L[#L + 1] = t end\n    end\n    return L[Z.B3_RANK[K.ro] or 1] or L[1] or R\n  end\n\n  -- plain tile to walk to after the drop (pair default; nearest plain tile if that one is red)\n  function Z.b3walkTile(s, px, pz)\n    local b, K = Z.b3, Z.B3_K[s]\n    if not (b and b.nn ~= nil and K) then return nil end\n    local W = (b.nn + K.wo) % 8 + 8 * K.wr\n    if not Z.b3act(W) or not (px and pz) then return W end\n    local best, bd\n    for t = 0, 15 do\n      if not Z.b3act(t) then\n        local x, z = Z.b3spot(t, (t < 8) and 5.0 or 10.0)\n        local d = (x - px) * (x - px) + (z - pz) * (z - pz)\n        if bd == nil or d < bd then best, bd = t, d end\n      end\n    end\n    return best or W\n  end\nend\n-- Bloom 3: draw ONLY your own destination. Before markers: your pair's rose tile (cyan pre-position, only when the new north\n-- is known from tiles / party positions). Tower player: your tower itself (green ring on the tower). Rose player: your inner\n-- rose tile (pink), then after the drop the plain tile to walk to (yellow). New north = tiles > party positions > parity.\nlocal s = Z.slot()\nlocal K = s and Z.B3_K and Z.B3_K[s]\nif not (K and Z.b3get) then return end\nlocal b = Z.b3get()\nZ.b3resolve()\nlocal n = b.nn\nif n == nil then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\n-- arrow only while outside the circle; once inside just the circle\nlocal function mark(x, z, col, rad)\n  if TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, x, p.pos.y, z) > rad then\n    Z.goTo(x, z, col, rad)\n  else\n    TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2):addCircle(x, p.pos.y, z, rad, false, Z.flags)\n  end\nend\nif b.roseSup == nil then\n  if b.nnSrc == \"guess\" then return end\n  -- early party-position lock (window opens at 256) can flicker wrong for 1-3 s: only show once it has held 1.5 s\n  if b.preN ~= n then b.preN, b.preT = n, Now() end\n  if b.nnSrc == \"party\" and Now() - b.preT < 1500 then return end\n  local x, z = Z.b3spot((n + K.ro) % 8, 5.5)\n  mark(x, z, 0x00FFFF, 0.8)\n  return\nend\nif b.roseSup ~= Z.isSup(s) then\n  -- your tower: 43201 sits at r=12 on the outer tile centre\n  local x, z = Z.b3spot((n + K.to) % 8 + 8, 12.0)\n  mark(x, z, 0x33FF33, 2.5)\n  return\nend\nif b.myDropT or (b.markT and Now() - b.markT > 7200) then\n  local w = Z.b3walkTile(s, p.pos.x, p.pos.z)\n  if w then\n    local wx, wz = Z.b3spot(w, (w < 8) and 5.0 or 10.0)\n    mark(wx, wz, 0xFFFF00, 1.2)\n  end\n  return\nend\nif b.rtFor ~= n then b.rt, b.rtFor = Z.b3roseTile(s), n end\nif b.rt == nil then return end\nlocal x, z = Z.b3spot(b.rt, 5.5)\nmark(x, z, 0xFF66FF, 1.0)\n",
							name = "[Draw] Bloom 3 - your rose / tower spot",
							uuid = "d2a85b44-0cc7-7073-a3d4-a0f065d0f0c7",
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
				mechanicTime = 278,
				name = "[Draw] Bloom 3 - your rose / tower spot",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 0.4,
				timerStartOffset = -22,
				uuid = "e8656190-b9b4-8dde-9eda-91b601fa9b2e",
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
				name = "Role Draws",
				uuid = "256af479-319e-3c61-b6fb-0f3b68e2def1",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- EF2 donuts (580): donut players go out to their clock spot\nlocal e = eventArgs\nif not (e and e.markerID == 580) then self.used = true return end\nif not Z.donuts or Now() - Z.donuts.t > 30000 then Z.donuts = {t = Now(), ids = {}} end\nZ.donuts.ids[e.entityID] = true\nlocal p = TensorCore.mGetPlayer()\nif p and e.entityID == p.id then hush(7000, \"DONUT: go OUT to your clock spot\", 0xFF33FF33) end\nself.used = true\n",
							name = "[Draw] Escelons' Fall 2 - donut markers",
							uuid = "43779ea7-7503-336a-b60a-b1f810fc1af2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 304.8,
				name = "[Draw] Escelons' Fall 2 - donut markers",
				timeRange = true,
				timelineIndex = 54,
				timerEndOffset = 3.5,
				timerStartOffset = -1,
				uuid = "40aa5e80-f06d-e6c7-bd5c-c178564914a0",
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
				name = "Role Draws",
				uuid = "b2134337-3135-2997-a360-cf1acdc0482f",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- EF2 (Braindead): donuts out to their clock spot (~10y), everyone else stacks center\nlocal s = Z.slot()\nlocal p = TensorCore.mGetPlayer()\nif not (s and p) then return end\nlocal cx, cz = 100, 100\nlocal b = Z.ef and TensorCore.mGetEntity(Z.ef.boss)\nif b and b.pos then cx, cz = b.pos.x, b.pos.z end\n-- only once the donut markers are out (not during Bud of Valor before them)\nif not (Z.donuts and Now() - Z.donuts.t < 30000) then return end\nlocal dn = Z.donuts.ids[p.id]\nif dn then\n  local x, z = Z.pt(cx, cz, Z.EF_CLOCK[s] or 0, 10.0)\n  Z.goTo(x, z, 0x33FF33, 1.5)\nelse\n  Z.goTo(cx, cz, 0x00FFFF, 1.5)\nend\n",
							name = "[Draw] Escelons' Fall 2 - donuts out / stack center",
							uuid = "6ca61f18-5ad2-dd5c-82be-30d1e80c48a6",
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
				mechanicTime = 314.7,
				name = "[Draw] Escelons' Fall 2 - donuts out / stack center",
				timeRange = true,
				timelineIndex = 56,
				timerEndOffset = 0.5,
				timerStartOffset = -19,
				uuid = "4eec46a5-8f16-f1a3-8517-a799630f04dd",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- EF2: my donut drop (Shock 43178 cast from a helper at the holder's spot)\nif not eventArgs then self.used = true return end\nif eventArgs.spellID == 43178 then\n  local c = TensorCore.mGetEntity(eventArgs.entityID)\n  local p = TensorCore.mGetPlayer()\n  if c and c.pos and p and p.pos then\n    local dx, dz = c.pos.x - p.pos.x, c.pos.z - p.pos.z\n    if dx * dx + dz * dz < 6.25 then Z.dnDrop = Now() end\n  end\nend\nself.used = true\n",
							name = "[Draw] Escelons' Fall 2 - donut drop tracker",
							uuid = "a33e4206-7d7b-7380-8b01-79d864d83b55",
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
				mechanicTime = 314.7,
				name = "[Draw] Escelons' Fall 2 - donut drop tracker",
				timeRange = true,
				timelineIndex = 56,
				timerEndOffset = 2,
				timerStartOffset = -4,
				uuid = "f91f4fa5-ee1c-9e4d-9659-e62e4e1b4335",
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
				uuid = "fb1a26f8-d8c6-9368-8c9f-31e949e83a83",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall cast start: new symbol list\nZ.ef = {t0 = Now(), sym = {}, boss = eventArgs.entityID, mode = 2}\nself.used = true\n",
							conditions = 
							{
								
								{
									"ed528bd3-888d-ef9c-88ea-9ea6935e7cdc",
									true,
								},
							},
							name = "[Draw] Escelons' Fall 2 - cast start",
							uuid = "dc5538d2-b3b2-7020-9c2b-3c1c20a823e2",
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
							eventSpellID = 43181,
							name = "Escelons' Fall",
							uuid = "ed528bd3-888d-ef9c-88ea-9ea6935e7cdc",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 319.8,
				name = "[Draw] Escelons' Fall 2 - cast start",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = -11.5,
				timerStartOffset = -14.5,
				uuid = "a49857b0-f112-3a58-ad5f-2dbbdbf1ce0a",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall symbols on the boss: 2127 = near, 2128 = far\nlocal e, ef = eventArgs, Z.ef\nif not (e and ef and e.entityID == ef.boss) then self.used = true return end\nlocal v = e.newActiveAura1\nif (v == 2127 or v == 2128) and #ef.sym < 4 then\n  ef.sym[#ef.sym + 1] = (v == 2127) and \"N\" or \"F\"\n  if #ef.sym == 4 then\n    local a, b, c, d = Z.efState(1), Z.efState(2), Z.efState(3), Z.efState(4)\n    if a and b and c and d then hush(9000, \"EF: \" .. a .. \" > \" .. b .. \" > \" .. c .. \" > \" .. d, 0xFF00FFFF) end\n  end\nend\nself.used = true\n",
							name = "[Draw] Escelons' Fall 2 - symbols",
							uuid = "32da9e30-24f8-6266-8d12-776c17c4986a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 25,
				loop = true,
				mechanicTime = 319.8,
				name = "[Draw] Escelons' Fall 2 - symbols",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = -0.5,
				timerStartOffset = -13,
				uuid = "568e238c-6b84-64c6-ba81-27eac6b8aeca",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- EF2 Witch Hunt: same as EF1 - clock spot, DPS start in, supports out, then follow the symbols\nlocal ef = Z.ef\nlocal p = TensorCore.mGetPlayer()\nlocal s = Z.slot()\nif not (ef and p and p.pos and s and ef.mode == 2) then return end\n-- donut holder: stand still until 4.5 s after my donut dropped (fallback: marker + 8 s), then go\nlocal dn = Z.donuts and Now() - Z.donuts.t < 30000 and Z.donuts.ids[p.id]\nif dn then\n  local drop = Z.dnDrop or (Z.donuts.t + 8000)\n  if Now() < drop + 4500 then\n    TensorCore.getCachedDrawer(0x3300FFFF, 0x5500FFFF, 0x8800FFFF, 0xFF00FFFF, 2):addCircle(p.pos.x, p.pos.y, p.pos.z, 0.7, false, Z.flags)\n    if not Z.dnSaid then Z.dnSaid = true; Z.say(4000, \"STAND STILL\", 0xFF00FFFF) end\n    return\n  elseif not Z.dnGo then\n    Z.dnGo = true; Z.say(2500, \"GO\", 0xFF33FF33)\n  end\nend\nlocal el = (Now() - ef.t0) / 1000\nlocal k\nfor i = 1, 4 do if el < Z.EF_HIT[i] + 0.3 then k = i break end end\nif not k then return end\nlocal st = Z.efState(k)\nif not st then\n  if k ~= 1 then return end\n  st = Z.isSup(s) and \"OUT\" or \"IN\"\nend\nlocal cx, cz = 100, 100\nlocal b = TensorCore.mGetEntity(ef.boss)\nif b and b.pos then cx, cz = b.pos.x, b.pos.z end\nlocal x, z = Z.pt(cx, cz, Z.EF_CLOCK[s] or 0, st == \"IN\" and 3.0 or 10.0)\nZ.goTo(x, z, st == \"IN\" and 0x33FF33 or 0x0099FF, 0.8)\n",
							name = "[Draw] Escelons' Fall 2 - in/out spot (clocks)",
							uuid = "505f5690-c2e8-a93e-9804-34ae45fd56b1",
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
				mechanicTime = 319.8,
				name = "[Draw] Escelons' Fall 2 - in/out spot (clocks)",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = 10.4,
				timerStartOffset = -4.4,
				uuid = "371bb03c-8165-f8ee-9d8f-334c755147d6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Melee Optimization",
				uuid = "3df01fc9-4fc0-f975-9112-f2137ddeaf3b",
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
									"ee412d7d-2457-8566-ac88-a9ebc0616040",
									true,
								},
								
								{
									"88172ace-f260-919b-bf90-c9ca43b70f2d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper4_Hotbar_Slither",
							uuid = "6987d52e-f495-63c3-b833-2c45047293f2",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 36951,
							conditions = 
							{
								
								{
									"432a074d-9973-8eaf-830a-da05d7fc3633",
									true,
								},
								
								{
									"88172ace-f260-919b-bf90-c9ca43b70f2d",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Current Target",
							uuid = "108def30-603d-7a13-bb40-a192ecd45a5c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 25762,
							conditions = 
							{
								
								{
									"e4ea10a1-8115-194e-9f25-f9d7e4cd402e",
									true,
								},
								
								{
									"88172ace-f260-919b-bf90-c9ca43b70f2d",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Current Target",
							uuid = "13f7ae06-deb7-83f6-a151-0d06d3616970",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7492,
							conditions = 
							{
								
								{
									"d94aad71-0bd6-1f34-a555-ff89dc45f93a",
									true,
								},
								
								{
									"88172ace-f260-919b-bf90-c9ca43b70f2d",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Current Target",
							uuid = "91ac78f7-d2fc-168e-94f3-55bef55a176a",
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
							conditionLua = "-- EF2 donut placed (GO, 4.5 s after my drop) and my next EF spot is IN, far from the boss\nlocal Z = data.zel\nif not (Z and Z.ef and Z.ef.mode == 2 and Z.dnDrop and Z.donuts and Z.efState and Z.EF_HIT) then return false end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos and Z.donuts.ids[p.id]) then return false end\nlocal now = Now()\nif now < Z.dnDrop + 4500 or now > Z.dnDrop + 9000 then return false end\nlocal el = (now - Z.ef.t0) / 1000\nlocal k\nfor i = 1, 4 do if el < Z.EF_HIT[i] + 0.3 then k = i break end end\nif not k then return false end\nlocal st = Z.efState(k)\nif not st and k == 1 then st = Z.isSup(Z.slot()) and \"OUT\" or \"IN\" end\nif st ~= \"IN\" then return false end\nlocal b = TensorCore.mGetEntity(Z.ef.boss)\nif not (b and b.pos) then return false end\nreturn TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, b.pos.x, p.pos.y, b.pos.z) > 6\n",
							name = "Donut placed, next spot IN",
							uuid = "88172ace-f260-919b-bf90-c9ca43b70f2d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Viper",
							uuid = "ee412d7d-2457-8566-ac88-a9ebc0616040",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "DRAGOON",
							name = "Dragoon",
							uuid = "432a074d-9973-8eaf-830a-da05d7fc3633",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "Monk",
							uuid = "e4ea10a1-8115-194e-9f25-f9d7e4cd402e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "SAMURAI",
							name = "Samurai",
							uuid = "d94aad71-0bd6-1f34-a555-ff89dc45f93a",
							version = 3,
						},
					},
				},
				displayPath = "Melee Optimization",
				mechanicTime = 319.8,
				name = "[Melee] EF2 - gap closer after donut drop",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "c5da6403-4e79-b0f5-b35b-3cbfa17d3df5",
				version = 2,
			},
		},
	},
	[62] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "6e7a51dd-66cb-874f-9cee-84967d87a5f9",
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
							actionID = 7549,
							conditions = 
							{
								
								{
									"ac8c3c71-d676-a484-8393-24094c1ddb45",
									true,
								},
								
								{
									"b8cd8704-352c-5905-a5c4-da888b24514d",
									true,
								},
								
								{
									"f258714a-6411-14b1-94ad-07da9ec5a9be",
									true,
								},
								
								{
									"f2573029-0490-afd2-84be-3934679fcfdc",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Enemy",
							uuid = "cb8eeedf-2381-ba6c-be30-78c83da02c1d",
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
							uuid = "ac8c3c71-d676-a484-8393-24094c1ddb45",
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
							uuid = "b8cd8704-352c-5905-a5c4-da888b24514d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "f258714a-6411-14b1-94ad-07da9ec5a9be",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "f2573029-0490-afd2-84be-3934679fcfdc",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 339,
				name = "[VPR] Feint - Stock Break x5 (339)",
				timeRange = true,
				timelineIndex = 62,
				timerEndOffset = -2,
				timerStartOffset = -6,
				uuid = "8624e1b9-416c-335b-a981-ba2d301bb8b0",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "c0756bfc-d024-08b1-942b-bc565ac39955",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: ring on the stack target for all 5 hits\nlocal e = eventArgs\nif not (e and e.markerID == 590) then self.used = true return end\nZ.sb = {id = e.entityID, t = Now()}\nTensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xFF00FFFF, 3):addTimedCircleOnEnt(11500, e.entityID, 5.0, 0, false, true, Z.flags)\nself.used = true\n",
							name = "[Draw] Stock Break - stack ring",
							uuid = "66c0cbe7-0a50-c5d0-8b70-4e6811041fe8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 339,
				name = "[Draw] Stock Break - stack ring",
				timeRange = true,
				timelineIndex = 62,
				timerEndOffset = -5.5,
				timerStartOffset = -8.5,
				uuid = "437b046d-6f9f-2c76-9132-9b242b38562d",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: arrow to the stack target when you are not in it\nlocal sb = Z.sb\nlocal p = TensorCore.mGetPlayer()\nif not (sb and p and p.pos) or sb.id == p.id or Now() - sb.t > 11500 then return end\nlocal t = TensorCore.mGetEntity(sb.id)\nif not (t and t.pos) then return end\nif TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, t.pos.x, p.pos.y, t.pos.z) > 3.0 then\n  Z.goTo(t.pos.x, t.pos.z, 0x00FFFF, 0.6)\nend\n",
							name = "[Draw] Stock Break - go stack",
							uuid = "1867c03f-5eba-6b64-8ab9-51fc7e3a4b81",
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
				mechanicTime = 339,
				name = "[Draw] Stock Break - go stack",
				timeRange = true,
				timelineIndex = 62,
				timerEndOffset = 4.6,
				timerStartOffset = -7.2,
				uuid = "c9620b2c-d02e-b121-8c09-f7e8b111ce42",
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
				name = "Role Draws",
				uuid = "f40e0342-4025-9194-8ff8-a4a72aa035d8",
			},
			objectType = "folder",
		},
	},
	[66] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "40d39612-435d-aec8-bf31-e17e4a563c39",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 4 rose markers (592)\nlocal e = eventArgs\nif not (e and e.markerID == 592) then self.used = true return end\nZ.b4 = Z.b4 or {}\nif Z.b4.roseSup == nil then\n  Z.b4.roseSup = Z.supOf(e.entityID)\n  local s = Z.slot()\n  if s then hush(6000, (Z.b4.roseSup == Z.isSup(s)) and \"ROSE: go OPPOSITE the ground AoEs\" or \"SPREAD: by the ground AoEs, off the red tiles\", 0xFFFF66FF) end\nend\nself.used = true\n",
							name = "[Draw] Bloom 4 - rose markers",
							uuid = "d8ebb7cd-2b39-4876-bc97-505206b9c082",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 357.5,
				name = "[Draw] Bloom 4 - rose markers",
				timeRange = true,
				timelineIndex = 66,
				timerEndOffset = 3.5,
				timerStartOffset = -1,
				uuid = "16e83e03-9b3b-7dc4-af01-2194b24be667",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 4: the two ground AoEs point at the spread side\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif ent and ent.pos then\n  Z.b4 = Z.b4 or {}\n  Z.b4.gx = (Z.b4.gx or 0) + (ent.pos.x - 100)\n  Z.b4.gz = (Z.b4.gz or 0) + (ent.pos.z - 100)\n  Z.b4.gT = Z.b4.gT or Now()\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"0ab61ebb-99d5-286c-90ba-5bf6fe146ac2",
									true,
								},
							},
							name = "[Draw] Bloom 4 - ground AoEs",
							uuid = "fc5289e2-27e6-aaf0-9af6-9dbfbb30ca6f",
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
							eventSpellID = 43238,
							name = "Bloom 4 ground AoE",
							uuid = "0ab61ebb-99d5-286c-90ba-5bf6fe146ac2",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 357.5,
				name = "[Draw] Bloom 4 - ground AoEs",
				timeRange = true,
				timelineIndex = 66,
				timerEndOffset = 3,
				timerStartOffset = -1,
				uuid = "a462a310-9e3c-da52-a2f5-9e87c773055a",
				version = 2,
			},
		},
	},
	[67] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "6373b48a-4f54-1203-9c7d-4bc3a90e40e6",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 4: spreads near the ground AoEs, roses opposite (G1 left, G2 right)\nlocal b = Z.b4\nlocal s = Z.slot()\nif not (b and b.gT and b.roseSup ~= nil and s) then return end\nif Now() - b.gT > 7600 then return end\nlocal rose = (b.roseSup == Z.isSup(s))\nlocal spot = rose and Z.B4_ROSE[s] or Z.B4_SPREAD[s]\nif not spot then return end\nlocal dir = math.deg(math.atan2(b.gx, -b.gz))\nlocal x, z = Z.pt(100, 100, dir + spot[1], spot[2])\nZ.goTo(x, z, rose and 0xFF66FF or 0x0099FF, 1.0)\n",
							name = "[Draw] Bloom 4 - your rose / spread spot",
							uuid = "feadf608-3d63-20e7-bd42-6c2651ae7c6d",
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
				mechanicTime = 365.1,
				name = "[Draw] Bloom 4 - your rose / spread spot (old)",
				timeRange = true,
				timelineIndex = 67,
				timerEndOffset = 0.6,
				timerStartOffset = -7.2,
				uuid = "19afdb14-6290-ff6e-85d9-ea921c6e69ed",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nZ.say(4500, \"STACK tight in a safe inner tile (Thorns)\", 0xFFFFFF00)\nself.used = true\n",
							name = "[Draw] Bloom 4 - stack for thorns",
							uuid = "7677d646-88fe-4d7c-ac5d-9b4ea5918dd6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				mechanicTime = 365.1,
				name = "[Draw] Bloom 4 - stack for thorns (old)",
				timeRange = true,
				timelineIndex = 67,
				timerEndOffset = 1.5,
				timerStartOffset = 0.2,
				uuid = "67cbf581-0daf-45fe-9260-77b4883e9e74",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not Z.tileHV1 then\n  Z.tileHV1 = true\n  -- floor tiles (BossMod Ex4Zelenia numbering): 0-7 inner ring (r <= 8), 8-15 outer ring (8 < r <= 16);\n  -- tile t%8 = k spans [45k, 45k+45) degrees clockwise from north (centre 22.5 + 45k). Z.tiles[t] = true while red.\n  Z.tiles = Z.tiles or {}\n  Z.tileT = Z.tileT or {}\n  function Z.tileAngle(t) return 22.5 + 45 * (t % 8) end\n  function Z.tileCenter(t) return Z.pt(100, 100, Z.tileAngle(t), (t < 8) and 4 or 12) end\n  function Z.tilePoint(t, frac)\n    local r0 = (t < 8) and 0 or 8\n    return Z.pt(100, 100, Z.tileAngle(t), r0 + 8 * (frac or 0.5))\n  end\n  function Z.tileOf(x, z)\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n  function Z.tileEdges(t)\n    if t == 0 then return {7, 1, 8} elseif t == 7 then return {6, 0, 15}\n    elseif t == 8 then return {15, 9, 0} elseif t == 15 then return {14, 8, 7} end\n    return {t - 1, t + 1, (t > 8) and (t - 8) or (t + 8)}\n  end\n  function Z.connected(t)\n    local set = {}\n    if not (t and Z.tiles[t]) then return set end\n    local q, h = {t}, 1\n    set[t] = true\n    while q[h] do\n      local v = q[h]; h = h + 1\n      for _, w in ipairs(Z.tileEdges(v)) do\n        if Z.tiles[w] and not set[w] then set[w] = true; q[#q + 1] = w end\n      end\n    end\n    return set\n  end\nend\n-- Bloom 4: roses opposite the ground AoEs, spreads by them. Angles are relative to G (the ground-AoE side), + = clockwise.\n-- Floor variants: in some pulls (2311, 2303) the outer tile at the T2/M2 spread spot (G+21, r9.5) is pre-red -> T2/M2 uses\n-- (G-30, r12) instead. Only decidable if the tile tracker sees the Bloom 4 floor pattern; otherwise both spots are shown.\nlocal b = Z.b4\nlocal s = Z.slot()\nif not (b and b.gT and b.gz and b.gz ~= 0 and b.roseSup ~= nil and s) then return end\nlocal now = Now()\nif now - b.gT > 7600 then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal G = (b.gz > 0) and 180 or 0\nif b.roseSup == Z.isSup(s) then\n  local rs = Z.B4_ROSE and Z.B4_ROSE[s]\n  if not rs then return end\n  local rx, rz = Z.pt(100, 100, G + rs[1], rs[2])\n  Z.goTo(rx, rz, 0xFF66FF, 1.0)\n  return\nend\nlocal sp = Z.B4_SPREAD and Z.B4_SPREAD[s]\nif not sp then return end\nlocal rel, r = sp[1], sp[2]\nlocal axisOuter = (s == \"T2\" or s == \"M2\")\nlocal v = b.var\nif axisOuter and v == nil and Z.tilesKnown and Z.tiles and Z.tileT and Z.tileOf then\n  -- only trust tiles that changed after Bloom 4 started and before the rose drop (i.e. the floor pattern itself)\n  local known = false\n  for t = 0, 15 do\n    local tt = Z.tileT[t]\n    if Z.tiles[t] and tt and now - tt < 16000 and tt - b.gT < 6500 then\n      known = true\n      break\n    end\n  end\n  if known then\n    local ax, az = Z.pt(100, 100, G + rel, r)\n    local at = Z.tileOf(ax, az)\n    local tt = at and Z.tileT[at]\n    v = (at and Z.tiles[at] and tt and now - tt < 16000) and \"B\" or \"A\"\n    b.var = v\n  end\nend\nif axisOuter and v == \"B\" then rel, r = -30, 12 end\nlocal x, z = Z.pt(100, 100, G + rel, r)\nZ.goTo(x, z, 0x0099FF, 1.0)\nlocal py = p.pos.y\nif axisOuter and v == nil then\n  local ax, az = Z.pt(100, 100, G - 30, 12)\n  TensorCore.getCachedDrawer(0x22FFFFFF, 0x44FFFFFF, 0x88FFFFFF, 0xFFFFFFFF, 2):addCircle(ax, py, az, 1.0, false, Z.flags)\n  if not b.altSaid then\n    b.altSaid = true\n    hush(7000, \"SPREAD: if the OUTER tile under your arrow is RED, use the WHITE ring\", 0xFFFFFFFF)\n  end\nend\n-- your spread (r4) and the two always-red flank tiles it must not touch\nTensorCore.getCachedDrawer(0x103333FF, 0x183333FF, 0x283333FF, 0xFF3333FF, 2):addCircle(p.pos.x, py, p.pos.z, 4.0, false, Z.flags)\nlocal d = TensorCore.getStaticDrawer(0xFF3333FF, 2)\nfor f = 0, 1 do\n  local a0 = G - 135\n  if f == 0 then a0 = G + 90 end\n  local pix, piz, pox, poz\n  for i = 0, 3 do\n    local aa = a0 + 15 * i\n    local ix, iz = Z.pt(100, 100, aa, 8)\n    local ox, oz = Z.pt(100, 100, aa, 15.8)\n    if i == 0 or i == 3 then d:addLine(ix, py, iz, ox, py, oz, 2) end\n    if pix then\n      d:addLine(pix, py, piz, ix, py, iz, 2)\n      d:addLine(pox, py, poz, ox, py, oz, 2)\n    end\n    pix, piz, pox, poz = ix, iz, ox, oz\n  end\nend\n",
							name = "[Draw] Bloom 4 - your rose / spread spot",
							uuid = "a27e730f-64d7-80a6-8052-66eec56ceebf",
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
				mechanicTime = 365.1,
				name = "[Draw] Bloom 4 - your rose / spread spot",
				timeRange = true,
				timelineIndex = 67,
				timerEndOffset = 0.6,
				timerStartOffset = -7.2,
				uuid = "1864d542-374b-4465-829e-2964695bdf6c",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not Z.tileHV1 then\n  Z.tileHV1 = true\n  -- floor tiles (BossMod Ex4Zelenia numbering): 0-7 inner ring (r <= 8), 8-15 outer ring (8 < r <= 16);\n  -- tile t%8 = k spans [45k, 45k+45) degrees clockwise from north (centre 22.5 + 45k). Z.tiles[t] = true while red.\n  Z.tiles = Z.tiles or {}\n  Z.tileT = Z.tileT or {}\n  function Z.tileAngle(t) return 22.5 + 45 * (t % 8) end\n  function Z.tileCenter(t) return Z.pt(100, 100, Z.tileAngle(t), (t < 8) and 4 or 12) end\n  function Z.tilePoint(t, frac)\n    local r0 = (t < 8) and 0 or 8\n    return Z.pt(100, 100, Z.tileAngle(t), r0 + 8 * (frac or 0.5))\n  end\n  function Z.tileOf(x, z)\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n  function Z.tileEdges(t)\n    if t == 0 then return {7, 1, 8} elseif t == 7 then return {6, 0, 15}\n    elseif t == 8 then return {15, 9, 0} elseif t == 15 then return {14, 8, 7} end\n    return {t - 1, t + 1, (t > 8) and (t - 8) or (t + 8)}\n  end\n  function Z.connected(t)\n    local set = {}\n    if not (t and Z.tiles[t]) then return set end\n    local q, h = {t}, 1\n    set[t] = true\n    while q[h] do\n      local v = q[h]; h = h + 1\n      for _, w in ipairs(Z.tileEdges(v)) do\n        if Z.tiles[w] and not set[w] then set[w] = true; q[#q + 1] = w end\n      end\n    end\n    return set\n  end\nend\n-- Bloom 4: after the spreads, tell everyone where the thorns stack is (fires once, after the spreads resolve)\nlocal b = Z.b4\nif b and b.gz and b.gz ~= 0 then\n  local G = (b.gz > 0) and 180 or 0\n  hush(5000, \"NEXT: STACK TIGHT at the boss's \" .. Z.dirName(G) .. \" side (yellow) - WAIT there for the chains\", 0xFFFFFF00)\nelse\n  hush(5000, \"NEXT: STACK TIGHT next to the boss on the ground-AoE side - WAIT for the chains\", 0xFFFFFF00)\nend\nself.used = true\n",
							name = "[Draw] Bloom 4 - stack for thorns",
							uuid = "b671acdd-b535-c363-bf82-dccdadbcb0cc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				mechanicTime = 365.1,
				name = "[Draw] Bloom 4 - stack for thorns",
				timeRange = true,
				timelineIndex = 67,
				timerEndOffset = 2,
				timerStartOffset = 0.8,
				uuid = "13732bfc-9bfb-cfa0-8f7b-d00e53f630e5",
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
				name = "Role Draws",
				uuid = "1b8ab05a-8403-b075-8a05-25c190e83b40",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nZ.say(6000, \"THORNS: supports WEST, DPS EAST (DPS share via red tiles)\", 0xFFFFFF00)\nself.used = true\n",
							name = "[Draw] Bloom 4 - thorns callout",
							uuid = "e32a4ab3-d6c4-c11f-a49c-a35f2ae92889",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				mechanicTime = 369.8,
				name = "[Draw] Bloom 4 - thorns callout (old)",
				timeRange = true,
				timelineIndex = 69,
				timerEndOffset = 1.5,
				uuid = "c483b8e2-8e55-c92e-9b91-4dbbbcf078d0",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not Z.tileHV1 then\n  Z.tileHV1 = true\n  -- floor tiles (BossMod Ex4Zelenia numbering): 0-7 inner ring (r <= 8), 8-15 outer ring (8 < r <= 16);\n  -- tile t%8 = k spans [45k, 45k+45) degrees clockwise from north (centre 22.5 + 45k). Z.tiles[t] = true while red.\n  Z.tiles = Z.tiles or {}\n  Z.tileT = Z.tileT or {}\n  function Z.tileAngle(t) return 22.5 + 45 * (t % 8) end\n  function Z.tileCenter(t) return Z.pt(100, 100, Z.tileAngle(t), (t < 8) and 4 or 12) end\n  function Z.tilePoint(t, frac)\n    local r0 = (t < 8) and 0 or 8\n    return Z.pt(100, 100, Z.tileAngle(t), r0 + 8 * (frac or 0.5))\n  end\n  function Z.tileOf(x, z)\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n  function Z.tileEdges(t)\n    if t == 0 then return {7, 1, 8} elseif t == 7 then return {6, 0, 15}\n    elseif t == 8 then return {15, 9, 0} elseif t == 15 then return {14, 8, 7} end\n    return {t - 1, t + 1, (t > 8) and (t - 8) or (t + 8)}\n  end\n  function Z.connected(t)\n    local set = {}\n    if not (t and Z.tiles[t]) then return set end\n    local q, h = {t}, 1\n    set[t] = true\n    while q[h] do\n      local v = q[h]; h = h + 1\n      for _, w in ipairs(Z.tileEdges(v)) do\n        if Z.tiles[w] and not set[w] then set[w] = true; q[#q + 1] = w end\n      end\n    end\n    return set\n  end\nend\n-- Bloom 4 Encircling Thorns: chain (tether 18) tracker. Remembers when the chains appear, your partner, and when yours breaks.\nlocal e = eventArgs\nif not e then self.used = true return end\nZ.b4 = Z.b4 or {}\nlocal b = Z.b4\nlocal p = TensorCore.mGetPlayer()\nlocal me = p and p.id\nif e.newTetherID == 18 then\n  b.tT = b.tT or Now()\n  if me and (e.sourceEntityID == me or e.newTargetID == me) then\n    local other = (e.sourceEntityID == me) and e.newTargetID or e.sourceEntityID\n    local s = Z.slot()\n    b.myP = other\n    b.mySrc = (e.sourceEntityID == me)\n    b.myBroke = nil\n    b.mySame = (s ~= nil and other ~= nil and Z.supOf(other) == Z.isSup(s)) or false\n    if b.mySame then\n      hush(5000, \"CHAIN to your OWN role - follow the arrow (goes AWAY from your partner)\", 0xFF3333FF)\n    elseif s then\n      hush(4000, Z.isSup(s) and \"CHAINS: RUN WEST into the red tile\" or \"CHAINS: RUN EAST into the red tile\", 0xFFFFFF00)\n    end\n  end\nelseif e.oldTetherID == 18 then\n  if me and (e.sourceEntityID == me or e.oldTargetID == me) then\n    b.myBroke = Now()\n    hush(2500, \"CHAIN BROKEN - stay in the red tile for the stack\", 0xFF33FF33)\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 4 - thorns chain tracker",
							uuid = "07c3f724-8697-5a71-965f-b7a6eacdd755",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 369.8,
				name = "[Draw] Bloom 4 - thorns chain tracker",
				timeRange = true,
				timelineIndex = 69,
				timerEndOffset = 11,
				timerStartOffset = -1,
				uuid = "ed5986c6-ba1a-bb22-8506-74bf9f7c96d8",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not Z.tileHV1 then\n  Z.tileHV1 = true\n  -- floor tiles (BossMod Ex4Zelenia numbering): 0-7 inner ring (r <= 8), 8-15 outer ring (8 < r <= 16);\n  -- tile t%8 = k spans [45k, 45k+45) degrees clockwise from north (centre 22.5 + 45k). Z.tiles[t] = true while red.\n  Z.tiles = Z.tiles or {}\n  Z.tileT = Z.tileT or {}\n  function Z.tileAngle(t) return 22.5 + 45 * (t % 8) end\n  function Z.tileCenter(t) return Z.pt(100, 100, Z.tileAngle(t), (t < 8) and 4 or 12) end\n  function Z.tilePoint(t, frac)\n    local r0 = (t < 8) and 0 or 8\n    return Z.pt(100, 100, Z.tileAngle(t), r0 + 8 * (frac or 0.5))\n  end\n  function Z.tileOf(x, z)\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n  function Z.tileEdges(t)\n    if t == 0 then return {7, 1, 8} elseif t == 7 then return {6, 0, 15}\n    elseif t == 8 then return {15, 9, 0} elseif t == 15 then return {14, 8, 7} end\n    return {t - 1, t + 1, (t > 8) and (t - 8) or (t + 8)}\n  end\n  function Z.connected(t)\n    local set = {}\n    if not (t and Z.tiles[t]) then return set end\n    local q, h = {t}, 1\n    set[t] = true\n    while q[h] do\n      local v = q[h]; h = h + 1\n      for _, w in ipairs(Z.tileEdges(v)) do\n        if Z.tiles[w] and not set[w] then set[w] = true; q[#q + 1] = w end\n      end\n    end\n    return set\n  end\nend\n-- Bloom 4 Encircling Thorns / Banish III: HOLD a tight stack on the ground-AoE side until the chains appear,\n-- THEN supports / DPS to their side (settings: DPS B = east, DPS D = west) into the always-red outer tile on the ROSE side of due W/E (it is connected to the\n-- rose tiles, so the healer's 8-person stack reaches the DPS through it). Pre-running makes the chain unbreakable.\nlocal s = Z.slot()\nif not s then return end\nlocal b = Z.b4\nif not b then\n  b = {}\n  Z.b4 = b\nend\nlocal now = Now()\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal py = p.pos.y\n-- G = ground-AoE side (0 = north, 180 = south); the roses and the red pathway are on the other side\nlocal G = nil\nif b.gT and b.gz and b.gz ~= 0 then G = (b.gz > 0) and 180 or 0 end\nif not G and Z.tilesKnown and Z.tiles and Z.tileT then\n  local nN, nS = 0, 0\n  for t = 0, 15 do\n    local tt = Z.tileT[t]\n    if Z.tiles[t] and tt and now - tt < 20000 then\n      local k = t % 8\n      if k == 0 or k == 7 then nN = nN + 1 elseif k == 3 or k == 4 then nS = nS + 1 end\n    end\n  end\n  if nN > nS then G = 180 elseif nS > nN then G = 0 end\nend\nif not b.f0 or now - b.f0 > 20000 then b.f0 = now end\n-- party list, refreshed at most every 300 ms (used for the stack centroid and the last-resort G guess)\nif not b.cT or now - b.cT > 300 then\n  b.cT = now\n  b.cx, b.cz, b.gG = nil, nil, nil\n  local L = TensorCore.getEntityGroupList(\"Party\")\n  if type(L) == \"table\" then\n    local sx, sz\n    if G then sx, sz = Z.pt(100, 100, G, 3.5) end\n    local n, ax, az, m, mz = 0, 0, 0, 0, 0\n    for _, v in pairs(L) do\n      local e = v\n      if type(v) == \"number\" then e = TensorCore.mGetEntity(v) end\n      if type(e) == \"table\" and e.pos and e.id ~= p.id and not (e.hp and e.hp.percent == 0) then\n        m = m + 1\n        mz = mz + e.pos.z\n        if sx then\n          local dx, dz = e.pos.x - sx, e.pos.z - sz\n          if dx * dx + dz * dz < 36 then\n            n = n + 1\n            ax = ax + e.pos.x\n            az = az + e.pos.z\n          end\n        end\n      end\n    end\n    if n >= 3 then\n      local cx, cz = ax / n, az / n\n      if (cx - 100) * (cx - 100) + (cz - 100) * (cz - 100) > 7.84 then b.cx, b.cz = cx, cz end\n    end\n    -- PF groups stack on the ground-AoE side: mean z of the party as a last-resort G\n    if m >= 3 then\n      mz = mz / m\n      if mz > 101 then b.gG = 180 elseif mz < 99 then b.gG = 0 end\n    end\n  end\nend\n-- chains appear ~15.5 s after the ground AoEs (~373.7); tracker first, time as fallback\nlocal chained = (b.tT ~= nil)\nif not chained then\n  if b.gT then chained = (now - b.gT > 15900) else chained = (now - b.f0 > 7900) end\nend\nif not chained then\n  if not G then return end\n  local sx, sz = Z.pt(100, 100, G, 3.5)\n  -- join the group if it is already stacked near the spot (short chain = it breaks at ~initial + 20 y)\n  if b.cx then sx, sz = b.cx, b.cz end\n  -- coming from the rose side: walk around the centre void zone (r2) instead of through it\n  local px, pz = p.pos.x, p.pos.z\n  local dx, dz = sx - px, sz - pz\n  local L2 = dx * dx + dz * dz\n  if L2 > 1 then\n    local t = ((100 - px) * dx + (100 - pz) * dz) / L2\n    if t > 0 and t < 1 then\n      local qx, qz = px + t * dx - 100, pz + t * dz - 100\n      if qx * qx + qz * qz < 7.84 then\n        local g = math.rad(G)\n        local lat = (px - 100) * math.cos(g) + (pz - 100) * math.sin(g)\n        sx, sz = Z.pt(100, 100, G + ((lat >= 0) and 90 or -90), 5.5)\n      end\n    end\n  end\n  Z.goTo(sx, sz, 0x00FFFF, 1.2)\n  return\nend\nif not G then G = b.gG end\nlocal sup = Z.isSup(s)\n-- DPS side from the settings window: B = east (default), D = west; supports take the other side\nlocal S = TataruZelenSettings\nif not S then\n  local folder = GetLuaModsPath() .. [[TensorReactions\\Settings\\]]\n  S = {b4dps = \"B\", folder = folder, path = folder .. [[Tataru-Zelen.settings.lua]]}\n  if FileExists(S.path) then\n    local t = FileLoad(S.path)\n    if type(t) == \"table\" and (t.b4dps == \"B\" or t.b4dps == \"D\") then S.b4dps = t.b4dps end\n  end\n  function S.save()\n    if not FolderExists(S.folder) then FolderCreate(S.folder) end\n    FileSave(S.path, {b4dps = S.b4dps})\n  end\n  TataruZelenSettings = S\nend\nlocal dpsEast = (S.b4dps ~= \"D\")\nlocal east = (sup ~= dpsEast)\nif b.mySame and b.myP and not b.myBroke then\n  -- chained to your own role (deaths): the tether TARGET takes the other role's side, the source keeps its own;\n  -- once the partner commits to a side, go to the other one\n  if not b.mySrc then east = not east end\n  local pe = TensorCore.mGetEntity(b.myP)\n  if pe and pe.pos then\n    if pe.pos.x < 97 then east = true elseif pe.pos.x > 103 then east = false end\n  end\nend\nlocal a\nif G == 180 then\n  a = east and 75 or 285\nelseif G == 0 then\n  a = east and 105 or 255\nelse\n  a = east and 90 or 270\nend\nlocal x, z = Z.pt(100, 100, a, 14)\nlocal col = b.myBroke and 0x33FF33 or (sup and 0xFFFF00 or 0x0099FF)\nZ.goTo(x, z, col, 1.5)\nif G then\n  -- outline the red outer tile you must stand IN\n  local d = TensorCore.getStaticDrawer(0xFF000000 + col, 2)\n  local a0 = 45 * math.floor(a / 45)\n  local pix, piz, pox, poz\n  for i = 0, 3 do\n    local aa = a0 + 15 * i\n    local ix, iz = Z.pt(100, 100, aa, 8)\n    local ox, oz = Z.pt(100, 100, aa, 15.8)\n    if i == 0 or i == 3 then d:addLine(ix, py, iz, ox, py, oz, 2) end\n    if pix then\n      d:addLine(pix, py, piz, ix, py, iz, 2)\n      d:addLine(pox, py, poz, ox, py, oz, 2)\n    end\n    pix, piz, pox, poz = ix, iz, ox, oz\n  end\nend\n",
							name = "[Draw] Bloom 4 - thorns: stack, then supports W / DPS E",
							uuid = "7a0522b7-2879-ac03-9810-80147b0deeb0",
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
				mechanicTime = 369.8,
				name = "[Draw] Bloom 4 - thorns: stack, then DPS B or D (settings)",
				timeRange = true,
				timelineIndex = 69,
				timerEndOffset = 9.4,
				timerStartOffset = -3.6,
				uuid = "4d586810-e950-d284-be72-0586b955c8e1",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not Z.tileHV1 then\n  Z.tileHV1 = true\n  -- floor tiles (BossMod Ex4Zelenia numbering): 0-7 inner ring (r <= 8), 8-15 outer ring (8 < r <= 16);\n  -- tile t%8 = k spans [45k, 45k+45) degrees clockwise from north (centre 22.5 + 45k). Z.tiles[t] = true while red.\n  Z.tiles = Z.tiles or {}\n  Z.tileT = Z.tileT or {}\n  function Z.tileAngle(t) return 22.5 + 45 * (t % 8) end\n  function Z.tileCenter(t) return Z.pt(100, 100, Z.tileAngle(t), (t < 8) and 4 or 12) end\n  function Z.tilePoint(t, frac)\n    local r0 = (t < 8) and 0 or 8\n    return Z.pt(100, 100, Z.tileAngle(t), r0 + 8 * (frac or 0.5))\n  end\n  function Z.tileOf(x, z)\n    local dx, dz = x - 100, z - 100\n    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n    if dx * dx + dz * dz <= 64 then return k end\n    return k + 8\n  end\n  function Z.tileEdges(t)\n    if t == 0 then return {7, 1, 8} elseif t == 7 then return {6, 0, 15}\n    elseif t == 8 then return {15, 9, 0} elseif t == 15 then return {14, 8, 7} end\n    return {t - 1, t + 1, (t > 8) and (t - 8) or (t + 8)}\n  end\n  function Z.connected(t)\n    local set = {}\n    if not (t and Z.tiles[t]) then return set end\n    local q, h = {t}, 1\n    set[t] = true\n    while q[h] do\n      local v = q[h]; h = h + 1\n      for _, w in ipairs(Z.tileEdges(v)) do\n        if Z.tiles[w] and not set[w] then set[w] = true; q[#q + 1] = w end\n      end\n    end\n    return set\n  end\nend\n-- Bloom 4: Encircling Thorns cast finished; chains appear ~4 s later\nhush(5000, \"THORNS: HOLD the tight stack until the chains appear, THEN supports WEST / DPS EAST into the red tile\", 0xFFFFFF00)\nself.used = true\n",
							name = "[Draw] Bloom 4 - thorns callout",
							uuid = "25debbe1-e9d4-3748-8728-b83eeb1e2296",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				mechanicTime = 369.8,
				name = "[Draw] Bloom 4 - thorns callout",
				timeRange = true,
				timelineIndex = 69,
				timerEndOffset = 1.5,
				uuid = "52d16d97-93c2-adfe-8103-df28065a6ee3",
				version = 2,
			},
		},
		
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
	[71] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "40b1fb26-b4b6-316d-b441-9dda035f1dde",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Encircling Thorns / Banish III: supports west, DPS east\nlocal s = Z.slot()\nif s then Z.goTo(Z.isSup(s) and 86 or 114, 100, 0xFFFF00, 1.5) end\n",
							name = "[Draw] Bloom 4 - thorns: supports W / DPS E",
							uuid = "38560fe9-b515-3463-afa4-98042950076e",
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
				mechanicTime = 378.8,
				name = "[Draw] Bloom 4 - thorns: supports W / DPS E (old)",
				timeRange = true,
				timelineIndex = 71,
				timerEndOffset = 0.4,
				timerStartOffset = -9,
				uuid = "4b8af182-c5ef-e633-a2a4-28aef5d9a4e9",
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
				name = "Role Draws",
				uuid = "43ce4304-6744-59d6-862e-b7ee1f86d317",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Power Break (EF3 add half-room cleave): 43184 = cleaves to the add's right, 43185 = its left\nlocal e = eventArgs\nif not (e and (e.spellID == 43184 or e.spellID == 43185)) then self.used = true return end\nlocal c = TensorCore.mGetEntity(e.entityID)\nif c and c.pos then\n  local h = c.pos.h + ((e.spellID == 43184) and -math.pi / 2 or math.pi / 2)\n  Z.pb = {t = Now(), x = c.pos.x, z = c.pos.z, h = h, n = 1}\n  local east = math.sin(h) > 0\n  local hit, safe = east and \"EAST\" or \"WEST\", east and \"WEST\" or \"EAST\"\n  if 1 == 1 then hush(6000, \"ADD CLEAVE \" .. hit .. \": go \" .. safe .. \" now, then your EF spot\", 0xFF3333FF)\n  else hush(6000, \"2nd ADD CLEAVE \" .. hit .. \": finish EF first, THEN go \" .. safe, 0xFF3333FF) end\nend\nself.used = true\n",
							name = "[Draw] EF3 - add cleave 1 tracker",
							uuid = "368b2c7f-c00e-b836-bfc8-697b7218eecf",
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
				mechanicTime = 414.5,
				name = "[Draw] EF3 - add cleave 1 tracker",
				timeRange = true,
				timelineIndex = 75,
				timerEndOffset = 1,
				timerStartOffset = -10,
				uuid = "a9b8efac-a4ef-7a1b-9702-ca454d8b9ef2",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Power Break: red half-room zone + arrow out of it (2nd cleave: arrow only after EF's last hit)\nlocal pb = Z.pb\nif not pb or Now() - pb.t > 7000 then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal py = p.pos.y\nTensorCore.getCachedDrawer(0x183333FF, 0x283333FF, 0x403333FF, 0xFF3333FF, 2):addRect(pb.x, py, pb.z, 24, 64, pb.h, false, Z.flags)\nlocal dx, dz = math.sin(pb.h), math.cos(pb.h)\nlocal d = (p.pos.x - pb.x) * dx + (p.pos.z - pb.z) * dz\nif d > -1.5 and (pb.n == 1 or Now() - pb.t > 4000) then\n  local tx, tz = p.pos.x - dx * (d + 3), p.pos.z - dz * (d + 3)\n  local r = math.sqrt((tx - 100) ^ 2 + (tz - 100) ^ 2)\n  if r > 14 then tx, tz = 100 + (tx - 100) * 14 / r, 100 + (tz - 100) * 14 / r end\n  Z.goTo(tx, tz, 0x33FF33, 1.0)\nend\n",
							name = "[Draw] EF3 - add cleave 1 zone",
							uuid = "76a1cb58-34e9-64c0-992d-e0a3d02efe3f",
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
				mechanicTime = 414.5,
				name = "[Draw] EF3 - add cleave 1 zone",
				timeRange = true,
				timelineIndex = 75,
				timerEndOffset = 0.5,
				timerStartOffset = -7,
				uuid = "cde484d4-0c1d-7366-ac36-08f4502a3e8c",
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
				name = "Role Draws",
				uuid = "36113b7e-42da-93fc-b888-436ad9940754",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall cast start: new symbol list\nZ.ef = {t0 = Now(), sym = {}, boss = eventArgs.entityID, mode = 1}\nself.used = true\n",
							conditions = 
							{
								
								{
									"2693e893-987f-7979-b2fd-4cbfe6b69e47",
									true,
								},
							},
							name = "[Draw] Escelons' Fall 3 - cast start",
							uuid = "0ea9c143-87b8-8a16-8e75-fdb38910a036",
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
							eventSpellID = 43181,
							name = "Escelons' Fall",
							uuid = "2693e893-987f-7979-b2fd-4cbfe6b69e47",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 417.5,
				name = "[Draw] Escelons' Fall 3 - cast start",
				timeRange = true,
				timelineIndex = 76,
				timerEndOffset = -11.5,
				timerStartOffset = -14.5,
				uuid = "706a5781-8cde-4cfa-991a-3675e360765f",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall symbols on the boss: 2127 = near, 2128 = far\nlocal e, ef = eventArgs, Z.ef\nif not (e and ef and e.entityID == ef.boss) then self.used = true return end\nlocal v = e.newActiveAura1\nif (v == 2127 or v == 2128) and #ef.sym < 4 then\n  ef.sym[#ef.sym + 1] = (v == 2127) and \"N\" or \"F\"\n  if #ef.sym == 4 then\n    local a, b, c, d = Z.efState(1), Z.efState(2), Z.efState(3), Z.efState(4)\n    if a and b and c and d then hush(9000, \"EF: \" .. a .. \" > \" .. b .. \" > \" .. c .. \" > \" .. d, 0xFF00FFFF) end\n  end\nend\nself.used = true\n",
							name = "[Draw] Escelons' Fall 3 - symbols",
							uuid = "f871772c-69d4-8d39-b4ae-aa6af07e81fb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 25,
				loop = true,
				mechanicTime = 417.5,
				name = "[Draw] Escelons' Fall 3 - symbols",
				timeRange = true,
				timelineIndex = 76,
				timerEndOffset = -0.5,
				timerStartOffset = -13,
				uuid = "3fc7a9af-2c78-f510-bd38-ac231f27d2ef",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Escelons' Fall 1/3: clock spot, DPS start in, supports out, then follow the symbols\nlocal ef = Z.ef\nlocal p = TensorCore.mGetPlayer()\nlocal s = Z.slot()\nif not (ef and p and p.pos and s and ef.mode == 1) then return end\nlocal el = (Now() - ef.t0) / 1000\nlocal k\nfor i = 1, 4 do if el < Z.EF_HIT[i] + 0.3 then k = i break end end\nif not k then return end\nlocal st = Z.efState(k)\nif not st then\n  if k ~= 1 then return end\n  st = Z.isSup(s) and \"OUT\" or \"IN\"\nend\nlocal cx, cz = 100, 100\nlocal b = TensorCore.mGetEntity(ef.boss)\nif b and b.pos then cx, cz = b.pos.x, b.pos.z end\nlocal x, z = Z.pt(cx, cz, Z.EF_CLOCK[s] or 0, st == \"IN\" and 3.0 or 10.0)\nZ.goTo(x, z, st == \"IN\" and 0x33FF33 or 0x0099FF, 0.8)\n",
							name = "[Draw] Escelons' Fall 3 - in/out spot",
							uuid = "0bcda9d5-59af-f304-bacd-da61de23d5a5",
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
				mechanicTime = 417.5,
				name = "[Draw] Escelons' Fall 3 - in/out spot",
				timeRange = true,
				timelineIndex = 76,
				timerEndOffset = 10.4,
				timerStartOffset = -2.8,
				uuid = "ef05e2bb-72a3-e274-ae4b-7908085151ba",
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
				name = "Role Draws",
				uuid = "80b5d322-518a-ba4b-be38-ca13b3637170",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Power Break (EF3 add half-room cleave): 43184 = cleaves to the add's right, 43185 = its left\nlocal e = eventArgs\nif not (e and (e.spellID == 43184 or e.spellID == 43185)) then self.used = true return end\nlocal c = TensorCore.mGetEntity(e.entityID)\nif c and c.pos then\n  local h = c.pos.h + ((e.spellID == 43184) and -math.pi / 2 or math.pi / 2)\n  Z.pb = {t = Now(), x = c.pos.x, z = c.pos.z, h = h, n = 2}\n  local east = math.sin(h) > 0\n  local hit, safe = east and \"EAST\" or \"WEST\", east and \"WEST\" or \"EAST\"\n  if 2 == 1 then hush(6000, \"ADD CLEAVE \" .. hit .. \": go \" .. safe .. \" now, then your EF spot\", 0xFF3333FF)\n  else hush(6000, \"2nd ADD CLEAVE \" .. hit .. \": finish EF first, THEN go \" .. safe, 0xFF3333FF) end\nend\nself.used = true\n",
							name = "[Draw] EF3 - add cleave 2 tracker",
							uuid = "e679cc93-3e38-5b7f-9fbb-b6df4c07a004",
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
				mechanicTime = 429.5,
				name = "[Draw] EF3 - add cleave 2 tracker",
				timeRange = true,
				timelineIndex = 81,
				timerEndOffset = 1,
				timerStartOffset = -10,
				uuid = "0c50454e-5838-597f-9393-7bad8bdebcc4",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Power Break: red half-room zone + arrow out of it (2nd cleave: arrow only after EF's last hit)\nlocal pb = Z.pb\nif not pb or Now() - pb.t > 7000 then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal py = p.pos.y\nTensorCore.getCachedDrawer(0x183333FF, 0x283333FF, 0x403333FF, 0xFF3333FF, 2):addRect(pb.x, py, pb.z, 24, 64, pb.h, false, Z.flags)\nlocal dx, dz = math.sin(pb.h), math.cos(pb.h)\nlocal d = (p.pos.x - pb.x) * dx + (p.pos.z - pb.z) * dz\nif d > -1.5 and (pb.n == 1 or Now() - pb.t > 4000) then\n  local tx, tz = p.pos.x - dx * (d + 3), p.pos.z - dz * (d + 3)\n  local r = math.sqrt((tx - 100) ^ 2 + (tz - 100) ^ 2)\n  if r > 14 then tx, tz = 100 + (tx - 100) * 14 / r, 100 + (tz - 100) * 14 / r end\n  Z.goTo(tx, tz, 0x33FF33, 1.0)\nend\n",
							name = "[Draw] EF3 - add cleave 2 zone",
							uuid = "edb29d92-f4f9-dc90-a212-1800c859e54b",
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
				mechanicTime = 429.5,
				name = "[Draw] EF3 - add cleave 2 zone",
				timeRange = true,
				timelineIndex = 81,
				timerEndOffset = 0.5,
				timerStartOffset = -7,
				uuid = "0cf29bfd-c3be-20ab-9631-55087d994de6",
				version = 2,
			},
		},
	},
	[82] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "VPR Optimization",
				uuid = "7c197884-cb24-8c0c-be52-50d1f62ba9fd",
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
							actionID = 7549,
							conditions = 
							{
								
								{
									"927d17d6-22cd-f603-ba4f-49c30de0711d",
									true,
								},
								
								{
									"101540bf-502d-31ef-a5ae-07e9fc399c02",
									true,
								},
								
								{
									"6cb9d3be-0dfc-7608-b1fb-9c3e631243ce",
									true,
								},
								
								{
									"676dbfcc-4d74-69f5-b5fb-5d105146741c",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Enemy",
							uuid = "2024e507-e583-3143-ab58-b906502e210d",
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
							uuid = "927d17d6-22cd-f603-ba4f-49c30de0711d",
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
							uuid = "101540bf-502d-31ef-a5ae-07e9fc399c02",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "6cb9d3be-0dfc-7608-b1fb-9c3e631243ce",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Target missing Feint",
							uuid = "676dbfcc-4d74-69f5-b5fb-5d105146741c",
							version = 3,
						},
					},
				},
				displayPath = "VPR Optimization",
				mechanicTime = 436.9,
				name = "[VPR] Feint - Stock Break (437)",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = -2,
				timerStartOffset = -6,
				uuid = "b91f8d62-3346-9325-8423-17a1f6f8700f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "a8f50804-6e75-8f81-a52b-35ac73c11859",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: ring on the stack target for all 5 hits\nlocal e = eventArgs\nif not (e and e.markerID == 590) then self.used = true return end\nZ.sb = {id = e.entityID, t = Now()}\nTensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xFF00FFFF, 3):addTimedCircleOnEnt(11500, e.entityID, 5.0, 0, false, true, Z.flags)\nself.used = true\n",
							name = "[Draw] Stock Break - stack ring",
							uuid = "31fcf0e0-c359-de88-905f-c0e5a83d2370",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 436.9,
				name = "[Draw] Stock Break - stack ring",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = -5.5,
				timerStartOffset = -8.5,
				uuid = "71beb02e-7f49-40b1-a6a7-fe2854f642cb",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: arrow to the stack target when you are not in it\nlocal sb = Z.sb\nlocal p = TensorCore.mGetPlayer()\nif not (sb and p and p.pos) or sb.id == p.id or Now() - sb.t > 11500 then return end\nlocal t = TensorCore.mGetEntity(sb.id)\nif not (t and t.pos) then return end\nif TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, t.pos.x, p.pos.y, t.pos.z) > 3.0 then\n  Z.goTo(t.pos.x, t.pos.z, 0x00FFFF, 0.6)\nend\n",
							name = "[Draw] Stock Break - go stack",
							uuid = "c72c2723-3e78-040f-9031-97309fd2c7c4",
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
				mechanicTime = 436.9,
				name = "[Draw] Stock Break - go stack",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = 4.6,
				timerStartOffset = -7.2,
				uuid = "e8c5ff0e-2a9a-3e86-9a3c-0d7719c402f4",
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
				name = "Role Draws",
				uuid = "36c50d6c-d45d-8d3b-a261-0d1527c96fb8",
			},
			objectType = "folder",
		},
	},
	[86] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "e083e90a-b706-b779-9e38-cb99ea4dd708",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nZ.say(6000, \"SWIPES: go to the side OPPOSITE the first swipes (2 or 4)\", 0xFF00FFFF)\nself.used = true\n",
							conditions = 
							{
								
								{
									"2e43295c-a820-f011-b7cd-c8f38e02a625",
									true,
								},
							},
							name = "[Draw] Bloom 5 - swipes callout",
							uuid = "0db1945e-2462-6a34-8d4f-da815a4bc9e0",
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
							eventSpellID = 43206,
							name = "Valorous Ascension",
							uuid = "2e43295c-a820-f011-b7cd-c8f38e02a625",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 457.4,
				name = "[Draw] Bloom 5 - swipes callout (old)",
				timeRange = true,
				timelineIndex = 86,
				timerEndOffset = -1,
				timerStartOffset = -4,
				uuid = "1eaa7964-1fb6-89ab-9723-518c03d024fa",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 5 swipes reminder on Valorous Ascension (43206); once per pull\nlocal e = eventArgs\nif e and e.spellID == 43206 then\n  local now = Now()\n  if not (Z.b5say0 and now - Z.b5say0 < 30000) then\n    Z.b5say0 = now\n    hush(3500, \"SWIPES: watch the FIRST chakram pair - start in the clear quadrant on the OTHER side\", 0xFF00FFFF)\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 5 - swipes callout",
							uuid = "50f67bda-2b69-9f72-9eaf-eda99f5ed742",
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
				mechanicTime = 457.4,
				name = "[Draw] Bloom 5 - swipes callout",
				timeRange = true,
				timelineIndex = 86,
				timerEndOffset = -1,
				timerStartOffset = -4,
				uuid = "aed204de-b989-7711-b74c-0e85b7769c10",
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
				uuid = "5cba632e-796b-893b-a03d-f02889c303b7",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 5 Thunder IV: start in/out, then 3 tiles clockwise and swap\nlocal id = eventArgs and eventArgs.spellID\nif id == 43450 then Z.say(8000, \"OUT first. After the explosions: 3 tiles CLOCKWISE, go IN\", 0xFF00FFFF)\nelseif id == 43451 then Z.say(8000, \"IN first. After the explosions: 3 tiles CLOCKWISE, go OUT\", 0xFF00FFFF) end\nself.used = true\n",
							name = "[Draw] Bloom 5 - in/out first callout",
							uuid = "84ee5ff0-29cf-e4b7-813a-655f449182a2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 469.2,
				name = "[Draw] Bloom 5 - in/out first callout",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = -5.4,
				timerStartOffset = -7.2,
				uuid = "4dd58c7b-ea3e-7760-872c-b8aa182771ac",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 5 tracker: Thunder IV in/out (43450 circle = OUT first, 43451 donut = IN first;\n-- boss visual 43448 = OUT first, 43449 = IN first), Thunder Slash cones (43216: helper heading\n-- = cone direction), Valorous Ascension chakram lines (43210, Briar Thorn 40x8 rect).\nlocal e = eventArgs\nlocal sid = e and e.spellID\nif not (sid == 43450 or sid == 43451 or sid == 43448 or sid == 43449 or sid == 43216 or sid == 43210) then\n  self.used = true\n  return\nend\nlocal now = Now()\nlocal B = Z.b5\nif not (B and B.t0 and now - B.t0 < 40000) then\n  B = {t0 = now, ids = {}, idSeen = {}, rect = {}, resT = {}, appT = {}, cones = {}, seenIV = {}, seenC = {}}\n  Z.b5 = B\nend\nlocal id = e.entityID\nlocal ct = e.channelTimeMax\nlocal ms = math.floor(((ct and ct > 0) and ct or 6.4) * 1000)\nif sid == 43450 or sid == 43451 then\n  if id and not B.seenIV[id] then\n    B.seenIV[id] = true\n    local io = (sid == 43451) and \"IN\" or \"OUT\"\n    B.nIV = (B.nIV or 0) + 1\n    if B.nIV == 1 then\n      B.io1 = io\n      B.tIV1 = now + ms\n      if not B.tIO then B.tIO = now end\n    elseif B.nIV == 2 then\n      B.io2 = io\n    end\n  end\nelseif sid == 43448 or sid == 43449 then\n  if not B.io1 then B.io1 = (sid == 43449) and \"IN\" or \"OUT\" end\n  if not B.tIV1 then B.tIV1 = now + ms + 700 end\n  if not B.tIO then B.tIO = now end\nelseif id then\n  local ent = TensorCore.mGetEntity(id)\n  if sid == 43216 then\n    if not B.seenC[id] and ent and ent.pos and ent.pos.h then\n      B.seenC[id] = true\n      B.cones[#B.cones + 1] = {a = (180 - math.deg(ent.pos.h)) % 360, t = now + ms}\n    end\n  else\n    if not B.idSeen[id] then\n      B.idSeen[id] = true\n      B.ids[#B.ids + 1] = id\n    end\n    if not B.resT[id] then\n      B.resT[id] = now + ms\n      if ent and ent.pos and ent.pos.h then B.rect[id] = {x = ent.pos.x, z = ent.pos.z, h = ent.pos.h} end\n    end\n  end\nend\nB.dirty = true\nself.used = true\n",
							name = "[Draw] Bloom 5 - cast tracker (Thunder IV / cones / chakram lines)",
							uuid = "459a4d5d-32da-0622-9ad4-c3bc7b6e4706",
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
				mechanicTime = 469.2,
				name = "[Draw] Bloom 5 - cast tracker (Thunder IV / cones / chakram lines)",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = -0.3,
				timerStartOffset = -13,
				uuid = "4adaa796-7343-3ddb-b2cc-eb0241762f7f",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 5: Briar Thorn chakrams appearing (action timeline 0x11DB = 4571, ~10.8 s before their line hits).\n-- The first pair to appear is the first set of swipes.\nlocal e = eventArgs\nif not (e and e.newAnimID == 4571 and e.entityID) then\n  self.used = true\n  return\nend\nlocal ent = TensorCore.mGetEntity(e.entityID)\n-- skip players (content id 0), the boss + helpers (13861) and the shades (13864)\nlocal cid = e.entityContentID or (ent and ent.contentid)\nif not (ent and ent.pos and cid and cid ~= 0 and cid ~= 13861 and cid ~= 13864) then\n  self.used = true\n  return\nend\nlocal dx, dz = ent.pos.x - 100, ent.pos.z - 100\nif dx * dx + dz * dz < 36 then\n  self.used = true\n  return\nend\nlocal now = Now()\nlocal B = Z.b5\nif not (B and B.t0 and now - B.t0 < 40000) then\n  B = {t0 = now, ids = {}, idSeen = {}, rect = {}, resT = {}, appT = {}, cones = {}, seenIV = {}, seenC = {}}\n  Z.b5 = B\nend\nlocal id = e.entityID\nif not B.idSeen[id] then\n  B.idSeen[id] = true\n  B.ids[#B.ids + 1] = id\n  B.appT[id] = now\n  if ent.pos.h then B.rect[id] = {x = ent.pos.x, z = ent.pos.z, h = ent.pos.h} end\n  B.dirty = true\nend\nself.used = true\n",
							name = "[Draw] Bloom 5 - chakram appear tracker",
							uuid = "0daf1e48-c265-6033-b3ed-0bc01e6cb3e7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 23,
				loop = true,
				mechanicTime = 469.2,
				name = "[Draw] Bloom 5 - chakram appear tracker",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = -4,
				timerStartOffset = -13,
				uuid = "7fe27dbd-2358-d7fc-bd03-dd4d4a106112",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 5: exact moment Thunder IV #1 lands (43450/43451 cast event) -> the draw swaps to the dodge spot\nlocal e = eventArgs\nlocal sid = e and e.spellID\nif sid == 43450 or sid == 43451 then\n  local B = Z.b5\n  if B and B.t0 and not B.ivHit and Now() - B.t0 < 40000 then B.ivHit = Now() end\nend\nself.used = true\n",
							name = "[Draw] Bloom 5 - Thunder IV hit tracker",
							uuid = "85650da9-472b-588c-ab91-2a024134a374",
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
				mechanicTime = 469.2,
				name = "[Draw] Bloom 5 - Thunder IV hit tracker",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = 2,
				timerStartOffset = -1.5,
				uuid = "53c6f34d-d79d-2e2d-91bc-3c9393906cd1",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 5: arrow to the start spot (clear quadrant away from the first chakram pair, IN/OUT per\n-- Thunder IV), then after the first explosions: 3 tiles clockwise, other ring. Same spot for all 8.\nif Z.b5fnV ~= 11 then\n  Z.b5fnV = 11\n  local function adiff(a, b)\n    local d = (a - b) % 360\n    if d > 180 then d = 360 - d end\n    return d\n  end\n  local RIN, ROUT = {5.5, 4.5, 6.5}, {12.0, 13.5, 10.5}\n  local OFFS = {10, 16, 22.5, 29, 35}\n  -- best point of sector k (0..7) in the inner/outer ring; hard = cone angles that must miss,\n  -- soft = cone angles to avoid if possible (score capped at cap), rects = chakram lines that must miss\n  local function spot(k, inner, hard, soft, cap, rects, cw)\n    local radii = inner and RIN or ROUT\n    local best, bx, bz\n    for ri = 1, 3 do\n      local r = radii[ri]\n      for oi = 1, 5 do\n        local a = 45 * k + OFFS[oi]\n        local x, z = Z.pt(100, 100, a, r)\n        local edge = 0.5 + r * math.sin(math.rad(math.min(OFFS[oi], 45 - OFFS[oi])))\n        local ring = (inner and math.min(8 - r, r - 2) or math.min(r - 8, 16 - r)) - 0.5\n        local m, ok = math.min(3.0, edge, ring), true\n        for i = 1, #hard do\n          local d = adiff(a, hard[i]) - 30\n          local dd = (d >= 90) and r or r * math.sin(math.rad(d))\n          if dd < 1.0 then ok = false break end\n          if dd < m then m = dd end\n        end\n        if ok then\n          for i = 1, #rects do\n            local R = rects[i]\n            local hx, hz = math.sin(R.h), math.cos(R.h)\n            local rx, rz = x - R.x, z - R.z\n            local u = rx * hx + rz * hz\n            if u > -1 and u < 41 then\n              local lat = math.abs(rx * hz - rz * hx) - 4\n              if lat < 1.0 then ok = false break end\n              if lat < m then m = lat end\n            end\n          end\n        end\n        if ok then\n          for i = 1, #soft do\n            local d = adiff(a, soft[i]) - 30\n            if d < 90 and r * math.sin(math.rad(d)) < 1.0 and m > cap then m = cap end\n          end\n          local sc = m + 0.02 * (cw and oi or (6 - oi)) - 0.01 * (ri - 1)\n          if not best or sc > best then best, bx, bz = sc, x, z end\n        end\n      end\n    end\n    return best, bx, bz\n  end\n  Z.b5fn = function(B)\n    local io1 = B.io1\n    local io2 = B.io2 or (io1 == \"IN\" and \"OUT\") or (io1 == \"OUT\" and \"IN\") or nil\n    -- chakram geometry: live until that chakram's own cast has started, then frozen\n    for i = 1, #B.ids do\n      local id = B.ids[i]\n      if not B.resT[id] then\n        local ent = TensorCore.mGetEntity(id)\n        if ent and ent.pos and ent.pos.h then B.rect[id] = {x = ent.pos.x, z = ent.pos.z, h = ent.pos.h} end\n      end\n    end\n    -- first pair = earliest to resolve (43210 cast) or, before the casts, earliest to appear (0x11DB)\n    local T = next(B.resT) and B.resT or B.appT\n    local tmin\n    for _, t in pairs(T) do\n      if not tmin or t < tmin then tmin = t end\n    end\n    local r1, r2 = {}, {}\n    for i = 1, #B.ids do\n      local id = B.ids[i]\n      local first\n      if tmin then first = (T[id] ~= nil and T[id] - tmin < 1500) else first = (i <= 2) end\n      local R = B.rect[id]\n      if R then\n        if first then r1[#r1 + 1] = R else r2[#r2 + 1] = R end\n      end\n    end\n    -- half of the arena swept by the first pair (0 N, 90 E, 180 S, 270 W)\n    local vx, vz = 0, 0\n    for i = 1, #r1 do\n      local R = r1[i]\n      local hx, hz = math.sin(R.h), math.cos(R.h)\n      local ox, oz = R.x - 100, R.z - 100\n      local al = ox * hx + oz * hz\n      vx = vx + ox - hx * al\n      vz = vz + oz - hz * al\n    end\n    if #r1 > 0 and vx * vx + vz * vz > 4 * #r1 * #r1 then\n      B.hc = (math.floor(((math.deg(math.atan2(vx, -vz)) % 360) + 45) / 90) % 4) * 90\n    end\n    local hc = B.hc\n    -- floor: only tile changes seen during this bloom count (\"A\" = NE/SW clear, \"B\" = SE/NW clear)\n    local fl\n    if Z.tilesKnown and Z.tiles and Z.tileT then\n      local cut, cA, cB = B.t0 - 20000, 0, 0\n      for t = 0, 15 do\n        local tt = Z.tileT[t]\n        if tt and tt >= cut and Z.tiles[t] then\n          local q = math.floor((t % 8) / 2)\n          if q == 0 or q == 2 then cA = cA + 1 else cB = cB + 1 end\n        end\n      end\n      if cB > cA then fl = \"A\" elseif cA > cB then fl = \"B\" end\n    end\n    B.floor = fl\n    -- candidates: clear quadrant q not swept first; start = its clockwise tile 2q+1, dodge = 3 tiles CW\n    local cands = {}\n    for q = 0, 3 do\n      local okF = (not fl) or ((fl == \"A\") == (q == 0 or q == 2))\n      local okH = (not hc) or adiff(45 + 90 * q, hc) > 90\n      if okF and okH then cands[#cands + 1] = {q = q, s = 2 * q + 1, e = (2 * q + 4) % 8} end\n    end\n    -- cones 1-2 (the opposite pair hitting at / right after the boom) must miss the start;\n    -- cones 4-6 must miss the dodge spot; cone 3 hits about when you arrive there (soft)\n    local h12, h46, sE, none = {}, {}, {}, {}\n    for i = 1, #B.cones do\n      local a = B.cones[i].a\n      if i <= 2 then h12[#h12 + 1] = a elseif i == 3 then sE[1] = a else h46[#h46 + 1] = a end\n    end\n    local P = {state = \"none\", V = {}}\n    if io1 then\n      local in1, in2 = (io1 == \"IN\"), (io2 == \"IN\")\n      local b1, b2\n      for i = 1, #cands do\n        local c = cands[i]\n        local s1, sx, sz = spot(c.s, in1, h12, none, 3.0, r1, true)\n        local s2, ex, ez = spot(c.e, in2, h46, sE, 1.2, r2, false)\n        if s1 and s2 then\n          c.sc, c.sx, c.sz, c.ex, c.ez = s1 + s2, sx, sz, ex, ez\n          P.V[#P.V + 1] = c\n          if not b1 or c.sc > b1.sc then\n            b2 = b1\n            b1 = c\n          elseif not b2 or c.sc > b2.sc then\n            b2 = c\n          end\n        end\n      end\n      local pick\n      if b1 and (not b2 or b1.sc - b2.sc >= 1.0) then pick = b1 end\n      -- keep the previous answer while it is still valid and not clearly beaten (no flicker)\n      if B.pick and b1 then\n        local pc\n        for i = 1, #P.V do\n          if P.V[i].s == B.pick then pc = P.V[i] end\n        end\n        if pc and pc ~= pick and b1.sc - pc.sc < 1.0 then pick = pc end\n      end\n      if pick then\n        P.state, P.c = \"ok\", pick\n        P.conf = (#B.cones >= 5 and #P.V == 1) and \"high\" or \"med\"\n        B.pick = pick.s\n      end\n    end\n    if P.state ~= \"ok\" and hc then\n      P.state = \"side\"\n      P.px, P.pz = Z.pt(100, 100, (hc + 180) % 360, (io1 == \"IN\" and 5.5) or (io1 == \"OUT\" and 12.0) or 8.0)\n    end\n    B.plan = P\n    if P.state == \"ok\" then\n      local c = P.c\n      local key = c.s * 10 + (io1 == \"IN\" and 1 or 2)\n      B.saidIO = true\n      if B.said ~= key and (B.nSaid or 0) < 3 then\n        B.said = key\n        B.nSaid = (B.nSaid or 0) + 1\n        hush(7000, \"B5: start \" .. io1 .. \" \" .. Z.dirName(45 * c.s + 22.5) .. \"  >> boom >>  3 tiles CW: \"\n          .. tostring(io2) .. \" \" .. Z.dirName(45 * c.e + 22.5), 0xFF00FFFF)\n      end\n    elseif io1 and not B.saidIO and Now() - (B.tIO or 0) > 1500 then\n      B.saidIO = true\n      hush(6000, \"B5: \" .. io1 .. \" first. After the boom: 3 tiles CLOCKWISE, go \" .. tostring(io2), 0xFF00FFFF)\n    elseif P.state == \"side\" and not B.saidSide then\n      B.saidSide = true\n      hush(4000, \"B5: first swipes hit the \" .. Z.dirName(hc) .. \" half - go \" .. Z.dirName(hc + 180) .. \" side\", 0xFF00FFFF)\n    end\n  end\nend\nlocal B = Z.b5\nif not (B and B.t0 and Z.b5fn) then return end\nlocal now = Now()\nif now - B.t0 > 40000 then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\n-- swap to the dodge once Thunder IV #1 has landed (its cast event + 0.15 s); fallback cast start + 7.0 s\n-- (Bloom 2 logs: the hit lands 6.66-6.91 s after the cast start); latched so it never flips back\nif not B.swapped then\n  local c1 = B.cones and B.cones[1]\n  local swap = (B.ivHit and B.ivHit + 150) or (B.tIV1 and B.tIV1 + 600) or (c1 and c1.t + 600)\n  if swap and now >= swap then\n    B.swapped = true\n  else\n    if B.dirty or not B.pT or now - B.pT > 400 then\n      B.dirty = false\n      B.pT = now\n      pcall(Z.b5fn, B)\n    end\n    local P = B.plan\n    if not P then return end\n    if P.state == \"ok\" then\n      local c = P.c\n      Z.goTo(c.sx, c.sz, (P.conf == \"high\") and 0x33FF33 or 0x00FFFF, 1.2)\n      TensorCore.getStaticDrawer(0x88FFFF00, 2):addCircle(c.ex, p.pos.y, c.ez, 1.0, false, Z.flags)\n    else\n      -- unresolved: wait on the opposite cardinal (edge of both candidate quadrants), but no arrow in the last 3 s (pick the clear tile yourself)\n      if P.state == \"side\" and not (swap and now > swap - 3000) then Z.goTo(P.px, P.pz, 0x00FFFF, 2.0) end\n      local V = P.V\n      if V and #V > 0 and #V <= 3 then\n        local d = TensorCore.getStaticDrawer(0x8800FFFF, 2)\n        for i = 1, #V do d:addCircle(V[i].sx, p.pos.y, V[i].sz, 0.8, false, Z.flags) end\n      end\n    end\n    return\n  end\nend\n-- after the first explosions: dodge spot (decided once; false = nothing sensible to show)\nif B.dodge == nil then\n  local P = B.plan\n  local V = P and P.V\n  local D = false\n  if P and P.state == \"ok\" then\n    D = {P.c.ex, P.c.ez}\n  else\n    -- unresolved: Hector's rule from the tile you are standing in (3 tiles clockwise, other ring);\n    -- if that tile is one of the candidates, use its computed dodge spot\n    local dx, dz = p.pos.x - 100, p.pos.z - 100\n    local r2 = dx * dx + dz * dz\n    if r2 >= 6.25 then\n      local k0 = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8\n      local in0 = r2 <= 64\n      if V and B.io1 and in0 == (B.io1 == \"IN\") then\n        for i = 1, #V do\n          if V[i].s == k0 then D = {V[i].ex, V[i].ez} end\n        end\n      end\n      if not D then\n        local inner = not in0\n        if B.io2 then inner = (B.io2 == \"IN\") end\n        local x, z = Z.pt(100, 100, 45 * ((k0 + 3) % 8) + 15, inner and 5.5 or 12.0)\n        D = {x, z}\n      end\n    end\n  end\n  B.dodge = D\nend\nif B.dodge then Z.goTo(B.dodge[1], B.dodge[2], 0xFFFF00, 1.2) end\n",
							name = "[Draw] Bloom 5 - start spot / 3 tiles CW dodge",
							uuid = "54aea05e-366e-97b6-a218-74fa0b2c6317",
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
				mechanicTime = 469.2,
				name = "[Draw] Bloom 5 - start spot / 3 tiles CW dodge",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = 5.6,
				timerStartOffset = -11.5,
				uuid = "8f85044c-ac1c-6d4b-9abd-d2b1c0259374",
				version = 2,
			},
		},
	},
	[97] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "c7ad323d-a8ee-2e02-ac36-c0965a875291",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tankbuster tethers (89) from players to the boss\nlocal e = eventArgs\nif not e then self.used = true return end\nZ.spec = Z.spec or {}\nif e.newTetherID == 89 then\n  Z.spec[e.sourceEntityID] = true\n  local p = TensorCore.mGetPlayer()\n  if p and e.sourceEntityID == p.id and not Z.tankOf(p.id) then hush(4000, \"BUSTER TETHER: let a tank take it\", 0xFF3333FF) end\nelseif e.oldTetherID == 89 then\n  Z.spec[e.sourceEntityID] = nil\nend\nself.used = true\n",
							name = "[Draw] Specter - tether tracker",
							uuid = "1faf6fff-f4e1-21b0-8c89-54eed58f33ee",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 484.4,
				name = "[Draw] Specter - tether tracker",
				timeRange = true,
				timelineIndex = 97,
				timerEndOffset = 0.3,
				timerStartOffset = -9,
				uuid = "6ef2855f-e94c-cd78-8aa6-01982a744413",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tanks get a line to any non-tank holding a tether\nlocal S = Z.spec\nlocal p = TensorCore.mGetPlayer()\nif not (S and p and p.pos) then return end\nlocal tank = Z.tankOf(p.id)\nfor id in pairs(S) do\n  if not Z.tankOf(id) then\n    local ent = TensorCore.mGetEntity(id)\n    if ent and ent.pos then\n      if tank then\n        TensorCore.getStaticDrawer(0xFF00FFFF, 4):addLine(p.pos.x, p.pos.y, p.pos.z, ent.pos.x, ent.pos.y, ent.pos.z, 6)\n        TensorCore.getCachedDrawer(0x3300FFFF, 0x5500FFFF, 0x8800FFFF, 0xFF00FFFF, 3):addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 1.5, false, Z.flags)\n      elseif id == p.id then\n        TensorCore.getCachedDrawer(0x333333FF, 0x553333FF, 0x883333FF, 0xFF3333FF, 3):addCircle(p.pos.x, p.pos.y, p.pos.z, 1.5, false, Z.flags)\n      end\n    end\n  end\nend\n",
							name = "[Draw] Specter - tanks grab tethers",
							uuid = "b5c7a722-bbe1-c31e-b96f-8b8e988fbe1d",
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
				mechanicTime = 484.4,
				name = "[Draw] Specter - tanks grab tethers",
				timeRange = true,
				timelineIndex = 97,
				timerEndOffset = 0.2,
				timerStartOffset = -8.5,
				uuid = "8df4526e-056f-37b0-98d7-365b86a54840",
				version = 2,
			},
		},
	},
	[99] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "4e6a34ff-a279-6637-baa0-d9c60bc982e6",
			},
			objectType = "folder",
		},
	},
	[103] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "542eeb23-2b3b-df7b-bb51-8ec526b64567",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6 rose markers (592)\nlocal e = eventArgs\nif not (e and e.markerID == 592) then self.used = true return end\nZ.b6 = Z.b6 or {}\nif Z.b6.roseSup == nil then\n  Z.b6.roseSup = Z.supOf(e.entityID)\n  Z.b6.markT = Now()\n  local s = Z.slot()\n  if s then\n    if Z.b6.roseSup == Z.isSup(s) then Z.say(8000, \"ROSE: inner or outer tile - link the tower NOT hit by the 1st cleave\", 0xFFFF66FF)\n    else Z.say(8000, \"TOWER: G1 west / G2 east, tanks+melee inner, healers+ranged outer\", 0xFF33FF33) end\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 6 - rose markers",
							uuid = "dec18331-2a50-9878-a126-64ae1a21bcf5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 4,
				loop = true,
				mechanicTime = 508.1,
				name = "[Draw] Bloom 6 - rose markers (old)",
				timeRange = true,
				timelineIndex = 103,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "5ebf67d9-fc2b-2222-8e3d-f02de08a4e1c",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6 rose markers (592): all supports or all DPS get roses, the other four soak towers\nlocal e = eventArgs\nif not (e and e.markerID == 592 and e.entityID) then self.used = true return end\nlocal now = Now()\n-- per-pull guard: every Bloom 6 event falls inside ~15s, so a Z.b6 older than 40s is from an earlier pull\nif Z.b6 and Z.b6.t0 and now - Z.b6.t0 > 40000 then Z.b6 = nil end\nZ.b6 = Z.b6 or {t0 = now}\nlocal b = Z.b6\nb.roseIds = b.roseIds or {}\nif not b.roseIds[e.entityID] then\n  b.roseIds[e.entityID] = true\n  b.roseN = (b.roseN or 0) + 1\nend\nif b.roseSup == nil then\n  b.roseSup = Z.supOf(e.entityID)\n  b.markT = now\nend\nif b.roseN == 4 and not b.roseSaid then\n  b.roseSaid = true\n  local sup = 0\n  for id in pairs(b.roseIds) do\n    if Z.supOf(id) then sup = sup + 1 end\n  end\n  if sup >= 3 then b.roseSup = true elseif sup <= 1 then b.roseSup = false end\n  local s = Z.slot()\n  local p = TensorCore.mGetPlayer()\n  if s then\n    local mine = (p and p.id and b.roseIds[p.id]) and true or false\n    if mine then\n      local q = Z.B6_ROSE and Z.B6_ROSE[s]\n      hush(7000, \"ROSE: \" .. (q and Z.dirName(q) or \"your\") .. \" tile - IN or OUT shows when the cleave is cast\", 0xFFFF66FF)\n    else\n      local west = (s == \"T1\" or s == \"H1\" or s == \"M1\" or s == \"R1\")\n      local inner = (s == \"T1\" or s == \"T2\" or s == \"M1\" or s == \"M2\")\n      hush(7000, \"TOWER: \" .. (west and \"WEST \" or \"EAST \") .. (inner and \"INNER\" or \"OUTER\") .. \" - follow the arrow\", 0xFF33FF33)\n    end\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 6 - rose markers",
							uuid = "21ed77f3-6d13-de0b-b4a0-a4a16cc36cd1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 508.1,
				name = "[Draw] Bloom 6 - rose markers",
				timeRange = true,
				timelineIndex = 103,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "dc0cad99-f167-2233-8986-608fc8670655",
				version = 2,
			},
		},
	},
	[105] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "5175f119-c506-0352-87d2-b33adbbc6325",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nZ.say(6000, \"Towers: after roses, stand at the FAR END of your long tower\", 0xFF33FF33)\nself.used = true\n",
							name = "[Draw] Bloom 6 - 2nd cleave callout",
							uuid = "cfe9ae03-743f-9cb3-bf7e-4963a2f3c135",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				mechanicTime = 518.3,
				name = "[Draw] Bloom 6 - 2nd cleave callout",
				timeRange = true,
				timelineIndex = 105,
				timerEndOffset = -2,
				timerStartOffset = -3.5,
				uuid = "3733b1a4-c785-64a8-8cdf-58c2c782dc30",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6: after the roses land - say what comes next (reads the plan made by the Bloom 6 draw)\nlocal b, s = Z.b6, Z.slot()\nlocal P = b and b.plan\nif b and s and b.roseSup ~= nil and P then\n  if P.amRose then\n    hush(5000, \"Roses down: off the red, dodge cleave 1, then cleave 2 - follow the arrow\", 0xFFFF66FF)\n  elseif P.tower then\n    local where = Z.dirName(P.fang or 0)\n    if P.nosafe then\n      hush(6000, \"Your tower is inside cleave 2 - soak it with mitigation (\" .. where .. \")\", 0xFF3333FF)\n    elseif P.hit then\n      hush(6000, \"After cleave 1: RUN to the far end of your tower (\" .. where .. \")\", 0xFF00FFFF)\n    else\n      hush(6000, \"After cleave 1: step into your tower (\" .. where .. \")\", 0xFF33FF33)\n    end\n  end\nelse\n  hush(5000, \"Towers: after the 1st cleave stand at the FAR END of your long tower\", 0xFF33FF33)\nend\nself.used = true\n",
							name = "[Draw] Bloom 6 - after roses callout",
							uuid = "06f1bc50-3256-586f-a86f-7cb95fbb348a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				mechanicTime = 518.3,
				name = "[Draw] Bloom 6 - after roses callout",
				timeRange = true,
				timelineIndex = 105,
				timerEndOffset = -1.5,
				timerStartOffset = -2.3,
				uuid = "50ef7903-2a0e-b16c-9bbe-94a2f3589ec0",
				version = 2,
			},
		},
	},
	[106] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "8f84959e-91f8-7bc9-a406-ea33dc0eff99",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6: cleave 1 just resolved - move to the cleave-2 spot now\nlocal b, s = Z.b6, Z.slot()\nlocal P = b and b.plan\nif b and s and b.roseSup ~= nil and P then\n  if P.amRose then\n    if P.r2x then hush(2500, \"MOVE: cleave 2 safe spot\", 0xFFFF66FF) end\n  elseif P.tower then\n    if P.nosafe then\n      hush(2500, \"SOAK + MITIGATE\", 0xFF3333FF)\n    elseif P.hit then\n      hush(2500, \"RUN: far end NOW\", 0xFF00FFFF)\n    else\n      hush(2500, \"IN: your tower\", 0xFF33FF33)\n    end\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 6 - go callout",
							uuid = "24dfa89f-8532-1054-b392-28ff47a4540a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				mechanicTime = 519.1,
				name = "[Draw] Bloom 6 - go callout",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = 0.8,
				uuid = "dd3408f9-2893-8c07-a222-56038e7fe45a",
				version = 2,
			},
		},
	},
	[108] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "a9113cb4-3be5-d2d5-b21b-542abc632f3d",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6 towers\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif ent and ent.pos then\n  Z.b6 = Z.b6 or {}\n  Z.b6.tw = Z.b6.tw or {}\n  local tw = Z.b6.tw\n  tw[#tw + 1] = {x = ent.pos.x, z = ent.pos.z}\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"9cd8ba92-0434-3410-92c9-3b21fe6fc9d8",
									true,
								},
							},
							name = "[Draw] Bloom 6 - towers",
							uuid = "d2b53432-a458-8eb1-abf9-147cf40597ed",
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
							eventSpellID = 43201,
							name = "Bloom towers",
							uuid = "9cd8ba92-0434-3410-92c9-3b21fe6fc9d8",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 522.1,
				name = "[Draw] Bloom 6 - towers (old)",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = -11,
				timerStartOffset = -13.5,
				uuid = "10790ff8-f2ad-cdfb-8672-9a2365a48d10",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6: roses link the towers NOT hit by the first cleave; towers by group and inner/outer\nlocal b = Z.b6\nlocal s = Z.slot()\nif not (b and b.roseSup ~= nil and s) then return end\nif b.roseSup == Z.isSup(s) then\n  if b.markT and Now() - b.markT > 7000 then return end\n  local q = Z.B6_ROSE[s]\n  if not q then return end\n  local mode\n  local hh, tw = b.hh, b.tw\n  if hh and tw and #tw > 0 then\n    local fx, fz = math.sin(hh.h), math.cos(hh.h)\n    local inN, outN = 0, 0\n    for i = 1, #tw do\n      local t = tw[i]\n      local dx, dz = t.x - hh.x, t.z - hh.z\n      local d = math.sqrt(dx * dx + dz * dz)\n      local hit = d <= 24 and (d < 0.1 or (dx * fx + dz * fz) / d >= 0.5)\n      if not hit then\n        if math.sqrt((t.x - 100) ^ 2 + (t.z - 100) ^ 2) < 8 then inN = inN + 1 else outN = outN + 1 end\n      end\n    end\n    if inN > 0 and outN == 0 then mode = \"in\" elseif outN > 0 and inN == 0 then mode = \"out\" end\n  end\n  if mode then\n    local x, z = Z.pt(100, 100, q, mode == \"in\" and 4.0 or 12.0)\n    Z.goTo(x, z, 0xFF66FF, 1.2)\n  else\n    local p = TensorCore.mGetPlayer()\n    local y = (p and p.pos) and p.pos.y or 0\n    local g = TensorCore.getCachedDrawer(0x33FF66FF, 0x55FF66FF, 0x88FF66FF, 0xFFFF66FF, 2)\n    local xi, zi = Z.pt(100, 100, q, 4.0)\n    local xo, zo = Z.pt(100, 100, q, 12.0)\n    g:addCircle(xi, y, zi, 1.2, false, Z.flags)\n    g:addCircle(xo, y, zo, 1.2, false, Z.flags)\n    local xm, zm = Z.pt(100, 100, q, 8.0)\n    Z.goTo(xm, zm, 0xFF66FF, 0.5)\n  end\nelse\n  local tw = b.tw\n  if not tw then return end\n  local west = (s == \"T1\" or s == \"H1\" or s == \"M1\" or s == \"R1\")\n  local inner = (s == \"T1\" or s == \"T2\" or s == \"M1\" or s == \"M2\")\n  local best, bestR\n  for i = 1, #tw do\n    local t = tw[i]\n    if (t.x < 100) == west then\n      local rr = math.sqrt((t.x - 100) ^ 2 + (t.z - 100) ^ 2)\n      if not best or (inner and rr < bestR) or ((not inner) and rr > bestR) then best, bestR = t, rr end\n    end\n  end\n  if best then Z.goTo(best.x, best.z, 0x33FF33, 2.0) end\nend\n",
							name = "[Draw] Bloom 6 - your rose / tower spot",
							uuid = "ec8b019f-afc9-aa64-ace2-21d9064c32d2",
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
				mechanicTime = 522.1,
				name = "[Draw] Bloom 6 - your rose / tower spot (old)",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = 0.4,
				timerStartOffset = -12,
				uuid = "9b18d43c-dc9e-4ee7-9efc-365566ef433b",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6: first Holy Hazard cone (24y, 120 degrees)\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nZ.b6 = Z.b6 or {}\nif not Z.b6.hh and ent and ent.pos then Z.b6.hh = {x = ent.pos.x, z = ent.pos.z, h = ent.pos.h} end\nself.used = true\n",
							conditions = 
							{
								
								{
									"50d46da9-07d0-96fe-8b82-a0603e1a49d3",
									true,
								},
							},
							name = "[Draw] Bloom 6 - first cleave",
							uuid = "07abd36c-9893-4c40-af24-d88aee3bd74d",
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
							eventSpellID = 43234,
							name = "Holy Hazard",
							uuid = "50d46da9-07d0-96fe-8b82-a0603e1a49d3",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 522.1,
				name = "[Draw] Bloom 6 - first cleave",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = -8.6,
				timerStartOffset = -11,
				uuid = "3f86ca0e-0126-66bf-8a46-988124e538c7",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6 towers (43201 Explosion, 13s cast): remember each tower's tile (BossMod numbering)\nlocal e = eventArgs\nif not (e and e.spellID == 43201 and e.entityID) then self.used = true return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nif ent and ent.pos then\n  local now = Now()\n  -- per-pull guard: every Bloom 6 event falls inside ~15s, so a Z.b6 older than 40s is from an earlier pull\n  if Z.b6 and Z.b6.t0 and now - Z.b6.t0 > 40000 then Z.b6 = nil end\n  Z.b6 = Z.b6 or {t0 = now}\n  local b = Z.b6\n  b.tw = b.tw or {}\n  b.twTiles = b.twTiles or {}\n  local x, z = ent.pos.x, ent.pos.z\n  local t = math.floor((math.deg(math.atan2(x - 100, 100 - z)) % 360) / 45) % 8\n  if (x - 100) ^ 2 + (z - 100) ^ 2 > 64 then t = t + 8 end\n  if not b.twTiles[t] then\n    b.twTiles[t] = true\n    b.tw[#b.tw + 1] = {x = x, z = z, t = t}\n  end\n  if not b.twT then\n    b.twT = now\n    b.twHit = b.twT + math.floor(((e.channelTimeMax or 12.7) + 0.2) * 1000)\n  end\nend\nself.used = true\n",
							name = "[Draw] Bloom 6 - towers",
							uuid = "741bdcfc-9252-e99a-a17a-a7e8d99f1502",
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
				mechanicTime = 522.1,
				name = "[Draw] Bloom 6 - towers",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = -10,
				timerStartOffset = -14,
				uuid = "7da9622e-a0b7-083e-bea1-97323b3f1a63",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6 Holy Hazard: boss visual 43233 (ENE row cleaved first) / 43231 (ESE row first),\n-- helper casts 43234 = the real cones (24y, 120 deg, two opposed cones per wave, two waves 3s apart)\nlocal e = eventArgs\nlocal id = e and e.spellID\nif id ~= 43234 and id ~= 43233 and id ~= 43231 then self.used = true return end\nlocal now = Now()\n-- per-pull guard: every Bloom 6 event falls inside ~15s, so a Z.b6 older than 40s is from an earlier pull\nif Z.b6 and Z.b6.t0 and now - Z.b6.t0 > 40000 then Z.b6 = nil end\nZ.b6 = Z.b6 or {t0 = now}\nlocal b = Z.b6\nif id == 43234 then\n  local ent = e.entityID and TensorCore.mGetEntity(e.entityID)\n  if ent and ent.pos and ent.pos.h then\n    b.hc = b.hc or {}\n    local hit = now + math.floor(((e.channelTimeMax or 7.4) + 0.2) * 1000)\n    local dup = false\n    for i = 1, #b.hc do\n      local c = b.hc[i]\n      if c.id == e.entityID and math.abs(c.hit - hit) < 1000 then dup = true break end\n    end\n    if not dup and #b.hc < 8 then\n      b.hc[#b.hc + 1] = {id = e.entityID, x = ent.pos.x, z = ent.pos.z, dx = math.sin(ent.pos.h), dz = math.cos(ent.pos.h), hit = hit}\n    end\n  end\nelseif not b.vis then\n  b.vis = id\n  b.visT = now\nend\nself.used = true\n",
							name = "[Draw] Bloom 6 - Holy Hazard tracker",
							uuid = "f6ac9c77-5b2d-624b-a598-cba608d081cf",
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
				mechanicTime = 522.1,
				name = "[Draw] Bloom 6 - Holy Hazard tracker",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = -2,
				timerStartOffset = -13,
				uuid = "e65c9001-ca43-a3d5-a2bb-c347ace3d038",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6 Holy Hazard cones from Argus AOE data (43234): heading straight from the AOE, preferred over the\n-- helper's facing when present\nlocal e = eventArgs\nif not (e and e.aoeID == 43234 and e.x and e.z and e.heading) then self.used = true return end\nlocal now = Now()\n-- per-pull guard: every Bloom 6 event falls inside ~15s, so a Z.b6 older than 40s is from an earlier pull\nif Z.b6 and Z.b6.t0 and now - Z.b6.t0 > 40000 then Z.b6 = nil end\nZ.b6 = Z.b6 or {t0 = now}\nlocal b = Z.b6\nb.hcA = b.hcA or {}\nlocal hit = now + math.floor(((e.duration or 7.4) + 0.2) * 1000)\nlocal dup = false\nfor i = 1, #b.hcA do\n  local c = b.hcA[i]\n  if c.id == e.entityID and math.abs(c.hit - hit) < 1000 then dup = true break end\nend\nif not dup and #b.hcA < 8 then\n  b.hcA[#b.hcA + 1] = {id = e.entityID, x = e.x, z = e.z, dx = math.sin(e.heading), dz = math.cos(e.heading), hit = hit}\nend\nself.used = true\n",
							name = "[Draw] Bloom 6 - Holy Hazard AOE tracker",
							uuid = "19a251ac-7e3c-4523-82a8-312908945b77",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 18,
				loop = true,
				mechanicTime = 522.1,
				name = "[Draw] Bloom 6 - Holy Hazard AOE tracker",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = -2,
				timerStartOffset = -13,
				uuid = "7e921701-5022-c990-926e-fae3d767fb95",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 6: roses IN/OUT on the ring of the towers the 2nd Holy Hazard hits; tower soakers wait out cleave 1,\n-- then stand at the max-clearance point of their (rose-extended) tower outside cleave 2; roses dodge both cleaves\nlocal b = Z.b6\nlocal s = Z.slot()\nif not (b and b.roseSup ~= nil and s) then return end\nlocal F = Z.b6fn\nif not F then\n  F = {HALF = 60}\n  local sin, cos, rad, sqrt, min, floor = math.sin, math.cos, math.rad, math.sqrt, math.min, math.floor\n  F.HS, F.HC = sin(rad(F.HALF)), cos(rad(F.HALF))\n  F.RIN = {2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5}\n  F.ROUT = {8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5}\n  F.ALL = {}\n  for t = 0, 15 do F.ALL[t] = true end\n  function F.tileOf(x, z)\n    local k = floor((math.deg(math.atan2(x - 100, 100 - z)) % 360) / 45) % 8\n    if (x - 100) ^ 2 + (z - 100) ^ 2 > 64 then return k + 8 end\n    return k\n  end\n  function F.tc(t, rIn)\n    return Z.pt(100, 100, 22.5 + 45 * (t % 8), (t < 8) and (rIn or 4) or 12)\n  end\n  function F.cone(deg)\n    return {x = 100, z = 100, dx = sin(rad(deg)), dz = -cos(rad(deg))}\n  end\n  -- clearance of a point from one cone (negative = inside)\n  function F.cclr(c, x, z)\n    local vx, vz = x - c.x, z - c.z\n    local d = sqrt(vx * vx + vz * vz)\n    if d < 0.3 then return -1 end\n    if d >= 24 then return d - 24 end\n    local cp = (vx * c.dx + vz * c.dz) / d\n    if cp >= F.HC then return -1 end\n    if cp <= -F.HS then return d end\n    return d * (F.HC * sqrt(1 - cp * cp) - F.HS * cp)\n  end\n  function F.wclr(W, x, z)\n    local m = 99\n    if W then\n      for i = 1, #W do\n        local c = F.cclr(W[i], x, z)\n        if c < m then m = c end\n      end\n    end\n    return m\n  end\n  -- connected red tiles from t0 (BossMod Tiles.Edges: ring +-1 and radial t+-8); t0 always included\n  function F.region(t0, red)\n    local seen, q, h = {[t0] = true}, {t0}, 1\n    while q[h] do\n      local v = q[h]\n      h = h + 1\n      local base, k = (v < 8) and 0 or 8, v % 8\n      local n1, n2, n3 = base + (k + 7) % 8, base + (k + 1) % 8, (v < 8) and (v + 8) or (v - 8)\n      if red[n1] and not seen[n1] then seen[n1] = true q[#q + 1] = n1 end\n      if red[n2] and not seen[n2] then seen[n2] = true q[#q + 1] = n2 end\n      if red[n3] and not seen[n3] then seen[n3] = true q[#q + 1] = n3 end\n    end\n    return seen\n  end\n  -- best grid point in tiles: >= mc outside wave W, >= 0.25 from borders of t that touch tiles NOT in ok\n  -- (ok = nil: no border rule); score = min(clearance, cap) - wd * dist(ref) - pen (if on a red tile)\n  function F.best(tiles, ok, W, mc, rx, rz, wd, cap, red, pen, step)\n    local bs, bx, bz, bc\n    local na = floor(45 / step + 0.5) - 1\n    for t = 0, 15 do\n      if tiles[t] then\n        local k8 = t % 8\n        local a0, base, inn = 45 * k8, (t < 8) and 0 or 8, t < 8\n        local okP, okN, okR = true, true, true\n        if ok then\n          okP = ok[base + (k8 + 7) % 8]\n          okN = ok[base + (k8 + 1) % 8]\n          okR = ok[inn and (t + 8) or (t - 8)]\n        end\n        local rr = inn and F.RIN or F.ROUT\n        for j = 1, na do\n          local da = step * j\n          local sa, ca = sin(rad(a0 + da)), cos(rad(a0 + da))\n          local sP, sN = sin(rad(da)), sin(rad(45 - da))\n          for k = 1, #rr do\n            local r = rr[k]\n            local bd = 99\n            if not okP then bd = r * sP end\n            if not okN then bd = min(bd, r * sN) end\n            if not okR then bd = min(bd, inn and (8 - r) or (r - 8)) end\n            if bd >= 0.25 then\n              local x, z = 100 + r * sa, 100 - r * ca\n              local cc = F.wclr(W, x, z)\n              if cc >= mc then\n                local cl = min(cc, bd, r - 2.3, 15.3 - r)\n                if cl > 0 then\n                  local sc = min(cl, cap)\n                  if rx then sc = sc - wd * sqrt((x - rx) ^ 2 + (z - rz) ^ 2) end\n                  if red and red[t] then sc = sc - pen end\n                  if not bs or sc > bs + 1e-6 then bs, bx, bz, bc = sc, x, z, cl end\n                end\n              end\n            end\n          end\n        end\n      end\n    end\n    return bx, bz, bc\n  end\n  -- waves from the helper casts (wave 1 = earliest hit, wave 2 = >=1.2s later; missing wave 2 = mirror of wave 1\n  -- across the E-W line), else from the boss visual with the assumed geometry (cone edges on the E-W line)\n  function F.waves(b)\n    local hc = b.hc\n    if b.hcA and #b.hcA >= 2 and #b.hcA >= (hc and #hc or 0) then hc = b.hcA end\n    if hc and #hc > 0 then\n      local h0, h2\n      for i = 1, #hc do\n        if not h0 or hc[i].hit < h0 then h0 = hc[i].hit end\n      end\n      local W1, W2 = {}, {}\n      for i = 1, #hc do\n        local c = hc[i]\n        if c.hit - h0 < 1200 then\n          W1[#W1 + 1] = c\n        else\n          W2[#W2 + 1] = c\n          if not h2 or c.hit < h2 then h2 = c.hit end\n        end\n      end\n      if #W1 == 1 and (W1[1].x - 100) ^ 2 + (W1[1].z - 100) ^ 2 < 4 then\n        W1[2] = {x = W1[1].x, z = W1[1].z, dx = -W1[1].dx, dz = -W1[1].dz}\n      end\n      if #W2 == 0 then\n        for i = 1, #W1 do\n          local c = W1[i]\n          W2[i] = {x = c.x, z = 200 - c.z, dx = c.dx, dz = -c.dz}\n        end\n      elseif #W2 == 1 and (W2[1].x - 100) ^ 2 + (W2[1].z - 100) ^ 2 < 4 then\n        W2[2] = {x = W2[1].x, z = W2[1].z, dx = -W2[1].dx, dz = -W2[1].dz}\n      end\n      return W1, W2, h0, h2 or (h0 + 3000)\n    end\n    if b.vis then\n      local Y = {F.cone(30), F.cone(210)}\n      local X = {F.cone(150), F.cone(330)}\n      local t1 = (b.visT or Now()) + 7600\n      if b.vis == 43233 then return Y, X, t1, t1 + 3000 end\n      return X, Y, t1, t1 + 3000\n    end\n  end\n  function F.ring(towers, W, wantHit)\n    local i, o = 0, 0\n    for k = 1, #towers do\n      local t = towers[k]\n      local x, z = F.tc(t)\n      if (F.wclr(W, x, z) < 0) == wantHit then\n        if t < 8 then i = i + 1 else o = o + 1 end\n      end\n    end\n    if i > 0 and o == 0 then return \"in\" end\n    if o > 0 and i == 0 then return \"out\" end\n  end\n  -- roses go on the ring of the towers hit by the 2nd cleave (= not hit by the 1st);\n  -- last resort = cactbot: IN when (43233 = ENE first) == (outer ENE tile is a tower)\n  function F.mode(towers, W1, W2, vis)\n    if #towers == 0 then return nil end\n    local m = W2 and F.ring(towers, W2, true)\n    if not m and W1 then m = F.ring(towers, W1, false) end\n    if not m and vis then\n      local e9, e1 = false, false\n      for k = 1, #towers do\n        if towers[k] == 9 then e9 = true elseif towers[k] == 1 then e1 = true end\n      end\n      if e9 or e1 then m = ((vis == 43233) == e9) and \"in\" or \"out\" end\n    end\n    return m\n  end\n  function F.sig(b, s, now)\n    local m = 0\n    if Z.tilesKnown and Z.tiles then\n      for t = 0, 15 do\n        if Z.tiles[t] then m = m + 2 ^ t end\n      end\n    end\n    local d = (b.markT and now >= b.markT + 6700) and 1 or 0\n    local n = 0\n    if b.roseIds then\n      for _ in pairs(b.roseIds) do n = n + 1 end\n    end\n    return s .. \"|\" .. tostring(b.roseSup) .. \"|\" .. n .. \"|\" .. (b.tw and #b.tw or 0) .. \"|\" .. (b.hc and #b.hc or 0) .. \"|\" .. (b.hcA and #b.hcA or 0) .. \"|\" .. tostring(b.vis) .. \"|\" .. m .. \"|\" .. d\n  end\n  function F.plan(b, s, now)\n    local P = {sig = F.sig(b, s, now), chk = now}\n    local towers, isT = {}, {}\n    local tw = b.tw\n    if tw then\n      for i = 1, #tw do\n        local t = tw[i].t or F.tileOf(tw[i].x, tw[i].z)\n        if not isT[t] then\n          isT[t] = true\n          towers[#towers + 1] = t\n        end\n      end\n    end\n    local W1, W2, t1, t2 = F.waves(b)\n    P.W1, P.W2, P.w1T, P.w2T = W1, W2, t1, t2\n    P.mode = F.mode(towers, W1, W2, b.vis)\n    -- red tiles = towers + fresh active tiles (tile tracker) + predicted roses until the real rose tiles show up.\n    -- dropFresh = non-tower tiles that turned red at/after the drop (Bloom 6 start pattern tiles do not count)\n    local red, dropFresh = {}, 0\n    for t in pairs(isT) do red[t] = true end\n    if Z.tilesKnown and Z.tiles then\n      local cut = (b.twT or b.markT or now) - 25000\n      local dcut = (b.markT or now) + 5500\n      for t = 0, 15 do\n        if Z.tiles[t] and not red[t] then\n          local tt = Z.tileT and Z.tileT[t]\n          if not tt or tt >= cut then\n            red[t] = true\n            if not tt or tt >= dcut then dropFresh = dropFresh + 1 end\n          end\n        end\n      end\n    end\n    local dropped = b.markT and now >= b.markT + 6700\n    if P.mode and not (dropped and dropFresh > 0) then\n      local o = (P.mode == \"out\") and 8 or 0\n      red[o] = true\n      red[o + 3] = true\n      red[o + 4] = true\n      red[o + 7] = true\n    end\n    P.red = red\n    -- am I a rose? my own marker is authoritative; else all supports / all DPS from the first marker\n    local pl = TensorCore.mGetPlayer()\n    local pid, n = pl and pl.id, 0\n    if b.roseIds then\n      for _ in pairs(b.roseIds) do n = n + 1 end\n    end\n    if pid and b.roseIds and b.roseIds[pid] then\n      P.amRose = true\n    elseif pid and n >= 4 then\n      P.amRose = false\n    else\n      P.amRose = (b.roseSup == Z.isSup(s))\n    end\n    if P.amRose then\n      local q = Z.B6_ROSE and Z.B6_ROSE[s]\n      if not (q and P.mode) then return P end\n      P.dx, P.dz = Z.pt(100, 100, q, (P.mode == \"in\") and 5.5 or 12.0)\n      if W1 and W2 then\n        local east = q < 180\n        local side, pside, plain = {}, {}, {}\n        for t = 0, 15 do\n          if not red[t] then plain[t] = true end\n          if ((t % 8) < 4) == east then\n            side[t] = true\n            if not red[t] then pside[t] = true end\n          end\n        end\n        local x2, z2 = F.best(pside, plain, W2, 1.2, P.dx, P.dz, 0.3, 2.0, nil, 0, 3)\n        if not x2 then x2, z2 = F.best(plain, plain, W2, 0.8, P.dx, P.dz, 0.3, 2.0, nil, 0, 3) end\n        P.r2x, P.r2z = x2, z2\n        if x2 then\n          local x1, z1 = F.best(side, nil, W1, 1.3, x2, z2, 0.5, 2.0, red, 1.5, 3)\n          if not x1 then x1, z1 = F.best(F.ALL, nil, W1, 1.0, x2, z2, 0.5, 2.0, red, 1.5, 3) end\n          P.r1x, P.r1z = x1, z1\n        end\n      end\n      return P\n    end\n    -- tower soaker: group 1 (T1 H1 M1 R1) west, group 2 east; tanks + melee inner, healers + ranged outer\n    local west = (s == \"T1\" or s == \"H1\" or s == \"M1\" or s == \"R1\")\n    local inner = (s == \"T1\" or s == \"T2\" or s == \"M1\" or s == \"M2\")\n    local my, alt\n    for k = 1, #towers do\n      local t = towers[k]\n      if ((t % 8) >= 4) == west then\n        if (t < 8) == inner then my = my or t else alt = alt or t end\n      end\n    end\n    my = my or alt\n    if not my then return P end\n    P.tower = my\n    local reg = F.region(my, red)\n    P.reg = reg\n    for k = 1, #towers do\n      if towers[k] ~= my and reg[towers[k]] then P.linked = true end\n    end\n    local cx, cz = F.tc(my)\n    P.fx, P.fz = F.tc(my, 5.5)\n    if W2 then\n      P.hit = F.wclr(W2, cx, cz) < 0\n      local fx, fz, fc = F.best(reg, reg, W2, 0.15, cx, cz, 0.02, 99, nil, 0, 1.5)\n      if fx then P.fx, P.fz, P.fclr = fx, fz, fc else P.nosafe = true end\n    end\n    if W1 then\n      -- wait inside your own region when that is not a detour (>4y longer run than the best spot anywhere)\n      local wx, wz = F.best(reg, nil, W1, 1.3, P.fx, P.fz, 1.0, 2.0, nil, 0, 1.5)\n      local gx, gz = F.best(F.ALL, nil, W1, 1.3, P.fx, P.fz, 1.0, 2.0, nil, 0, 3)\n      if gx and (not wx or sqrt((wx - P.fx) ^ 2 + (wz - P.fz) ^ 2) > sqrt((gx - P.fx) ^ 2 + (gz - P.fz) ^ 2) + 4) then wx, wz = gx, gz end\n      P.wx, P.wz = wx, wz\n    end\n    P.fang = math.deg(math.atan2(P.fx - 100, 100 - P.fz)) % 360\n    return P\n  end\n  Z.b6fn = F\nend\nlocal now = Now()\nlocal P = b.plan\nif not P or now - (P.chk or 0) >= 250 then\n  if P then P.chk = now end\n  local sg = F.sig(b, s, now)\n  if not P or sg ~= P.sig then\n    local ok, np = pcall(F.plan, b, s, now)\n    if ok and np then\n      P = np\n      b.plan = P\n    end\n  end\nend\nif not P then return end\nif not b.roseSaid and b.markT and now > b.markT + 800 then\n  b.roseSaid = true\n  hush(6000, P.amRose and \"ROSE: your quadrant tile - follow the arrow\" or \"TOWER: follow the arrow\", P.amRose and 0xFFFF66FF or 0xFF33FF33)\nend\nlocal pl = TensorCore.mGetPlayer()\nlocal py = (pl and pl.pos) and pl.pos.y or 0\nlocal w1T, w2T = P.w1T, P.w2T\nif P.amRose then\n  if now < (b.markT or now) + 6800 then\n    if P.dx then\n      Z.goTo(P.dx, P.dz, 0xFF66FF, 1.2)\n    else\n      local q = Z.B6_ROSE and Z.B6_ROSE[s]\n      if not q then return end\n      local g = TensorCore.getCachedDrawer(0x33FF66FF, 0x55FF66FF, 0x88FF66FF, 0xFFFF66FF, 2)\n      local xi, zi = Z.pt(100, 100, q, 5.5)\n      local xo, zo = Z.pt(100, 100, q, 12.0)\n      g:addCircle(xi, py, zi, 1.2, false, Z.flags)\n      g:addCircle(xo, py, zo, 1.2, false, Z.flags)\n      local xm, zm = Z.pt(100, 100, q, 8.75)\n      Z.goTo(xm, zm, 0xFF66FF, 0.5)\n    end\n  elseif w1T and now < w1T then\n    if P.r1x then Z.goTo(P.r1x, P.r1z, 0xFF66FF, 1.0) end\n    if P.r2x then TensorCore.getCachedDrawer(0x22FFFF00, 0x44FFFF00, 0x66FFFF00, 0xCCFFFF00, 2):addCircle(P.r2x, py, P.r2z, 0.7, false, Z.flags) end\n  elseif w2T and now < w2T + 500 and P.r2x then\n    Z.goTo(P.r2x, P.r2z, 0xFF66FF, 1.0)\n  end\n  return\nend\nif not P.tower then return end\n-- pre-mark YOUR tower: outline of your tower tile from the moment the towers appear until they explode\nif not b.twHit or now < b.twHit + 300 then\n  local t = P.tower\n  local r0, r1 = (t < 8) and 2.3 or 8.0, (t < 8) and 8.0 or 15.3\n  local a0 = 45 * (t % 8)\n  local pts = {}\n  for i = 0, 6 do pts[#pts + 1] = {Z.pt(100, 100, a0 + 7.5 * i, r0)} end\n  for i = 6, 0, -1 do pts[#pts + 1] = {Z.pt(100, 100, a0 + 7.5 * i, r1)} end\n  local ln = TensorCore.getStaticDrawer(0xFF33FF33, 3)\n  for i = 1, #pts do\n    local p1, p2 = pts[i], pts[i % #pts + 1]\n    ln:addLine(p1[1], py, p1[2], p2[1], py, p2[2], 3)\n  end\nend\nif not (w1T and P.wx) then\n  local x, z = F.tc(P.tower, 5.5)\n  Z.goTo(x, z, 0x33FF33, 2.0)\nelseif now < w1T then\n  Z.goTo(P.wx, P.wz, 0x33FF33, 1.0)\n  TensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xCC00FFFF, 2):addCircle(P.fx, py, P.fz, P.hit and 0.6 or 1.0, false, Z.flags)\nelseif not w2T or now < w2T + 500 then\n  Z.goTo(P.fx, P.fz, P.hit and 0x00FFFF or 0x33FF33, P.hit and 0.6 or 1.2)\nend\nif P.linked and not b.linkWarn then\n  b.linkWarn = true\n  hush(5000, \"TOWERS LINKED (rose on a wrong tile) - mitigate\", 0xFF3333FF)\nelseif P.nosafe and not b.noSafeWarn and now >= (b.markT or now) + 7000 then\n  b.noSafeWarn = true\n  hush(5000, \"No cleave-safe spot in your tower - soak it with mitigation\", 0xFF3333FF)\nend\n",
							name = "[Draw] Bloom 6 - your rose / tower spot",
							uuid = "69b203aa-d823-07ac-a077-3c18face2651",
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
				mechanicTime = 522.1,
				name = "[Draw] Bloom 6 - your rose / tower spot",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = 0.5,
				timerStartOffset = -15,
				uuid = "8009dea7-ef95-a486-859c-b83ad201939b",
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
				name = "Role Draws",
				uuid = "a3043562-b3cb-7b73-bcd9-e9e02a7fd89a",
			},
			objectType = "folder",
		},
	},
	[112] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "8a9b7617-d1d2-d6a0-8929-dfa1713f8fb6",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nZ.say(6000, \"THUNDER II: 3 inner safe tiles, stay BEHIND the rotation\", 0xFF00FFFF)\nself.used = true\n",
							conditions = 
							{
								
								{
									"447b195b-737e-80ca-81cf-a38c7cb0837a",
									true,
								},
							},
							name = "[Draw] Bloom 1 (repeat) - Thunder II callout",
							uuid = "c0bfb361-da0b-82cd-80a0-41a137ffdb1c",
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
							eventSpellID = 43198,
							name = "Thunder II",
							uuid = "447b195b-737e-80ca-81cf-a38c7cb0837a",
							version = 3,
						},
					},
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 542,
				name = "[Draw] Bloom 1 (repeat) - Thunder II callout (old)",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = -3.5,
				timerStartOffset = -6,
				uuid = "dafeba7a-ae84-11d7-956d-b1657bffe553",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not eventArgs then self.used = true return end\n-- Bloom 1: rotation icon on Zelenia (167 = clockwise, 168 = counter-clockwise)\nlocal m = eventArgs.markerID\nif m == 167 or m == 168 then\n  local now = Now()\n  local b = Z.b1\n  if not (b and b.t0 and now - b.t0 < 40000) then\n    b = {t0 = now, cones = {}, nc = 0, k = 0}\n    Z.b1 = b\n  end\n  b.dir = (m == 167) and 1 or -1\nend\nself.used = true",
							name = "[Draw] Bloom 1 (repeat) - Thunder II rotation tracker",
							uuid = "36eaebc8-611b-1b5d-9ee4-014be626da81",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 542,
				name = "[Draw] Bloom 1 (repeat) - Thunder II rotation tracker",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "c03c85fe-293c-85d4-ad7c-5ccce4412530",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not eventArgs then self.used = true return end\n-- Bloom 1: the three Alexandrian Thunder II cones (43199, 5.4s) start; store each helper's facing\nif eventArgs.spellID == 43199 then\n  local now = Now()\n  local b = Z.b1\n  if not (b and b.t0 and now - b.t0 < 40000) then\n    b = {t0 = now, cones = {}, nc = 0, k = 0}\n    Z.b1 = b\n  end\n  b.cones = b.cones or {}\n  b.chanT = b.chanT or now\n  local id = eventArgs.entityID\n  if id and b.cones[id] == nil and (b.nc or 0) < 3 then\n    local e = TensorCore.mGetEntity(id)\n    if e and e.pos and e.pos.h then\n      b.cones[id] = (180 - math.deg(e.pos.h)) % 360\n      b.nc = (b.nc or 0) + 1\n    end\n  end\nend\nself.used = true",
							name = "[Draw] Bloom 1 (repeat) - Thunder II cone tracker",
							uuid = "fb2d0a3b-3cd2-174b-bf99-74e39255e93f",
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
				mechanicTime = 542,
				name = "[Draw] Bloom 1 (repeat) - Thunder II cone tracker",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "d2e382a2-d9a8-db15-810c-f4f7d286db28",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nif not eventArgs then self.used = true return end\n-- Bloom 1: count Thunder II snapshots (43199 = 1st hit, 43064 = repeats; 3 casts per step, 15 steps)\nlocal sid = eventArgs.spellID\nif sid == 43199 or sid == 43064 then\n  local b = Z.b1\n  local now = Now()\n  if b and b.t0 and now - b.t0 < 40000 then\n    if not b.stepT or now - b.stepT > 450 then\n      b.k = (b.k or 0) + 1\n      b.stepT = now\n      if b.k == 1 then b.T0 = now end\n    end\n    -- late direction fallback: a 2nd-step heading is a start cone +-10 degrees\n    if not b.dir and b.k == 2 and eventArgs.heading and b.cones then\n      local a = (180 - math.deg(eventArgs.heading)) % 360\n      for _, c in pairs(b.cones) do\n        if math.abs((a - c - 10 + 540) % 360 - 180) < 3 then b.dir = 1 break end\n        if math.abs((a - c + 10 + 540) % 360 - 180) < 3 then b.dir = -1 break end\n      end\n    end\n  end\nend\nself.used = true",
							name = "[Draw] Bloom 1 (repeat) - Thunder II step counter",
							uuid = "94eca5bf-74ea-d4d9-98a2-f82288451481",
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
				mechanicTime = 542,
				name = "[Draw] Bloom 1 (repeat) - Thunder II step counter",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = 16,
				timerStartOffset = -0.5,
				uuid = "a50c03ce-2d54-328a-a339-5b23e53a2033",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 1 Thunder II: arrow to the start spot just behind a cone, then follow the rotation on plain tiles\n-- (plan = 15 snapshot phases x 16 tiles, solved once; afterwards each frame only looks up the phase)\nlocal b = Z.b1\nlocal now = Now()\nif not (b and b.t0 and now - b.t0 < 40000) then return end\nif not b.plan and not b.planFail then\n  local cones = {}\n  if b.cones then for _, c in pairs(b.cones) do cones[#cones + 1] = c end end\n  if #cones < 3 then\n    if b.chanT and now - b.chanT < 400 then return end\n    if not b.chanT and now - b.t0 < 1000 then return end\n  end\n  local dir = b.dir\n  if not dir and #cones == 3 then\n    -- every log: CW starts {22.5,142.5,262.5}, CCW starts {67.5,187.5,307.5}\n    local m = cones[1] % 120\n    if math.abs(m - 22.5) < 4 then dir = 1 elseif math.abs(m - 67.5) < 4 then dir = -1 end\n  end\n  if not dir then\n    if not b.said0 and b.chanT and now - b.chanT > 1500 then\n      b.said0 = true\n      hush(6000, \"THUNDER II: 3 inner safe tiles, stay BEHIND the rotation\", 0xFF00FFFF)\n    end\n    return\n  end\n  if #cones ~= 3 then cones = (dir > 0) and {22.5, 142.5, 262.5} or {67.5, 187.5, 307.5} end\n  -- floor: live tile tracker when fresh and plausible, else the floor seen in every log for this rotation\n  local red, useT, newest = {}, false, 0\n  if Z.tilesKnown and type(Z.tiles) == \"table\" then\n    local nr = 0\n    for t = 0, 15 do\n      if Z.tiles[t] then nr = nr + 1 end\n      local tt = type(Z.tileT) == \"table\" and Z.tileT[t]\n      if tt and tt > newest then newest = tt end\n    end\n    useT = (nr >= 4 and nr <= 13 and now - newest < 25000)\n    -- floor still changing: wait for it to settle (max 2.5s after the rotation marker)\n    if useT and now - newest < 400 and now - b.t0 < 2500 then return end\n  end\n  b.planNewest = newest\n  if useT then\n    for t = 0, 15 do red[t] = Z.tiles[t] and true or false end\n  else\n    local plain = (dir > 0) and {[2] = 1, [3] = 1, [4] = 1, [9] = 1, [10] = 1, [12] = 1}\n      or {[0] = 1, [3] = 1, [6] = 1, [7] = 1, [13] = 1, [14] = 1}\n    for t = 0, 15 do red[t] = not plain[t] end\n  end\n  -- node(n, u): safe arc of tile u for snapshot n (outside the cones at n-1 and n), target = its forward end\n  local function node(n, u)\n    local inner = u < 8\n    local k = u % 8\n    local s = 45 * k\n    -- start spot (before the 1st hit, held ~5 s): wider margin; afterwards 8 deg behind the cone that just fired\n    local mg = (n == 0) and (inner and 15 or 9) or (inner and 8 or 5)\n    local em = inner and 9 or 5.5\n    local base = inner and 0 or 8\n    local a, bb = s, s + 45\n    if red[base + (k + 7) % 8] then a = a + em end\n    if red[base + (k + 1) % 8] then bb = bb - em end\n    local arcs = {}\n    for i = 1, 3 do\n      local p2 = cones[i] + 10 * dir * n\n      local p1 = (n > 0) and (cones[i] + 10 * dir * (n - 1)) or p2\n      local x0 = math.min(p1, p2) - 22.5 - mg\n      local x1 = math.max(p1, p2) + 22.5 + mg\n      arcs[i] = {x0, x1}\n      local w = x1 - x0\n      local p = (x0 - s) % 360\n      if p < 45 then\n        if s + p <= a then a = math.max(a, s + p + w) else bb = math.min(bb, s + p) end\n      end\n      if p + w > 360 then a = math.max(a, s + p + w - 360) end\n    end\n    if bb - a < (inner and 2 or 1.5) then return nil end\n    local t = (dir > 0) and bb or a\n    local lag = 999\n    for i = 1, 3 do\n      local g = (dir > 0) and ((arcs[i][1] - t) % 360) or ((t - arcs[i][2]) % 360)\n      if g < lag then lag = g end\n    end\n    if lag > 180 then lag = 0 end\n    local x, z = Z.pt(100, 100, t, inner and 5.5 or 10)\n    return {u = u, ang = t, inner = inner, lag = lag, x = x, z = z}\n  end\n  local N, INF = 15, 1e9\n  local nodes, best, nxt = {}, {}, {}\n  for n = 0, N - 1 do\n    nodes[n], best[n], nxt[n] = {}, {}, {}\n    for u = 0, 15 do nodes[n][u] = node(n, u) end\n  end\n  local function ncost(q)\n    local c = q.lag / 10 + (q.inner and 0 or 0.3)\n    if red[q.u] then c = c + 25 end\n    return c\n  end\n  for u = 0, 15 do\n    local q = nodes[N - 1][u]\n    best[N - 1][u] = q and ncost(q) or INF\n  end\n  for n = N - 2, 0, -1 do\n    for u = 0, 15 do\n      local q = nodes[n][u]\n      local bc, bv = INF, nil\n      if q then\n        local k = u % 8\n        local base = (u < 8) and 0 or 8\n        local cand = {u, base + (k + 7) % 8, base + (k + 1) % 8, (u < 8) and (u + 8) or (u - 8)}\n        for j = 1, 4 do\n          local v = cand[j]\n          local w = nodes[n + 1][v]\n          if w and best[n + 1][v] < INF then\n            local dx, dz = q.x - w.x, q.z - w.z\n            local dist = math.sqrt(dx * dx + dz * dz)\n            local okm = dist <= 6.5\n            local tc = 0\n            if v ~= u then\n              tc = (v % 8 == k) and 1.5 or 0.5\n              if math.abs((q.ang - w.ang + 540) % 360 - 180) > 30 then okm = false end\n            end\n            if dist > 4 then tc = tc + dist - 4 end\n            if okm and tc + best[n + 1][v] < bc then bc, bv = tc + best[n + 1][v], v end\n          end\n        end\n      end\n      if bv then\n        best[n][u] = ncost(q) + bc\n        nxt[n][u] = bv\n      else\n        best[n][u] = INF\n      end\n    end\n  end\n  local u0, c0 = nil, INF\n  for u = 0, 15 do\n    local c = best[0][u] + ((u < 8) and 0 or 0.5)\n    if c < c0 then u0, c0 = u, c end\n  end\n  if not u0 then\n    b.planFail = true\n    return\n  end\n  local plan = {dir = dir, cones = cones, useT = useT, red = red}\n  local u = u0\n  for n = 0, N - 1 do\n    local q = u and nodes[n][u]\n    if not q then break end\n    plan[n] = q\n    u = nxt[n][u]\n  end\n  b.plan = plan\n  local q0 = plan[0]\n  if q0 and b.saidU ~= q0.u then\n    b.saidU = q0.u\n    hush(7000, \"THUNDER II: rotates \" .. ((dir > 0) and \"CLOCKWISE\" or \"COUNTER-CLOCKWISE\") .. \" - start \" ..\n      Z.dirName(q0.ang) .. (q0.inner and \" inner\" or \" outer\") .. \", follow the arrow\", 0xFF00FFFF)\n  end\nend\nlocal plan = b.plan\nif not plan then return end\n-- phase = next snapshot index: counted casts, or time since the first hit when a cast event was missed\nlocal n = b.k or 0\nlocal T0 = b.T0 or (b.chanT and (b.chanT + 5540))\nif T0 and now > T0 + 300 then\n  local nt = math.floor((now - T0 - 300) / 1007) + 1\n  if nt > n then n = nt end\nend\nif n > 14 then return end\n-- before the first hit: if the floor changed after planning, plan again next frame\nif n == 0 and Z.tilesKnown and type(Z.tileT) == \"table\" then\n  local nw = 0\n  for t = 0, 15 do\n    local tt = Z.tileT[t]\n    if tt and tt > nw then nw = tt end\n  end\n  if nw > (b.planNewest or 0) + 50 then\n    b.plan = nil\n    return\n  end\nend\nlocal q = plan[n]\nif not q then return end\nZ.goTo(q.x, q.z, 0x33FF33, 0.7)\nlocal p = TensorCore.mGetPlayer()\nlocal y = (p and p.pos) and p.pos.y or 0\nlocal q2 = plan[n + 1]\nif q2 then\n  TensorCore.getCachedDrawer(0x4400FFFF, 0x6600FFFF, 0x9900FFFF, 0xFF00FFFF, 1.5):addCircle(q2.x, y, q2.z, 0.45, false, Z.flags)\nend\n-- edges of the three cones that hit next\nlocal dl = TensorCore.getStaticDrawer(0xCC3333FF, 2)\nlocal cs = plan.cones\nfor i = 1, 3 do\n  local c = cs[i] + 10 * plan.dir * n\n  local xa, za = Z.pt(100, 100, c - 22.5, 2.5)\n  local xb, zb = Z.pt(100, 100, c - 22.5, 16)\n  dl:addLine(xa, y, za, xb, y, zb, 2)\n  xa, za = Z.pt(100, 100, c + 22.5, 2.5)\n  xb, zb = Z.pt(100, 100, c + 22.5, 16)\n  dl:addLine(xa, y, za, xb, y, zb, 2)\nend",
							name = "[Draw] Bloom 1 (repeat) - Thunder II follow the rotation",
							uuid = "2dd2d9aa-01ed-7d6d-b463-e3dff3d21d10",
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
				mechanicTime = 542,
				name = "[Draw] Bloom 1 (repeat) - Thunder II follow the rotation",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = 15.5,
				timerStartOffset = -5.3,
				uuid = "1c639eee-efbd-cf8f-9a34-173bf3a5fbfc",
				version = 2,
			},
		},
	},
	[114] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "e774f122-be5b-b45e-bd6e-22cc744eaffb",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\nhush(6000, \"SPREAD anywhere, but NOT on a red (vine) tile when it goes off\", 0xFF00FFFF)\nself.used = true\n",
							name = "[Draw] Bloom 1 (repeat) - spread callout",
							uuid = "64d128f4-0b58-4f3d-b4fb-b0dfefb57239",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				mechanicTime = 561.8,
				name = "[Draw] Bloom 1 (repeat) - spread callout",
				timeRange = true,
				timelineIndex = 114,
				timerEndOffset = -3,
				timerStartOffset = -4.3,
				uuid = "ad81077f-9622-ff3c-964c-441c1685e473",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Bloom 1 Thunder III: per-slot spread spot on a plain (non-vine) tile, >= 5.2y from every other slot's spot\nlocal s = Z.slot()\nif not s then return end\nlocal now = Now()\n-- wait until the last Thunder II snapshot is out (15 steps) before pulling people off the rotation path\nlocal b0 = Z.b1\nif b0 and b0.t0 and now - b0.t0 < 45000 and (b0.k or 0) < 15 then\n  local T0 = b0.T0 or (b0.chanT and (b0.chanT + 5540))\n  if T0 and now - T0 < 14400 then return end\nend\nlocal c = Z.b1s\nif not (c and c.t and now - c.t < 12000) then\n  c = nil\n  local b = Z.b1\n  local plan = (b and b.t0 and now - b.t0 < 45000) and b.plan or nil\n  local dir = plan and plan.dir or ((b and b.t0 and now - b.t0 < 45000) and b.dir or nil)\n  local red, useT = {}, false\n  if plan and plan.red then\n    red, useT = plan.red, plan.useT\n  else\n    if Z.tilesKnown and type(Z.tiles) == \"table\" then\n      local nr, newest = 0, 0\n      for t = 0, 15 do\n        if Z.tiles[t] then nr = nr + 1 end\n        local tt = type(Z.tileT) == \"table\" and Z.tileT[t]\n        if tt and tt > newest then newest = tt end\n      end\n      useT = (nr >= 4 and nr <= 13 and now - newest < 45000)\n    end\n    if not dir and useT then\n      local cw = not (Z.tiles[2] or Z.tiles[3] or Z.tiles[4])\n      local ccw = not (Z.tiles[6] or Z.tiles[7] or Z.tiles[0])\n      if cw and not ccw then dir = 1 elseif ccw and not cw then dir = -1 end\n    end\n    if dir then\n      if useT then\n        for t = 0, 15 do red[t] = Z.tiles[t] and true or false end\n      else\n        local plain = (dir > 0) and {[2] = 1, [3] = 1, [4] = 1, [9] = 1, [10] = 1, [12] = 1}\n          or {[0] = 1, [3] = 1, [6] = 1, [7] = 1, [13] = 1, [14] = 1}\n        for t = 0, 15 do red[t] = not plain[t] end\n      end\n    end\n  end\n  if dir then\n    -- {angle clockwise from N, radius}: the spots this PF used (CCW = marker 168, CW = marker 167)\n    local DES = (dir > 0) and {T1 = {103, 4.5}, T2 = {62, 12.0}, H1 = {219, 14.8}, H2 = {203, 10.0},\n        M1 = {211, 4.8}, M2 = {157, 6.5}, R1 = {116, 12.5}, R2 = {192, 15.0}}\n      or {T1 = {33, 5.5}, T2 = {152, 6.0}, H1 = {230, 14.8}, H2 = {308, 14.5},\n        M1 = {232, 9.5}, M2 = {299, 5.5}, R1 = {277, 14.5}, R2 = {254, 13.2}}\n    local function good(x, z)\n      local dx, dz = x - 100, z - 100\n      local r = math.sqrt(dx * dx + dz * dz)\n      if r < 3 or r > 15.3 then return false end\n      local ang = math.deg(math.atan2(dx, -dz)) % 360\n      local k = math.floor(ang / 45) % 8\n      local base = (r <= 8) and 0 or 8\n      local t = base + k\n      if red[t] then return false end\n      local rel = ang - 45 * k\n      if red[base + (k + 7) % 8] and math.rad(rel) * r < 0.9 then return false end\n      if red[base + (k + 1) % 8] and math.rad(45 - rel) * r < 0.9 then return false end\n      if base == 0 and red[t + 8] and 8 - r < 0.9 then return false end\n      if base == 8 and red[t - 8] and r - 8 < 0.9 then return false end\n      return true\n    end\n    local placed = {}\n    local function free(x, z)\n      for i = 1, #placed do\n        local dx, dz = placed[i][1] - x, placed[i][2] - z\n        if dx * dx + dz * dz < 27.04 then return false end\n      end\n      return true\n    end\n    local sp = {}\n    local ORDER = {\"T1\", \"T2\", \"H1\", \"H2\", \"M1\", \"M2\", \"R1\", \"R2\"}\n    for i = 1, 8 do\n      local sl = ORDER[i]\n      local d = DES[sl]\n      local x, z = Z.pt(100, 100, d[1], d[2])\n      if not (good(x, z) and free(x, z)) then\n        local bx, bz, bd\n        for t = 0, 15 do\n          if not red[t] then\n            local ca = 22.5 + 45 * (t % 8)\n            local rs = (t < 8) and {4.8, 6.6} or {9.6, 12.4, 15.0}\n            for j = 1, #rs do\n              for da = -14, 14, 7 do\n                local cx, cz = Z.pt(100, 100, ca + da, rs[j])\n                if good(cx, cz) and free(cx, cz) then\n                  local dd = (cx - x) * (cx - x) + (cz - z) * (cz - z)\n                  if not bd or dd < bd then bx, bz, bd = cx, cz, dd end\n                end\n              end\n            end\n          end\n        end\n        if bx then x, z = bx, bz end\n      end\n      sp[sl] = {x, z}\n      placed[#placed + 1] = {x, z}\n    end\n    c = {t = now, sp = sp, dir = dir, useT = useT}\n    Z.b1s = c\n  end\nend\nif not c then return end\nlocal q = c.sp[s]\nif q then Z.goTo(q[1], q[2], 0xFF66FF, 0.8) end",
							name = "[Draw] Bloom 1 (repeat) - Thunder III your spread spot",
							uuid = "9ea1905f-5991-8326-8da7-299217e1b537",
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
				mechanicTime = 561.8,
				name = "[Draw] Bloom 1 (repeat) - Thunder III your spread spot",
				timeRange = true,
				timelineIndex = 114,
				timerEndOffset = 1.2,
				timerStartOffset = -5.3,
				uuid = "c98e7512-117b-40af-a921-2364cd37a7d8",
				version = 2,
			},
		},
	},
	[116] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "9a676044-7861-7029-ac11-b2acd1f51715",
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
							actionLua = "local function hush() end -- removed text callouts (draws cover them)\ndata.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tankbuster tethers (89) from players to the boss\nlocal e = eventArgs\nif not e then self.used = true return end\nZ.spec = Z.spec or {}\nif e.newTetherID == 89 then\n  Z.spec[e.sourceEntityID] = true\n  local p = TensorCore.mGetPlayer()\n  if p and e.sourceEntityID == p.id and not Z.tankOf(p.id) then hush(4000, \"BUSTER TETHER: let a tank take it\", 0xFF3333FF) end\nelseif e.oldTetherID == 89 then\n  Z.spec[e.sourceEntityID] = nil\nend\nself.used = true\n",
							name = "[Draw] Specter - tether tracker",
							uuid = "37c467db-0110-e472-8b35-20f02b3b13e2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 580.8,
				name = "[Draw] Specter - tether tracker",
				timeRange = true,
				timelineIndex = 116,
				timerEndOffset = 0.3,
				timerStartOffset = -9,
				uuid = "49705d64-1f36-732f-bd94-57f53f7ebb65",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Specter of the Lost: tanks get a line to any non-tank holding a tether\nlocal S = Z.spec\nlocal p = TensorCore.mGetPlayer()\nif not (S and p and p.pos) then return end\nlocal tank = Z.tankOf(p.id)\nfor id in pairs(S) do\n  if not Z.tankOf(id) then\n    local ent = TensorCore.mGetEntity(id)\n    if ent and ent.pos then\n      if tank then\n        TensorCore.getStaticDrawer(0xFF00FFFF, 4):addLine(p.pos.x, p.pos.y, p.pos.z, ent.pos.x, ent.pos.y, ent.pos.z, 6)\n        TensorCore.getCachedDrawer(0x3300FFFF, 0x5500FFFF, 0x8800FFFF, 0xFF00FFFF, 3):addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 1.5, false, Z.flags)\n      elseif id == p.id then\n        TensorCore.getCachedDrawer(0x333333FF, 0x553333FF, 0x883333FF, 0xFF3333FF, 3):addCircle(p.pos.x, p.pos.y, p.pos.z, 1.5, false, Z.flags)\n      end\n    end\n  end\nend\n",
							name = "[Draw] Specter - tanks grab tethers",
							uuid = "a9c51255-8ec8-861e-abd2-35d871bd59cb",
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
				mechanicTime = 580.8,
				name = "[Draw] Specter - tanks grab tethers",
				timeRange = true,
				timelineIndex = 116,
				timerEndOffset = 0.2,
				timerStartOffset = -8.5,
				uuid = "0197dcd1-251f-b072-97fb-372f4f8550c0",
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
				uuid = "10eef0f2-e2d2-29c3-a92e-1a944ff8612d",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: ring on the stack target for all 5 hits\nlocal e = eventArgs\nif not (e and e.markerID == 590) then self.used = true return end\nZ.sb = {id = e.entityID, t = Now()}\nTensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xFF00FFFF, 3):addTimedCircleOnEnt(11500, e.entityID, 5.0, 0, false, true, Z.flags)\nself.used = true\n",
							name = "[Draw] Stock Break - stack ring",
							uuid = "258df56c-0ab1-e124-96de-e64fde641d49",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 594.3,
				name = "[Draw] Stock Break - stack ring",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = -5.5,
				timerStartOffset = -8.5,
				uuid = "6df472f1-9f22-b151-be15-9f7622662907",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: arrow to the stack target when you are not in it\nlocal sb = Z.sb\nlocal p = TensorCore.mGetPlayer()\nif not (sb and p and p.pos) or sb.id == p.id or Now() - sb.t > 11500 then return end\nlocal t = TensorCore.mGetEntity(sb.id)\nif not (t and t.pos) then return end\nif TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, t.pos.x, p.pos.y, t.pos.z) > 3.0 then\n  Z.goTo(t.pos.x, t.pos.z, 0x00FFFF, 0.6)\nend\n",
							name = "[Draw] Stock Break - go stack",
							uuid = "ad6125e5-c1f7-0914-8291-ca38c790d493",
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
				mechanicTime = 594.3,
				name = "[Draw] Stock Break - go stack",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 4.6,
				timerStartOffset = -7.2,
				uuid = "33f6daf2-f502-cfc1-8d42-bd9499af1421",
				version = 2,
			},
		},
	},
	[119] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "a4ac0af7-b386-df2d-b3a0-8d829136e432",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: ring on the stack target for all 5 hits\nlocal e = eventArgs\nif not (e and e.markerID == 590) then self.used = true return end\nZ.sb = {id = e.entityID, t = Now()}\nTensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xFF00FFFF, 3):addTimedCircleOnEnt(11500, e.entityID, 5.0, 0, false, true, Z.flags)\nself.used = true\n",
							name = "[Draw] Stock Break - stack ring",
							uuid = "addd526f-ffab-a4b2-97ea-e9ffabe060ee",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 607.4,
				name = "[Draw] Stock Break - stack ring",
				timeRange = true,
				timelineIndex = 119,
				timerEndOffset = -5.5,
				timerStartOffset = -8.5,
				uuid = "02eefedb-327c-10cb-927f-7f2bb095701c",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: arrow to the stack target when you are not in it\nlocal sb = Z.sb\nlocal p = TensorCore.mGetPlayer()\nif not (sb and p and p.pos) or sb.id == p.id or Now() - sb.t > 11500 then return end\nlocal t = TensorCore.mGetEntity(sb.id)\nif not (t and t.pos) then return end\nif TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, t.pos.x, p.pos.y, t.pos.z) > 3.0 then\n  Z.goTo(t.pos.x, t.pos.z, 0x00FFFF, 0.6)\nend\n",
							name = "[Draw] Stock Break - go stack",
							uuid = "4bfd0831-f6d6-a080-a11d-a1998fbd049a",
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
				mechanicTime = 607.4,
				name = "[Draw] Stock Break - go stack",
				timeRange = true,
				timelineIndex = 119,
				timerEndOffset = 4.6,
				timerStartOffset = -7.2,
				uuid = "3aff5d65-49a9-d560-9c90-a71227a26cd2",
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
				uuid = "d37705a6-c021-26f3-8d95-241925f95a22",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: ring on the stack target for all 5 hits\nlocal e = eventArgs\nif not (e and e.markerID == 590) then self.used = true return end\nZ.sb = {id = e.entityID, t = Now()}\nTensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xFF00FFFF, 3):addTimedCircleOnEnt(11500, e.entityID, 5.0, 0, false, true, Z.flags)\nself.used = true\n",
							name = "[Draw] Stock Break - stack ring",
							uuid = "16ee09dd-b138-ee9a-abc3-bad84582fa61",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 4,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Stock Break - stack ring",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = -5.5,
				timerStartOffset = -8.5,
				uuid = "09c6d828-7452-40a8-a263-4c9a077d8eb9",
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
							actionLua = "data.zel = data.zel or {}\nlocal Z = data.zel\nif not Z.initV then\n  Z.initV = true\n  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}\n  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}\n  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}\n  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}\n  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}\n  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}\n  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}\n  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}\n  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}\n  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}\n  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}\n  function Z.slot()\n    local R = AnyoneCore and AnyoneCore.Roster\n    local s = R and R.mySlot and R.mySlot()\n    if not s and GetCurrentRole then\n      local r = GetCurrentRole()\n      s = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r\n    end\n    return s\n  end\n  function Z.slotOf(id)\n    local R = AnyoneCore and AnyoneCore.Roster\n    return R and R.slotOf and R.slotOf(id)\n  end\n  function Z.isSup(s) return s == \"T1\" or s == \"T2\" or s == \"H1\" or s == \"H2\" end\n  function Z.supOf(id)\n    local s = Z.slotOf(id)\n    if s then return Z.isSup(s) end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.SUPJOB[e.job]) and true or false\n  end\n  function Z.tankOf(id)\n    local s = Z.slotOf(id)\n    if s then return s == \"T1\" or s == \"T2\" end\n    local e = TensorCore.mGetEntity(id)\n    return (e and Z.TANKJOB[e.job]) and true or false\n  end\n  function Z.pt(cx, cz, deg, r)\n    local a = math.rad(deg)\n    return cx + r * math.sin(a), cz - r * math.cos(a)\n  end\n  function Z.goTo(x, z, col, rad)\n    local p = TensorCore.mGetPlayer()\n    if not (p and p.pos) then return end\n    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)\n    local px, py, pz = p.pos.x, p.pos.y, p.pos.z\n    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)\n    if d > 0.8 then\n      -- tether from you to your spot\n      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)\n      local tip = math.min(1.5, d * 0.35)\n      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)\n    end\n    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)\n  end\n  function Z.say(ms, txt, col)\n    local p = TensorCore.mGetPlayer()\n    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then\n      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)\n    end\n  end\n  function Z.dirName(deg)\n    local N = {\"N\",\"NNE\",\"NE\",\"ENE\",\"E\",\"ESE\",\"SE\",\"SSE\",\"S\",\"SSW\",\"SW\",\"WSW\",\"W\",\"WNW\",\"NW\",\"NNW\"}\n    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]\n  end\n  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)\n  function Z.efState(k)\n    local ef = Z.ef\n    if not ef then return nil end\n    local sym = ef.sym\n    if not sym[k] then return nil end\n    local mySup = Z.isSup(Z.slot())\n    local supFirst\n    if ef.mode == 2 and Z.donutSup ~= nil then\n      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3\n      supFirst = not Z.donutSup\n    else\n      if not sym[1] then return nil end\n      supFirst = (sym[1] == \"F\")\n    end\n    local iTake = ((k % 2 == 1) == (supFirst == mySup))\n    if iTake then return (sym[k] == \"N\") and \"IN\" or \"OUT\" end\n    return (sym[k] == \"N\") and \"OUT\" or \"IN\"\n  end\nend\n-- Stock Break: arrow to the stack target when you are not in it\nlocal sb = Z.sb\nlocal p = TensorCore.mGetPlayer()\nif not (sb and p and p.pos) or sb.id == p.id or Now() - sb.t > 11500 then return end\nlocal t = TensorCore.mGetEntity(sb.id)\nif not (t and t.pos) then return end\nif TensorCore.getDistance2d2(p.pos.x, p.pos.y, p.pos.z, t.pos.x, p.pos.y, t.pos.z) > 3.0 then\n  Z.goTo(t.pos.x, t.pos.z, 0x00FFFF, 0.6)\nend\n",
							name = "[Draw] Stock Break - go stack",
							uuid = "1b5ac7a9-824e-5db2-abdf-40f82dd417fd",
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
				mechanicTime = 620.5,
				name = "[Draw] Stock Break - go stack",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = 4.6,
				timerStartOffset = -7.2,
				uuid = "4fcfc7a5-9627-2d4a-b3e0-027ef9abc6e1",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "zelenia-ex",
	version = "1.0.1",
}



return tbl