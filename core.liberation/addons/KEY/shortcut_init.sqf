// Additional Key Shortcut
waitUntil {!(isNull (findDisplay 46))};

// Weapon to back
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User1') select 0) then {
		if (currentWeapon player != "") then {
			player action ['SWITCHWEAPON',player,player,-1];
		};
	};
}];

// Alway run
// from https://forums.bohemia.net/forums/topic/205916-release-auto-run-script/
(findDisplay 46) displayAddEventHandler ["KeyDown", {
    if (_this select 1 == (actionKeys 'User2') select 0) then {
		if (isNil "AR_active") then {AR_active = false};
 		if (AR_active) exitWith {AR_active = false};
		if ((!isNull objectParent player) || (surfaceIsWater (getPos player)) ||
		   (lifeState player == 'incapacitated') || (!isNull R3F_LOG_joueur_deplace_objet) ) exitWith {};

		AR_active = true;
		AR_weapon = currentWeapon player;
		AR_animation = switch (true) do {
			case (AR_weapon isEqualTo ""): {"AmovPercMevaSnonWnonDf"};
			case (AR_weapon isEqualTo (handgunWeapon player)): {"AmovPercMevaSlowWpstDf"};
			case (AR_weapon isEqualTo (primaryWeapon player)): {"AmovPercMevaSlowWrflDf"};
			case (AR_weapon isEqualTo (secondaryWeapon player)): {"AmovPercMevaSlowWlnrDf"};
			default {"AmovPercMevaSnonWnonDf"};
		};

		player addEventHandler ["AnimDone", {
			if ((!AR_active) || dialog || {!((currentWeapon player) isEqualTo AR_weapon)} ||
			   {!isNull objectParent player} || {surfaceIsWater (getPos player)} ||
			   (_this select 1 == AR_animation && speed (vehicle player) <= 0) ||
			   (lifeState player == 'incapacitated')) exitWith {
					player removeEventHandler ["AnimDone", _thisEventHandler];
					AR_active = false;
					AR_weapon = nil;
					AR_animation = nil;
			};
			player playMoveNow AR_animation;
		}];
		player playMoveNow AR_animation;
	};
}];

// Stop running
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (!(_this select 1 in [actionKeys 'User2' select 0, actionKeys 'lookAround' select 0])) then {
		if (AR_active) then {AR_active = false};
	};
}];

// earplug
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this select 1 == (actionKeys 'User3') select 0) then { [] spawn NRE_earplugs };
}];