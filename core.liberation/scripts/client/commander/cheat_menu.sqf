waitUntil { !isNil "GRLIB_permissions" };
private [ "_dialog", "_players_array" ];

_players_array = [];
_dialog = createDialog "liberation_cheat";
waitUntil { dialog };
disableSerialization;
_ctrl = (findDisplay 5204) displayCtrl 1607;

if (!isDamageAllowed player) then {
	_ctrl ctrlSetChecked true;
} else {
	_ctrl ctrlSetChecked false;
};

waitUntil { !dialog || !(alive player) };
hintSilent "";
