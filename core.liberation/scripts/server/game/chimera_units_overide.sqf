if (!isServer) exitWith {};
if (GRLIB_mod_west == "A3_BLU") exitWith {};
private [ "_unit_model", "_cloth", "_items", "_weapon", "_mag", "_src_class", "_dst_class", "_veh_lst", "_veh", "_src_pos", "_src_dir" ];

// repaint man units
private _chimera_soldiers = [];
private _grp = createGroup [GRLIB_side_friendly, true];
private _chimera_soldiers = units group chimeraofficer;
{
	_unit_model = selectRandom blufor_squad_inf;
	_cloth = getText(configfile >> "CfgVehicles" >> _unit_model >> "uniformClass");
	_items = getArray (configfile >> "CfgVehicles" >> _unit_model >> "linkedItems");
	_weapon = (getArray (configfile >> "CfgVehicles" >> _unit_model >> "weapons") - ["Throw","Put"]) select 0;
	_mag = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines" ) select 0;
	//diag_log format ["DBG: %1 %2 %3 %4", _unit_model, _items, _weapon, _mag];
	_unit = _x;
	_unit forceAddUniform _cloth;
	removeVest _unit;
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeHeadgear _unit;
	{if ("Headgear" in (_x call BIS_fnc_itemType)) then {_unit addHeadgear _x}} forEach _items;
	{if ("Vest" in (_x call BIS_fnc_itemType)) then {_unit addVest _x} else {_unit linkItem _x}} forEach _items;	
	if (!isNil "_mag") then {
		for "_i" from 1 to 3 do {_unit addItem _mag};
		for "_i" from 1 to 4 do {_unit addItemToVest _mag};
	};
	_unit addWeapon _weapon;
	[_unit] joinSilent _grp;
} forEach _chimera_soldiers;

// repaint vehicle
if (!isNil "chimera_vehicle_overide") then {
	{
		_src_class = _x select 0;
		_dst_class = _x select 1;
		_veh_lst = vehicles select { alive _x && (_x distance2D lhd < GRLIB_fob_range) && typeOf _x == _src_class };
		{
			_src_pos = (getPosATL _x) vectorAdd [0, 0, 0.2];
			_src_dir = getDir _x;
			deleteVehicle _x;
			sleep 0.5;
			if (_dst_class != "") then {
				_veh = _dst_class createVehicle _src_pos;
				_veh allowDamage false;
				_veh setDir _src_dir;
				_veh setPosATL _src_pos;
				_veh setVariable ["GRLIB_vehicle_owner", "public", true];
				_veh addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

				if (GRLIB_ACE_enabled) then {
					if (_src_class == "B_Heli_Light_01_F") then {
						_veh setVariable ["ace_cargo_hasCargo", true, true];
						_veh setVariable ["ace_cargo_space", 15, true];
					};
					if (_src_class == "B_Heli_Transport_01_F") then {
						_veh setVariable ["ace_cargo_hasCargo", true, true];
						_veh setVariable ["ace_cargo_space", 30, true];
					};
				};
				sleep 1;
				_veh allowDamage true;
			};
		} forEach _veh_lst;
	} forEach chimera_vehicle_overide;
};

// Remove Helipad
if (GRLIB_fob_type > 0) then {
	private _air_items = (nearestObjects [lhd, ["Helipad_base_F","Land_PortableHelipadLight_01_F"], 150]);
	_air_items = _air_items + (allSimpleObjects ["PortableHelipadLight_01_blue_F"]);
	{
		if (_x == huronspawn) then { 
			huronspawn = "Land_HelipadEmpty_F" createVehicle (getPos _x);
			huronspawn setDir (getDir _x);
		};
		deleteVehicle _x;
	} forEach _air_items;
};

// Optre bonus
if (GRLIB_OPTRE_enabled) then {
	_src_pos = (getPosATL lhd) vectorAdd [0,-300,250];
	_veh = createVehicle ["OPTRE_Frigate_UNSC", _src_pos, [], 0, "CAN_COLLIDE"];
	_veh allowDamage false;
	_veh setDir 90;
	_veh setVehicleLock "LOCKED";
	_veh enableSimulation false;

	_src_pos = _src_pos vectorAdd [-200,-500,0];
	_veh = createVehicle ["OPTRE_Frigate_In", _src_pos, [], 0, "CAN_COLLIDE"];
	_veh allowDamage false;
	_veh setDir 90;
	_veh setVehicleLock "LOCKED";
	_veh enableSimulation false;
};
