/**
 * Héliporte un objet avec un héliporteur
 * 
 * @param 0 l'héliporteur
 * 
 * Copyright (C) 2014 Team ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (R3F_LOG_mutex_local_verrou) then
{
	hintC STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;
	
	private ["_heliporteur", "_objet"];
	
	_heliporteur = _this select 0;
	
	// Recherche de l'objet à héliporter
	_objet = objNull;
	{
		if (
			(_x getVariable ["R3F_LOG_fonctionnalites", R3F_LOG_CST_zero_log] select R3F_LOG_IDX_can_be_lifted) &&
			_x != _heliporteur && !(_x getVariable "R3F_LOG_disabled") &&
			((getPosASL _heliporteur select 2) - (getPosASL _x select 2) > 2 && (getPosASL _heliporteur select 2) - (getPosASL _x select 2) < 15)
		) exitWith {_objet = _x;};
	} forEach (nearestObjects [_heliporteur, ["All"], 20]);
	
	if (!isNull _objet) then
	{
		if !(_objet getVariable "R3F_LOG_disabled") then
		{
			if (isNull (_objet getVariable "R3F_LOG_est_transporte_par") && (isNull (_objet getVariable "R3F_LOG_est_deplace_par") || (!alive (_objet getVariable "R3F_LOG_est_deplace_par")) || (!isPlayer (_objet getVariable "R3F_LOG_est_deplace_par")))) then
			{
				// Finalement on autorise l'héliport d'un véhicule avec du personnel à bord
				//if (count crew _objet == 0 || getNumber (configFile >> "CfgVehicles" >> (typeOf _objet) >> "isUav") == 1) then
				//{
					// Ne pas héliporter quelque chose qui remorque autre chose
					if (isNull (_objet getVariable ["R3F_LOG_remorque", objNull])) then
					{
						private ["_duree", "_ctrl_titre", "_ctrl_fond", "_ctrl_jauge", "_time_debut", "_attente_valide", "_pas_de_hook"];
						
						_duree = 10;
						
						#define _JAUGE_Y 0.7
						#define _JAUGE_W 0.4
						#define _JAUGE_H 0.025
						
						disableSerialization;
						
						// Création du titre du compte-à-rebours dans le display du jeu
						_ctrl_titre = (findDisplay 46) ctrlCreate ["RscText", -1];
						_ctrl_titre ctrlSetPosition [0.5 - 0.5*_JAUGE_W, _JAUGE_Y - 1.5*_JAUGE_H, _JAUGE_W, 1.5*_JAUGE_H];
						_ctrl_titre ctrlSetFontHeight 1.5*_JAUGE_H;
						_ctrl_titre ctrlSetText format [STR_R3F_LOG_action_heliport_attente, _duree];
						_ctrl_titre ctrlCommit 0;
						
						// Création de l'arrière-plan de la jauge dans le display du jeu
						_ctrl_fond = (findDisplay 46) ctrlCreate ["RscText", -1];
						_ctrl_fond ctrlSetBackgroundColor [0, 0, 0, 0.4];
						_ctrl_fond ctrlSetPosition [0.5 - 0.5*_JAUGE_W, _JAUGE_Y, _JAUGE_W, _JAUGE_H];
						_ctrl_fond ctrlCommit 0;
						
						// Création d'une jauge à 0% dans le display du jeu
						_ctrl_jauge = (findDisplay 46) ctrlCreate ["RscText", -1];
						_ctrl_jauge ctrlSetBackgroundColor [0, 0.6, 0, 1];
						_ctrl_jauge ctrlSetPosition [0.5 - 0.5*_JAUGE_W, _JAUGE_Y, 0, _JAUGE_H];
						_ctrl_jauge ctrlCommit 0;
						
						// La jauge passe progressivement de 0% à 100%
						_ctrl_jauge ctrlSetPosition [0.5 - 0.5*_JAUGE_W, _JAUGE_Y, _JAUGE_W, _JAUGE_H];
						_ctrl_jauge ctrlCommit _duree;
						
						_time_debut = time;
						_attente_valide = true;
						
						while {_attente_valide && time - _time_debut < _duree} do
						{
							_ctrl_titre ctrlSetText format [STR_R3F_LOG_action_heliport_attente, ceil (_duree - (time - _time_debut))];
							
							// A partir des versions > 1.32, on interdit le lift si le hook de BIS est utilisé
							if (productVersion select 2 > 132) then
							{
								// Call compile car la commande getSlingLoad n'existe pas en 1.32
								_pas_de_hook = _heliporteur call compile format ["isNull getSlingLoad _this"];
							}
							else
							{
								_pas_de_hook = true;
							};
							
							// Pour valider l'héliportage, il faut rester en stationnaire au dessus de l'objet pendant le compte-à-rebours
							if !(
								alive player && vehicle player == _heliporteur && !(_heliporteur getVariable "R3F_LOG_disabled") && _pas_de_hook &&
								isNull (_heliporteur getVariable "R3F_LOG_heliporte") && (vectorMagnitude velocity _heliporteur < 6) && (_heliporteur distance _objet < 15) &&
								!(_objet getVariable "R3F_LOG_disabled") && isNull (_objet getVariable "R3F_LOG_est_transporte_par") &&
								(isNull (_objet getVariable "R3F_LOG_est_deplace_par") || (!alive (_objet getVariable "R3F_LOG_est_deplace_par")) || (!isPlayer (_objet getVariable "R3F_LOG_est_deplace_par"))) &&
								((getPosASL _heliporteur select 2) - (getPosASL _objet select 2) > 2 && (getPosASL _heliporteur select 2) - (getPosASL _objet select 2) < 15)
							) then
							{
								_attente_valide = false;
							};
							
							sleep 0.1;
						};
						
						// On effecture l'héliportage
						if (_attente_valide) then
						{
							ctrlDelete _ctrl_titre;
							ctrlDelete _ctrl_fond;
							ctrlDelete _ctrl_jauge;
							
							_heliporteur setVariable ["R3F_LOG_heliporte", _objet, true];
							_objet setVariable ["R3F_LOG_est_transporte_par", _heliporteur, true];
							
							// Attacher sous l'héliporteur au ras du sol
							_objet attachTo [_heliporteur, [
								0,
								0,
								(boundingBoxReal _heliporteur select 0 select 2) - (boundingBoxReal _objet select 0 select 2) - (getPos _heliporteur select 2) + 0.5
							]];
							
							// Ré-aligner dans le sens de la longueur si besoin
							if (((boundingBoxReal _objet select 1 select 0) - (boundingBoxReal _objet select 0 select 0)) >
								((boundingBoxReal _objet select 1 select 1) - (boundingBoxReal _objet select 0 select 1))) then
							{
								[_objet, "setDir", 90] call R3F_LOG_FNCT_exec_commande_MP;
							};
							
							systemChat format [STR_R3F_LOG_action_heliporter_fait, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
							
							// Boucle de contrôle pendant l'héliportage
							[_heliporteur, _objet] spawn
							{
								private ["_heliporteur", "_objet", "_a_ete_souleve"];
								
								_heliporteur = _this select 0;
								_objet = _this select 1;
								
								_a_ete_souleve = false;
								
								while {_heliporteur getVariable "R3F_LOG_heliporte" == _objet} do
								{
									// Mémoriser si l'objet a déjà été soulevé (cables tendus)
									if (!_a_ete_souleve && getPos _objet select 2 > 3) then
									{
										_a_ete_souleve = true;
									};
									
									// Si l'hélico se fait détruire ou si l'objet héliporté entre en contact avec le sol, on largue l'objet
									if (!alive _heliporteur || (_a_ete_souleve && getPos _objet select 2 < 0)) exitWith
									{
										_heliporteur setVariable ["R3F_LOG_heliporte", objNull, true];
										_objet setVariable ["R3F_LOG_est_transporte_par", objNull, true];
										
										// Détacher l'objet et lui appliquer la vitesse de l'héliporteur (inertie)
										[_objet, "detachSetVelocity", velocity _heliporteur] call R3F_LOG_FNCT_exec_commande_MP;
										
										systemChat format [STR_R3F_LOG_action_heliport_larguer_fait, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
									};
									
									sleep 0.1;
								};
							};
						}
						else
						{
							systemChat STR_R3F_LOG_action_heliport_echec_attente;
							
							// La jauge s'arrête
							_ctrl_jauge ctrlSetPosition ctrlPosition _ctrl_jauge;
							
							// La jauge clignote rouge
							_ctrl_jauge ctrlSetBackgroundColor [1, 0, 0, 1];
							_ctrl_jauge ctrlCommit 0; sleep 0.175;
							_ctrl_jauge ctrlSetBackgroundColor [1, 0, 0, 0];
							_ctrl_jauge ctrlCommit 0; sleep 0.175;
							_ctrl_jauge ctrlSetBackgroundColor [1, 0, 0, 1];
							_ctrl_jauge ctrlCommit 0; sleep 0.175;
							_ctrl_jauge ctrlSetBackgroundColor [1, 0, 0, 0];
							_ctrl_jauge ctrlCommit 0; sleep 0.175;
							_ctrl_jauge ctrlSetBackgroundColor [1, 0, 0, 1];
							_ctrl_jauge ctrlCommit 0; sleep 0.175;
							_ctrl_jauge ctrlSetBackgroundColor [1, 0, 0, 0];
							_ctrl_jauge ctrlCommit 0; sleep 0.175;
							_ctrl_jauge ctrlSetBackgroundColor [1, 0, 0, 1];
							_ctrl_jauge ctrlCommit 0; sleep 0.175;
							
							ctrlDelete _ctrl_titre;
							ctrlDelete _ctrl_fond;
							ctrlDelete _ctrl_jauge;
						};
					}
					else
					{
						systemChat format [STR_R3F_LOG_objet_remorque_en_cours, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
					};
				//}
				//else
				//{
				//	systemChat format [STR_R3F_LOG_joueur_dans_objet, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
				//};
			}
			else
			{
				systemChat format [STR_R3F_LOG_objet_en_cours_transport, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
			};
		};
	};
	
	R3F_LOG_mutex_local_verrou = false;
};