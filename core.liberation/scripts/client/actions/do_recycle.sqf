params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private [ "_objectinfo", "_cfg", "_dialog" ];
private _ammobox = [ammobox_b_typename, ammobox_o_typename];

_objectinfo = ( [ (light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + buildings + opfor_recyclable + ind_recyclable), { typeof _vehicle == _x select 0 } ] call BIS_fnc_conditionalSelect ) select 0;
if (isNil "_objectinfo") then {
	_objectinfo = [typeOf _vehicle, 0, 0, 0];
};
dorecycle = 0;

_cfg = configFile >> "cfgVehicles";
_dialog = createDialog "liberation_recycle";
waitUntil { dialog };

private _ammount_ammo = round ((_objectinfo select 2) * GRLIB_recycling_percentage);
ctrlSetText [ 134, format [ localize "STR_RECYCLING_YIELD", getText (_cfg >> (_objectinfo select 0) >> "displayName" ) ] ];
ctrlSetText [ 131, format [ "%1", round (_objectinfo select 1) ] ];
ctrlSetText [ 132, format [ "%1", _ammount_ammo] ];
ctrlSetText [ 133, format [ "%1", round ( _objectinfo select 3) ] ];

while { dialog && (alive player) && dorecycle == 0 } do {
	sleep 0.5;
};

if ( dialog ) then { closeDialog 0 };

if ( dorecycle == 1 && !(isnull _vehicle) && alive _vehicle) then {
	[_vehicle] remoteExec ["deleteVehicle", 2];
	if (typeOf _vehicle in _ammobox && score player <= GRLIB_perm_log) then {
		[player, 10] remoteExec ["addScore", 2];
		hint format ["%1\nBonus Score + 10 Pts!", name player];
		playSound "taskSucceeded";
	};
	private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
	player setVariable ["GREUH_ammo_count", (_ammo_collected + _ammount_ammo), true];
	player addRating 500;
};
