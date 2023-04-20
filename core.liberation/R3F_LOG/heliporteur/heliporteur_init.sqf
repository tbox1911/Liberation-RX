/**
 * Initialise un véhicule héliporteur
 *
 * @param 0 l'héliporteur
 */

private ["_heliporteur"];

_heliporteur = _this select 0;

// Définition locale de la variable si elle n'est pas définie sur le réseau
if (isNil {_heliporteur getVariable "R3F_LOG_heliporte"}) then
{
	_heliporteur setVariable ["R3F_LOG_heliporte", objNull, false];
};

_heliporteur addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_heliporter + "</t>  <img size='1' image='R3F_LOG\icons\r3f_tow.paa'/>"), {_this call R3F_LOG_FNCT_heliporteur_heliporter}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_heliporter_valide"];

_heliporteur addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_heliport_larguer + "</t>  <img size='1' image='R3F_LOG\icons\r3f_release.paa'/>"), {_this call R3F_LOG_FNCT_heliporteur_larguer}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_heliport_larguer_valide"];

_heliporteur addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_heliport_paradrop + "</t>  <img size='1' image='\a3\Ui_f\data\map\VehicleIcons\iconparachute_ca.paa'/>"), {_this call R3F_LOG_FNCT_heliporteur_larguer}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_heliport_paradrop_valide"];