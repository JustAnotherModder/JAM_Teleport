local JTP = JAM.Teleport

function JTP:Update()
	if not self or not JUtils then return; end
	while not ESX or not self.ESX do Citizen.Wait(100); self.ESX = ESX; end
	while not ESX.IsPlayerLoaded() do Citizen.Wait(100); end
	
	self.timer = GetGameTimer()

	while true do
		Citizen.Wait(0)
		local tpPressed = IsControlJustPressed(1, JUtils.Keys[self.EnableKey]) or IsDisabledControlJustPressed(1, JUtils.Keys[self.EnableKey])
		if tpPressed and (GetGameTimer() - self.timer) > 150 then

			self.timer = GetGameTimer()

			local canContinue = false
			ESX.TriggerServerCallback('JAM:GetAceGroup', function(group) if group ~= "admin" and group ~= "superadmin" then canContinue = 1; else canContinue = 2; end; end)
			while not canContinue do Citizen.Wait(0); end
			
			if canContinue == 2 then 
				if not IsWaypointActive() then
					ESX.ShowNotification("~r~Set a waypoint first.")
				else
					local firstBlip = GetFirstBlipInfoId(8)
					if firstBlip then 
						local blipPos = GetBlipInfoIdCoord(firstBlip)

						local startHeight = 1000.0
						local rayLength   = 100.0

						local ray = StartShapeTestRay(blipPos.x, blipPos.y, startHeight, blipPos.x, blipPos.y, startHeight - rayLength, 1, plyPed, false)
						local hit,coord,normal,ent = GetShapeTestResult(ray, hit, coord, normal, ent)

						local attempt = 0
						local plyPed = PlayerPedId()
						local plyPos = GetEntityCoords(plyPed)
						if not normal or normal.x == 0.0 then DoScreenFadeOut(300); Citizen.Wait(200); end
						while not normal or normal.x == 0.0 do
							Citizen.Wait(100)

							SetEntityCoords(plyPed, blipPos.x, blipPos.y, startHeight)
							startHeight = startHeight - 50		
							if startHeight <= -100 then startHeight = 1000.0; end	

							ray = StartShapeTestRay(blipPos.x, blipPos.y, startHeight, blipPos.x, blipPos.y, startHeight - rayLength, 1, plyPed, false)
							hit,coord,normal,ent = GetShapeTestResult(ray, hit, coord, normal, ent)

							attempt = attempt + 1
							if attempt >= 1000 then 
								normal = plyPos 
								ESX.ShowNotification("~r~Can't teleport to this waypoint.")
							end
						end

						if normal.x == 0.0 and normal.y == 0.0 and normal.z == 0.0 then 
							ESX.ShowNotification("~r~Can't teleport to this waypoint.")
						else
							local plyPed = PlayerPedId()
							SetEntityCoords(plyPed, normal)
							DoScreenFadeIn(300);
						end
					end				
				end
			end			
		end
	end
end

Citizen.CreateThread(function(...) JTP:Update(...); end)