params ["_vehicle"];
if (isNull _vehicle) exitWith {};
private _blacklist_class = [
	"Air",
	"Boat_F",
	"Bicycle",
	"Motorcycle"
];
if (([_vehicle, _blacklist_class] call F_itemIsInClass)) exitWith {};
if ((tolower typeOf _vehicle) find "bicycle" > -1) exitWith {};

if (count (crew _vehicle) == 0) exitWith {};

#define _incd_repair 20     // must match speak_manger.sqf (_msg)
#define _incd_fuel 22

private _driver = driver _vehicle;
private _grp = group _driver;
private _delay = (150 + floor random 200);
private _trigger = (time + _delay);
private _event_stared = false;
private _wait_max = 0;
private _incd = 0;
private _marker = "";
private _helped = false;

sleep (60 + floor random 60);

while { alive _vehicle && !(isNull _driver)} do {
	// Correct static position
	if ((vectorUp _vehicle) select 2 < 0.70) then {
		_vehicle setPos [(getposATL _vehicle) select 0, (getposATL _vehicle) select 1, 0.5];
		_vehicle setVectorUp (surfaceNormal getPos _vehicle);
	};

	// Shit happens...
	if (!_event_stared && time > _trigger) then {
		_incd = selectRandom [0,0,_incd_repair,_incd_repair,_incd_fuel];

		// lucky ?
		if (_incd == 0 || surfaceIsWater (getposATL _vehicle)) exitWith { _trigger = (time + _delay) };

		_event_stared = true;
		diag_log format ["Civilian vehicle %1 incident %2 at %3", typeOf _vehicle, _incd , time];
		_vehicle setVariable ["GRLIB_civ_incd", _incd, true];
		doStop _driver;
		sleep 3;

		_vehicle engineOn false;
		_marker = createMarkerLocal [format ["civ_ai_veh_%1", (_vehicle call BIS_fnc_netId)], getPosATL _vehicle];
		_marker setMarkerTypeLocal "loc_car";
		_marker setMarkerTextLocal "Civilian need help.";
		_marker setMarkerColor "ColorCIV";

		switch (_incd) do {
			// breakdown
			case _incd_repair: {
				_hit_index = selectRandom ["HitLFWheel", "HitLBWheel", "HitRFWheel", "HitRBWheel", "HitHull" ];  // "HitBody"
				_vehicle setHitPointDamage [_hit_index, 1];
				_vehicle setHitPointDamage ["HitEngine", 1];
				_vehicle allowDamage false;
			};

			// refuel
			case _incd_fuel: {
				_vehicle setFuel 0;
			};

			default {};
		};
		_wait_max = time + (20*60);
	};

	// Rescued
	if (_event_stared) then {
		_helped = false;
		if (_incd == _incd_repair && _vehicle getHitPointDamage "HitEngine" < 1) then { _helped = true };
		if (_incd == _incd_fuel && fuel _vehicle >= 0.5) then { _helped = true };
		if (time > _wait_max) then { _helped = true };

		if (_helped) then {
			if (time <= _wait_max) then {
				private _winner = ([_vehicle, 30] call F_getNearbyPlayers) select 0;
				if (!isNil "_winner") then {
					private _bonus = 7 + (floor random 10);
					if (isServer) then {
						[_driver, (_incd+1), _winner] spawn speak_manager_remote_call;
						[_winner, _bonus] call F_addScore;
						[_winner, 5] call F_addReput;
						sleep 5;
					} else {
						[_driver, (_incd+1), _winner] remoteExec ["speak_manager_remote_call", 2];
						[_winner, _bonus] remoteExec ["F_addScore", 2];
						[_winner, 5] remoteExec ["F_addReput", 2];
					};
				};
			};
			_vehicle setVariable ["GRLIB_civ_incd", 0, true];
			_vehicle setDamage 0;
			_vehicle allowDamage true;
			_vehicle setFuel 1;
			_vehicle engineOn true;
			_driver moveInDriver _vehicle;
			_driver assignAsDriver _vehicle;
			{_x doFollow (leader _grp)} foreach units _grp;
			_event_stared = false;
			deleteMarker _marker;
			_trigger = (time + _delay);
		};
	};

	sleep 5;
};

deleteMarker _marker;
