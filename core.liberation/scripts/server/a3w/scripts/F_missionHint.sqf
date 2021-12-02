// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: missionHint.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

private ["_title", "_subTitle", "_picture", "_text", "_titleColor", "_info"];

_title = param [0, "?"];
_subtitle = param [1, ""];
_picture = param [2, "", [""]];
_text = param [3, ""];
_titleColor = param [4, "", [""]];

if (GRLIB_fancy_info == 2) then {
	_msg = format [
		"<t color='%5' shadow='2' size='1.75'>%1</t><br/>" +
		"<t color='%5'>--------------------------------</t><br/>" +
		(if (_subtitle != "") then { "<t size='1.25'>%2</t><br/>" } else { "" }) +
		(if (_picture != "") then { "<img size='5' image='%3'/><br/>" } else { "" }) +
		"%4",
		_title,
		_subtitle,
		_picture,
		_text,
		_titleColor
	];
	_info = [_msg, 0, 0, 6, 0, -1, 90];
} else {
	_info = [
		format ["%1", _title],
		"",
		format ["%1", _subtitle]
	];
};
[_info] remoteExec ["remote_call_showinfo", 0];
