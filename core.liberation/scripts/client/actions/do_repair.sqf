params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private _repairbox = (_vehicle nearEntities [[repairbox_typename], 15]) select { alive _x && getObjectType _x >= 8 } select 0;

if (!isNil "_repairbox") then {
    disableUserInput true;
    player setDir (player getDir _vehicle);
    player playMove 'ainvpknlmstpslaywrfldnon_medic';
    playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_repair.wss", _vehicle];
    hintSilent format [localize "STR_REPAIR_VEH_MSG", [_vehicle] call F_getLRXName];
    sleep 1;
	deleteVehicle _repairbox;
    { _vehicle setHitPointDamage [_x, 0] } forEach (getAllHitPointsDamage _vehicle select 0);
    _vehicle setDamage 0;
    sleep 5;
    disableUserInput false;
    disableUserInput true;
    disableUserInput false;
};
