
-- This is just a simple test of the behavior tree's functions... not even sure if that whole thing works the way it should in the end :)
	
	-- Never add a predicate or child function like this "mc_global.FALSE()" , always "mc_global.FALSE", or you will call the function instead of passing its name  !!
	mc_global.ai_grind = mc_core.TreeWalker:new("MainBot",nil,    
					
				-- Randomly picks a child()
				mc_core.RandomSelector:new(	
					
					--random choice 1
					mc_core.Sequence:new( 
					
						-- RepeatUntil:: repeat child() until predicate() true or targettime passed,
						mc_core.RepeatUntil:new( mc_global.FALSE, mc_global.Something, 4 )							
							
										
					),
					
					-- random choice 2
					mc_core.PrioritySelector:new(
					
							-- we have a target
							mc_core.Decorator:new( function() return Player:GetTarget() ~= nil end, mc_global.Attack ),							
														
							-- we wait 3 seconds
							mc_core.Wait:new( mc_global.FALSE , mc_global.TRUE , 3),
							
							-- try to get a new target					
							mc_core.Decorator:new( function() return Player:GetTarget() == nil end, mc_global.PickNewTarget )
							-- move on to the next marker/spot
							
						)
				)
	)




