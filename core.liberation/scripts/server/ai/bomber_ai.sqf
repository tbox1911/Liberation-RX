params ["_unit", ["_side", west]];

if (typeof _unit == pilot_classname) exitWith {};
if (_unit getVariable ["mission_AI", false]) exitWith {};

sleep 3;
if (!alive _unit) exitWith {};

private	_explosiveClass = selectRandom ["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];	
private _cloth = selectRandom ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite"];
private _explosive = objNull;
private _targets = [];
private _target = objNull;

_unit removeAllMPEventHandlers "MPKilled";
_unit removeAllEventHandlers "HandleDamage";

_grp = createGroup [GRLIB_side_civilian, true];
[_unit] joinSilent _grp;

// Init bomber
removeAllWeapons _unit;
removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
removeGoggles _unit;
{ _unit unlinkItem _x } forEach (assignedItems _unit);

_unit forceAddUniform _cloth;
_unit addVest "V_Chestrig_khk";

_unit setHitPointDamage ["hitLegs", 0];
{_unit disableAI _x} count ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
_unit setUnitPos "UP";
_unit setSpeedMode "FULL";
_unit allowFleeing 0;
sleep 1;

while {alive _unit} do {

	_targets = [getpos _unit , 100] call F_getNearbyPlayers;
	if (count _targets > 0) then {
		_target = _targets select 0;
		if (_unit distance2D _target < 15) then {
			_explosive = createMine [_explosiveClass, (getPos _unit), [], 0];
			_explosive attachTo [_unit, [0, 0.15, 0.15], "Pelvis"];
			_explosive setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];

			sleep 1;
			{
				if ((_unit distance2D _x) <= 100) then { ["bombershout"] remoteExec ["playSound", owner _x] };
			} forEach allPlayers;

			sleep 0.5;
			_explosive setDamage 1;
		} else {
			_unit doMove (getPos _target);
		};
		sleep 4;
	};
	sleep 1;
};

if (!isNull _explosive)	 then { deleteVehicle _explosive };
