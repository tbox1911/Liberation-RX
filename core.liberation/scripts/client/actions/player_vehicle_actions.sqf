params ["_add"];

if (_add) then {
    if (count GRLIB_player_vehicle_actions == 0) then {
        // Juke Box
        GRLIB_player_vehicle_actions pushBack (player addAction ["<t color='#ffffff'>" + localize "STR_JKB_ACTION" + "</t>","addons\JKB\fn_openJukeBox.sqf","",0,false,true,"","!(isNull objectParent player)"]);
        // Fast Eject Crew
        GRLIB_player_vehicle_actions pushBack (player addAction ["<t color='#0080F0'>" + localize "STR_EJECT_CREW" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_eject.sqf","",999,false,true,"","call GRLIB_checkEjectCrew"]);
        // Fast Onboard Crew
        GRLIB_player_vehicle_actions pushBack (player addAction ["<t color='#0080F0'>" + localize "STR_ONBOARD_CREW" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_onboard_crew.sqf","",998,false,true,"","call GRLIB_checkOnboardCrew"]);
        // Build Water FOB
        GRLIB_player_vehicle_actions pushBack (player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_ACTION" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_build_fob.sqf","",981,false,true,"","call GRLIB_checkBuildFOBWater"]);
    };
} else {
    if (count GRLIB_player_vehicle_actions > 0) then {
        { player removeAction _x } forEach GRLIB_player_vehicle_actions;
        GRLIB_player_vehicle_actions = [];
    };
};
