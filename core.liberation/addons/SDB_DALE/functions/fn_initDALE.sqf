scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

addMissionEventHandler [
	"PlayerViewChanged",
	{
		params ["_unitOld","_unitNew","_veh","_camOld","_camNew","_uav"];
		
		if (_camNew == _camOld) exitWith {};
		
		if ((_camNew == _uav) or {(_camOld == _unitNew) and {_camNew == _veh}}) then {
			[_camNew] call DALE_fnc_actLoadout;
		};
	}
];

player addEventHandler [
	"GetInMan",
	{
		params ["_unitNew","_role","_camNew","_path"];
		
		[_camNew] call DALE_fnc_actLoadout;
	}
];