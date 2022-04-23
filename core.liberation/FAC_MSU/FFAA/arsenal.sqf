FFAA_arsenal= [
	"ACE_Banana"
	
];

_box = missionNamespace getVariable ["myLARsBox", objNull];
[_box, false] call ace_arsenal_fnc_initBox;
[_box, FFAA_arsenal] call ace_arsenal_fnc_addVirtualItems;
[_box, all_weapons] call ace_arsenal_fnc_addVirtualItems;
[_box, all_grenades] call ace_arsenal_fnc_addVirtualItems;
[_box, all_explosives] call ace_arsenal_fnc_addVirtualItems;
[_box, all_items] call ace_arsenal_fnc_addVirtualItems;
[_box, all_backpacks] call ace_arsenal_fnc_addVirtualItems;
[_box, player, false] call ace_arsenal_fnc_openBox;