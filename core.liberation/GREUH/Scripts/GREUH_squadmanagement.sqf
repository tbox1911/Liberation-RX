waitUntil {sleep 0.1; !isNull (findDisplay 5565)};

private _grp = groups_list select (lbCurSel 515);
private _grp_player = group player;
if (isNull _grp) exitWith {};

switch (squadaction) do {

	case "join" : {
		if (_grp != _grp_player) then {
			if (count (units _grp_player) == 1) then {
				if !(_grp in global_locked_group) then {
					[_grp_player, "del"] remoteExec ["addel_group_remote_call", 2];
					[player] join _grp;
					hint "Squad joined";
				} else {hint "Sorry, the Squad is Locked."};
			} else {hint "Sorry, your Group is not Empty."};
		};
	};

	case "leave" : {
		if (leader _grp_player != player) then {
			GRLIB_player_group = createGroup [GRLIB_side_friendly, true];
			[GRLIB_player_group, "add"] remoteExec ["addel_group_remote_call", 2];
			[player] joinSilent GRLIB_player_group;
			hint "New Squad created";
		};
	};

	case "lock" : {
		if (_grp == _grp_player) then {
			if (_grp in global_locked_group) then {
				hint "Squad unLocked !";
				[_grp, "del"] remoteExec ["addel_group_remote_call", 2];
				ctrlSetText [516, "Lock"];
			} else {
				hint "Squad locked !";
				[_grp, "add"] remoteExec ["addel_group_remote_call", 2];
				ctrlSetText [516, "UnLock"];
			};
		};
	};

	case "rename" : {
		if (leader _grp_player == player) then {
			private _rename_controls = [521,522,523,524,525,526,527];
			{ ctrlShow [_x, true] } foreach _rename_controls;
			ctrlSetText [527, (groupid _grp_player)];
			squadname = "";
			waitUntil { (squadname != "" || squadaction == "" || !(dialog) || !(alive player)) };
			{ ctrlShow [_x, false] } foreach _rename_controls;

			if (alive player && dialog && squadname != "") then {
				_grp_player setGroupIdGlobal [squadname];
				profileNamespace setVariable ["GRLIB_group_name", squadname];
			};
			squadname = "";
		} else {
			hint "Sorry, only the Squad Leader can rename their squad.";
		};
	};

};
