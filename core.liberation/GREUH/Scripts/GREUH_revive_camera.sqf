waitUntil {sleep 1; GRLIB_player_spawned};
revive_ui = compileFinal preprocessFileLineNumbers "GREUH\scripts\GREUH_revive_ui.sqf";
count_death = 1;
private ["_pos", "_destpos", "_cam", "_noesckey"];

while { true } do {
	waitUntil {sleep 0.5; (player getVariable ["GREUH_isUnconscious", 0]) == 1};
	closeDialog 0;
	waitUntil {!dialog};

	//_camobj = player;
	_pos = positionCameraToWorld [0,0,-0.2];
	_destpos = [getpos player select 0, getpos player select 1, (getpos player select 2) + 150];
	_cam = "camera" camCreate _pos;
	_cam cameraEffect ["internal", "BACK"];
	_cam camSetFOV 1.0;
	showCinemaBorder false;
	if ( (date select 3) < 4 || (date select 3) >= 20 ) then { camUseNVG true; } else { camUseNVG false; };
	//_cam camSetTarget _camobj;   //follow player
	_cam camSetTarget getpos player;	//static view

	createDialog "deathscreen";
	waitUntil { sleep 0.1; dialog };
	_noesckey = (findDisplay 5651) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

	[player] call F_deathSound;
	uiSleep 3.5;

	titleText ["" ,"BLACK IN", 3];

	"filmGrain" ppEffectAdjust [0.3, 2, 4, 0.5, 0.5, true];
	"filmGrain" ppEffectCommit 0;
	"filmGrain" ppEffectEnable true;

	"colorCorrections" ppEffectAdjust [1, 1.6, -0.35, [1, 1, 1, 0], [1, 1, 1, 0], [0.75, 0.25, 0, 1.0]];
	"colorCorrections" ppEffectCommit 0;
	"colorCorrections" ppEffectEnable true;

	_cam camCommit 0;
	_cam camSetPos _destpos;
	_cam camCommit 900;
	uiSleep 2;

	closeDialog 0;
	waitUntil {!dialog};

	[] spawn revive_ui;
	waitUntil {sleep 0.5; (player getVariable ["PAR_isUnconscious", 1]) == 0 || !alive player };
	closeDialog 5566;
	player setVariable ["GREUH_isUnconscious", 0];

	"colorCorrections" ppEffectEnable FALSE;
	"filmGrain" ppEffectEnable FALSE;
	_cam cameraEffect ["Terminate", "BACK"];
	camDestroy _cam;
	camUseNVG false;
	(findDisplay 5651) displayRemoveEventHandler ["KeyDown", _noesckey];
};