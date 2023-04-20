// Additional Key Shortcut
waitUntil {sleep 0.5;!(isNull (findDisplay 46))};

// Weapon to the back
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User10') select 0) then { [] execVM "addons\KEY\user1.sqf" };
}];

// Alway Run
// from https://forums.bohemia.net/forums/topic/205916-release-auto-run-script/
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User11') select 0) then { [] execVM "addons\KEY\user2.sqf" };
}];

// Stop running
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (!(_this select 1 in [actionKeys 'User11' select 0, actionKeys 'lookAround' select 0])) then {
		if (AR_active) then {AR_active = false};
	};
}];

// Earplug
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User12') select 0) then { [] spawn NRE_earplugs };
}];

// Toggle HUD
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User13') select 0) then {
		private _state = "ON";
		if (shownHUD select 0) then {
			showHUD [false,false,false,false,false,false,false,false,false];
			_state = "OFF";
		} else {
			showHUD [true,true,true,true,true,true,true,true,true,true];
		};
		gamelogic globalChat (format ["HUD Toggle %1.", _state]);
	};
}];

//Screenshot
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User14') select 0) then {
		_name = format ["%1_%2_%3-%4_%5.png", name player, worldname, date select 3, date select 4, round(time)];
		screenshot _name;
		gamelogic globalChat (format ["Take screenshot: %1.", _name]);
	};
}];

// LRX Diag
if ((getPlayerUID player) in GRLIB_whitelisted_steamids) then {
	(findDisplay 46) displayAddEventHandler ["KeyDown", {
		if (_this select 1 == (actionKeys 'User20') select 0) then {
			_save = 0;  // Dump savegame: 0 = no, 1 = yes
			[_save] execVM "scripts\shared\diag_debug.sqf";
			[_save, "scripts\shared\diag_debug.sqf"] remoteExec ["execVM", 2];
			gamelogic globalChat "LRX Diag called.";
		};
	}];
};