// LRX Virtual Garage
// by pSiKO v2.0

createDialog "VIRT_vehicle_garage";
waitUntil { dialog };

private _display = findDisplay 2301;
private _control = _display displayCtrl (110);
private _vehicles_out = [];
private _selected_item = 0;
private _old_sel = -1;
private _cfg = configFile >> "cfgVehicles";
private _refresh = true;

load_veh = 0;

ctrlEnable [ 120, false ];
ctrlEnable [ 121, false ];

while { dialog && alive player } do {
	if ( _refresh ) then {
		_refresh = false;

		// list outside
		_vehicles_out = (player nearEntities [["LandVehicle","Air","Ship_F",playerbox_typename], 150]) select {
			alive _x && (count (crew _x) == 0 || (typeOf _x in uavs_vehicles)) &&
			(_x distance2D lhd > GRLIB_fob_range) &&
			(_x getVariable ["GRLIB_vehicle_owner", ""] == PAR_Grp_ID) &&
			(isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])) &&
			!(typeOf _x in list_static_weapons)
		};

		lbClear 110;
		{
			_class = typeOf _x;
			_entrytext = [_class] call F_getLRXName;
			_control lnbAddRow [_entrytext, "OUT"];

			_icon = getText ( _cfg >> _class >> "icon");
			if(isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture [110, [((lnbSize 110) select 0) - 1, 0], _icon];

			_control lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [1,1,1,1]];
			_control lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [1,1,1,1]];
		} foreach _vehicles_out;

		// list inside Garage
		{
			_class = _x select 0;
			_entrytext = [_class] call F_getLRXName;
			_control lnbAddRow [_entrytext, "IN"];

			_icon = getText ( _cfg >> _class >> "icon");
			if(isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture [110, [((lnbSize 110) select 0) - 1, 0], _icon];

			_control lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [0.4,0.4,0.4,1]];
			_control lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [0.4,0.4,0.4,1]];
		} foreach GRLIB_virtual_garage;

		_old_sel = -1;
		sleep 1;
	};

	if (count (_vehicles_out + GRLIB_virtual_garage) > 0) then {
		_selected_item = lbCurSel 110;
		if (_selected_item != -1 && _old_sel != _selected_item) then {
			if ( (_control lnbText [_selected_item, 1]) == "OUT") then {
				ctrlEnable [ 120, true ];
				ctrlEnable [ 121, false ];
			} else {
				ctrlEnable [ 120, false ];
				ctrlEnable [ 121, true ];
			};
			_old_sel = _selected_item;
		};

		if (load_veh != 0) then {
			private	_vehicle_name = _control lnbText [_selected_item, 0];

			// Load
			if (load_veh == 1) then {
				private _vehicle = _vehicles_out select _selected_item;
				if (isNull _vehicle) exitWith {};
				private _timer = _vehicle getVariable ["GREUH_rearm_timer", 0];
				private _msg = format [ "%1\nRearming Cooldown (%2 sec)\nPlease Wait...", _vehicle_name, round (_timer - time) ];
				if (_timer >= time) exitWith { hintSilent _msg; sleep 2 };
				if (count GRLIB_virtual_garage >= GRLIB_garage_size) exitWith { hintSilent (format [localize "STR_FULL_GARAGE", GRLIB_garage_size]); sleep 2 };
				if ([_vehicle] call F_VehicleNeedRepair) exitWith { hintSilent "Damaged Vehicles cannot be Parked !"; sleep 2 };
				if (count (crew _vehicle) > 0 && !(typeOf _vehicle in uavs_vehicles)) exitWith { hintSilent localize "STR_CANT_PARKUAV"; sleep 2 };

				ctrlEnable [ 120, false ];
				private _color = _vehicle getVariable ["GRLIB_vehicle_color", ""];
				private _compo = _vehicle getVariable ["GRLIB_vehicle_composant", []];
				private _ammo = [_vehicle] call F_getVehicleAmmoDef;
				//private _lst_a3 = [_vehicle, true] call F_getCargo;
				private _lst_a3 = [];
				private _lst_r3f = [];
				{ _lst_r3f pushback (typeOf _x)} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
				private _lst_grl = [];
				{_lst_grl pushback (typeOf _x)} forEach (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);
				GRLIB_virtual_garage append [[typeOf _vehicle,_color,_ammo,_compo,_lst_a3,_lst_r3f,_lst_grl]];
				[_vehicle, true, true] call clean_vehicle;
				player setVariable [format ["GRLIB_virtual_garage_%1", PAR_Grp_ID], GRLIB_virtual_garage, true];
				hintSilent (format [localize "STR_LOADED", _vehicle_name]);
			};

			// Unload
			if (load_veh == 2) then {
				_selected_item = (_selected_item - count _vehicles_out);
				private _vehicle = GRLIB_virtual_garage select _selected_item;
				closeDialog 0;

				if (count _vehicle < 7) exitWith {};
				buildtype = GRLIB_BuildTypeDirect;
				build_unit = _vehicle;
				dobuild = 1;

				waitUntil {sleep 0.5; dobuild == 0};
				if (build_confirmed == 0) then {
					hintSilent (format ["Vehicle %1\nUnloaded from Garage.", [(_vehicle select 0)] call F_getLRXName]);
					GRLIB_virtual_garage deleteAt _selected_item;
					player setVariable [format ["GRLIB_virtual_garage_%1", PAR_Grp_ID], GRLIB_virtual_garage, true];
				};
			};

			sleep 0.5;
			_refresh = true;
			load_veh = 0;
		};
	};

	sleep 0.2;
};
