if (isDedicated || (!hasInterface && !isServer)) exitWith {};
if (GRLIB_endgame == 1) exitWith {};

params ["_title", "_sub", "_picture", "_text", "_titleColor"];

private _subtitle = _sub call BIS_fnc_localize;
private _formated_text = "";
private _safe_display = true;

private _sector = [GRLIB_sector_size, player] call F_getNearestSector;
if (_sector in opfor_sectors + active_sectors) then { _safe_display = false };
if ((behaviour player) in ["COMBAT", "STEALTH"]) then { _safe_display = false };
if (_sector in A3W_sectors_in_use) then { _safe_display = true };

if (GRLIB_fancy_info == 2 && _safe_display) then {
	if (typeName _text == "ARRAY") then {
		_formated_text = format [(_text select 0) call BIS_fnc_localize, _text select 1, _text select 2];
	} else {
		_formated_text = _text call BIS_fnc_localize;
	};
	private _msg = format [
		"<t color='%5' shadow='2' size='1.75'>%1</t><br/>" +
		"<t color='%5'>--------------------------------</t><br/>" +
		(if (_subtitle != "") then { "<t size='1.25'>%2</t><br/>" } else { "" }) +
		(if (_picture != "") then { "<img size='5' image='%3'/><br/>" } else { "" }) +
		"%4",
		_title,
		_subtitle,
		_picture,
		_formated_text,
		_titleColor
	];
	[_msg, 0, 0, 6, 0, -1, 90] spawn BIS_fnc_dynamicText;
} else {
	waitUntil { sleep 0.5; (isNil {uinamespace getvariable ["BIS_InfoText", nil]}) };
	private _info = [
		format ["%1", _title],
		"",
		format ["%1", _subtitle]
	];
	_info spawn BIS_fnc_infoText;
};
