// Additional Key Shortcut
waitUntil {!(isNull (findDisplay 46))};

// Weapon to the back
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User1') select 0) then { [] execVM "addons\KEY\user1.sqf" };
}];

// Alway Run
// from https://forums.bohemia.net/forums/topic/205916-release-auto-run-script/
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User2') select 0) then { [] execVM "addons\KEY\user2.sqf" };
}];

// Stop running
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (!(_this select 1 in [actionKeys 'User2' select 0, actionKeys 'lookAround' select 0])) then {
		if (AR_active) then {AR_active = false};
	};
}];

// Earplug
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User3') select 0) then { [] spawn NRE_earplugs };
}];

//Screenshot
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User9') select 0) then {
		_name = format ["%1_%2_%3-%4_%5.png", name player, worldname, date select 3, date select 4, round(random [100,500,1000])];
		screenshot _name;
	};
}];