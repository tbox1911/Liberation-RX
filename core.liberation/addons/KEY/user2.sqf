// Alway Run

if (player getVariable ["GRLIB_action_inuse", false]) exitWith {};
if (isNil "AR_active") then {AR_active = false};
if (AR_active) exitWith {AR_active = false};
if ((!isNull objectParent player) || (surfaceIsWater (getPos player)) || (lifeState player == 'INCAPACITATED') || PAR_isDragging ) exitWith {};

// player carring 
private _carry = false;
if (!isNull R3F_LOG_joueur_deplace_objet) then { _carry = true };
if (!isNull ((player getVariable ["ace_dragging_carriedObject", objNull]))) then { _carry = true };

AR_active = true;
AR_weapon = currentWeapon player;
AR_animation = switch (true) do {
	case (_carry): {"AmovPercMwlkSnonWnonDf"};
	case (AR_weapon isEqualTo ""): {"AmovPercMevaSnonWnonDf"};
	case (AR_weapon isEqualTo (handgunWeapon player)): {"AmovPercMevaSlowWpstDf"};
	case (AR_weapon isEqualTo (primaryWeapon player)): {"AmovPercMevaSlowWrflDf"};
	case (AR_weapon isEqualTo (secondaryWeapon player)): {"AmovPercMevaSlowWlnrDf"};
	default {"AmovPercMevaSnonWnonDf"};
};

waitUntil {sleep 0.2; !(isSwitchingWeapon player)};
player addEventHandler ["AnimDone", {
	if ((!AR_active) || dialog || {!((currentWeapon player) isEqualTo AR_weapon)} ||
		{!isNull objectParent player} || {surfaceIsWater (getPos player)} ||
		(_this select 1 == AR_animation && speed vehicle player <= 0) ||
		(lifeState player == 'INCAPACITATED')) exitWith {
			player removeEventHandler ["AnimDone", _thisEventHandler];
			AR_active = false;
			AR_weapon = nil;
			AR_animation = nil;
	};
	player playMoveNow AR_animation;
}];
if (!isNil "AR_animation") then { player playMoveNow AR_animation };
