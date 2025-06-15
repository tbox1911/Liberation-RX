waitUntil { sleep 1; !isNil "blufor_sectors" };
private [
	"_unitList", "_my_squad",
	"_near_arsenal", "_primary_weapon", "_needammo1", "_needammo2", "_maxpri", "_minpri",
	"_near_medic", "_needmedic",
	"_near_repair", "_near_lhd", "_list_vehicles", "_vehicle",
	"_vehicle_need_repair", "_vehicle_hitpoints", "_vehicle_damage"
];

private _distarsenal = 30;           // minimal distance from source (ammo/repair)
private _maxpri_def = 8;             // maximum magazines unit can take (primary weapon)
private _minpri_def = 3;             // minimal magazines before unit need to reload
private _maxsec_def = 3;             // maximum magazines unit can take (secondary weapon)
private _minsec_def = 1;             // minimal magazines before unit need to reload
private _added_pri = 0;
private _added_sec = 0;

private _artillery = [
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F"
];

private _vehicle_support_enabled = true;
if (GRLIB_ACE_enabled) then { _vehicle_support_enabled = false };

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

		{
			_unit = _x;
			_in_vehicle = !(isNull objectParent _unit);
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

					// check primary Weapon
					if ( _primary_weapon find "LMG" >= 0 || _primary_weapon find "MMG" >= 0 || _primary_weapon find "RPK12" >= 0 ) then { _minpri = 1; _maxpri = 3 };
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
					if (damage _unit > 0.1 && (behaviour _unit) != "COMBAT") then {
						_needmedic = true;
					};
				};

				// Animation
				if (_needammo1 || _needammo2) then {
					if ((_added_pri + _added_sec) == 0) then {
						_unit groupchat localize "STR_DIALOG_REARM_FAILED_FULL";
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
			if (_vehicle_support_enabled && _in_vehicle) then {
				_vehicle = vehicle _unit;
				_near_lhd = (_unit distance2D lhd < GRLIB_fob_range);
				if (!(_vehicle isKindOf "ParachuteBase") &&	(_unit in [gunner _vehicle, driver _vehicle, commander _vehicle])) then {
					if (_vehicle getVariable ["R3F_LOG_disabled", false]) exitWith {};
					_vehicle_class = typeOf _vehicle;
					_vehicle_name = [_vehicle_class] call F_getLRXName;
					_reammo_cost = 0;
					_is_arty = ([_vehicle_class, _artillery] call F_itemIsInClass);
					if (_is_arty) then { _distarsenal = 80 };
					if ([_unit, "FOB", _distarsenal, true] call F_check_near) then { _reammo_cost = 100 };

					// REAMMO
					_near_arsenal = ([_vehicle, "REAMMO", _distarsenal] call F_check_near || _near_lhd);
					_vehicle_need_ammo = (([_vehicle] call F_getVehicleAmmoDef) <= 0.85);
					_affordable = (player getVariable ["GREUH_ammo_count", 0] > _reammo_cost);

					if (!isNil "GRLIB_LRX_debug") then {
						diag_log format ["DBG: %1: need Ammo:%2 - near Ammo source:%3", _vehicle_class, _vehicle_need_ammo, _near_arsenal];
					};

					if (_near_arsenal && _vehicle_need_ammo && _affordable) then {
						_timer = _vehicle getVariable ["GREUH_rearm_timer", 0];
						if (_timer <= time) then {
							_max_ammo = 3;
							_cooldown = 5 * 60;
							[_reammo_cost] call F_pay;
							_vehicle setVehicleAmmo 1;
							if (_is_arty) then { _cooldown = _cooldown * 1.5 };
							_vehicle setVariable ["GREUH_rearm_timer", round (time + _cooldown)];  // min cooldown
							_screenmsg = format [localize "STR_REARM_COST_LINE", _vehicle_name, localize "STR_REARMING", "100%", _reammo_cost];
							titleText [_screenmsg, "PLAIN DOWN"];
							hintSilent _screenmsg;
						} else {
							if (_unit distance2D player <= 30) then {
								_screenmsg = format [localize "STR_REARM_COOLDOWN_LINE", _vehicle_name, round (_timer - time)];
								titleText [_screenmsg, "PLAIN DOWN"];
							};
						};
					};

					// REPAIR
					_near_repair = ([_vehicle, "REPAIR_AI", _distarsenal] call F_check_near || _near_lhd);
					_vehicle_need_repair = [_vehicle] call F_VehicleNeedRepair;
					if (!isNil "GRLIB_LRX_debug") then {
						diag_log format ["DBG: %1: need Repair:%2 - near Repair source:%3", _vehicle_class, _vehicle_need_repair, _near_repair];
					};

					if (_near_repair && _vehicle_need_repair) then {
						_timer = _vehicle getVariable ["GREUH_repair_timer", 0];
						if (_timer <= time) then {
							_vehicle setDamage 0;
							_vehicle setVariable ["GREUH_repair_timer", round (time + (5*60))];  // min cooldown
							_screenmsg = format ["%1\n%2 - %3", _vehicle_name, localize "STR_REPAIRING", "100%"];
							titleText [_screenmsg, "PLAIN DOWN"];
							hintSilent _screenmsg;
						} else {
							if (_unit distance2D player <= 30) then {
								_screenmsg = format [localize "STR_REPAIR_COOLDOWN_LINE", _vehicle_name, round (_timer - time)];
								titleText [_screenmsg, "PLAIN DOWN"];
							};
						};
					};

					// REFUEL
					_near_refuel = ([_vehicle, "REFUEL", _distarsenal] call F_check_near || _near_lhd);
					_vehicle_need_refuel = (fuel _vehicle < 0.5);
					if (!isNil "GRLIB_LRX_debug") then {
						diag_log format ["DBG: %1: need Fuel:%2 - near refuel source:%3", _vehicle_class, _vehicle_need_refuel, _near_refuel];
					};

					if (_near_refuel && _vehicle_need_refuel) then {
						_timer = _vehicle getVariable ["GREUH_refuel_timer", 0];
						if (_timer <= time) then {
							_vehicle setFuel 1;
							_vehicle setVariable ["GREUH_refuel_timer", round (time + (5*60))];  // min cooldown
							_screenmsg = format ["%1\n%2 - %3", _vehicle_name, localize "STR_REFUELING", "100%"];
							titleText [_screenmsg, "PLAIN DOWN"];
							hintSilent _screenmsg;
						} else {
							if (_unit distance2D player <= 30) then {
								_screenmsg = format [localize "STR_REFUEL_COOLDOWN_LINE", _vehicle_name, round (_timer - time)];
								titleText [_screenmsg, "PLAIN DOWN"];
							};
						};
					};

					// UNFLIP
					if (_unit == driver _vehicle) then {
						[_vehicle] call F_vehicleUnflip;
					};
				};
			};
			sleep 0.2;
		} forEach _unitList;
	};

	// Show Hint
	private _neartower = ((sectors_tower select {(_x in opfor_sectors) && player distance2D (markerPos  _x) <= 20})) select 0;
	if (!isNil "_neartower") then {
		_msg = localize "STR_DESTROY_TOWER";
		[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	};

	sleep 30;
};