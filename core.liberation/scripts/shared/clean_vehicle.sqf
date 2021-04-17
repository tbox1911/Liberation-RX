params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

// Detach
detach _vehicle;
sleep 0.2;

// Delete R3F Cargo
{[_x] remoteExec ["deleteVehicle", 0]} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
_vehicle setVariable ["R3F_LOG_objets_charges", [], true];
sleep 0.2;

// Delete GRLIB Cargo
if ( _vehicle getVariable ["GRLIB_ammo_truck_load", 0] >= 1 ) then {
	{
		if (typeOf _x in [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename, fuelbarrel_typename]) then {
			detach _x;
			sleep 0.2;
			_x setVelocity [([] call F_getRND), ([] call F_getRND), 10];
			sleep (0.5 + floor(random 3));
			_x setDamage 1;
		} else {
			deleteVehicle _x;
		};
	} foreach (attachedObjects _vehicle);
};
sleep 0.2;

//Delete A3 Cargo
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

// Delete Crew
{if (! alive _x) then {[_x] remoteExec ["deleteVehicle", 0]}} forEach crew _vehicle;
_vehicle removeAllEventHandlers "HandleDamage";