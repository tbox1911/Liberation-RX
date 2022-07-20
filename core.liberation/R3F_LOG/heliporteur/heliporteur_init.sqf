/**
 * Initialise un v�hicule h�liporteur
 *
 * @param 0 l'h�liporteur
 */

private ["_heliporteur"];

_heliporteur = _this select 0;

// D�finition locale de la variable si elle n'est pas d�finie sur le r�seau
if (isNil {_heliporteur getVariable "R3F_LOG_heliporte"}) then
{
	_heliporteur setVariable ["R3F_LOG_heliporte", objNull, false];
};

_heliporteur addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_heliporter + "</t>  <img size='1' image='R3F_LOG\icons\r3f_tow.paa'/>"), {_this call R3F_LOG_FNCT_heliporteur_heliporter}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_heliporter_valide"];

_heliporteur addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_heliport_larguer + "</t>  <img size='1' image='R3F_LOG\icons\r3f_release.paa'/>"), {_this call R3F_LOG_FNCT_heliporteur_larguer}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_heliport_larguer_valide"];

_heliporteur addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_heliport_paradrop + "</t>  <img size='1' image='\a3\Ui_f\data\map\VehicleIcons\iconparachute_ca.paa'/>"), {_this call R3F_LOG_FNCT_heliporteur_larguer}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_heliport_paradrop_valide"];