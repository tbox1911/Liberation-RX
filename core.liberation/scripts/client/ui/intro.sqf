waituntil {
	titleText ["... Loading Player Data ...", "BLACK FADED", 100];
	uIsleep 1;
	titleText ["... Please Wait ...", "BLACK FADED", 100];
	uIsleep 1;
	(player getVariable ["GRLIB_score_set", 0] == 1);
};

waituntil {
	titleText ["... Building the Arsenal ...", "BLACK FADED", 100];
	uIsleep 1;
	titleText ["... Please Wait ...", "BLACK FADED", 100];
	uIsleep 1;
	(!isNil "LRX_arsenal_init_done");
};

titleText ["", "BLACK FADED", 100];
waitUntil { sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil { sleep 1; !isNil "active_sectors" };
[] spawn cinematic_camera;

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

waitUntil {
	sleep 0.1;
	( vehicle player == player && alive player && !dialog )
};

createDialog "liberation_menu";
waitUntil { dialog };

private _noesckey = (findDisplay 5651) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
private _timer = round (time + (3 * 60));
waitUntil { dostartgame == 1 || howtoplay == 1 || !dialog || time > _timer };
disableUserInput true;
(findDisplay 5651) displayRemoveEventHandler ["KeyDown", _noesckey];
closeDialog 0;

if ( howtoplay == 1 ) then {
	[] call compileFinal preprocessFileLineNumbers "scripts\client\ui\tutorial_manager.sqf";
};

cinematic_camera_started = false;
titleText ["","BLACK FADED", 100];
introDone = true;
dostartgame = 1;

waituntil {sleep 1; GRLIB_player_spawned};
10 fadeMusic 0;
sleep 10;
playMusic "";
