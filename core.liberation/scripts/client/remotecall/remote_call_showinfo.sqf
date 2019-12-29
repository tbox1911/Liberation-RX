if ( isDedicated ) exitWith {};
params [ "_info" ];

if (count _info == 7 && (!((behaviour player) in [ "COMBAT", "STEALTH"]) || (_info select 0) find "Objective Complete" >= 0) ) then {
 _info spawn BIS_fnc_dynamicText;
};

if (count _info == 3) then {
	_info spawn BIS_fnc_infoText;
};