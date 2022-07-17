	params ["_state","_unit"];
	private ["_last_shooter","_got_shooted"];
	sleep 3;
	if ((isNil "last_shooter") || (isNil "got_shooted")) exitWith {};

	_last_shooter = last_shooter;
	_got_shooted = got_shooted;

	if (isNil 'tk_debug') then {tk_debug = false};

	if (tk_debug) then {
	hint (format ["last_shooter = %1, got_shooted = %2, _state = %3, _unit = %4", str _last_shooter,str _got_shooted, str _state, str _unit])
	};
	if ((_state) && (_unit == _got_shooted) && (isPlayer _last_shooter) && (side _last_shooter == west)) then {
		
		_msgBox = format ["Friendly fire from %1. Forgive?", name _last_shooter];
		if ((isPlayer _last_shooter) && (_last_shooter != _unit)) then {
			[_msgBox,_last_shooter] spawn {
				params ["_msgBox","_last_shooter"];
				_result = [_msgBox, "Confirm", true, true] call BIS_fnc_guiMessage;
				if !(_result) then {
					[getPlayerUID _last_shooter, tkill_score] remoteExec ["F_addPlayerScore", 2];
					[getPlayerUID _last_shooter, tkill_ammo] remoteExec ["F_addPlayerAmmo", 2];
					_msg= format ["You lost %1 Ammo and %2 Score for teamkilling another player.",str(tkill_ammo), str(tkill_score)] remoteExec ["hint", _last_shooter];
					
					diag_log format ["[Ammo] %1", _msg ];
				};
			}
		}
	};

	got_shooted = objNull;
	last_shooter = objNull;
