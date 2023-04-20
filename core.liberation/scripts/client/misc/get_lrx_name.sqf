params ["_class"];

if (isNil"_class") exitWith {};
if (typeName _class != "STRING") exitWith {};

private _text = getText (configFile >> "cfgVehicles" >> _class >> "displayName");

if ( _class == FOB_box_typename ) then {
	_text = localize "STR_FOBBOX";
};
if ( _class == Arsenal_typename ) then {
	_text = localize "STR_ARSENAL_BOX";
};
if ( _class == FOB_truck_typename ) then {
	_text = localize "STR_FOBTRUCK";
};
if ( _class == Respawn_truck_typename ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN_TRUCK", "(Truck)"];
};
if ( _class == mobile_respawn ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN_TRUCK", "(Tent)"];
};
if ( _class == huron_typename ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN_TRUCK", "(Heli)"];
};
if ( _class == canisterFuel ) then {
	_text = "Fuel Jerican";
};
if ( _class == waterbarrel_typename ) then {
	_text = "Water Barrel";
};
if ( _class == fuelbarrel_typename ) then {
	_text = "Fuel Barrel";
};
if ( _class == foodbarrel_typename ) then {
	_text = "Food Pallet";
};
if ( _class == "Land_CargoBox_V1_F" ) then {
	_text = "Fireworks Box";
};
if ( _class == FOB_box_outpost ) then {
	_text = localize "STR_OUTPOSTBOX";
};
_text;