/*
Script name:	NRE_earplugs.sqf
*/

if (!(isNil "NRE_EarplugsActive")) then {
  if ( NRE_EarplugsActive == 1 ) then {
    NRE_EarplugsActive = 0;
    1 fadeSound 1;
    hint localize "STR_NREEP_OUT_HINT";
  } else {
    NRE_EarplugsActive = 1;
    1 fadeSound ( NRE_vehvolume / 100.0 );
    hint localize "STR_NREEP_IN_HINT";
  };
  sleep 2;
  hintSilent "";
};

