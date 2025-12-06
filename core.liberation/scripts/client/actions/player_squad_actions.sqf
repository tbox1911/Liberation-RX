params ["_add"];

if (_add) then {
    if (count GRLIB_player_squad_actions == 0) then {
        private _icon_grp = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
        GRLIB_player_squad_actions pushBack (player addAction ["<t color='#8080FF'>" + localize "STR_SQUAD_MOVE" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","move",-935,false,true,"","call GRLIB_checkSquad"]);
        GRLIB_player_squad_actions pushBack (player addAction ["<t color='#8080FF'>" + localize "STR_SQUAD_FOLLOW" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","follow",-935,false,true,"","call GRLIB_checkSquad"]);
        GRLIB_player_squad_actions pushBack (player addAction ["<t color='#8080FF'>" + localize "STR_SQUAD_STOP" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","stop",-935,false,true,"","call GRLIB_checkSquad"]);
        GRLIB_player_squad_actions pushBack (player addAction ["<t color='#F02000'>" + localize "STR_SQUAD_DISMISS" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","del",-935,false,true,"","call GRLIB_checkSquad"]);
    };
} else {
    if (count GRLIB_player_squad_actions > 0) then {
        { player removeAction _x } forEach GRLIB_player_squad_actions;
        GRLIB_player_squad_actions = [];
    };
};
