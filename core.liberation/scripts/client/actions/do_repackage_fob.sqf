private _fob_pos = GRLIB_player_nearest_fob;
private _fob_name = [_fob_pos] call F_getFobName;
private _fob_owner = [_fob_pos] call F_getFobOwner;
if ((PAR_Grp_ID != _fob_owner) && !([] call is_admin)) exitWith { hintSilent localize "STR_HINT_FOB_WRONG_OWNER" };
if (player distance2D _fob_pos > 20) exitWith {};

build_confirmed = 1;
dorepackage = 0;
createDialog "liberation_repackage_fob";
waitUntil { dialog };

ctrlEnable [123, false];
if (surfaceIsWater _fob_pos) then {
	ctrlEnable [121, false];
	ctrlEnable [122, false];
	ctrlEnable [123, true];
};

if (GRLIB_naval_type == 0) then {
	ctrlEnable [123, false];
};

while { dialog && alive player && dorepackage == 0 } do {
	sleep 0.5;
};

if ( dorepackage > 0 ) then {
	closeDialog 0;
	waitUntil { !dialog };

	private _unit_list_redep = (units player - [player]) select { (isNull objectParent _x) && (_x distance2D player < 40) && !(captive _x) };
	if (dorepackage == 3) then {
		private _fob_text = ((["NavalFobType"] call lrx_getParamData) select 1) select (["NavalFobType"] call lrx_getParamValue);
		titleText [format [localize "STR_NAVAL_FOB_LEAVING", _fob_text], "BLACK FADED", 30];
		disableUserInput true;
		{ _x allowDamage false; _x enableSimulationGlobal false } forEach _unit_list_redep;
	};
	[player, "Land_Carrier_01_blast_deflector_down_sound"] remoteExec ["sound_range_remote_call", 2];
	[_fob_pos] remoteExec ["destroy_fob_remote_call", 2];
	private _count_fobs = count GRLIB_all_fobs;
	waitUntil {
		sleep 3;
		[player, "Land_Carrier_01_blast_deflector_down_sound"] remoteExec ["sound_range_remote_call", 2];
		(count GRLIB_all_fobs != _count_fobs)
	};

	private _box_typename = "";
	if (dorepackage == 1) then { _box_typename = FOB_box_typename };
	if (dorepackage == 2) then { _box_typename = FOB_truck_typename };
	if (dorepackage == 3) then { _box_typename = FOB_boat_typename; _fob_pos set [2, 1] };

	private _fob_box = _box_typename createVehicle _fob_pos;
	[_fob_box] call F_clearCargo;
	_fob_box addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_fob_box setVariable ["GRLIB_vehicle_owner", PAR_Grp_ID, true];
	hintSilent format ["%1 %2 "+ localize "STR_FOB_REPACKAGE_HINT", "FOB", _fob_name];

	if (dorepackage == 3) then {
		{ _x enableSimulationGlobal true } forEach _unit_list_redep;
		player moveInDriver _fob_box;
		private _destpos = (getPosASL player);
		{
			_x doFollow player;
			_x setPosASL (_destpos getPos [10, random 360]);
			_x assignAsCargoIndex [_fob_box, (_forEachIndex + 1)];
			_x moveInCargo _fob_box;
			sleep 0.5;
		} forEach _unit_list_redep;

		disableUserInput false;
		disableUserInput true;
		disableUserInput false;
		titleText ["" ,"BLACK IN", 3];
		sleep 1;
		{ _x allowDamage true } forEach _unit_list_redep;
	};
	GRLIB_player_fobdistance = (player distance2D ([] call F_getNearestFob));
};

sleep 2;
build_confirmed = 0;
