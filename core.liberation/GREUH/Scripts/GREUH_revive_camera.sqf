revive_ui = compile preprocessFileLineNumbers "GREUH\scripts\GREUH_revive_ui.sqf";

closeDialog 0;
closeDialog 0;
closeDialog 0;

sleep 1;

while { true } do {
	waitUntil {sleep 0.5; ( player getVariable ["GREUH_isUnconscious",0]) == 1 };

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
	waitUntil { dialog };
	_noesckey = (findDisplay 5651) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
	_randomsound1 = selectRandom [3,4,5,6,7,8,9];
	_randomsound2 = selectRandom [1,2,3];
	_deathsound = format ["A3\sounds_f\characters\human-sfx\P0%1\hit_max_%2.wss",_randomsound1,_randomsound2];
	playSound3D [_deathsound, player, false, getPosASL player, 1, 1, 0];
	sleep 3.5;

	titleText ["" ,"BLACK IN", 3];

	"filmGrain" ppEffectAdjust [0.3, 2, 4, 0.5, 0.5, true];
	"filmGrain" ppEffectCommit 0;
	"filmGrain" ppEffectEnable TRUE;

	"colorCorrections" ppEffectAdjust [1, 1.6, -0.35, [1, 1, 1, 0], [1, 1, 1, 0], [0.75, 0.25, 0, 1.0]];
	"colorCorrections" ppEffectCommit 0;
	"colorCorrections" ppEffectEnable TRUE;

	_cam camCommit 0;

	_cam camSetPos _destpos;

	_cam camCommit 900;

	waitUntil {sleep 0.5; ((player getVariable ["GREUH_isUnconscious",0]) == 0) || ((player getVariable ["PAR_isUnconscious", 0]) == 1) };
	closeDialog 0;
	waitUntil {!dialog};
	if ((player getVariable "GREUH_isUnconscious") != 0) then {
		[] spawn revive_ui;
		waitUntil {dialog};
	};
	waitUntil {sleep 0.5; ( player getVariable ["PAR_isUnconscious", 0] ) == 0 || !alive player || !dialog };
	player setVariable ["GREUH_isUnconscious", 0, true];
	closeDialog 5566;
	"colorCorrections" ppEffectEnable FALSE;
	"filmGrain" ppEffectEnable FALSE;
	_cam cameraEffect ["Terminate", "BACK"];
	camDestroy _cam;
	camUseNVG false;
	(findDisplay 5651) displayRemoveEventHandler ["KeyDown", _noesckey];
};