_vip = [];
if (isDedicated) exitWith {_vip};

//pSikO
if (getPlayerUID player in ["76561198085724439"]) then {
	_vip = _vip + [["pSiKO", RPT_texDir + "hex.paa"]];
};

_vip;