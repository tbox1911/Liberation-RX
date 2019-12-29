// Update the missions list

if (!isServer) exitWith {};
params ["_mission", "_delete", "_missionsList", "_weight"];

private _res = (_missionsList select 0) find _mission;

if (_delete) then {
	if (_res >= 0) then {
	_missionsList select 0 deleteAt _res;
	_missionsList select 1 deleteAt _res;
	};
} else {
	if (_res == -1) then {
		_missionsList append [[_mission, _weight]];
	};
};
_missionsList;