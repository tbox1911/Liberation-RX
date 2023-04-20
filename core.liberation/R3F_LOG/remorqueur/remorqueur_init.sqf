/**
 * Initialise un v�hicule remorqueur
 * 
 * @param 0 le remorqueur
 */

private ["_remorqueur"];

_remorqueur = _this select 0;

// D�finition locale de la variable si elle n'est pas d�finie sur le r�seau
if (isNil {_remorqueur getVariable "R3F_LOG_remorque"}) then
{
	_remorqueur setVariable ["R3F_LOG_remorque", objNull, false];
};

_remorqueur addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_remorquer_deplace + "</t>  <img size='1' image='R3F_LOG\icons\r3f_tow.paa'/>"), {_this call R3F_LOG_FNCT_remorqueur_remorquer_deplace}, nil, 7, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_joueur_deplace_objet != _target && R3F_LOG_action_remorquer_deplace_valide"];