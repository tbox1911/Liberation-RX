// Commander mode
if (GRLIB_Commander_mode) then {
	waitUntil {sleep 1; !isNil "opfor_sectors"};
	waitUntil {sleep 1; !isNil "GRLIB_AvailAttackSectors"};
	waitUntil {sleep 1; !isNil "GRLIB_player_commander"};

	GRLIB_Com_lastClicked = time;
	addMissionEventHandler ["MapSingleClick", {
		params ["_units", "_pos"];
		if (count active_sectors == 0 && count GRLIB_AvailAttackSectors > 0) then {
			if ((time - GRLIB_Com_lastClicked) > 3 && (GRLIB_Commander_VoteEnabled || GRLIB_player_commander)) then {
				_closestSector = [100, _pos, GRLIB_AvailAttackSectors] call F_getNearestSector;
				if (_closestSector in opfor_sectors) then {
					playSoundUI ["a3\ui_f\data\sound\cfgnotifications\tacticalping3.wss", 0.5, 1.2];
					if (GRLIB_player_commander) then {
						[player, _closestSector] remoteExec ["activate_sector_remote_call", 2];
					} else {
						[player, _closestSector] remoteExec ["vote_sector_remote_call", 2];
					};
					GRLIB_Com_lastClicked = time;
				};
			};
		};
	}, [player]];
};
