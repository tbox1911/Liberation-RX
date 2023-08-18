params ["_unit", ["_side", west]];

if (typeof _unit == pilot_classname) exitWith {};
if (_unit getVariable ["GRLIB_mission_AI", false]) exitWith {};
if (_unit getVariable ["GRLIB_is_prisonner", false]) exitWith {};

sleep 3;
if (!alive _unit) exitWith {};

private _cloth = getText(configfile >> "CfgVehicles" >> selectRandom civilians >> "uniformClass");
private _targets = [];
private _target = objNull;

_grp = createGroup [GRLIB_side_civilian, true];
[_unit] joinSilent _grp;
_unit setVariable ["GRLIB_is_kamikaze", true, true];

// Init bomber
removeAllWeapons _unit;
removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
removeGoggles _unit;
{ _unit unlinkItem _x } forEach (assignedItems _unit);

_unit forceAddUniform _cloth;
_unit setHitPointDamage ["hitLegs", 0];
{_unit disableAI _x} count ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
_unit setUnitPos "UP";
_unit setSpeedMode "FULL";
_unit allowFleeing 0;
sleep 1;

private ["_expl1","_expl2","_expl3"];
while {alive _unit} do {
	_targets = [getpos _unit , 100] call F_getNearbyPlayers;
	if (count _targets > 0) then {
		_target = _targets select 0;
		_unit doMove (getPos _target);
		if (round (speed vehicle _unit) == 0) then { 
			_unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";
		};

		if (_unit distance2D _target < 20) then {
			_expl1 = "DemoCharge_Remote_Ammo" createVehicle (getPosATL _unit);
			_expl1 attachTo [_unit, [-0.1, 0.1, 0.15], "Pelvis"];
			_expl1 setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
			_expl2 = "DemoCharge_Remote_Ammo" createVehicle (getPosATL _unit);
			_expl2 attachTo [_unit, [0, 0.15, 0.15], "Pelvis"];
			_expl2 setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];
			_expl3 = "DemoCharge_Remote_Ammo" createVehicle (getPosATL _unit);
			_expl3 attachTo [_unit, [0.1, 0.1, 0.15], "Pelvis"];
			_expl3 setVectorDirAndUp [[0.5, -0.5, 0], [0.5, 0.5, 0]];

			sleep 2.5;
			playSound3D [getMissionPath "res\shout.ogg", _unit, false, getPosASL _unit, 5, 1, 500];
			sleep 0.5;
			{ deleteVehicle _x } forEach [_expl1,_expl2,_expl3];
			if (alive _unit) then {
				"Rocket_04_HE_F" createVehicle (getPosATL _unit);
				deleteVehicle _unit;
			};
		};
	} else {
		doStop _unit;
	};
	sleep 2;
};
