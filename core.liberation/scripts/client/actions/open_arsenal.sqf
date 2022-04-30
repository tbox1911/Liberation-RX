if (FAC_MSU_ACTIVE) then {
    _fac = group player getVariable ["BIS_dg_fac", true];
    // gibt true wenn keine Gruppe oder Fraktion festgelegt.
    if (_fac == "Nofaction") exitwith {
        hint "Bitte erstelle eine Gruppe im groupmanager, und wähle deine Fraktion in den Gruppendetails!";
    };
    
    _prc = format ["FAC_MSU\%1\arsenal.sqf", _fac];
    // [] call compile preprocessFileLineNumbers _prc;
    
    _handle = player execVM _prc;
    waitUntil {
        scriptDone _handle
    };
    
    _box = missionnamespace getVariable ["myLARsBox", objNull];
    [_box, false] call ace_arsenal_fnc_initBox;
    [_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
    [_box, arsenal] call ace_arsenal_fnc_addVirtualitems;
    [_box, items_allFac] call ace_arsenal_fnc_addVirtualitems;
    [_box, all_weapons] call ace_arsenal_fnc_addVirtualitems;
    [_box, all_magazines] call ace_arsenal_fnc_addVirtualitems;
    [_box, all_accessorys] call ace_arsenal_fnc_addVirtualitems;
    [_box, all_grenades] call ace_arsenal_fnc_addVirtualitems;
    [_box, all_explosives] call ace_arsenal_fnc_addVirtualitems;
    [_box, all_items] call ace_arsenal_fnc_addVirtualitems;
    [_box, all_backpacks] call ace_arsenal_fnc_addVirtualitems;
    [_box, player, false] call ace_arsenal_fnc_openBox;
    
    // filter and pay loadout
    [player] call F_filterloadout;
    [player] call F_payloadout;
} else {
    load_loadout = 0;
    edit_loadout = 0;
    respawn_loadout = 0;
    load_from_player = -1;
    exit_on_load = 0;
    
    GRLIB_backup_loadout = [player] call F_getloadout;
    player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
    
    // Blacklist items
    _blacklisted_ace_arsenal= [
        "B_UavTerminal",
        "O_UavTerminal",
        "I_UavTerminal",
        "C_UavTerminal",
        "I_UAV_06_backpack_F",
        "O_UAV_06_backpack_F",
        "B_UAV_06_backpack_F",
        "I_UAV_06_medical_backpack_F",
        "O_UAV_06_medical_backpack_F",
        "C_IDAP_UAV_06_medical_backpack_F",
        "B_UAV_06_medical_backpack_F",
        "I_UAV_01_backpack_F",
        "O_UAV_01_backpack_F",
        "B_UAV_01_backpack_F",
        "C_IDAP_UAV_06_antimine_backpack_F",
        "C_UAV_06_backpack_F",
        "C_IDAP_UAV_06_backpack_F",
        "C_UAV_06_medical_backpack_F",
        "C_IDAP_UAV_01_backpack_F",
        "I_E_UAV_06_backpack_F",
        "I_E_UAV_06_medical_backpack_F",
        "I_E_UAV_01_backpack_F",
        "launch_I_Titan_eaf_F",
        "launch_B_Titan_olive_F",
        "launch_B_Titan_tna_F",
        "launch_B_Titan_short_tna_F",
        "launch_O_Titan_ghex_F",
        "launch_O_Titan_short_ghex_F",
        "launch_B_Titan_F",
        "launch_I_Titan_F",
        "launch_O_Titan_F",
        "launch_Titan_F",
        "launch_B_Titan_short_F",
        "launch_I_Titan_short_F",
        "launch_O_Titan_short_F",
        "launch_Titan_short_F",
        "B_Static_Designator_01_weapon_F",
        "B_W_Static_Designator_01_weapon_F",
        "O_Static_Designator_02_weapon_F",
        "B_UGV_02_Science_backpack_F",
        "O_UGV_02_Science_backpack_F",
        "I_UGV_02_Science_backpack_F",
        "B_UGV_02_Demining_backpack_F",
        "O_UGV_02_Demining_backpack_F",
        "I_UGV_02_Demining_backpack_F",
        "land_Tentdome_F",
        "B_Respawn_sleeping_bag_blue_F",
        "B_Respawn_sleeping_bag_brown_F",
        "B_Respawn_Tentdome_F",
        "B_Respawn_sleeping_bag_F",
        "B_Respawn_TentA_F",
        "B_Patrol_Respawn_bag_F",
        "B_Patrol_Respawn_tent_F",
        "B_HMG_01_support_F",
        "O_HMG_01_support_F",
        "I_HMG_01_support_F",
        "B_HMG_01_support_high_F",
        "O_HMG_01_support_high_F",
        "I_HMG_01_support_high_F",
        "I_HMG_01_A_weapon_F",
        "B_HMG_01_A_weapon_F",
        "O_HMG_01_A_weapon_F",
        "O_HMG_01_weapon_F",
        "B_HMG_01_weapon_F",
        "I_HMG_01_weapon_F",
        "I_HMG_01_high_weapon_F",
        "O_HMG_01_high_weapon_F",
        "B_HMG_01_high_weapon_F",
        "B_HMG_01_support_grn_F",
        "B_HMG_01_Weapon_grn_F",
        "B_HMG_02_high_weapon_F",
        "B_G_HMG_02_high_weapon_F",
        "I_HMG_02_high_weapon_F",
        "O_HMG_02_high_weapon_F",
        "B_HMG_02_support_F",
        "B_G_HMG_02_support_F",
        "I_HMG_02_support_F",
        "O_HMG_02_support_F",
        "B_HMG_02_support_high_F",
        "B_G_HMG_02_support_high_F",
        "I_HMG_02_support_high_F",
        "O_HMG_02_support_high_F",
        "B_HMG_02_weapon_F",
        "B_G_HMG_02_weapon_F",
        "I_HMG_02_weapon_F",
        "O_HMG_02_weapon_F",
        "I_GMG_01_A_weapon_F",
        "O_GMG_01_A_weapon_F",
        "B_GMG_01_A_weapon_F",
        "O_GMG_01_weapon_F",
        "I_GMG_01_weapon_F",
        "B_GMG_01_weapon_F",
        "B_GMG_01_high_weapon_F",
        "I_GMG_01_high_weapon_F",
        "O_GMG_01_high_weapon_F",
        "I_Mortar_01_support_F",
        "B_Mortar_01_support_F",
        "O_Mortar_01_support_F",
        "B_Mortar_01_weapon_F",
        "O_Mortar_01_weapon_F",
        "I_Mortar_01_weapon_F",
        "B_AA_01_weapon_F",
        "O_AA_01_weapon_F",
        "I_AA_01_weapon_F",
        "B_AT_01_weapon_F",
        "O_AT_01_weapon_F",
        "I_AT_01_weapon_F",
        "I_UAV_01_backpack_F",
        "B_UAV_01_backpack_F",
        "O_UAV_01_backpack_F",
        "B_Mortar_01_support_grn_F",
        "B_GMG_01_Weapon_grn_F",
        "B_Mortar_01_Weapon_grn_F",
        "B_Protagonist_VR_F",
        "U_B_Protagonist_VR",
        "O_Protagonist_VR_F",
        "U_O_Protagonist_VR",
        "I_Protagonist_VR_F",
        "U_I_Protagonist_VR",
        "C_Protagonist_VR_F",
        "TFAR_rf7800str",
        "C_UavTerminal",
        "I_E_UavTerminal",
        "O_UavTerminal",
        "TFAR_pnr1000a",
        "TFAR_pnr1000a",
        "TFAR_fadak",
        "I_UavTerminal",
        "TFAR_anprc154",
        "TFAR_anprc148jem",
        "U_C_Protagonist_VR",
        "optic_Nightstalker",
        "optic_tws",
        "optic_tws_mg",
        "optic_NVS",
        "NVgoggles_tna_F",
        "NVgogglesB_blk_F",
        "NVgogglesB_grn_F",
        "NVgogglesB_gry_F",
        "H_Helmeto_ViperSP_hex_F",
        "H_Helmeto_ViperSP_ghex_F",
        "U_O_V_Soldier_Viper_hex_F",
        "U_O_V_Soldier_Viper_F",
        "O_V_Soldier_Viper_F",
        "CUP_U_C_Priest_01",
        "CUP_launch_Javelin",
        "CUP_Javelin_M",
        "MMG_01_hex_F",
        "MMG_01_tan_F",
        "MMG_02_black_F",
        "MMG_02_sand_F",
        "MMG_02_camo_F",
        "arifle_ARX_blk_F",
        "arifle_ARX_hex_F",
        "arifle_ARX_ghex_F",
        "O_V_Soldier_Viper_hex_F"
        
    ];
    
    _box = missionnamespace getVariable ["myLARsBox", objNull];
    [_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
    [_box, true] call ace_arsenal_fnc_initBox;
    [_box, _blacklisted_ace_arsenal] call ace_arsenal_fnc_removeVirtualitems;
    [_box, player, false] call ace_arsenal_fnc_openBox;
    
    // filter and pay loadout
    [player] call F_filterloadout;
    [player] call F_payloadout;
};