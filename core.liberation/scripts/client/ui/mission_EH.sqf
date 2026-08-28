waitUntil {sleep 1; !isNil "GRLIB_player_near_outpost"};

addMissionEventHandler ["Draw3D",{
    // Sign Info
	if !(isNull objectParent player) exitWith {};
	private _pos = ASLToAGL getPosASL chimera_sign;
	if (player distance2D _pos <= 30) then {
		drawIcon3D ["", [1,1,1,1], _pos vectorAdd [0, 0, 3], 0, 0, 0, "- READ ME -", 2, 0.05, "TahomaB"];
	};

	if (GRLIB_player_near_fob && !GRLIB_player_near_lhd) then {
		private _sign = nearestObjects [player, [FOB_sign], 5] select 0;
		if (!isNil "_sign") then {
			private _gid = _sign getVariable ["GRLIB_vehicle_owner", ""];
			private _type = "FOB";
			if (GRLIB_player_near_outpost) then { _type = "Outpost" };
			private _name = "- LRX";
			if (_gid != "lrx") then {
				_name = GRLIB_player_scores select { _x select 0 == _gid } select 0 select 5;
			};
			drawIcon3D ["", [1,1,1,1], (ASLToAGL getPosASL _sign) vectorAdd [0, 0, 2.5], 0, 0, 0, format ["- %1 %2 -", _type, _name], 2, 0.07, "RobotoCondensed", "center"];
		};
	};

	if (dobuild == 0) then {
        // player box Info
		private _near_box = nearestObjects [player, [playerbox_typename], 3];
		if (count _near_box > 0) then {
			private _box = _near_box select 0;
			private _box_pos = ASLToAGL getPosASL _box;
			private _gid = _box getVariable ["GRLIB_vehicle_owner", ""];
			private _name = GRLIB_player_scores select { _x select 0 == _gid } select 0 select 5;
			drawIcon3D ["", [1,1,1,1], _box_pos vectorAdd [0, 0, 1], 2, 2, 0, format ["- %1 Personal Box -", _name], 2, 0.05, "RobotoCondensed", "center"];
		};

        // storage Info
		private _near_storage = nearestObjects [player, ["VR_Area_01_square_2x2_yellow_F"], 2];
		if (count (_near_storage) > 0) then {
			private _storage = _near_storage select 0;
			private _storage_pos = ASLToAGL getPosASL _storage;
			drawIcon3D ["", [1,1,1,1], _storage_pos vectorAdd [0, 0, 1], 2, 2, 0, "Use LOAD / UNLOAD Action", 2, 0.05, "RobotoCondensed", "center"];
		};
	};

    // statics Info
	private _near_static = nearestObjects [player, static_vehicles_AI, 5];
	if (count (_near_static) > 0) then {
		private _static = _near_static select 0;
		private _static_pos = ASLToAGL getPosASL _static;
		private _screenmsg = "";
		private _timer = _static getVariable ["GREUH_rearm_timer", 0];
		private _ammo = [_static] call F_getVehicleAmmoDef;
		if (_timer > time && _ammo <= 0.85) then {
			_screenmsg = format [ "%1 Rearming Cooldown (%2 sec)...", ([_static] call F_getLRXName), round (_timer - time) ];
		};
		private _timer = _static getVariable ["GREUH_repair_timer", 0];
		private _damage = [_static] call F_getVehicleDamage;
		if (_timer > time && _damage >= 0.04) then {
			_screenmsg = format [ "%1 Repairing Cooldown (%2 sec)...", ([_static] call F_getLRXName), round (_timer - time) ];
		};
		if (_screenmsg != "") then {
			drawIcon3D ["", [1,1,1,1], _static_pos vectorAdd [0, 0, 1], 2, 2, 0, _screenmsg, 2, 0.05, "RobotoCondensed", "center"];
		};
	};

}];
