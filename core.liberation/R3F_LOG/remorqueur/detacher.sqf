/**
 * D�tacher un objet d'un v�hicule
 *
 * @param 0 l'objet � d�tacher
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

	private ["_remorqueur", "_objet"];

	_objet = _this select 0;
	_remorqueur = _objet getVariable "R3F_LOG_est_transporte_par";

	// Ne pas permettre de d�crocher un objet s'il est en fait h�liport�
	if (_remorqueur getVariable "R3F_LOG_fonctionnalites" select R3F_LOG_IDX_can_tow) then
	{
		[_objet, player] call R3F_LOG_FNCT_definir_proprietaire_verrou;

		_remorqueur setVariable ["R3F_LOG_remorque", objNull, true];
		_objet setVariable ["R3F_LOG_est_transporte_par", objNull, true];

		// Le l�ger setVelocity vers le haut sert � defreezer les objets qui pourraient flotter.
		[_objet, "detachSetVelocity", [0, 0, 0.1]] call R3F_LOG_FNCT_exec_commande_MP;

		player playMove format ["AinvPknlMstpSlay%1Dnon_medic", switch (currentWeapon player) do
		{
			case "": {"Wnon"};
			case primaryWeapon player: {"Wrfl"};
			case secondaryWeapon player: {"Wlnr"};
			case handgunWeapon player: {"Wpst"};
			default {"Wrfl"};
		}];
		sleep 7;

		if (alive player) then
		{
			systemChat STR_R3F_LOG_action_detacher_fait;
		};
	}
	else
	{
		hintC STR_R3F_LOG_action_detacher_impossible_pour_ce_vehicule;
	};

	R3F_LOG_mutex_local_verrou = false;
};