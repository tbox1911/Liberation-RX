params [ "_sector_pos", "_radius", "_number" ];

if (_number == 0) exitWith {};
if (_number >= 1) then {
	[ _sector_pos, _radius, _number - 1 ] spawn ied_trap_manager;
};

private ["_nearinfantry"];
private _activation_radius_infantry = 3;
private _infantry_trigger = 1;

private _ied_type = selectRandom GRLIB_ide_traps;
private _ied_power = selectRandom [
	"GrenadeHand",
	"mini_Grenade",
	"M_AT",
	"R_PG7_F",
	"R_PG32V_F",
	"R_MRAAWS_HE_F",
	"GrenadeHand",
	"mini_Grenade"
	//"Rocket_04_HE_F"
];
private _ide_pos = ([_sector_pos, floor(random _radius), random(360)] call BIS_fnc_relPos) findEmptyPosition [0,20,"B_Quadbike_01_F"];
private _goes_boom = false;
private _false_trap = false;

if ( count _ide_pos > 0 ) then {
	private _ied_obj = createVehicle [_ied_type, _ide_pos, [], 3, "None"];
	_ied_obj setVariable ["GRLIB_intel_search", true, true];
	_ied_obj setPos (getPos _ied_obj);

	if ((random 100) <= 50) then { _false_trap = true };

	private _timeout = time + (60 * 60);
	while {alive _ied_obj && time < _timeout && !_goes_boom } do {
		sleep 1;
		if (!_false_trap) then {
			_nearinfantry = [allPlayers, {_x distance2D _ide_pos < _activation_radius_infantry}] call BIS_fnc_conditionalSelect;
			if ( count _nearinfantry >= _infantry_trigger ) then {
				{
					[
						[],
					{
						if (isDedicated) exitWith {};
						for "_i" from 1 to 5 do {
							playSound "beep";
							sleep 0.5;
						};
					}] remoteExec ["bis_fnc_call", owner _x];
				} foreach _nearinfantry;
				sleep 3;
				_ied_power createVehicle (getPosATL _ied_obj);
				stats_ieds_detonated = stats_ieds_detonated + 1; publicVariable "stats_ieds_detonated";
				_goes_boom = true;
			};
		};
	};
	deleteVehicle _ied_obj;
};
