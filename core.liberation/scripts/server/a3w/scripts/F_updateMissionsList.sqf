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
	if (_spawn_place_water >= 1) then {
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

// // Town Insurgency
// _mission_name = "mission_TownInsurgency";
// if (!([_missionsList, _mission_name] call getMissionState)) then {
// 	if (count blufor_sectors >= 10 && (A3W_mission_failed > 8 || A3W_delivery_failed >= 3)) then {
// 		[_missionsList, _mission_name, false] call setMissionState;
// 	} else {
// 		[_missionsList, _mission_name, true] call setMissionState;
// 	};
// };

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
	if (_spawn_place >= 1 && _opfor_factor > 60) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Hostile Helicopter
_mission_name = "mission_HostileHelicopter";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _opfor_city = count ([] call cityList);
	if (_opfor_city <= 1) then {
		[_missionsList, _mission_name, true] call setMissionState;
	} else {
		[_missionsList, _mission_name, false] call setMissionState;
	};
};

// Capture VIP
_mission_name = "mission_CaptureVIP";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _opfor_city = count ([] call cityList);
	private _excluded_map = ["Stratis", "Eusa"];
	if (_opfor_city <= 1 || worldName in _excluded_map) then {
		[_missionsList, _mission_name, true] call setMissionState;
	} else {
		[_missionsList, _mission_name, false] call setMissionState;
	};
};

// Meet Resistance
_mission_name = "mission_MeetResistance";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	if (count blufor_sectors >= 7 && _opfor_factor > 50 && GRLIB_side_enemy != INDEPENDENT) then {
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
