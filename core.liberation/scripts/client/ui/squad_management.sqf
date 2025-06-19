private _selection = 0;
private _selectedmember = objNull;
private _rename_controls = [521,522,523,524,525,526,527];
private _button_controls = [210,211,212,215,217];
private _update = false;

createDialog "liberation_squad";
waitUntil { dialog };

{ ctrlShow [_x, false] } foreach _rename_controls;
GRLIB_Squad_target = "Sign_Sphere100cm_F" createVehicleLocal [ 0, 0, 0 ];
hideObject GRLIB_Squad_target;
GRLIB_Squad_camera = "camera" camCreate (getpos player);
GRLIB_Squad_camera cameraEffect ["internal","back", "rtt"];
GRLIB_Squad_camera camSetTarget GRLIB_Squad_target;
GRLIB_Squad_camera camcommit 0;
"rtt" setPiPEffect [0];

{ ctrlEnable [_x, false] } forEach _button_controls;

// LikeMe Button disabled
if (GRLIB_filter_arsenal == 4) then { _button_controls = _button_controls - [215] };

// Arsenal Button disabled
if (GRLIB_enable_arsenal == 0) then { _button_controls = _button_controls - [212] };

// Squad list
private _squad_list = [player] + PAR_AI_bros;

// Create unit list
lbClear 101;
private _unitname= "";
private _membercount = 0;
{
	_unitname = format ["%1. %2", [ _x ] call F_getUnitPositionId, name _x];
	lbAdd [101, _unitname];
	_membercount = _membercount + 1;
} foreach _squad_list;

lbSetCurSel [101, 0];

