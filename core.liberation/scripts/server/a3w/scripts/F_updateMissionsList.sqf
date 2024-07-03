// Update the missions list
params ["_missionsList"];
private ["_mission_name"];
if (!isServer) exitWith {};
if (count _missionsList == 0) exitWith {};

private _spawn_place = count ([SpawnMissionMarkers] call checkSpawn);
private _spawn_place_forest = count ([ForestMissionMarkers] call checkSpawn);
private _spawn_place_water = count ([SunkenMissionMarkers] call checkSpawn);
private _opfor_sectors = (count sectors_allSectors) - (count blufor_sectors);
private _opfor_factor = round ((_opfor_sectors / (count sectors_allSectors)) * 100);
private _opfor_chopper = { !(_x isKindOf "Plane") } count (opfor_air);

// Air Wreck
_mission_name = "mission_AirWreck";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (_spawn_place >= 1) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Weapon Cache
_mission_name = "mission_WepCache";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (_spawn_place_forest >= 1) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

//Sunken Supply
_mission_name = "mission_SunkenSupplies";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (_spawn_place_water >= 1 && count opfor_boats >= 1) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Town capture
_mission_name = "mission_TownInvasion";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 10 && (_opfor_factor <= 40 || A3W_mission_failed >= 8)) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Vehicle Capture
_mission_name = "mission_VehicleCapture";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (_spawn_place >= 1 && _opfor_factor > 40) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Helicopter Capture
_mission_name = "mission_HeliCapture";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (_spawn_place >= 1 && _opfor_factor > 60 && _opfor_chopper > 0) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Hostile Helicopter
_mission_name = "mission_HostileHelicopter";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _opfor_city = count ([] call cityList);
	if (_opfor_city < 2 || count opfor_troup_transports_heli == 0) then {
		[_missionsList, _mission_name, true] call setMissionState;
	} else {
		[_missionsList, _mission_name, false] call setMissionState;
	};
};

// Capture VIP
_mission_name = "mission_CaptureVIP";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _opfor_city = count ([] call cityList);
	if (_opfor_city < 3) then {
		[_missionsList, _mission_name, true] call setMissionState;
	} else {
		[_missionsList, _mission_name, false] call setMissionState;
	};
};

// Meet Resistance
_mission_name = "mission_MeetResistance";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 7 && _opfor_factor > 50) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Special Delivery
_mission_name = "mission_SpecialDelivery";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 10) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Water Delivery
_mission_name = "mission_WaterDelivery";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 5 && {_x in sectors_tower} count blufor_sectors >= 3) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Food Delivery
_mission_name = "mission_FoodDelivery";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 5 && {_x in sectors_bigtown} count blufor_sectors >= 1) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Fuel Delivery
_mission_name = "mission_FuelDelivery";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 5 && {_x in sectors_factory} count blufor_sectors >= 2) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Ammo Delivery
_mission_name = "mission_AmmoDelivery";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 5 && {_x in sectors_military} count blufor_sectors >= 2) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Enemy Outpost
_mission_name = "mission_Outpost";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (_spawn_place >= 1 && count blufor_sectors >= 7 && _opfor_factor >= 50) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// RoadBlock
_mission_name = "mission_RoadBlock";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 7 && _opfor_factor >= 30) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Search Intel
_mission_name = "mission_SearchIntel";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (_spawn_place >= 1 && _opfor_factor >= 20) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Kill Officer
_mission_name = "mission_KillOfficer";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _blufor_city = sectors_bigtown select {(_x in blufor_sectors)};
	if (count _blufor_city > 1) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Baron Rouge
_mission_name = "mission_BaronRouge";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _br_plane = "";
	if (count a3w_br_planes == 0) then {
		_br_plane = selectRandom (opfor_air select { _x isKindOf "Plane" });
	};

	if (count sectors_bigtown > 1 && !isNil "_br_plane") then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Heal Civilian
_mission_name = "mission_HealCivilian";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 10) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};