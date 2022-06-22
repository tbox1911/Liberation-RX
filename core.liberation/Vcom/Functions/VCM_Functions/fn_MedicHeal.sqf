
/*
	Author: Genesis

	Description:
		Makes medic move to a soldier and heal him.

	Parameter(s):
		0: OBJECT - Medic
		1: OBJECT - Injured unit

	Returns:
		NOTHING
*/

params ["_medic","_unit"];

if (_medic isEqualType [] || {!(alive _medic)} || {!(alive _unit)} || {_unit distance2D _medic > 75}) exitWith {};

if (VCM_DEBUG) then {systemChat format ["%1 attempting to heal %2", _medic, _unit];};

_medic setVariable ["VCM_MBUSY", true];

while {alive _medic && {alive _unit} && {_unit distance2D _medic > 3}} do 
{
	_medic doMove getPos _unit;
	sleep 3;
};

if (!(alive _medic) || {!(alive _unit)} || {_unit distance2D _medic > 75}) exitWith {};

doStop _unit;
doStop _medic;

_medic action ["HealSoldier",_unit];
sleep 4;
_unit setdamage 0;

_medic setVariable ["VCM_MBUSY", false]; // No longer busy