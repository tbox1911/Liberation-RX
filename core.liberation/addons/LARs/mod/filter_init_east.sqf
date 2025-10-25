if (GRLIB_filter_arsenal == 2) exitWith {};

// Add ArmA3 Weapons
if (["A3_", GRLIB_mod_east, true] call F_startsWith) then {
	private _A3_exclude = ["O_","U_O_","U_OG_"];
	if (["A3_OPF", GRLIB_mod_east, true] call F_startsWith) then { _A3_exclude = ["B_","U_B_","U_BG_"] };
	private _A3_Items = [
		"B_","U_B_","U_BG_","O_","U_O_","U_OG_","I_","U_I_","C_","U_C_","H_","V_","G_",
		"hgun_","arifle_","srifle_","MMG_","LMG_","SMG_","launch_",
		"acc_","bipod_","optic_","muzzle_",
		"Laserdesignator_","NVGoggles"
	] - _A3_exclude;
	GRLIB_MOD_signature = GRLIB_MOD_signature + _A3_Items;
};
// Add WS Weapons
if (["WS_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + [
		"launch_","arifle_RPK12_lush",
		"acc_","bipod_","optic_","muzzle_",
		"Titan_","RPG32_","MRAWS_","Chemlight_","SmokeShell"
	];
};
// Add CUP Weapons
if (["CP_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["CUP_"];
};
// Add GM Weapons
if (["GM_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["gm_"];
};
// Add OPTRE Weapons
if (["OPTRE", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["optre_"];
};
// Add EricJ Weapons
if (["EJW_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["ej_"];
};
// Add RHS Weapons
if (["RHS_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["rhs"];
};
// Add R3F Weapons
if (["R3F_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["r3f_"];
};
// Add SOG Weapons
if (["SOG_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["vn_"];
};
// Add 3CB Weapons
if (["3CB_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["uk3cb_"];
};
// Add CWR Weapons
if (["CWR3_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["cwr3"] + ["CUP_"];
};
// Add FFAA Weapons
if (["FFAA_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["ffaa_"];
};
// Add ASZ Weapons
if (["ASZ_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + [
		"B_mas_itl","U_mas_itl_","V_mas_itl_","G_mas_itl_",
		"hgun_","arifle_mas_itl_","srifle_mas_itl_","MMG_mas_itl_","LMG_mas_itl_","SMG_mas_itl_","launch_mas_itl_",
		"acc_","bipod_","optic_","muzzle_",
		"NVGoggles_mas_itl_","Laserdesignator_"
	];
};
// Add PO Weapons
if (["PO_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["LOP_"];
};
// Add Unsung Weapons
if (["UNS_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["uns_"];
};
// Add IFA3 Weapons
if (["IFA_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["LIB_","B_LIB_","G_LIB_","H_LIB_","U_LIB_","V_LIB_"];
};
// Add DLC: Spearhead 1944 (WW2) Weapons
if (["SPE_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["SPE_","U_SPE_","V_SPE_","B_SPE_","H_SPE_","G_SPE_"];
};
// Add DLC: UFP (Ukrainian Faction Project) Weapons
if (["RHS_UFP", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["afou_weap_","U_B_afou_","vest_afou_","bp_afougf_","H_B_afou_"];
};
// Add DLC: CSLA Iron Curtain Z@Warrior
if (["IC_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["US85_","CSLA_","AFMC_","FIA_"];
};
// Add USP Weapons
if (["USP_", GRLIB_mod_east, true] call F_startsWith) then {
    GRLIB_MOD_signature = GRLIB_MOD_signature + ["RHS_","USP_"];
};