if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_title", "_sub", "_picture", "_text", "_titleColor"];

private _subtitle = _sub call BIS_fnc_localize;
private _formated_text = "";

if (GRLIB_fancy_info == 2) then {
	
	if (typeName _text == "ARRAY") then {
		_formated_text = format [(_text select 0) call BIS_fnc_localize, _text select 1, _text select 2];
	} else {
		_formated_text = _text;
	};

	_msg = format [
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
	_info = [_msg, 0, 0, 6, 0, -1, 90];
	if (!((behaviour player) in [ "COMBAT", "STEALTH"]) || _title find "Objective Complete" >= 0) then {
		_info spawn BIS_fnc_dynamicText;
	};
} else {
	_info = [
		format ["%1", _title],
		"",
		format ["%1", _subtitle]
	];
	_info spawn BIS_fnc_infoText;
};
