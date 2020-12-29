/*
	NRE Earplug Init
*/

waitUntil {sleep 0.5;!(isNull (findDisplay 46))};
NRE_EarplugsActive = 0;
NRE_vehvolume = 20;
NRE_earplugs = compileFinal preprocessFileLineNumbers "addons\NRE\NRE_earplugs.sqf";
//(findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == NRE_Key) then {[] spawn NRE_earplugs}"];

systemChat "-------- NRE Earplugs Initialized --------";