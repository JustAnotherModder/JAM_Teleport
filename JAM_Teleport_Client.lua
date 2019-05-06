local JTP = JAM.Teleport

function JTP:Update()
	if not self or not JUtils or not ESX then return; end
	while not ESX.IsPlayerLoaded() do Citizen.Wait(100); end
	
	ESX.TriggerServerCallback('JTP:GetAceGroup', function(group) if group ~= "admin" and group ~= "superadmin" then return; end; end)

	self.timer = GetGameTimer()

	while true do
		Citizen.Wait(0)
		local tpPressed = IsControlJustPressed(0, JUtils.Keys["PAGEDOWN"]) or IsDisabledControlJustPressed(0, JUtils.Keys["PAGEDOWN"])
		if tpPressed and (GetGameTimer() - self.timer) > 150 then
			self.timer = GetGameTimer()
			if not IsWaypointActive() then
				ESX.ShowNotification("~r~Set a waypoint first.")
				return
			else
				local plyPed = GetPlayerPed()
				local firstBlip = GetFirstBlipInfoId(8)
				if not firstBlip then return; end
				local blipPos = GetBlipInfoIdCoord(firstBlip)

				local startHeight = 1000.0
				local rayLength   = 200.0

				local ray = StartShapeTestRay(blipPos.x, blipPos.y, startHeight, blipPos.x, blipPos.y, startHeight - rayLength, 1, plyPed, false)
				local hit,coord,normal,ent = GetShapeTestResult(ray, hit, coord, normal, ent)

				if not coord or coord == 0 then DoScreenFadeOut(300); Citizen.Wait(200); end

				while not coord or coord == 0 do
					Citizen.Wait(100)
					SetEntityCoords(plyPed, blipPos.x, blipPos.y, startHeight)
					startHeight = startHeight - 100		
					if startHeight <= -200 then startHeight = 1000.0; end		
					ray = StartShapeTestRay(blipPos.x, blipPos.y, startHeight, blipPos.x, blipPos.y, startHeight - rayLength, 1, plyPed, false)
					hit,coord,normal,ent = GetShapeTestResult(ray, hit, coord, normal, ent)
				end

				if normal.x == 0.0 and normal.y == 0.0 and normal.z == 0.0 then 
					ESX.ShowNotification("~r~Can't teleport to this waypoint.")
				else
					SetEntityCoords(plyPed, normal)
					DoScreenFadeIn(300);
				end
			end
		end
	end
end

Citizen.CreateThread(function(...) JTP:Update(...); end)