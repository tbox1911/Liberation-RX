if (!isServer && hasInterface) exitWith {};
params ["_fob_pos", "_owner"];

[_fob_pos, "Land_Carrier_01_blast_deflector_up_sound"] spawn sound_range_remote_call;

private _outpost = nearestObjects [_fob_pos, [FOB_outpost], 30] select 0;
private _outpost_sign = nearestObjects [_fob_pos, [FOB_sign], 30] select 0;
private _outpost_dir = getDir _outpost;
{ deleteVehicle _x } forEach [_outpost, _outpost_sign] + (_fob_pos nearEntities ["LandVehicle", 20]);
GRLIB_all_outposts = GRLIB_all_outposts - [_fob_pos];
publicVariable "GRLIB_all_outposts";
sleep 1;

private _fob = createVehicle [FOB_typename, _fob_pos, [], 1, "None"];
_fob allowDamage false;
_fob setPosATL _fob_pos;
private _fob_dir = (_outpost_dir - 180);
_fob setVectorDirAndUp [[sin _fob_dir, cos _fob_dir, 0], [0, 0, 1]];
[_fob_pos, "Land_Carrier_01_blast_deflector_up_sound"] spawn sound_range_remote_call;
sleep 1;

[_fob, _owner] call fob_init;
[_fob_pos, 6] remoteExec ["remote_call_fob", 0];
GRLIB_redraw_marker_fob = true; 