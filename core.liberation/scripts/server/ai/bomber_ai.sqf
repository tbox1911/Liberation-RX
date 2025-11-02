params ["_unit", ["_range", 150]];

if (isNull _unit) exitWith {};
if !(isNull objectParent _unit) exitWith {};
if (_unit getVariable ["GRLIB_is_prisoner", false]) exitWith {};
if (surfaceIsWater (getPosATL _unit)) exitWith {};

sleep 30;
if (!alive _unit) exitWith {};

// Check locality
if (!local _unit) exitWith { [_unit, _range] remoteExec ["bomber_remote_call", 2] };

// Init bomber
removeAllWeapons _unit;
removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
removeGoggles _unit;
{ _unit unlinkItem _x } forEach (assignedItems _unit);

private _cloth = getText(configfile >> "CfgVehicles" >> selectRandom civilians >> "uniformClass");
_unit forceAddUniform _cloth;
[_unit] call F_fixPosUnit;
sleep 3;

{_unit disableAI _x} count ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
_unit setUnitPos "UP";
sleep 1;

private _grp = createGroup [GRLIB_side_civilian, true];
[_unit] joinSilent _grp;
[_grp] call F_deleteWaypoints;
_unit setVariable ["GRLIB_is_kamikaze", true, true];
_grp setCombatMode "BLUE";
_grp setBehaviourStrong "SAFE";

private ["_targets", "_target", "_expl1","_expl2","_expl3"];
while {alive _unit} do {
	_targets = [getPos _unit, _range] call F_getNearbyPlayers;
	if (count _targets > 0) then {
		[_grp] call F_deleteWaypoints;
		_target = _targets select 0;
		_unit doMove (getPos _target);
		_unit setSpeedMode "FULL";
		if (speed vehicle _unit == 0) then {
			_unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";
		};

		if (_unit distance2D _target < 15) then {
			_expl1 = "DemoCharge_Remote_Ammo" createVehicle (getPosATL _unit);
			_expl1 attachTo [_unit, [-0.1, 0.1, 0.15], "Pelvis"];
			_expl1 setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
			_expl2 = "DemoCharge_Remote_Ammo" createVehicle (getPosATL _unit);
			_expl2 attachTo [_unit, [0, 0.15, 0.15], "Pelvis"];
			_expl2 setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];
			_expl3 = "DemoCharge_Remote_Ammo" createVehicle (getPosATL _unit);
			_expl3 attachTo [_unit, [0.1, 0.1, 0.15], "Pelvis"];
			_expl3 setVectorDirAndUp [[0.5, -0.5, 0], [0.5, 0.5, 0]];
			sleep 1.5;
			playSound3D [getMissionPath "res\shout.ogg", _unit, false, getPosASL _unit, 5, 1, 500];
			sleep 0.5;
			private _civils = [];
			if (alive _unit) then {
				{
					if (_x distance2D _unit < 15 && !(_x getVariable ["GRLIB_is_kamikaze", false])) then {
						_civils pushBack _x;
						_x setVariable ["GRLIB_last_killer", _target, true];
					};
				} forEach (units GRLIB_side_civilian);
				{
					detach _x;
					_x setDamage 1;
					sleep 0.1;
				} forEach [_expl1,_expl2,_expl3];
				deleteVehicle _unit;
			};
			sleep 1;
			{ deleteVehicle _x } forEach [_expl1,_expl2,_expl3];
			{ _x setVariable ["GRLIB_last_killer", nil, true] } forEach _civils;
		};
	} else {
		if (count waypoints _grp == 0 && _range > 20) then {
			_unit setSpeedMode "NORMAL";
			[_grp, getPos _unit, _range] call BIS_fnc_taskPatrol;
			sleep 2;
		};
	};
	sleep 2;
};
