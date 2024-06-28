// format: [ Text in menu, template location, price, author]

GRLIB_FOB_Defense = [];
if ([] call is_admin) then {
    GRLIB_FOB_Defense = [["From Clipboard", "", 0, "You!"]];
};
GRLIB_FOB_Defense = GRLIB_FOB_Defense + [
    ["Small Defense 1", "scripts\fob_templates\defense1.sqf", 50, "-LRX-"],
    ["Small Defense 2", "scripts\fob_templates\defense2.sqf", 55, "-LRX-"],
    ["Medium Defense 1", "scripts\fob_templates\defense3.sqf", 80, "pSiKO"],
    ["Medium Defense 2", "scripts\fob_templates\defense4.sqf", 80, "Max Rocka"],
    ["(todo) Large Defense 1", "scripts\fob_templates\defense5.sqf", 150, ""],
    ["(todo) Large Defense 2", "scripts\fob_templates\defense6.sqf", 180, ""],
    ["Very Large Defense", "scripts\fob_templates\defense7.sqf", 210, "Max Rocka"]
];

if (GRLIB_SOG_enabled) then {
    GRLIB_FOB_Defense = GRLIB_FOB_Defense + [
        ["(todo) SOG Template", "scripts\fob_templates\defense0.sqf", 999, ""]
    ];
};

if (GRLIB_GM_enabled) then {
    GRLIB_FOB_Defense = GRLIB_FOB_Defense + [
        ["(todo) GM Template", "scripts\fob_templates\defense0.sqf", 999, ""]
    ];
};

GRLIB_FOB_Defense_Sea_level = [
    "PortableHelipadLight_01_green_F",
    "Land_Cargo_Tower_V1_F"
];

{
    private _path = (_x select 1);
    if (count _path > 0) then {
	    private _objects_to_build = ([] call compile preprocessFileLineNumbers _path);
	    { fob_defenses_classnames pushBackUnique (_x select 0) } forEach _objects_to_build;
    };
} forEach GRLIB_FOB_Defense;
