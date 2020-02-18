params ["_unit", "_pos"];
private [ "_backpack", "_backpackcontents" ];

_backpack = backpack _unit;
if ( _backpack != "" && _backpack != "B_Parachute" ) then {
	_backpackcontents = backpackItems _unit;
	removeBackpack _unit;
	sleep 0.1;
};
_unit addBackpack "B_Parachute";
_unit setpos _pos vectorAdd [random [10,15,20], 0, 0];

sleep 4;
halojumping = false;
//waitUntil { !alive _unit || isTouchingGround _unit };
while {alive _unit && !isTouchingGround _unit} do {
	if ((getPosATL _unit) select 2 <= 50 && !(isPlayer _unit)) then {_unit allowDamage false};
	sleep 0.5;
};
removeBackpack _unit;
sleep 0.1;
if ( _backpack != "" && _backpack != "B_Parachute" ) then {
	_unit addBackpack _backpack;
	clearAllItemsFromBackpack _unit;
	{_unit addItemToBackpack _x} foreach _backpackcontents;
};
_unit allowDamage true;
_unit doFollow leader player;
