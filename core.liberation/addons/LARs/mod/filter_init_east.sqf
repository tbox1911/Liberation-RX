// Add ArmA3 Weapons
if (["A3_", GRLIB_mod_east, true] call F_startsWith) then {
	private _A3_Items = [
		"B_","O_","I_","U_",
		"acc_","hgun_","arifle_","srifle_","MMG_","LMG_","SMG_","bipod_","launch_","optic_","muzzle_",
		"Laserdesignator_","H_Bandanna_","H_Beret_","H_Booniehat_","H_Cap_","H_Hat_","H_Helmet","H_MilCap_",
		"H_PASGT_","U_B_","U_BG_","U_C_","U_I_","U_O_","V_","NVGoggles",
		"Vorona_","Titan_","RPG32_","NLAW_F","MRAWS_","Chemlight_","SmokeShell"
	];
	GRLIB_MOD_signature = GRLIB_MOD_signature + _A3_Items;
};
// Add WS Weapons
if (["WS_", GRLIB_mod_east, true] call F_startsWith) then {
	private _A3_Items = [
		"bipod_","launch_","optic_","muzzle_","arifle_RPK12_lush",
		"Titan_","RPG32_","MRAWS_","Chemlight_","SmokeShell"
	];
	GRLIB_MOD_signature = GRLIB_MOD_signature + _A3_Items;
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
if (["OPTRE_", GRLIB_mod_east, true] call F_startsWith) then {
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
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["cwr3"];
};
// Add FFAA Weapons
if (["FFAA_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["ffaa_"];
};
// Add PO Weapons
if (["PO_", GRLIB_mod_east, true] call F_startsWith) then {
	GRLIB_MOD_signature = GRLIB_MOD_signature + ["LOP_"];
};
