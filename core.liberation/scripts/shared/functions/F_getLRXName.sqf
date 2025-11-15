params ["_class"];

private _default = "Unknow";
if (isNil "_class") exitWith { _default };

private _text = "";
if (typeName _class == "STRING") then {
	_text = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
	if (_text == "") then {
		_text = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
	};
	if (_text == "") then {
		_text = getText (configFile >> "CfgMagazines" >> _class >> "displayName");
	};
	if (_text == "") then {
		_text = getText (configFile >> "CfgGlasses" >> _class >> "displayName");
	};
	if (_text == "") then { _text = _class };
};
if (typeName _class == "OBJECT") then {
	_text = getText (configOf _class >> "displayName");
	_class = typeOf _class;
};
if (_text == "") exitWith { diag_log format ["--- LRX Error: get LRX name for class:%1, not found!", _class]; _default };

if ( _class == FOB_box_typename ) then {
	_text = localize "STR_FOBBOX";
};
if ( _class == Arsenal_typename ) then {
	_text = localize "STR_ARSENAL_BOX";
};
if ( _class == FOB_truck_typename ) then {
	_text = localize "STR_FOBTRUCK";
};
if ( _class == FOB_boat_typename ) then {
	_text = localize "STR_FOBBOAT";
};
if ( _class == respawn_truck_typename ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN", "(Truck)"];
};
if ( _class == mobile_respawn ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN", "(Tent)"];
};
if ( _class == huron_typename ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN", "(Heli)"];
};
if ( _class == canister_fuel_typename ) then {
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
if ( _class == repairbox_typename ) then {
	_text = localize "STR_REPAIR_VEH_NAME";
};
if ( _class == FOB_box_outpost ) then {
	_text = localize "STR_OUTPOSTBOX";
};
if ( _class == a3w_sd_item ) then {
	_text = "Mission Suitcase";
};
if ( _class == playerbox_typename ) then {
	_text = "Personal Player Box";
};
if ( _class == land_cutter_typename ) then {
	_text = "Magic Mower (Hide Terrain Objects)";
};
if ( _class == Warehouse_typename ) then {
	_text = "Global Warehouse";
};
if ( _class == basic_weapon_typename ) then {
	_text = "Basic Weapons";
};
if ( _class == medic_heal_typename ) then {
	_text = "Medical Support";
};
if ( _class == storage_medium_typename ) then {
	_text = "Medium Storage Zone";
};
if ( _class == box_uavs_typename ) then {
	private _uavs_name = getText (configFile >> "cfgVehicles" >> uavs_light >> "displayName");
	_text = format ["Box of %1 Drones (%2)", box_uavs_max, _uavs_name];
};

_text;