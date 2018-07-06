-- Soul Filcher's Vehicle Tweaker Core: an API for tweaking existing vehicles without redefining them entirely.
-- Modified from DarkSlayerEX's Item Tweaker
--Initializes the tables needed for the code to run
if not VehicleTweaker then  VehicleTweaker = {} end
if not TweakVehicle then  TweakVehicle = {} end
if not TweakVehicleData then  TweakVehicleData = {} end

--Prep code to make the changes to all vehicles in the TweakVehicleData table.
function VehicleTweaker.tweakVehicles()
	local vehicle;
	for k,v in pairs(TweakVehicleData) do 
		for t,y in pairs(v) do 
			vehicle = ScriptManager.instance:getVehicle(k);		
			if vehicle ~= nil then
				local module, name = k:match"([^.]*).(.*)"
				if t == "skin" then
					vehicle:Load(name, "{"..t.."{ texture ="..y..",}".."}");
				elseif t == "lightbar" then
					vehicle:Load(name, "{"..t.."{ soundSiren="..y..",}".."}");
				elseif t == "model" then
					vehicle:Load(name, "{"..t.."{ file="..y..",}".."}");
				elseif t == "part" then
					vehicle:Load(name, "{"..t.. y.."}");
				else
					vehicle:Load(name, "{"..t.."="..y..",".."}");
				end
				print(k..": "..t..", "..y);
			end
		end
	end
end

function TweakVehicle(vehicleName, vehicleProperty, propertyValue)
	if not TweakVehicleData[vehicleName] then
		TweakVehicleData[vehicleName] = {};
	end
	TweakVehicleData[vehicleName][vehicleProperty] = propertyValue;
end

Events.OnGameBoot.Add(VehicleTweaker.tweakVehicles)


--[[
-------------------------------------------------
--------------------IMPORTANT--------------------
-------------------------------------------------

You can make compatibility patches, allowing tweaks to only be applied under the proper circumstances.
Example:


		TweakVehicleData["MyMod.MyVehicle"] = { ["mechanicType"] = "3" };
		
		if getActivatedMods():contains("PaintItBlack") then 
			TweakVehicleData["MyMod.MyVehicle"] = { ["forcedColor"] = "0.0 0.0 0.0" };
		end
		

]]
