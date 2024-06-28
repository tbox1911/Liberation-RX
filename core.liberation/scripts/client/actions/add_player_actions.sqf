private _icon_dog = (getText (configFile >> "CfgVehicleIcons" >> "iconAnimal"));
private _icon_grp = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
private _icon_tuto = "\a3\ui_f\data\map\markers\handdrawn\unknown_ca.paa";

// Tuto
player addAction ["<t color='#80FF80'>" + localize "STR_TUTO_ACTION" + "</t> <img size='1' image='" + _icon_tuto + "'/>","[] execVM 'scripts\client\ui\tutorial_manager.sqf'","",-740,false,true,"","(_target distance2D lhd < GRLIB_fob_range)"];

// Admin Menu
player addAction ["<t color='#0000F8'>" + localize "STR_ADMIN_MENU" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Use_ca.paa'/>","scripts\client\commander\admin_menu.sqf","",999,false,true,"","call GRLIB_checkOperator"];
player addAction ["<t color='#008080'>-- CONFIGURE MISSION</t> <img size='1' image='\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_saveas_ca.paa'/>","scripts\client\commander\open_params.sqf","",998,false,true,"","call GRLIB_checkAdmin"];
player addAction ["<t color='#FF8000'>" + localize "STR_COMMANDER_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\commander\open_permissions.sqf","",997,false,true,"","call GRLIB_checkCommander"];
player addAction ["<t color='#FF8000'>-- DUMP FOB TEMPLATE </t> <img size='1' image='res\ui_build.paa'/>","scripts\fob_templates\export_template.sqf","",996,false,true,"","call GRLIB_checkCommander && GRLIB_player_near_fob"];

// Extended Options
player addAction ["<t color='#FF8000'>" + localize "STR_EXTENDED_OPTIONS" + "</t>","GREUH\scripts\GREUH_dialog.sqf","",-999,false,true];

// Juke Box
player addAction ["<t color='#ffffff'>" + localize "STR_JKB_ACTION" + "</t>","addons\JKB\fn_openJukeBox.sqf","",0,false,true,"","!(isNull objectParent player)"];

// Dog - Actions
player addAction ["<t color='#FF8000'>" + localize "STR_DOG_FIND" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","find",-640,false,true,"","call GRLIB_check_Dog && call GRLIB_check_DogRelax"];
player addAction ["<t color='#FF8000'>" + localize "STR_DOG_FIND_GUN" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","find_gun",-640,false,true,"","call GRLIB_check_Dog && call GRLIB_check_DogRelax"];
player addAction ["<t color='#FF8000'>" + localize "STR_DOG_PATROL" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","patrol",-640,false,true,"","call GRLIB_check_Dog && call GRLIB_check_DogRelax"];
player addAction ["<t color='#FF8000'>" + localize "STR_DOG_RECALL" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","recall",-640,false,true,"","call GRLIB_check_Dog && call GRLIB_check_DogOnDuty"];
player addAction ["<t color='#FF8000'>" + localize "STR_DOG_STOP" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","stop",-641,false,true,"","call GRLIB_check_Dog && call GRLIB_check_DogRelax"];
player addAction ["<t color='#F02000'>" + localize "STR_DOG_DISMISS" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","del",-642,false,true,"","call GRLIB_check_Dog && call GRLIB_check_Dog"];

// Squad - Actions
player addAction ["<t color='#8080FF'>" + localize "STR_SQUAD_MOVE" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","move",-935,false,true,"","call GRLIB_checkSquad"];
player addAction ["<t color='#8080FF'>" + localize "STR_SQUAD_FOLLOW" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","follow",-935,false,true,"","call GRLIB_checkSquad"];
player addAction ["<t color='#8080FF'>" + localize "STR_SQUAD_STOP" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","stop",-935,false,true,"","call GRLIB_checkSquad"];
player addAction ["<t color='#F02000'>" + localize "STR_SQUAD_DISMISS" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","del",-935,false,true,"","call GRLIB_checkSquad"];

// Redeploy
player addAction ["<t color='#80FF80'>" + localize "STR_DEPLOY_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\redeploy_manager.sqf","",-502,true,true,"","call GRLIB_checkRedeploy"];

// Halo Jump
player addAction ["<t color='#80FF80'>" + localize "STR_HALO_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\do_halo.sqf","",-503,false,true,"","call GRLIB_checkHalo"];

// Send Ressource
player addAction ["<t color='#80FF00'>" + localize "STR_SEND_RSC" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\do_send_ammo.sqf","",-981,true,true,"","call GRLIB_checkSendAmmo"];

// Buy Fuel
player addAction ["<t color='#00F080'>" + localize "STR_BUY_FUEL" + "</t> <img size='1' image='\A3\ui_f\data\map\mapcontrol\Fuelstation_CA.paa'/>", "scripts\client\actions\do_buy_fuel.sqf","",-900,true,true,"","call GRLIB_checkBuyFuel"];

// Heal Self
player addAction ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Heal_ca.paa'/> Heal self", { (_this select 1) playMove "AinvPknlMstpSlayWnonDnon_medic"; (_this select 1) setDamage 0;},"",999,true,true,"", "call GRLIB_checkHeal"];

// Take Leadrship
player addAction ["<t color='#80FF80'>" + localize "STR_TAKE_LEADRSHIP" + "</t> <img size='1' image='" + _icon_grp + "'/>", {(group player) selectLeader player}, [],0,true,true,"", "call GRLIB_checkLeader"];

// Air Drop
player addAction ["<t color='#00F0F0'>" + localize "STR_AIR_SUPPORT" + "</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\misc\drop_support.sqf","",-980,false,true,"","call GRLIB_checkAirDrop"];

// Arsenal
player addAction ["<t color='#FFFF00'>" + localize "STR_ARSENAL_OPEN" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\open_arsenal.sqf","",-500,true,true,"","call GRLIB_checkArsenal"];

// Personal Arsenal
player addAction ["<t color='#FFFF00'>" + localize "STR_ARSENAL_OPEN" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\open_personal_arsenal.sqf","",-500,true,true,"","call GRLIB_checkArsenalPerso"];
player addAction ["<t color='#00FFFF'>" + localize "STR_ARSENAL_UNPACK" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\unpack_personal_arsenal.sqf","",-501,false,true,"","call GRLIB_checkArsenalPerso"];

// Virtual Garage
player addAction ["<t color='#0080FF'>" + localize "STR_VIRTUAL_GARAGE" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa'/>","addons\VIRT\virtual_garage.sqf","",-984,false,true,"","call GRLIB_checkGarage"];

// Build Menu
player addAction ["<t color='#FFFF00'>" + localize "STR_BUILD_ACTION" + "</t> <img size='1' image='res\ui_build.paa'/>","scripts\client\build\open_build_menu.sqf","",-501,false,true,"","call GRLIB_checkBuild"];

// Squad Management
player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_MANAGEMENT_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\ui\squad_management.sqf","",-760,false,true,"","call GRLIB_checkSquadMgmt"];

// Pack Beacon
player addAction ["<t color='#FFFF00'>" + localize "STR_PACK_BEACON" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_pack.sqf","",-950,false,true,"","call GRLIB_checkPackBeacon"];

// UnPack Beacon
player addAction ["<t color='#FFFF00'>" + localize "STR_UNPACK_BEACON" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_unpack.sqf","",-950,false,true,"","call GRLIB_checkUnpackBeacon"];

// Build FOB
player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_ACTION" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_build_fob.sqf","",-981,false,true,"","call GRLIB_checkBuildFOB"];
player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_ACTION" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_build_fob.sqf","",-981,false,true,"","call GRLIB_checkBuildFOBWater"];

// Pack FOB
player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_REPACKAGE" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_repackage_fob.sqf","",-981,false,true,"","call GRLIB_checkPackFOB"];

// Build Outpost
player addAction ["<t color='#FF6F00'>" + localize "STR_OUTPOST_ACTION" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_build_fob.sqf","",-981,false,true,"","call GRLIB_checkBuildOutpost"];

// Upgrade Outpost
player addAction ["<t color='#00FF8F'>" + localize "STR_UPGRADE_OUTPOST" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_upgrade_outpost.sqf","",-983,false,true,"","call GRLIB_checkUpgradeOutpost"];

// Destroy Outpost
player addAction ["<t color='#FF6F00'>" + localize "STR_DESTROY_OUTPOST" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_destroy_outpost.sqf","",-984,false,true,"","call GRLIB_checkDelOutpost"];

// Onboard Ship
player addAction ["<t color='#00206F'>" + localize "STR_ONBOARD_SHIP" + "</t> <img size='1' image='res\ui_deployfob.paa'/>",{[GRLIB_player_nearest_fob] call do_onboard;},"",-981,false,true,"","call GRLIB_checkOnboardShip"];

// Remove Helipad
player addAction ["<t color='#FFFF00'>" + localize "STR_RECYCLE_MANAGER" + "</t> <img size='1' image='res\ui_recycle.paa'/>",{ deleteVehicle (nearestObjects [player, ["Helipad_base_F"], GRLIB_ActionDist_3] select 0) },"",-505,false,true,"","call GRLIB_checkRemoveHelipad"];
