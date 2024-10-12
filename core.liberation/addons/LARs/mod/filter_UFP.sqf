// Mod: UFP (Ukrainian Faction Project) 

GRLIB_MOD_signature = GRLIB_MOD_signature + ["afou_weap_","U_B_afou_","vest_afou_","bp_afougf_","H_B_afou_","rhs_weap_","rhsusf_weap_"];

// Weapons + Equipements (uniforms, etc..)
(
	"
	getNumber (_x >> 'scope') > 1 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
	"
	([(configName _x)] call is_allowed_item) &&
	((configName _x) iskindof 'Bag_Base')
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;
