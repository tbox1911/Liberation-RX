params ["_add"];

if (_add) then {
    if (count GRLIB_player_fob_actions == 0) then {
        private _icon_grp = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
        // Squad Management
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_MANAGEMENT_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\ui\squad_management.sqf","",-760,false,true,"","call GRLIB_checkSquadMgmt"]);
        // Virtual Garage
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#0080FF'>" + localize "STR_VIRTUAL_GARAGE" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa'/>","addons\VIRT\virtual_garage.sqf","",-984,false,true,"","call GRLIB_checkGarage"]);
        // Build Menu
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#FFFF00'>" + localize "STR_BUILD_ACTION" + "</t> <img size='1' image='res\ui_build.paa'/>","scripts\client\build\open_build_menu.sqf",false,-350,false,true,"","call GRLIB_checkBuild"]);
        // Pack FOB
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#F02000'>" + localize "STR_FOB_REPACKAGE" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_repackage_fob.sqf","",-981,false,true,"","call GRLIB_checkPackFOB"]);
        // Upgrade Outpost
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#00FF8F'>" + localize "STR_UPGRADE_OUTPOST" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_upgrade_outpost.sqf","",-983,false,true,"","call GRLIB_checkUpgradeOutpost"]);
        // Destroy Outpost
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#F02000'>" + localize "STR_DESTROY_OUTPOST" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_destroy_outpost.sqf","",-984,false,true,"","call GRLIB_checkDelOutpost"]);
        // Onboard Ship
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#00206F'>" + localize "STR_ONBOARD_SHIP" + "</t> <img size='1' image='res\ui_deployfob.paa'/>",{ [] spawn do_onboard },"",-981,false,true,"","call GRLIB_checkOnboardShip"]);
        // Remove Helipad
        GRLIB_player_fob_actions pushBack (player addAction ["<t color='#FFFF00'>" + localize "STR_RECYCLE_MANAGER" + "</t> <img size='1' image='res\ui_recycle.paa'/>",{ deleteVehicle (nearestObjects [player, ["Helipad_base_F"], GRLIB_ActionDist_3] select 0) },"",-505,false,true,"","call GRLIB_checkRemoveHelipad"]);
    };
} else {
    if (count GRLIB_player_fob_actions > 0) then {
        { player removeAction _x } forEach GRLIB_player_fob_actions;
        GRLIB_player_fob_actions = [];
    };
};
