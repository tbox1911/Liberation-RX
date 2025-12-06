params ["_add"];

if (_add) then {
    if (count GRLIB_player_dog_actions == 0) then {
        private _icon_dog = (getText (configFile >> "CfgVehicleIcons" >> "iconAnimal"));
        GRLIB_player_dog_actions pushBack (player addAction ["<t color='#00AA00'>" + localize "STR_DOG_PET" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","pet",-639,true,true,"","call GRLIB_check_DogClose"]);
        GRLIB_player_dog_actions pushBack (player addAction ["<t color='#FF8000'>" + localize "STR_DOG_FIND" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","find",-640,false,true,"","call GRLIB_check_DogRelax"]);
        GRLIB_player_dog_actions pushBack (player addAction ["<t color='#FF8000'>" + localize "STR_DOG_FIND_GUN" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","find_gun",-640,false,true,"","call GRLIB_check_DogRelax"]);
        GRLIB_player_dog_actions pushBack (player addAction ["<t color='#FF8000'>" + localize "STR_DOG_PATROL" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","patrol",-640,false,true,"","call GRLIB_check_DogRelax"]);
        GRLIB_player_dog_actions pushBack (player addAction ["<t color='#FF8000'>" + localize "STR_DOG_RECALL" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","recall",-640,false,true,"","call GRLIB_check_DogOnDuty"]);
        GRLIB_player_dog_actions pushBack (player addAction ["<t color='#FF8000'>" + localize "STR_DOG_STOP" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","stop",-641,false,true,"","call GRLIB_check_DogRelax"]);
        GRLIB_player_dog_actions pushBack (player addAction ["<t color='#F02000'>" + localize "STR_DOG_DISMISS" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","del",-642,false,true,"","call GRLIB_check_Dog && GRLIB_player_near_fob"]);
    };
} else {
    if (count GRLIB_player_dog_actions > 0) then {
        { player removeAction _x } forEach GRLIB_player_dog_actions;
        GRLIB_player_dog_actions = [];
    };
};