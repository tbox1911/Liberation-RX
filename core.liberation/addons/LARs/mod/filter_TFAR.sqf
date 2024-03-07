// Add TFAR Radio
(
	"
	(tolower ((configName _x) select [0,3]) == 'tf_' || tolower ((configName _x) select [0,5]) == 'tfar_')
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;
