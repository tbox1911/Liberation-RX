/**
 * Remorque l'objet point� au v�hicule remorqueur valide le plus proche
 *
 * @param 0 l'objet � remorquer
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

	private ["_objet", "_remorqueur"];

	_objet = _this select 0;

	// Recherche du remorqueur valide le plus proche
	_remorqueur = objNull;
	{
		if (
			_x != _objet && (_x getVariable ["R3F_LOG_fonctionnalites", R3F_LOG_CST_zero_log] select R3F_LOG_IDX_can_tow) &&
			alive _x && isNull (_x getVariable "R3F_LOG_est_transporte_par") &&
			isNull (_x getVariable "R3F_LOG_remorque") && (vectorMagnitude velocity _x < 6) &&
			!([_x, player] call R3F_LOG_FNCT_objet_est_verrouille) && !(_x getVariable "R3F_LOG_disabled") &&
			{
				private ["_delta_pos"];

				_delta_pos =
				(
					_objet modelToWorld
					[
						boundingCenter _objet select 0,
						boundingBoxReal _objet select 1 select 1,
						boundingBoxReal _objet select 0 select 2
					]
				) vectorDiff (
					_x modelToWorld
					[
						boundingCenter _x select 0,
						boundingBoxReal _x select 0 select 1,
						boundingBoxReal _x select 0 select 2
					]
				);

				// L'arri�re du remorqueur est proche de l'avant de l'objet point�
				abs (_delta_pos select 0) < 3 && abs (_delta_pos select 1) < 5
			}
		) exitWith {_remorqueur = _x;};
	} forEach (nearestObjects [_objet, ["All"], 30]);

	if (!isNull _remorqueur) then
	{
		if (isNull (_objet getVariable "R3F_LOG_est_transporte_par") && (isNull (_objet getVariable "R3F_LOG_est_deplace_par") || (!alive (_objet getVariable "R3F_LOG_est_deplace_par")) || (!isPlayer (_objet getVariable "R3F_LOG_est_deplace_par")))) then
		{
			[_remorqueur, player] call R3F_LOG_FNCT_definir_proprietaire_verrou;

			_remorqueur setVariable ["R3F_LOG_remorque", _objet, true];
			_objet setVariable ["R3F_LOG_est_transporte_par", _remorqueur, true];

			// Quelques corrections visuelles pour des classes sp�cifiques
			private _offset_attach_y = 0.2;
			private _offset_attach_z = 0.2;

			if !(_objet isKindOf (typeOf _remorqueur)) then {
				//A3
				if (_remorqueur isKindOf "B_Truck_01_mover_F") then {_offset_attach_y = 1 };

				// CUP
				if (_remorqueur isKindOf "CUP_UAZ_Base") then {_offset_attach_z = _offset_attach_z + 2.4};
				if (_objet isKindOf "CUP_UAZ_Base") then {_offset_attach_z = _offset_attach_z - 2.4};

				// RHS
				if (_remorqueur isKindOf "RHS_Ural_Base") then { _offset_attach_z = _offset_attach_z + 2.0 };
				if (_objet isKindOf "RHS_Ural_Base") then { _offset_attach_z = _offset_attach_z - 2.0 };	
				if (_remorqueur isKindOf "RHS_Ural_Zu23_Base") then { _offset_attach_z = _offset_attach_z + 2.0 };
				if (_objet isKindOf "RHS_Ural_Zu23_Base") then { _offset_attach_z = _offset_attach_z - 2.0 };
				if (_remorqueur isKindOf "rhs_a3t72tank_base") then { _offset_attach_z = _offset_attach_z + 1.2 };
				if (_objet isKindOf "rhs_a3t72tank_base") then { _offset_attach_z = _offset_attach_z - 0.8 };				
			};

			// On place le joueur sur le c�t� du v�hicule en fonction qu'il se trouve � sa gauche ou droite
			if ((_remorqueur worldToModel (player modelToWorld [0,0,0])) select 0 > 0) then	{
				player attachTo [_remorqueur, [
					(boundingBoxReal _remorqueur select 1 select 0) + 0.5,
					(boundingBoxReal _remorqueur select 0 select 1),
					((boundingBoxReal _remorqueur select 0 select 2) - (boundingBoxReal player select 0 select 2)) + _offset_attach_z
				]];
				player setDir 270;
			} else {
				player attachTo [_remorqueur, [
					(boundingBoxReal _remorqueur select 0 select 0) - 0.5,
					(boundingBoxReal _remorqueur select 0 select 1),
					((boundingBoxReal _remorqueur select 0 select 2) - (boundingBoxReal player select 0 select 2)) + _offset_attach_z
				]];
				player setDir 90;
			};

			player playMove format ["AinvPknlMstpSlay%1Dnon_medic", switch (currentWeapon player) do {
				case "": {"Wnon"};
				case primaryWeapon player: {"Wrfl"};
				case secondaryWeapon player: {"Wlnr"};
				case handgunWeapon player: {"Wpst"};
				default {"Wrfl"};
			}];
			sleep 2;

			// Attacher � l'arri�re du v�hicule au ras du sol
			private _pos_x = (boundingCenter _objet select 0);
			private _pos_y = ((boundingBoxReal _remorqueur select 0 select 1) + (boundingBoxReal _objet select 0 select 1)) + _offset_attach_y;
			private _pos_z = ((boundingBoxReal _remorqueur select 0 select 2) - (boundingBoxReal _objet select 0 select 2)) + _offset_attach_z;
			_objet attachTo [_remorqueur, [_pos_x, _pos_y, _pos_z]];

			R3F_LOG_objet_selectionne = objNull;

			detach player;

			// Si l'objet est une arme statique, on corrige l'orientation en fonction de la direction du canon
			if (_objet isKindOf "StaticWeapon") then
			{
				private ["_azimut_canon"];

				_azimut_canon = ((_objet weaponDirection (weapons _objet select 0)) select 0) atan2 ((_objet weaponDirection (weapons _objet select 0)) select 1);

				// Seul le D30 a le canon pointant vers le v�hicule
				if !(_objet isKindOf "D30_Base") then // All in Arma
				{
					_azimut_canon = _azimut_canon + 180;
				};

				[_objet, "setDir", (getDir _objet)-_azimut_canon] call R3F_LOG_FNCT_exec_commande_MP;
			};

			sleep 7;
		}
		else
		{
			hintC format [STR_R3F_LOG_objet_en_cours_transport, [_objet] call F_getLRXName];
		};
	};

	R3F_LOG_mutex_local_verrou = false;
};