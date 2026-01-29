// format: [ Text in menu, template location, price, author]

GRLIB_FOB_Defense = [];
if ([] call is_admin) then {
    GRLIB_FOB_Defense = [["From Clipboard", "", 0, "You!"]];
};
GRLIB_FOB_Defense = GRLIB_FOB_Defense + [
    ["Small Defense 1", "scripts\fob_templates\defense1.sqf", 50, "-LRX-"],
    ["Small Defense 2", "scripts\fob_templates\defense2.sqf", 55, "-LRX-"],
    ["Medium Defense 1 - Square A", "scripts\fob_templates\defense3.sqf", 80, "pSiKO"],
    ["Medium Defense 2 - Square B", "scripts\fob_templates\defense4.sqf", 80, "Max Rocka"],
    ["Medium Defense 3 - type A", "scripts\fob_templates\z-medium3.sqf", 80, "Z@Warrior"],
    ["Medium Defense 4 - type D", "scripts\fob_templates\z-medium4.sqf", 80, "Z@Warrior"],
    ["Large Defense 1 - Lockhart", "scripts\fob_templates\z-large-lockhart.sqf", 180, "Z@Warrior"],
    ["Large Defense 2 - Vauban", "scripts\fob_templates\z-large-vauban.sqf", 180, "Z@Warrior"],
    ["Large Defense 3 - Trap", "scripts\fob_templates\sinpi_large_trap.sqf", 170, "sinpi"],
    // ["(todo) Large Defense 1", "scripts\fob_templates\defense5.sqf", 150, ""],
    // ["(todo) Large Defense 2", "scripts\fob_templates\defense6.sqf", 180, ""],
    ["Very Large Defense 1", "scripts\fob_templates\defense7.sqf", 310, "Max Rocka"]
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
    "Land_ControlTower_01_F",
    "Land_Cargo_Patrol_V1_F",
    "Land_Cargo_House_V1_F",
    "Land_Cargo_Tower_V1_F"
];

private _defenses_blacklist = [] + GRLIB_recycleable_blacklist + all_friendly_classnames + all_hostile_classnames;
fob_defenses_classnames = [];
{
    private _path = (_x select 1);
    if (count _path > 0) then {
	    private _objects_to_build = ([] call compile preprocessFileLineNumbers _path);
	    {
            _class = (_x select 0);
            if !(_class in _defenses_blacklist) then {
                fob_defenses_classnames pushBackUnique _class;
            } else {
                diag_log format ["--- LRX Defense filter: in %1 - object %2 rejected!", _path, _class];
            };
        } forEach _objects_to_build;
    };
} forEach GRLIB_FOB_Defense;
