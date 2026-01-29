GRLIB_vehicle_need_support = [];

private [
	"_unitList", "_my_squad",
	"_near_arsenal", "_primary_weapon", "_needammo1", "_needammo2", "_maxpri", "_minpri",
	"_near_medic", "_needmedic",
	"_near_repair", "_near_refuel", "_near_lhd", "_list_vehicles", "_vehicle",
	"_vehicle_need_ammo", "_vehicle_need_repair", "_vehicle_need_refuel",
	"_vehicle_hitpoints", "_vehicle_damage"
];

private _distarsenal = 30;           // minimal distance from source (ammo/repair)
private _maxpri_def = 8;             // maximum magazines unit can take (primary weapon)
private _minpri_def = 3;             // minimal magazines before unit need to reload
private _maxsec_def = 3;             // maximum magazines unit can take (secondary weapon)
private _minsec_def = 1;             // minimal magazines before unit need to reload
private _added_pri = 0;
private _added_sec = 0;
private _uiticks = 0;

private _artillery = [
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F"
];

private _blacklist_vehicle = [
	"ParachuteBase"
];

private _vehicle_support_enabled = true;

while {true} do {
	waitUntil {sleep 1; GRLIB_player_spawned};

	_unitList = (units group player) select { local _x && lifeState _x != "INCAPACITATED" };
	_my_squad = player getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then { { _unitList pushBack _x } forEach units _my_squad };
	{_unitList append units _x} foreach hcAllGroups player;

	if (count _unitList >= 1) then {
		_needammo1 = false;
		_needammo2 = false;
		_needmedic = false;
		GRLIB_vehicle_need_support = [];
		{
			_unit = _x;
			_vehicle = objectParent _unit;
			_in_vehicle = !(isNull _vehicle);
			_vehicle_support_enabled = true;
			if ([_vehicle, _blacklist_vehicle] call F_itemIsInClass) then { _vehicle_support_enabled = false };
			if !(_unit in [gunner _vehicle, driver _vehicle, commander _vehicle]) then { _vehicle_support_enabled = false };
			if (_vehicle in GRLIB_vehicle_need_support) then { _vehicle_support_enabled = false };
			if (GRLIB_ACE_enabled) then { _vehicle_support_enabled = false };
			_distarsenal = 30;

			// Out vehicle
			if (!_in_vehicle && !(isPlayer _unit)) then {
				_needammo1 = false;
				_needammo2 = false;
				_needmedic = false;
				_near_arsenal = [_unit, "REAMMO_AI", _distarsenal] call F_check_near;
				_primary_weapon = primaryWeapon _unit;
				_secondary_weapon = secondaryWeapon _unit;
				if (_near_arsenal && (_primary_weapon != "" || _secondary_weapon != "")) then {
					_maxpri = _maxpri_def;
					_minpri = _minpri_def;
					if ( _primary_weapon find "LMG" >= 0 || _primary_weapon find "MMG" >= 0 || _primary_weapon find "RPK12" >= 0 ) then {
						_minpri = 1;
						_maxpri = 3
					};

					// check primary Weapon
					_needammo1 = [_unit, _primary_weapon, _minpri] call F_UnitNeedAmmo;
					if (_needammo1) then {
						_unit groupchat localize "STR_DIALOG_REARM_PRIMARY";
						_added_pri = [_unit, _primary_weapon, _maxpri] call F_UnitAddAmmo;
					};

					// check secondary Weapon if backpack present
					if (!isNull (unitBackpack _unit)) then {
						_needammo2 = [_unit, _secondary_weapon, _minsec_def] call F_UnitNeedAmmo;
						if (_needammo2) then {
							//clearAllItemsFromBackpack _unit;
							_unit groupchat localize "STR_DIALOG_REARM_SECONDARY";
							_added_sec = [_unit, _secondary_weapon, _maxsec_def] call F_UnitAddAmmo;
							if (_added_sec > 0 && count (secondaryWeaponMagazine _unit) == 0) then {
								_unit removeWeapon _secondary_weapon;
								sleep 0.1;
								_unit addWeapon _secondary_weapon;
							};
						};
					};

					// check medkit
					if !([_unit] call PAR_has_medikit) then {
						_unit addItem PAR_AidKit;
						_unit addItem PAR_AidKit;
					};

					// GL mun
					[_unit] call F_correctHEGL;
				};

				// Medic
				_near_medic = [_unit, "MEDIC", _distarsenal] call F_check_near;
				if (_near_medic) then {
					if (damage _unit > 0.1 && (behaviour _unit) != "COMBAT" && isNil {_unit getVariable "PAR_heal"}) then {
						_needmedic = true;
					};
				};

				// Animation
				if (_needammo1 || _needammo2) then {
					if ((_added_pri + _added_sec) == 0) then {
						if (_uiticks % 6 == 0) then {
							_unit groupchat localize "STR_DIALOG_REARM_FAILED_FULL";
						};
					} else {
						_unit switchMove 'WeaponMagazineReloadStand';
						_unit playMoveNow 'WeaponMagazineReloadStand';
						sleep 4;
					};
				};
				if (_needmedic) then {
					[_unit] spawn {
						params ["_target"];
						_target groupchat format ["Healing myself."];
						_target setVariable ["PAR_heal", true];
						_target switchMove 'AinvPknlMstpSlayWrflDnon_medic';
						_target playMoveNow 'AinvPknlMstpSlayWrflDnon_medic';
						sleep 6;
						if (lifeState _target != "INCAPACITATED") then {
							_target setDamage 0;
						};
						sleep 4;
						_target setVariable ["PAR_heal", nil];
					};
				};
			};

			// In vehicle
			if (_in_vehicle && _vehicle_support_enabled) then {
				_near_lhd = (_unit distance2D lhd < GRLIB_fob_range);
				_vehicle setVariable ["GRLIB_vehicle_need_support", nil];
				private _task = [];

				// REPAIR
				_near_repair = ([_vehicle, "REPAIR", _distarsenal] call F_check_near || _near_lhd);
				_vehicle_need_repair = [_vehicle] call F_vehicleNeedRepair;
				if (_near_repair && _vehicle_need_repair) then { _task pushBack 1 };

				// REAMMO
				_near_arsenal = ([_vehicle, "REAMMO", _distarsenal] call F_check_near || _near_lhd);
				_vehicle_need_ammo = (([_vehicle] call F_getVehicleAmmoDef) <= 0.85);
				if (_near_arsenal && _vehicle_need_ammo) then { _task pushBack 2 };

				// REFUEL
				_near_refuel = ([_vehicle, "REFUEL", _distarsenal] call F_check_near || [_unit, "FUEL", _distarsenal, false] call F_check_near || _near_lhd);
				_vehicle_need_refuel = (fuel _vehicle <= 0.7);
				if (_near_refuel && _vehicle_need_refuel) then { _task pushBack 3 };

				// Set Task
				if (count _task > 0) then {
					_vehicle setVariable ["GRLIB_vehicle_need_support", _task];
					GRLIB_vehicle_need_support pushBackUnique _vehicle;
					if (_uiticks % 4 == 0) then {
						gamelogic globalChat format [localize "STR_VEH_NEED_SUPPORT", ([_vehicle] call F_getLRXName)];
					};
				};

				// UNFLIP
				if (_unit == driver _vehicle) then {
					[_vehicle] call F_vehicleUnflip;
				};
			};
			sleep 0.2;
		} forEach _unitList;
	};

	// Show Hint
	if (_uiticks % 6 == 0) then {
		private _tower = [player] call F_getNearestRadioTower;
		if (!isNil "_tower") then {
			if ([GRLIB_capture_size, _tower, opfor_sectors] call F_getNearestSector != "") then {
				_msg = localize "STR_DESTROY_TOWER";
				[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
			};
		};
	};

	_uiticks = _uiticks + 1;
	if (_uiticks > 1000) then { _uiticks = 0 };
	sleep 5;
};