waitUntil {!isNil "abort_loading" };
if (abort_loading) exitWith {};

if ( isNil "cinematic_camera_started" ) then { cinematic_camera_started = false };
waituntil {(time > 2) && (getClientStateNumber >= 10) && (getClientState == "BRIEFING READ")};

[] spawn cinematic_camera;

if (serverName == "DevSrv") then {
	GRLIB_introduction = false;
};

if ( GRLIB_introduction ) then {
	uisleep 2;
	cutRsc ["intro1","PLAIN",1,true];
	uisleep 2.5;
	cutRsc ["intro11","PLAIN",1,true];
	uisleep 2.5;
	cutRsc ["intro12","PLAIN",1,true];
	uisleep 2.5;
	cutRsc ["intro2","PLAIN",1,true];
	uisleep 8.5;
};

showcaminfo = true;
dostartgame = 0;
howtoplay = 0;

disableUserInput false;
disableUserInput true;
disableUserInput false;

closeDialog 0;
uisleep 1;

createDialog "liberation_menu";
waitUntil { dialog };
_noesckey = (findDisplay 5651) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
waitUntil { dostartgame == 1 || howtoplay == 1 || !dialog };
//disableUserInput true;
(findDisplay 5651) displayRemoveEventHandler ["KeyDown", _noesckey];
closeDialog 0;

if ( howtoplay == 1 ) then {
	[] call compileFinal preprocessFileLineNUmbers "scripts\client\ui\tutorial_manager.sqf";
	dostartgame = 1;
};
