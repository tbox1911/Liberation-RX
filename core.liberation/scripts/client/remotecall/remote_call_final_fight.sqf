if (isDedicated || (!hasInterface && !isServer)) exitWith {};

private _msg = format ["%1, the <t color='#800000'>ARMAGEDDON</t> has begun...<br/><br/>Be ready for the <t color='#000080'>Final FIGHT</t> !<br/>", name player];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
sleep 3;

[1] spawn BIS_fnc_earthquake;

waitUntil { sleep 1; !isNil "opfor_target"};
waitUntil { sleep 1; sector_timer > 0};

// GUI
private _final_progressBar = findDisplay 46 ctrlCreate ["GREUH_Progress", -1];
private _position = [ 0.3, 0.1 + safeZoneY, 0.4, 0.05];
_final_progressBar ctrlSetPosition _position;
_final_progressBar progressSetPosition 0;
_final_progressBar ctrlCommit 0;

private _final_text = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
_final_text ctrlSetPosition _position;
_final_text ctrlSetStructuredText parseText format["<t size='1' align='center'>Enemy Damage: %1%2</t>", 0, "%"];
_final_text ctrlCommit 0;

private _progress = damage opfor_target;
while {sector_timer > 0 && _progress < 1} do {
	_progress = damage opfor_target;
	_final_progressBar progressSetPosition _progress;
	_final_text ctrlSetStructuredText parseText format["<t size='1' align='center'>Enemy Damage: %1%2</t>", round(100*_progress), "%"];
	sleep 2;
};

ctrlDelete _final_progressBar;
ctrlDelete _final_text;

// Mission failed
if (sector_timer <= 0) then {
	disableUserInput true;
	player allowDamage false;
	closeDialog 0;
	if (lifestate player == "INCAPACITATED") then {
		"colorCorrections" ppEffectEnable false;
		"filmGrain" ppEffectEnable false;
	};

	cinematic_camera_started = true;
	sector_timer = 0;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;

	camUseNVG false;
	showCinemaBorder false;
	_startpos0 = [ 0, 500, 3000];
	_startpos1 = [ 0, 500, 250];
	_endpos1 = [ 0, 450, 225];
	_startpos2 = [ 0, 100, 40];
	_endpos2 = [ 0, 80, 30];
	_startpos3 = [ 0, 8, 2.8];
	_endpos3 = [ 0, 6, 2.25];

	_spawn_camera = "camera" camCreate _startpos0;
	_spawn_camera cameraEffect ["internal","front"];
	_spawn_camera camSetTarget opfor_target;
	_spawn_camera camSetRelPos _startpos0;
	_spawn_camera camcommit 0;
	_spawn_camera camSetRelPos _startpos1;
	_spawn_camera camcommit 0.5;
	waitUntil { camCommitted _spawn_camera };

	_spawn_camera camSetRelPos _endpos1;
	_spawn_camera camcommit 1.75;
	waitUntil { camCommitted _spawn_camera };

	_spawn_camera camSetRelPos _startpos2;
	_spawn_camera camcommit 0.25;
	waitUntil { camCommitted _spawn_camera };

	_spawn_camera camSetRelPos _endpos2;
	_spawn_camera camcommit 1.75;
	waitUntil { camCommitted _spawn_camera };

	_spawn_camera camSetRelPos _startpos3;
	_spawn_camera camcommit 0.25;
	waitUntil { camCommitted _spawn_camera };

	_spawn_camera camSetRelPos _endpos3;
	_spawn_camera camcommit 1.75;
	waitUntil { camCommitted _spawn_camera };

	_spawn_camera camSetRelPos [0,0.4,10];
	_spawn_camera camcommit 2;
	waitUntil { camCommitted _spawn_camera };

	waitUntil { sleep 1; isObjectHidden opfor_target };
	sleep 1;

	_spawn_camera camSetRelPos _startpos1;
	_spawn_camera camcommit 5;
	waitUntil { camCommitted _spawn_camera };

	sleep 3;
	[opfor_target] execVM "addons\NUKE\nuke.sqf";
	_id1 = playSoundUI [getMissionPath "res\nuke.ogg", 5];
	sleep 6;

	_spawn_camera camSetRelPos [ 0, 2000, 400];
	_spawn_camera camcommit 22;
	_id2 = playSoundUI [getMissionPath "res\nuke.ogg", 5];
	sleep 15;
	//waitUntil { camCommitted _spawn_camera };

	playSoundUI  ["\a3\Music_F_Oldman\music\radio\rock\Track_R_11.ogg", 1];
	titleText [localize "STR_MISSION3_FAILED" ,"BLACK", 5];

	waitUntil { camCommitted _spawn_camera };
	sleep 10;

	_spawn_camera cameraEffect ["Terminate","back"];
	camDestroy _spawn_camera;
	camUseNVG false;

	endMission "LOSER";
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
	player allowDamage true;

	"colorCorrections" ppEffectEnable false; // disable effect
	"filmGrain" ppEffectEnable false; // disable effect
};
