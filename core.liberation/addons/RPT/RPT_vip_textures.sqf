_vip = [];
if (isDedicated) exitWith {_vip};

//pSikO
if (getPlayerUID player in ["76561198085724439"]) then {
	_vip = _vip + [["pSiKO", RPT_texDir + "hex.paa"]];
};
// Barbare
if (getPlayerUID player in ["76561198085724439", "76561198098904932"]) then {
	_vip = _vip + [["Barbare", RPT_texDir + "hellokitty.paa"]];
};
// Raven
if (getPlayerUID player in ["76561198085724439", "76561198017505587"]) then {
	_vip = _vip + [["Raven", RPT_texDir + "raven.paa"]];
};
// Christophe
if (getPlayerUID player in ["76561198085724439", "76561198299706821"]) then {
	_vip = _vip + [["Christophe", RPT_texDir + "camo_chris.paa"]];
};
// Taz
if (getPlayerUID player in ["76561198085724439", "76561198108847768"]) then {
	_vip = _vip + [["taz4933_fr", RPT_texDir + "abstraitrouge.paa"]];
};

_vip;