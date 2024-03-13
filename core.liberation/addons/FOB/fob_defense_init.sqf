// format: [ Text in menu, template location, price, author]

GRLIB_FOB_Defense = [
    ["From Clipboard", "", 0, "You!"],
    ["Small Defense 1", "scripts\fob_templates\defense1.sqf", 50, "-LRX-"],
    ["Small Defense 2", "scripts\fob_templates\defense2.sqf", 55, "-LRX-"],
    ["Medium Defense 1", "scripts\fob_templates\defense3.sqf", 80, "pSiKO"],
    ["(todo) Medium Defense 2", "scripts\fob_templates\defense4.sqf", 80, ""],
    ["(todo) Large Defense 1", "scripts\fob_templates\defense5.sqf", 100, ""],
    ["(todo) Large Defense 2", "scripts\fob_templates\defense6.sqf", 100, ""],
    ["Very Large Defense", "scripts\fob_templates\defense7.sqf", 200, "Max Rocka"]
];

if (GRLIB_SOG_enabled) then {
    GRLIB_FOB_Defense = GRLIB_FOB_Defense + [
        ["(todo) SOG Template", "scripts\fob_templates\defense0.sqf", 0, ""]
    ];
};

if (GRLIB_GM_enabled) then {
    GRLIB_FOB_Defense = GRLIB_FOB_Defense + [
        ["(todo) GM Template", "scripts\fob_templates\defense0.sqf", 0, ""]
    ];
};
