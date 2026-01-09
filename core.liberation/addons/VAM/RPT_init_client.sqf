// Vehicle Paint v1.10 merged with VAM
// by pSiKO - client side

[] call compileFinal preprocessFileLineNumbers "addons\VAM\RPT_init_static.sqf";

VAM_arsenal_class_names = [];

VAM_cargo_class_names_def = [
	Arsenal_typename,
	mobile_respawn,
	repairbox_typename,
	canister_fuel_typename,
	medicalbox_typename,
	"Land_CncBarrierMedium4_F",
	"Land_BagFence_Short_F"
];

VAM_inventory_class_names = [
	PAR_Medikit,
	PAR_AidKit,
	"ToolKit",
	"SatchelCharge_Remote_Mag",
	"DemoCharge_Remote_Mag",
	"O_NVGoggles_urb_F",
	"HandGrenade",
	"FlareWhite_F"		
];

// ACE use only whitelist
if (GRLIB_ACE_enabled) then {
	VAM_cargo_class_names_def append  [
		"ACE_Wheel",
		"ACE_Track"
	];
};
