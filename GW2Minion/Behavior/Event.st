local tbl = 
{
	class = "SubTree",
	nodes = 
	{
		
		{
			class = "Sequence",
			nodes = 
			{
				
				{
					class = "Action",
					nodes = 
					{
					},
					settings = 
					{
					},
					variables = 
					{
						finishcode = "",
						info = "Find marker",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
						runcode = "context.event_marker = nil\nif(context.event_id) then\n\t\tlocal EList = MapMarkerList(\"nearest,onmesh,eventID=\"..context.event_id)\n\t\tif(table.valid(EList)) then\n\t\t\t\tlocal _,event = next(EList)\n\t\t\t\tif(table.valid(event) and not gw2_blacklistmanager.CheckBlacklistEntry(GetString(\"Event\"),event.eventid)) then\n\t\t\t\t\t\tcontext.event_marker = event\n\t\t\t\t\t\tcontext.event_name = event.name\n\t\t\t\t\t\tcontext.event_position = event.pos\n\t\t\t\t\t\tif(context.event_lastevent and context.event_lastevent.id == event.eventid) then\n\t\t\t\t\t\t\t\tcontext.event_start = context.event_lastevent.start\n\t\t\t\t\t\telse\n\t\t\t\t\t\t\t\tcontext.event_lastevent = {}\n\t\t\t\t\t\t\t\tcontext.event_lastevent.id = event.eventid\n\t\t\t\t\t\t\t\tcontext.event_lastevent.start = ml_global_information.Now\n\t\t\t\t\t\t\t\tcontext.event_start = ml_global_information.Now\n\t\t\t\t\t\tend\n\t\t\t\t\t\t\n\t\t\t\t\t\tself:success()\n\t\t\t\t\t\treturn\n\t\t\t\tend\n\t\tend\n\n\t\tgw2_blacklistmanager.AddBlacklistEntry(GetString(\"Event\"), context.event_id, \"Event\", ml_global_information.Now + 1600000)\n\t\tcontext.event_id = nil\nend\nself:fail()\n",
						startcode = "",
					},
				},
				
				{
					class = "Action",
					nodes = 
					{
					},
					settings = 
					{
					},
					variables = 
					{
						finishcode = "",
						info = "Check event details",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
						runcode = "if(context.event_marker) then\n\t\tif(not table.valid(context.event_marker.eventinfo)) then\n\t\t\t\td(\"[Event]: No valid event info.\")\n\t\t\t\tgw2_blacklistmanager.AddBlacklistEntry(GetString(\"Event\"), context.event_id, \"Unknown event 1\", ml_global_information.Now + 1600000)\n\t\t\t\tcontext.event_marker = nil\n\t\tend\n\n\t\tif(context.event_marker and not table.valid(context.event_marker.eventobjectivelist)) then\n\t\t\t\td(\"[Event]: No valid event objectives.\")\n\t\t\t\tgw2_blacklistmanager.AddBlacklistEntry(GetString(\"Event\"), context.event_id, \"Unknown event 2\", ml_global_information.Now + 1600000)\n\t\t\t\tcontext.event_marker = nil\n\t\tend\nelse\n\t\td(\"[Event]: No event marker set.\")\nend\n\nif(context.event_marker) then\n\t\tself:success()\nelse\n\t\tself:fail()\nend",
						startcode = "",
					},
				},
				
				{
					class = "Action",
					nodes = 
					{
					},
					settings = 
					{
					},
					variables = 
					{
						finishcode = "",
						info = "Set up the event objective",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
						runcode = "context.event_radius = nil\nif(table.valid(context.event_marker)) then\n\t\tlocal objectivelist = context.event_marker.eventobjectivelist\n\t\tif(table.valid(objectivelist)) then\n\t\t\t\tlocal _,objective = next(objectivelist)\n\t\t\t\tif(table.valid(objective)) then\n\t\t\t\t\t\tlocal type = objective.type\n\n\t\t\t\t\t\tif(type == GW2.OBJECTIVETYPE.BreakMoral) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.CaptureLocation) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.CollectItems) then\n\t\t\t\t\t\t\t\td(\"[Event]: The bot does not support collect events. Blacklisting it.\")\n\t\t\t\t\t\t\t\tgw2_blacklistmanager.AddBlacklistEntry(GetString(\"Event\"), context.event_marker.eventID, \"CollectItems\", ml_global_information.Now + 3600000)\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.Counter) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.KillCount) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.Cull) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.Defend) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.DefendGadget) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.Escort) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.EventStatus) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 3000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.InteractWithGadget) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.Intimidate) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.IntimidateScaled) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.RepairGadget) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.Timer) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.Tripwire) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.WvwHold) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.WvwOrbResetTimer) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telseif(type == GW2.OBJECTIVETYPE.WvwUpgrade) then\n\t\t\t\t\t\t\t\tcontext.event_radius = 2000\n\t\t\t\t\t\telse\n\t\t\t\t\t\t\t\td(\"[Event]: Unknown event objective. Blacklisting it.\")\n\t\t\t\t\t\t\t\tgw2_blacklistmanager.AddBlacklistEntry(GetString(\"Event\"), context.event_marker.eventID, \"Unknown event 3\", ml_global_information.Now + 1600000)\n\t\t\t\t\t\tend\n\t\t\t\tend\n\t\tend\nend\n\nif(context.event_radius) then\n\t\tself:success()\nelse\n\t\tcontext.event_marker = nil\n\t\tself:fail()\nend",
						startcode = "",
					},
				},
				
				{
					class = "PrioritySelector",
					nodes = 
					{
						
						{
							class = "Sequence",
							nodes = 
							{
								
								{
									class = "Action",
									nodes = 
									{
									},
									settings = 
									{
									},
									variables = 
									{
										finishcode = "",
										info = "",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
										runcode = "if(context.event_id and table.valid(context.event_position) and not context.event_reached) then\n\t\tlocal dist = math.distance3d(ml_global_information.Player_Position,context.event_position)\n\t\tif(dist > 500) then\n\t\t\t\tcontext.moveto_position = context.event_position\n\t\t\t\tself:success()\n\t\t\t\treturn\n\t\tend\n\t\tcontext.event_reached = true\nend\nself:fail()",
										startcode = "",
									},
								},
								
								{
									class = "SubTree",
									nodes = 
									{
									},
									settings = 
									{
										randomMovement = true,
										randomizestoppingdistance = true,
										smoothturns = true,
										stoppingdistance = 300,
										stoppingidstancemaxrange = 450,
										usewaypoints = false,
									},
									variables = 
									{
										filename = "MoveTo.st",
									},
								},
							},
							settings = 
							{
							},
							variables = 
							{
								info = "",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
							},
						},
						
						{
							class = "Action",
							nodes = 
							{
							},
							settings = 
							{
							},
							variables = 
							{
								finishcode = "",
								info = "Check marker status",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
								runcode = "if(context.event_id) then\n\t\tlocal EList = MapMarkerList(\"nearest,eventID=\"..context.event_id)\n\t\tif(table.valid(EList)) then\n\t\t\t\tlocal _,event = next(EList)\n\t\t\t\tif(table.valid(event) and not gw2_blacklistmanager.CheckBlacklistEntry(GetString(\"Event\"),event.eventid)) then\n\t\t\t\t\t\tcontext.event_marker = event\n\t\t\t\t\t\tcontext.event_name = event.name\n\t\t\t\t\t\tif(event.onmesh) then\n\t\t\t\t\t\t\t\tcontext.event_position = event.pos\t\t\t\t\t\t\n\t\t\t\t\t\t\t\tcontext.event_lasttimeonmesh = ml_global_information.Now\n\t\t\t\t\t\telse\n\t\t\t\t\t\t\t\tif(context.event_lasttimeonmesh == nil) then\n\t\t\t\t\t\t\t\t\t\t\tcontext.event_lasttimeonmesh = ml_global_information.Now\n\t\t\t\t\t\t\t\tend\n\n\t\t\t\t\t\t\t\tif(TimeSince(context.event_lasttimeonmesh) > 65000) then\n\t\t\t\t\t\t\t\t\t\td(\"[Event]: Event not on mesh for 65 seconds.\")\n\t\t\t\t\t\t\t\t\t\tcontext.event_marker = nil\n\t\t\t\t\t\t\t\tend\n\t\t\t\t\t\tend\n\n\t\t\t\t\t\tif(TimeSince(context.event_start) > context.event_maxduration*1000) then\n\t\t\t\t\t\t\t\t\t\td(\"[Event]: Event expired. Max duration: \".. tostring(context.event_maxduration) .. \" seconds\")\n\t\t\t\t\t\t\t\t\t\tgw2_blacklistmanager.AddBlacklistEntry(GetString(\"Event\"), context.event_id, \"Event timed out\", ml_global_information.Now + 6000000)\n\t\t\t\t\t\t\t\t\t\tcontext.event_marker = nil\t\t\t\t\t\t\t\t\n\t\t\t\t\t\tend\n\n\t\t\t\t\t\tif(context.event_marker) then\n\t\t\t\t\t\t\t\tself:fail()\n\t\t\t\t\t\t\t\treturn\n\t\t\t\t\t\tend\n\n\t\t\t\tend\n\t\tend\n\t\td(\"[Event]: Event gone, not on mesh or ended.\")\n\t\tPlayer:StopMovement()\n\t\tif(not gw2_blacklistmanager.CheckBlacklistEntry(GetString(\"Event\"),context.event_id)) then\n\t\t\t\tgw2_blacklistmanager.AddBlacklistEntry(GetString(\"Event\"), context.event_id, \"Event cooldown\", ml_global_information.Now + 300000)\n\t\tend\n\t\tcontext.event_marker = nil\n\t\tcontext.event_combat_target = nil\n\t\tcontext.event_stoppingdistance = nil\n\t\tcontext.event_reached = false\n\t\tcontext.event_id = nil\n\n\t\t-- Force this node to take priority without ending until the next pulse\n\t\tself:success()\n\t\treturn\nend\nself:fail()",
								startcode = "",
							},
						},
						
						{
							class = "PrioritySelector",
							nodes = 
							{
								
								{
									class = "Action",
									nodes = 
									{
									},
									settings = 
									{
									},
									variables = 
									{
										finishcode = "",
										info = "",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
										runcode = "if(context.event_marker) then\n\t\tlocal target = gw2_common_functions.GetBestEventTarget(context.event_marker,context.event_objective,context.event_radius)\n\t\t\n\t\tif(table.valid(target)) then\n\t\t\t\tif(context.event_combat_target and context.event_combat_target.id ~= target.id) then\n\t\t\t\t\t-- Swap target\n\t\t\t\t\t\tcontext.event_combat_target = nil\n\t\t\t\t\t\tself:running()\n\t\t\t\t\t\treturn\n\t\t\t\tend\n\n\t\t\t\tcontext.event_combat_target = {id = target.id, pos = target.pos }\n\t\t\t\tcontext.combat_moveintocombatrange = true\n\t\t\t\tself:fail()\n\t\t\t\treturn\n\t\tend\nend\ncontext.event_combat_target = nil\nself:fail()",
										startcode = "",
									},
								},
								
								{
									class = "Sequence",
									nodes = 
									{
										
										{
											class = "Action",
											nodes = 
											{
											},
											settings = 
											{
											},
											variables = 
											{
												finishcode = "",
												info = "",
												monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
												runcode = "if(context.event_combat_target) then\n\t\tcontext.combat_targetid = context.event_combat_target.id\n\t\tcontext.combat_targetpos = context.event_combat_target.pos\n\t\tself:success()\nelse\n\t\tself:fail()\nend",
												startcode = "",
											},
										},
										
										{
											class = "SubTree",
											nodes = 
											{
											},
											settings = 
											{
											},
											variables = 
											{
												filename = "CombatHandler.st",
											},
										},
									},
									settings = 
									{
									},
									variables = 
									{
										info = "",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
									},
								},
							},
							settings = 
							{
							},
							variables = 
							{
								info = "Fight event mobs",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.runningTask or 'None'))",
							},
						},
						
						{
							class = "PrioritySelector",
							nodes = 
							{
								
								{
									class = "Action",
									nodes = 
									{
									},
									settings = 
									{
									},
									variables = 
									{
										finishcode = "",
										info = "",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
										runcode = "if(context.event_marker) then\n\t\tif(context.event_revivenpc) then\n\t\t\t\tlocal target = CharacterList:Get(context.event_revivenpc.id)\n\t\t\t\tif(target and not target.alive and target.pathdistance < 99999) then\n\t\t\t\t\t\tcontext.event_revivenpc =  {id = target.id, pos = target.pos}\n\t\t\t\t\t\tself:fail()\n\t\t\t\t\t\treturn\n\t\t\t\tend\n\t\t\t\tcontext.event_revivenpc = nil\n\t\t\t\tself:success()\n\t\t\t\treturn\n\t\telse\n\t\t\t\tlocal CList = CharacterList(\"nearest,npc,dead,friendly,onmesh,maxdistance=3000\")\n\t\t\t\tif(table.valid(CList)) then\n\t\t\t\t\t\tlocal _,target = next(CList)\n\t\t\t\t\t\tif(table.valid(target) and target.pathdistance < 99999) then\n\t\t\t\t\t\t\t\tlocal dist = math.distance3d(target.pos,context.event_marker.pos)\n\t\t\t\t\t\t\t\tif(dist < context.event_radius/2) then\n\t\t\t\t\t\t\t\t\t\tcontext.event_revivenpc =  {id = target.id, pos = target.pos}\n\t\t\t\t\t\t\t\t\t\tself:fail()\n\t\t\t\t\t\t\t\t\t\treturn\n\t\t\t\t\t\t\t\tend\n\t\t\t\t\t\tend\n\t\t\t\tend\n\t\tend\nend\ncontext.event_revivenpc = nil\nself:fail()",
										startcode = "",
									},
								},
								
								{
									class = "Sequence",
									nodes = 
									{
										
										{
											class = "Action",
											nodes = 
											{
											},
											settings = 
											{
											},
											variables = 
											{
												finishcode = "",
												info = "",
												monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
												runcode = "if(context.event_revivenpc) then\n\t\tcontext.revive_position = context.event_revivenpc.pos\n\t\tcontext.revive_targetid = context.event_revivenpc.id\n\t\tself:success()\nelse\n\t\tself:fail()\nend",
												startcode = "",
											},
										},
										
										{
											class = "SubTree",
											nodes = 
											{
											},
											settings = 
											{
											},
											variables = 
											{
												filename = "ReviveActionHandler.st",
											},
										},
									},
									settings = 
									{
									},
									variables = 
									{
										info = "",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
									},
								},
							},
							settings = 
							{
							},
							variables = 
							{
								info = "Revive NPC",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.runningTask or 'None'))",
							},
						},
						
						{
							class = "PrioritySelector",
							nodes = 
							{
								
								{
									class = "Action",
									nodes = 
									{
									},
									settings = 
									{
									},
									variables = 
									{
										finishcode = "",
										info = "",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
										runcode = "context.event_inradius = true\ncontext.event_marker = nil\n\n-- update the event marker, since the \"moveto\" task before can yield in a \"self:running()\" which causes this node to be pulsed in a later tick\nif(context.event_id) then\n\t\tlocal EList = MapMarkerList(\"nearest,onmesh,eventID=\"..context.event_id)\n\t\tif(table.valid(EList)) then\n\t\t\t\tlocal _,event = next(EList)\n\t\t\t\tif(table.valid(event) and not gw2_blacklistmanager.CheckBlacklistEntry(GetString(\"Event\"),event.eventid)) then\n\t\t\t\t\t\tcontext.event_marker = event\n\t\t\t\t\t\tcontext.event_name = event.name\n\t\t\t\t\t\tcontext.event_position = event.pos\n\t\t\t\tend\n\t\tend\nend\n\nif(context.event_marker) then\n\t\tif(context.event_marker.distance > context.event_radius) then\n\t\t\t\tcontext.event_inradius = false\n\t\tend\n\n\t\tcontext.event_waitcheck = context.event_waitcheck or math.random(13,25)\n\t\tif(context.event_waittime == nil or TimeSince(context.event_waittime) > context.event_waitcheck*1000) then\n\t\t\t\tcontext.event_waittime = ml_global_information.Now\n\t\t\t\tcontext.event_waitcheck = nil\n\t\t\t\tcontext.event_inradius = false\n\t\tend\n\n\t\tcontext.event_stoppingdistance = context.event_stoppingdistance or math.random(250,400)\n\n\t\tif(not context.event_inradius and context.event_stoppingdistance < context.event_marker.distance) then\n\t\t\t\tcontext.event_inradius = false\n\t\t\t\tself:fail()\n\t\t\t\treturn\n\t\telse\n\t\t\t\tPlayer:StopMovement()\n\t\t\t\tcontext.event_stoppingdistance = nil\n\t\t\t\tcontext.event_reached = true\n\t\tend\nend\nself:fail()",
										startcode = "",
									},
								},
								
								{
									class = "Sequence",
									nodes = 
									{
										
										{
											class = "Action",
											nodes = 
											{
											},
											settings = 
											{
											},
											variables = 
											{
												finishcode = "",
												info = "",
												monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
												runcode = "if(not context.event_inradius and table.valid(context.event_position)) then\n\t\tcontext.moveto_position = context.event_position\n\t\tself:success()\nelse\n\t\tself:fail()\nend",
												startcode = "",
											},
										},
										
										{
											class = "SubTree",
											nodes = 
											{
											},
											settings = 
											{
												randomMovement = true,
												randomizestoppingdistance = true,
												smoothturns = true,
												stoppingdistance = 250,
												stoppingidstancemaxrange = 350,
												usewaypoints = true,
											},
											variables = 
											{
												filename = "MoveTo.st",
											},
										},
									},
									settings = 
									{
									},
									variables = 
									{
										info = "Ha",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
									},
								},
							},
							settings = 
							{
							},
							variables = 
							{
								info = "Move back to event",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))\nif(context) then\n\t\tif (context.event_waittime) then GUI:Text(\"event_waittime: \"..tostring(context.event_waittime or 0)) end\n\t\tif (context.event_inradius) then GUI:Text(\"event_inradius: \"..tostring(context.event_inradius or 0)) end\n\t\tif (context.event_stoppingdistance) then GUI:Text(\"event_stoppingdistance: \"..tostring(context.event_stoppingdistance or 0)) end\n\t\tif (context.event_reached) then GUI:Text(\"event_reached: \"..tostring(context.event_reached or false)) end\nend",
							},
						},
						
						{
							class = "Action",
							nodes = 
							{
							},
							settings = 
							{
							},
							variables = 
							{
								finishcode = "",
								info = "Wait",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
								runcode = "if(context.event_marker) then\n\t\tself:running()\nelse\n\t\tself:fail()\nend",
								startcode = "",
							},
						},
					},
					settings = 
					{
					},
					variables = 
					{
						info = "",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
					},
				},
			},
			settings = 
			{
			},
			variables = 
			{
				info = "",
				monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
			},
		},
	},
	settings = 
	{
	},
	variables = 
	{
		filename = "Event.st",
		finishcode = "context.event_id = nil\ncontext.event_reached = false\ncontext.event_radius = nil\ncontext.event_maxduration = nil\ncontext.event_type = nil\ncontext.event_marker = nil\ncontext.event_combat_target = nil\ncontext.event_stoppingdistance = nil\ncontext.event_starttime = nil\ncontext.event_revivenpc = nil\ncontext.event_lasttimeonmesh = nil\ncontext.event_start = nil",
		info = "Event\ncontext.event_id\n\nOptional:\ncontext.event_radius\n\nOptional:\ncontext.event_maxduration\ncontext.event_type\ncontext.event_start",
		menucode = "",
		monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Filename: '..self.variables.filename) GUI:Text('Filepath: '..self.filepath)",
		runcode = "context.event_maxduration = context.event_maxduration or self.settings.maxduration\nif(not context.event_maxduration) then\n\t\tcontext.event_maxduration = 900\nend\n\ncontext.event_lastevent = context.event_lastevent or {}",
		startcode = "self.settings.maxduration = self.settings.maxduration or 900\ncontext.event_starttime = ml_global_information.Now",
		subtreeuicode = "self.settings.maxduration = GUI:InputInt(\"Max duration (s)\", self.settings.maxduration or 900)",
	},
}



return tbl