while { dialog && alive player && _membercount > 0 } do {
	_update = false;
	GRLIB_squadaction = -1;
	private _old_selection = -1;
	waitUntil {
		_selection = lbCurSel 101;
		_selectedmember = _squad_list select _selection;
		if (_selection != _old_selection) then {
			if (_selection == 0 || [_selectedmember] call PAR_is_wounded) then {
				{ ctrlEnable [_x, false] } forEach _button_controls;
			} else {
				{ ctrlEnable [_x, true] } forEach _button_controls;
			};
			_old_selection = _selection;
		};
		sleep 0.2;
		(!dialog || !(alive player) || GRLIB_squadaction != -1);
	};
	if !(dialog) exitWith {};
	if !(alive player) exitWith {};

	// Promote
	if ( GRLIB_squadaction == 1 ) then {
		ctrlEnable [210, false];
		private _ai_rank = (GRLIB_rank_level find (rank _selectedmember));
		private _pl_rank = (GRLIB_rank_level find (rank player));
		private _ai_score = _selectedmember getVariable ["PAR_AI_score", nil];
		if (!isNil "_ai_score") then {
			if (_ai_rank < (_pl_rank - 1)) then {
				private _cost = (_ai_score * 17);
				private _msg = format [localize "STR_UI_PROMOTE_CONFIRM",name _selectedmember,_cost];
				private _result = [_msg, localize "STR_UI_WARNING_TITLE", true, true] call BIS_fnc_guiMessage;
				if (_result) then {
					if (!([_cost] call F_pay)) exitWith {};
					_selectedmember setVariable ["PAR_AI_score", 0];
					hint localize 'STR_PROMOTE_OK';
					waitUntil {sleep 0.3; _selectedmember getVariable ["PAR_AI_score", 0] !=0 };
				};
			} else {
				hint localize 'STR_PROMOTE_KO';
			};
		};
		sleep 0.5;
		ctrlEnable [210, true];
	};

	// Delete
	if (GRLIB_squadaction == 2) then {
		ctrlEnable [211, false];
		private _msg = format [localize "STR_UI_DELETE_MEMBER_CONFIRM",rank _selectedmember,name _selectedmember];
		private _result = [_msg, localize "STR_UI_WARNING_TITLE", true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			private _ai_rank = 1 + (GRLIB_rank_level find (rank _selectedmember));
			private _refund = [_selectedmember] call F_loadoutPrice;
			if (_ai_rank > 1 ) then {
				_refund = round (_refund * (_ai_rank * 0.7));
			};
			[player, _refund, 0] remoteExec ["ammo_add_remote_call", 2];
			playSound "taskSucceeded";
			if (_ai_rank > 1 ) then {
				gamelogic globalChat format [localize "STR_LOG_SOLDIER_REFUND_RANKED",_refund,_ai_rank];
			} else {
				gamelogic globalChat format [localize "STR_LOG_SOLDIER_REFUND_SIMPLE",_refund];
			};
			PAR_AI_bros = PAR_AI_bros - [_selectedmember];
			deleteVehicle _selectedmember;
			hint localize 'STR_REMOVE_OK';
			_update = true;
		};
		sleep 0.5;
		ctrlEnable [211, true];
	};

	// Arsenal
	if (GRLIB_squadaction == 3) then {
		closeDialog 0;
		[_selectedmember] spawn {
			params ["_unit"];
			titleText ["", "BLACK FADED", 1];
			sleep 0.5;
			private _oldprice = [_unit] call F_loadoutPrice;
			private _oldstuff = getUnitLoadout _unit;
			["Open", [false, myLARsBox, _unit]] call BIS_fnc_arsenal;
			titleText ["" ,"BLACK IN", 3];
			waitUntil { sleep 0.5; isNull (uiNameSpace getVariable ["BIS_fnc_arsenal_cam", objNull])};
			[_unit] call F_filterLoadout;
			private _newprice = [_unit] call F_loadoutPrice;
			private _cost = 0 max (_newprice - _oldprice);
			if (!([_cost] call F_pay)) then {
				waitUntil {sleep 0.1; !(isSwitchingWeapon _unit)};
				_unit setUnitLoadout _oldstuff;
			};
		};
	};

	// Like Me
	if (GRLIB_squadaction == 4) then {
		ctrlEnable [215, false];
		if ((player distance _selectedmember) < 30) then {
			private _price_ai = [_selectedmember] call F_loadoutPrice;
			private _price = [player] call F_loadoutPrice;
			private _cost = 0 max (_price - _price_ai);
			if ([_cost] call F_pay) then {
				waitUntil {sleep 0.1; !(isSwitchingWeapon _selectedmember)};
				_selectedmember setUnitLoadout (getUnitLoadout player);
				hintSilent format [localize "STR_HINT_LOADOUT_COPIED", _cost];
				lbSetCurSel [101, _selection];
			};
		} else {
			hintSilent localize "STR_HINT_UNIT_TOO_FAR";
		};
		sleep 0.5;
		ctrlEnable [215, true];
	};

	// Rename
	if (GRLIB_squadaction == 5) then {
		ctrlEnable [217, false];
		unitname = "";
		_name = name _selectedmember;
		{ ctrlShow [_x, true] } foreach _rename_controls;
		ctrlSetText [527, _name];
		waitUntil {uiSleep 0.1; ((GRLIB_squadaction == -1) || (unitname != "") || !(dialog) || !(alive player)) };

		if (unitname != "") then {
			_p2 = (unitname splitString " ") select 0;
			_p1 = (unitname splitString " ") select 1;
			if (isNil "_p1") then {_p1 = ""};
			_selectedmember setName [unitname, _p1, _p2];
			gamelogic globalChat format [localize "STR_LOG_UNIT_RENAMED",_name,unitname];
		};
		{ ctrlShow [_x, false] } foreach _rename_controls;
		sleep 0.5;
		ctrlEnable [217, true];
		_update = true;
	};

	// Update unit list
	if (_update) then {
		_squad_list = [player] + PAR_AI_bros;
		_membercount = 0;
		lbClear 101;
		{
			_unitname = format ["%1. %2", [ _x ] call F_getUnitPositionId, name _x];
			lbAdd [101, _unitname];
			_membercount = _membercount + 1;
		} foreach _squad_list;
		lbSetCurSel [101, _selection];
	};
};

closeDialog 0;
"spawn_marker" setMarkerPosLocal markers_reset;
GRLIB_Squad_camera cameraEffect ["terminate","back"];
camDestroy GRLIB_Squad_camera;
deleteVehicle GRLIB_Squad_target;
uiSleep 3;
hintSilent "";