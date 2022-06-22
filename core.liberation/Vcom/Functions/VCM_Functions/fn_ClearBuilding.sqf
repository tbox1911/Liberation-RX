
/*
	Author: Genesis

	Description:
		Orders group to clear building

	Parameter(s):
		0: GROUP - Clearing group
		1: OBJECT - Enemy to clear out

	Returns:
		STRING
*/

params ["_group","_enemy"];

private _nBuildingLst = nearestObjects [_enemy, ["House", "Building"], 25];
if (count _nBuildingLst < 1) exitWith {};

private _buildingPositions = [];

{
	if (count ([_x] call BIS_fnc_buildingPositions) > 3) then {_buildingPositions pushback _x;};
} foreach _nBuildingLst;

if (count _buildingPositions < 1) exitWith {};
private _finalSel = [_buildingPositions,_enemy,true,"Clear0"] call VCM_fnc_ClstObj; 
private _tempA = _finalSel call BIS_fnc_buildingPositions;
private _tempB = _tempA;

//Filter down the closest positions
private _unitPosition = getposATL _enemy;
private _acceptableRange = _unitPosition select 2;
{
	if ((_x select 2) < (_acceptableRange - 1) || (_x select 2) > (_acceptableRange + 1)) then
	{
		_tempA deleteAt _forEachIndex;
	};

} foreach _tempA;

if (_tempA isEqualTo []) then {_tempA = _tempB;};

private _clstP = [_tempA,_enemy,true,"Clear1"] call VCM_fnc_ClstObj;

{
	doStop _x;
	_x doMove _clstP;	
} foreach (units _group);