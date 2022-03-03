// Update the missions list
params ["_missionsList"];
if (!isServer) exitWith {};
if (count _missionsList == 0) exitWith {};

// Limit Town capture
_mission_name = "mission_TownInvasion";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _opfor_sectors = (count sectors_allSectors) - (count blufor_sectors);
	private _opfor_factor = round ((_opfor_sectors / (count sectors_allSectors)) * 100);
	if (_opfor_factor <= 40 && count allPlayers > 1) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};

// Disable HostileHelicopter if no more bigcity
_mission_name = "mission_HostileHelicopter";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	_opfor_city = count ([(call cityList)] call checkSpawn);
	if (_opfor_city <= 1) then {
		[_missionsList, _mission_name, true] call setMissionState;
	} else {
		[_missionsList, _mission_name, false] call setMissionState;
	};
};

// MeetRes
_mission_name = "mission_MeetResistance";
if (!([_missionsList, _mission_name] call getMissionState)) then {
	private _opfor_sectors = (count sectors_allSectors) - (count blufor_sectors);
	private _opfor_factor = round ((_opfor_sectors / (count sectors_allSectors)) * 100);
	if (count blufor_sectors >= 7 && _opfor_factor >= 50) then {
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
	if (count blufor_sectors >= 5 && {_x in sectors_factory} count blufor_sectors >= 3) then {
		[_missionsList, _mission_name, false] call setMissionState;
	} else {
		[_missionsList, _mission_name, true] call setMissionState;
	};
};