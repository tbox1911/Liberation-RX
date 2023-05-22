createDialog "GREUH_respawn";
waitUntil { sleep 0.1; dialog };

private _display = findDisplay 5566;
private _noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
private _labelwidth = -1;
private _labelpos = [];
private _tick = 0;
private _respawn_delay = 80;

(_display displayCtrl 677) ctrlEnable false; 	//disable restart button
(_display displayCtrl 679) ctrlEnable false; 	//disable recall button

while { dialog && alive player } do {

	if ( !isNil "public_bleedout_message" && !isNil "public_bleedout_timer") then {
		if (_labelwidth == -1) then { _labelwidth = (ctrlPosition (_display displayCtrl 6699)) select 2 };
		if (public_bleedout_timer > PAR_BleedOut) then {public_bleedout_timer = PAR_BleedOut};
		_labelpos = [ctrlPosition (_display displayCtrl 6699) select 0, ctrlPosition (_display displayCtrl 6699) select 1,_labelwidth * (public_bleedout_timer / PAR_BleedOut), ctrlPosition (_display displayCtrl 6699) select 3];
		(_display displayCtrl 6699) ctrlSetPosition _labelpos;
		ctrlSetText [5567,public_bleedout_message];

		if (public_bleedout_timer <= 30) then {
			(_display displayCtrl 5567) ctrlSetTextColor [1, 0, 0, 1];
			if ( public_bleedout_timer % 2 == 0 ) then {
				(_display displayCtrl 6698) ctrlSetTextColor [1, 0, 0, 1];
			} else {
				(_display displayCtrl 6698) ctrlSetTextColor [1, 1, 1, 1];
			}
		} else {
			(_display displayCtrl 5567) ctrlSetTextColor [1, 1, 1, 1];
		};
		(_display displayCtrl 6699) ctrlCommit 0.5;
		(_display displayCtrl 6698) ctrlCommit 0.5;

	};
	if ( _tick % 4 == 0 && _tick < _respawn_delay) then {
		ctrlSetText [677, format ["Wait %1 sec", (_respawn_delay - round(_tick))/4 ]];
	};
	if (_tick == _respawn_delay && GRLIB_endgame == 0) then {
		ctrlSetText [677, "Respawn"];
		(_display displayCtrl 677) ctrlEnable true;
	};
	if (_tick == _respawn_delay * 2) then {
		(_display displayCtrl 679) ctrlEnable true;
	};
	if ( _tick % 10 == 0 ) then {
		[ 10000 ] call BIS_fnc_bloodEffect;
	};
	if ( _tick % 50 == 0 ) then {
		private _msg = selectRandom GREUH_TipsText;
		(_display displayCtrl 678) ctrlSetStructuredText parseText format["<t size='0.8' align='center'>Tips:<br/>%1</t>", _msg];
	};
	_tick = _tick + 1;
	uiSleep 0.25;
};
_display displayRemoveEventHandler ["KeyDown", _noesckey];