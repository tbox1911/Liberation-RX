params ["_add"];

waitUntil {sleep 0.1; !isNil "GRLIB_player_admin_actions" };
if (_add) then {
    if (count GRLIB_player_admin_actions == 0) then {
        private _icon_grp = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
        GRLIB_player_admin_actions pushBack (player addAction ["<t color='#0000F8'>" + localize "STR_ADMIN_MENU_ACTION" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Use_ca.paa'/>","scripts\client\commander\admin_menu.sqf","",999,false,true,"","call GRLIB_checkOperator"]);
        GRLIB_player_admin_actions pushBack (player addAction ["<t color='#0000F8'>" + localize "STR_ADMIN_MENU_MISSION" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Use_ca.paa'/>","scripts\client\commander\admin_menu_a3w.sqf","",998,false,true,"","call GRLIB_checkOperator"]);
        GRLIB_player_admin_actions pushBack (player addAction ["<t color='#008080'>" + localize "STR_ADMIN_CONFIGURE" + "</t> <img size='1' image='\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_saveas_ca.paa'/>",{[] spawn GRLIB_CreateParamDialog;},"",997,false,true,"","call GRLIB_checkAdmin"]);
        GRLIB_player_admin_actions pushBack (player addAction ["<t color='#FF8000'>" + localize "STR_COMMANDER_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\commander\open_permissions.sqf","",996,false,true,"","call GRLIB_checkAdmin"]);
        GRLIB_player_admin_actions pushBack (player addAction ["<t color='#FF8000'>" + localize "STR_DUMP_FOB_TEMPLATE" + "</t> <img size='1' image='res\ui_build.paa'/>","scripts\fob_templates\export_template.sqf","",995,false,true,"","call GRLIB_checkAdmin && GRLIB_player_near_fob"]);
    };
} else {
    if (count GRLIB_player_admin_actions > 0) then {
        { player removeAction _x } forEach GRLIB_player_admin_actions;
        GRLIB_player_admin_actions = [];
    };
};
