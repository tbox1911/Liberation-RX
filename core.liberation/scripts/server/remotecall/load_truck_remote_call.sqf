if (!isServer && hasInterface) exitWith {};
params [ "_truck_to_unload" ,"_ammobox" ];

waitUntil {sleep 0.1; isNil "GRLIB_load_box"};
GRLIB_load_box = true;

private _truck_to_load = objNull;
private _box_offset = { if (typeOf _ammobox == (_x select 0)) exitWith {_x select 1} } foreach box_transport_offset;
if (isNil "_box_offset") then {_box_offset = [0, 0, 0]};

private _maxload = 0;
private _offsets = [];
{
	if ( _x select 0 == typeof _truck_to_unload ) then {
		_maxload = (count _x) - 2;
		for "_i" from 2 to (count _x) do { _offsets pushback (_x select _i) };
	};
} foreach box_transport_config;

if ( isNull _truck_to_unload ) then {
	private _truck_load = _truck_to_unload getVariable ["GRLIB_ammo_truck_load", []];
	if ( count _truck_load < _maxload ) then {
		_truck_to_load = _truck_to_unload;
		_truck_offset = (_offsets select (count _truck_load)) vectorAdd _box_offset;
		_ammobox attachTo [ _truck_to_unload, _truck_offset ];
		_ammobox setVariable ["R3F_LOG_disabled", true, true];
		_ammobox allowDamage false;
		[_ammobox, false] remoteExec ["enableSimulationGlobal", 2];
		_truck_load pushback _ammobox;
		_truck_to_unload setVariable ["GRLIB_ammo_truck_load", _truck_load, true];
		_msg = [localize "STR_BOX_LOADED", [typeOf _ammobox] call F_getLRXName];
		[_msg] remoteExec ["hintSilent", owner _truck_to_unload];
	};
};

sleep 1;
GRLIB_load_box = nil;
