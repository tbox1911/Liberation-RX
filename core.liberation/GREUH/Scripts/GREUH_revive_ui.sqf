createDialog "GREUH_respawn";
waitUntil { dialog };
private _noesckey = (findDisplay 5566) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

_labelwidth = -1;
_labelpos = [];
_tick = 0;
replace_ai = 0;
_respawn_delay = 80;
((findDisplay 5566) displayCtrl 677) ctrlEnable false; 	//disable restart button
((findDisplay 5566) displayCtrl 679) ctrlEnable false; 	//disable recall button

while { dialog && alive player } do {

	if ( !isNil "public_bleedout_message" && !isNil "public_bleedout_timer") then {
		if (_labelwidth == -1) then { _labelwidth = (ctrlPosition ((findDisplay 5566) displayCtrl 6699)) select 2 };
		if (public_bleedout_timer > PAR_BleedOut) then {public_bleedout_timer = PAR_BleedOut};
		_labelpos = [ctrlPosition ((findDisplay 5566) displayCtrl 6699) select 0, ctrlPosition ((findDisplay 5566) displayCtrl 6699) select 1,_labelwidth * (public_bleedout_timer / PAR_BleedOut), ctrlPosition ((findDisplay 5566) displayCtrl 6699) select 3];
		((findDisplay 5566) displayCtrl 6699) ctrlSetPosition _labelpos;
		ctrlSetText [5567,public_bleedout_message];

		if (public_bleedout_timer <= 30) then {
			((findDisplay 5566) displayCtrl 5567) ctrlSetTextColor [1, 0, 0, 1];
			if ( public_bleedout_timer % 2 == 0 ) then {
				((findDisplay 5566) displayCtrl 6698) ctrlSetTextColor [1, 0, 0, 1];
			} else {
				((findDisplay 5566) displayCtrl 6698) ctrlSetTextColor [1, 1, 1, 1];
			}
		} else {
			((findDisplay 5566) displayCtrl 5567) ctrlSetTextColor [1, 1, 1, 1];
		};
		((findDisplay 5566) displayCtrl 6699) ctrlCommit 0.5;
		((findDisplay 5566) displayCtrl 6698) ctrlCommit 0.5;

	};
	if ( _tick % 4 == 0 && _tick < _respawn_delay) then {
		ctrlSetText [677, format ["Wait %1 sec", (_respawn_delay - round(_tick))/4 ]];
	};
	if (_tick == _respawn_delay && GRLIB_endgame == 0) then {
		ctrlSetText [677, "Respawn"];
		((findDisplay 5566) displayCtrl 677) ctrlEnable true;
	};
	if (_tick == _respawn_delay * 2) then {
		((findDisplay 5566) displayCtrl 679) ctrlEnable true;
	};
	if ( _tick % 10 == 0 ) then {
		[ 10000 ] call BIS_fnc_bloodEffect;
	};
	if ( _tick % 50 == 0 ) then {
		_msg = selectRandom GREUH_TipsText;
		((findDisplay 5566) displayCtrl 678) ctrlSetStructuredText parseText format["<t size='0.8' align='center'>Tips:<br/>%1</t>", _msg];
	};
	_tick = _tick + 1;
	uiSleep 0.25;
};
(findDisplay 5566) displayRemoveEventHandler ["KeyDown", _noesckey];