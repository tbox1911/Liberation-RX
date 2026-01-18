/**
 * Script principal qui initialise le systéme de logistique
 *
 * Copyright (C) 2014 Team ~R3F~
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "R3F_LOG_ENABLE.h"

#ifdef R3F_LOG_ENABLE
	/* DEBUT import config */

	// Initialise les listes vides avant que le config.sqf les concaténe
	R3F_LOG_CFG_can_tow = [];
	R3F_LOG_CFG_can_be_towed = [];
	R3F_LOG_CFG_can_lift = [];
	R3F_LOG_CFG_can_be_lifted = [];
	R3F_LOG_CFG_can_transport_cargo = [];
	R3F_LOG_CFG_can_be_transported_cargo = [];
	R3F_LOG_CFG_can_be_moved_by_player = [];

	// Initialise les listes vides de config_creation_factory.sqf
	R3F_LOG_CFG_CF_whitelist_full_categories = [];
	R3F_LOG_CFG_CF_whitelist_medium_categories = [];
	R3F_LOG_CFG_CF_whitelist_light_categories = [];
	R3F_LOG_CFG_CF_blacklist_categories = [];

	#include "config.sqf"
	private _path = format ["mod_template\%1\classnames_r3f.sqf", GRLIB_mod_west];
	[_path] call F_getTemplateFile;
	private _path = format ["mod_template\%1\classnames_r3f.sqf", GRLIB_mod_east];
	[_path] call F_getTemplateFile;

	// Chargement du fichier de langage
	call compile preprocessFileLineNumbers format ["R3F_LOG\%1_strings_lang.sqf", R3F_LOG_CFG_language];

	// Dedup list
	R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow arrayIntersect R3F_LOG_CFG_can_tow;
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed arrayIntersect R3F_LOG_CFG_can_be_towed;
	R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift arrayIntersect R3F_LOG_CFG_can_lift;
	R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted arrayIntersect R3F_LOG_CFG_can_be_lifted;
	R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo arrayIntersect R3F_LOG_CFG_can_transport_cargo;
	R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo arrayIntersect R3F_LOG_CFG_can_be_transported_cargo;
	R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player arrayIntersect R3F_LOG_CFG_can_be_moved_by_player;

	/*
	 * On inverse l'ordre de toutes les listes de noms de classes pour donner
	 * la priorité aux classes spécifiques sur les classes génériques
	 */
	reverse R3F_LOG_CFG_can_tow;
	reverse R3F_LOG_CFG_can_be_towed;
	reverse R3F_LOG_CFG_can_lift;
	reverse R3F_LOG_CFG_can_be_lifted;
	reverse R3F_LOG_CFG_can_transport_cargo;
	reverse R3F_LOG_CFG_can_be_transported_cargo;
	reverse R3F_LOG_CFG_can_be_moved_by_player;

	// On passe tous les noms de classes en minuscules
	{R3F_LOG_CFG_can_tow set [_forEachIndex, toLower _x];} forEach R3F_LOG_CFG_can_tow;
	{R3F_LOG_CFG_can_be_towed set [_forEachIndex, toLower _x];} forEach R3F_LOG_CFG_can_be_towed;
	{R3F_LOG_CFG_can_lift set [_forEachIndex, toLower _x];} forEach R3F_LOG_CFG_can_lift;
	{R3F_LOG_CFG_can_be_lifted set [_forEachIndex, toLower _x];} forEach R3F_LOG_CFG_can_be_lifted;
	{R3F_LOG_CFG_can_transport_cargo select _forEachIndex set [0, toLower (_x select 0)];} forEach R3F_LOG_CFG_can_transport_cargo;
	{R3F_LOG_CFG_can_be_transported_cargo select _forEachIndex set [0, toLower (_x select 0)];} forEach R3F_LOG_CFG_can_be_transported_cargo;
	{R3F_LOG_CFG_can_be_moved_by_player set [_forEachIndex, toLower _x];} forEach R3F_LOG_CFG_can_be_moved_by_player;

	// On construit la liste des classes des transporteurs dans les quantités associées (pour les nearestObjects, count isKindOf, ...)
	R3F_LOG_classes_transporteurs = R3F_LOG_CFG_can_transport_cargo apply { _x select 0 };

	// On construit la liste des classes des transportables dans les quantités associées (pour les nearestObjects, count isKindOf, ...)
	R3F_LOG_classes_objets_transportables = R3F_LOG_CFG_can_be_transported_cargo apply { _x select 0 };

	// Union des tableaux de types d'objets servant dans un isKindOf
	R3F_LOG_objets_depl_heli_remorq_transp = [];
	{
		if !(_x in R3F_LOG_objets_depl_heli_remorq_transp) then
		{
			R3F_LOG_objets_depl_heli_remorq_transp pushBack _x;
		};
	} forEach (R3F_LOG_CFG_can_be_moved_by_player + R3F_LOG_CFG_can_be_lifted + R3F_LOG_CFG_can_be_towed + R3F_LOG_classes_objets_transportables);

	// Gestion compatibilité fichier de config 3.0 => 3.1 (définition de valeurs par défaut)
	if (isNil "R3F_LOG_CFG_lock_objects_mode") then {R3F_LOG_CFG_lock_objects_mode = "side";};
	if (isNil "R3F_LOG_CFG_unlock_objects_timer") then {R3F_LOG_CFG_unlock_objects_timer = 30;};
	if (isNil "R3F_LOG_CFG_CF_sell_back_bargain_rate") then {R3F_LOG_CFG_CF_sell_back_bargain_rate = 0.75;};
	if (isNil "R3F_LOG_CFG_CF_creation_cost_factor") then {R3F_LOG_CFG_CF_creation_cost_factor = [];};

	/* FIN import config */

	if (isServer) then
	{
		// On crée le point d'attache qui servira aux attachTo pour les objets é charger virtuellement dans les véhicules
		R3F_LOG_PUBVAR_point_attache = "Land_HelipadEmpty_F" createVehicle [0,0,0];
		R3F_LOG_PUBVAR_point_attache setPosASL [0,0,0];
		R3F_LOG_PUBVAR_point_attache setVectorDirAndUp [[0,1,0], [0,0,1]];

		// Partage du point d'attache avec tous les joueurs
		publicVariable "R3F_LOG_PUBVAR_point_attache";

		// /** Liste des objets é ne pas perdre dans un vehicule/cargo détruit */
		// R3F_LOG_liste_objets_a_proteger = [];

		// /* Protége les objets présents dans R3F_LOG_liste_objets_a_proteger */
		// if (count R3F_LOG_liste_objets_a_proteger > 0) then {
		// 	[] spawn compileFinal preprocessFileLineNumbers "R3F_LOG\surveiller_objets_a_proteger.sqf";
		// };
	};

	/**
	 * Suite é une PVEH, exécute une commande en fonction de la localité de l'argument
	 * @param 0 l'argument sur lequel exécuter la commande
	 * @param 1 la commande é exécuter (chaéne de caractéres)
	 * @param 2 les éventuels paramétres de la commande (optionnel)
	 * @note il faut passer par la fonction R3F_LOG_FNCT_exec_commande_MP
	 */
	R3F_LOG_FNCT_PVEH_commande_MP =
	{
		private ["_argument", "_commande", "_parametre"];
		_argument = _this select 1 select 0;
		_commande = _this select 1 select 1;
		_parametre = if (count (_this select 1) == 3) then {_this select 1 select 2} else {0};

		// Commandes é argument global et effet local
		switch (_commande) do
		{
			// Aucune pour l'instant
			// ex : case "switchMove": {_argument switchMove _parametre;};
		};

		// Commandes é faire uniquement sur le serveur
		if (isServer) then
		{
			if (_commande == "setOwnerTo") then	{
				if (count crew _argument == 0) then {
					_argument setOwner (owner _parametre);
				} else {
					private _grp = group (crew _argument select 0);
					_grp setGroupOwner (owner _parametre);
				};
			};
		};
	};
	"R3F_LOG_PV_commande_MP" addPublicVariableEventHandler R3F_LOG_FNCT_PVEH_commande_MP;

	/**
	 * Ordonne l'exécution d'une commande quelque soit la localité de l'argument ou de l'effet
	 * @param 0 l'argument sur lequel exécuter la commande
	 * @param 1 la commande é exécuter (chaéne de caractéres)
	 * @param 2 les éventuels paramétres de la commande (optionnel)
	 * @usage [_objet, "setDir", 160] call R3F_LOG_FNCT_exec_commande_MP
	 */
	R3F_LOG_FNCT_exec_commande_MP =
	{
		R3F_LOG_PV_commande_MP = _this;
		publicVariable "R3F_LOG_PV_commande_MP";
		["R3F_LOG_PV_commande_MP", R3F_LOG_PV_commande_MP] spawn R3F_LOG_FNCT_PVEH_commande_MP;
	};

	/** Pseudo-mutex permettant de n'exécuter qu'un script de manipulation d'objet à la fois (true : vérouillé) */
	R3F_LOG_mutex_local_verrou = false;

	call compile preprocessFileLineNumbers "R3F_LOG\fonctions_generales\lib_geometrie_3D.sqf";

	// Indices du tableau des fonctionnalités retourné par R3F_LOG_FNCT_determiner_fonctionnalites_logistique
	R3F_LOG_IDX_can_be_depl_heli_remorq_transp = 0;
	R3F_LOG_IDX_can_be_moved_by_player = 1;
	R3F_LOG_IDX_can_lift = 2;
	R3F_LOG_IDX_can_be_lifted = 3;
	R3F_LOG_IDX_can_tow = 4;
	R3F_LOG_IDX_can_be_towed = 5;
	R3F_LOG_IDX_can_transport_cargo = 6;
	R3F_LOG_IDX_can_transport_cargo_cout = 7;
	R3F_LOG_IDX_can_be_transported_cargo = 8;
	R3F_LOG_IDX_can_be_transported_cargo_cout = 9;
	R3F_LOG_CST_zero_log = [false, false, false, false, false, false, false, 0, false, 0];

	R3F_LOG_FNCT_determiner_fonctionnalites_logistique = compile preprocessFileLineNumbers "R3F_LOG\fonctions_generales\determiner_fonctionnalites_logistique.sqf";
	R3F_calculer_chargement_vehicule = compile preprocessFileLineNumbers "R3F_LOG\transporteur\calculer_chargement_vehicule.sqf";
	R3F_transporteur_charger_auto = compile preprocessFileLineNumbers "R3F_LOG\transporteur\charger_auto.sqf";

	// Un serveur dédié n'en a pas besoin
	if (!isDedicated && hasInterface) then {
		// Le client attend que le serveur ai créé et publié la référence de l'objet servant de point d'attache
		waitUntil {sleep 0.5;!isNil "R3F_LOG_PUBVAR_point_attache"};

		/** Indique quel objet le joueur est en train de déplacer, objNull si aucun */
		R3F_LOG_joueur_deplace_objet = objNull;

		/** Objet actuellement sélectionner pour étre chargé/remorqué */
		R3F_LOG_objet_selectionne = objNull;

		/** Objet actuellement sélectionner pour étre heliporté */	
		R3F_LOG_objet_heliporter = objNull;

		/** Tableau contenant toutes les usines créées */
		R3F_LOG_CF_liste_usines = [];

		call compile preprocessFileLineNumbers "R3F_LOG\fonctions_generales\lib_visualisation_objet.sqf";

		R3F_LOG_FNCT_objet_relacher = compile preprocessFileLineNumbers "R3F_LOG\objet_deplacable\relacher.sqf";
		R3F_LOG_FNCT_objet_deplacer = compile preprocessFileLineNumbers "R3F_LOG\objet_deplacable\deplacer.sqf";

		R3F_LOG_FNCT_heliporteur_heliporter = compile preprocessFileLineNumbers "R3F_LOG\heliporteur\heliporter.sqf";
		R3F_LOG_FNCT_heliporteur_detect_objet = compile preprocessFileLineNumbers "R3F_LOG\heliporteur\detect_objet.sqf";
		R3F_LOG_FNCT_heliporteur_larguer = compile preprocessFileLineNumbers "R3F_LOG\heliporteur\larguer.sqf";
		R3F_LOG_FNCT_heliporteur_init = compile preprocessFileLineNumbers "R3F_LOG\heliporteur\heliporteur_init.sqf";

		R3F_LOG_FNCT_remorqueur_detacher = compile preprocessFileLineNumbers "R3F_LOG\remorqueur\detacher.sqf";
		R3F_LOG_FNCT_remorqueur_fix = compile preprocessFileLineNumbers "R3F_LOG\remorqueur\remorqueur_fix.sqf";
		R3F_LOG_FNCT_remorqueur_remorquer_deplace = compile preprocessFileLineNumbers "R3F_LOG\remorqueur\remorquer_deplace.sqf";
		R3F_LOG_FNCT_remorqueur_remorquer_direct = compile preprocessFileLineNumbers "R3F_LOG\remorqueur\remorquer_direct.sqf";
		R3F_LOG_FNCT_remorqueur_init = compile preprocessFileLineNumbers "R3F_LOG\remorqueur\remorqueur_init.sqf";

		R3F_LOG_FNCT_transporteur_charger_deplace = compile preprocessFileLineNumbers "R3F_LOG\transporteur\charger_deplace.sqf";
		R3F_LOG_FNCT_transporteur_charger_selection = compile preprocessFileLineNumbers "R3F_LOG\transporteur\charger_selection.sqf";
		R3F_LOG_FNCT_transporteur_decharger = compile preprocessFileLineNumbers "R3F_LOG\transporteur\decharger.sqf";
		R3F_LOG_FNCT_transporteur_selectionner_objet = compile preprocessFileLineNumbers "R3F_LOG\transporteur\selectionner_objet.sqf";
		R3F_LOG_FNCT_transporteur_voir_contenu_vehicule = compile preprocessFileLineNumbers "R3F_LOG\transporteur\voir_contenu_vehicule.sqf";
		R3F_LOG_FNCT_transporteur_init = compile preprocessFileLineNumbers "R3F_LOG\transporteur\transporteur_init.sqf";

		R3F_LOG_FNCT_objet_init = compile preprocessFileLineNumbers "R3F_LOG\objet_commun\objet_init.sqf";
		R3F_LOG_FNCT_objet_est_verrouille = compile preprocessFileLineNumbers "R3F_LOG\objet_commun\objet_est_verrouille.sqf";
		R3F_LOG_FNCT_deverrouiller_objet = compile preprocessFileLineNumbers "R3F_LOG\objet_commun\deverrouiller_objet.sqf";
		R3F_LOG_FNCT_definir_proprietaire_verrou = compile preprocessFileLineNumbers "R3F_LOG\objet_commun\definir_proprietaire_verrou.sqf";

		R3F_LOG_FNCT_formater_fonctionnalites_logistique = compile preprocessFileLineNumbers "R3F_LOG\fonctions_generales\formater_fonctionnalites_logistique.sqf";
		R3F_LOG_FNCT_formater_nombre_entier_milliers = compile preprocessFileLineNumbers "R3F_LOG\fonctions_generales\formater_nombre_entier_milliers.sqf";

		// Liste des variables activant ou non les actions de menu
		R3F_LOG_action_charger_deplace_valide = false;
		R3F_LOG_action_charger_selection_valide = false;
		R3F_LOG_action_contenu_vehicule_valide = false;

		R3F_LOG_action_remorquer_deplace_valide = false;

		R3F_LOG_action_heliporter_valide = false;
		R3F_LOG_action_heliport_larguer_valide = false;
		R3F_LOG_action_heliport_paradrop_valide = false;

		R3F_LOG_action_deplacer_objet_valide = false;
		R3F_LOG_action_remorquer_direct_valide = false;
		R3F_LOG_action_detacher_valide = false;
		R3F_LOG_action_selectionner_objet_charge_valide = false;

		R3F_LOG_action_ouvrir_usine_valide = false;
		R3F_LOG_action_revendre_usine_direct_valide = false;
		R3F_LOG_action_revendre_usine_deplace_valide = false;
		R3F_LOG_action_revendre_usine_selection_valide = false;

		R3F_LOG_action_deverrouiller_valide = false;

		/** Sur ordre (publicVariable), révéler la présence d'un objet au joueur (accélérer le retour des addActions) */
		R3F_LOG_FNCT_PUBVAR_reveler_au_joueur =
		{
			private ["_objet"];
			_objet = _this select 1;

			if (alive player) then {
				player reveal [_objet, 4];
			};
		};
		"R3F_LOG_PUBVAR_reveler_au_joueur" addPublicVariableEventHandler R3F_LOG_FNCT_PUBVAR_reveler_au_joueur;

		/** Event handler GetIn : ne pas monter dans un véhicule qui est en cours de transport */
		R3F_LOG_FNCT_EH_GetIn =
		{
			if (local (_this select 2)) then
			{
				_this spawn
				{
					sleep 0.1;
					if ((!(isNull (_this select 0 getVariable "R3F_LOG_est_deplace_par")) && (alive (_this select 0 getVariable "R3F_LOG_est_deplace_par")) && (isPlayer (_this select 0 getVariable "R3F_LOG_est_deplace_par"))) || !(isNull (_this select 0 getVariable "R3F_LOG_est_transporte_par"))) then
					{
						(_this select 2) action ["GetOut", _this select 0];
						(_this select 2) action ["Eject", _this select 0];
						if (player == _this select 2) then {hintC format [STR_R3F_LOG_objet_en_cours_transport, [(_this select 0)] call F_getLRXName]};
					};
				};
			};
		};

		// Actions é faire quand le joueur est apparu
		0 spawn
		{
			waitUntil {sleep 1; !isNull player};

			// Ajout d'un event handler "WeaponDisassembled" pour gérer le cas oé une arme est démontée alors qu'elle est en cours de transport
			player addEventHandler ["WeaponDisassembled",
			{
				private ["_objet"];

				// Récupération de l'arme démontée avec cursorObject au lieu de _this (http://feedback.arma3.com/view.php?id=18090)
				_objet = cursorObject;

				if (!isNull _objet && {!isNull (_objet getVariable ["R3F_LOG_est_deplace_par", objNull])}) then
				{
					_objet setVariable ["R3F_LOG_est_deplace_par", objNull, true];
				};
			}];
		};

		/** Variable publique passer é true pour informer le script surveiller_nouveaux_objets.sqf de la création d'un objet */
		R3F_LOG_PUBVAR_nouvel_objet_a_initialiser = false;

		/* Vérification permanente des conditions donnant accés aux addAction */
		[] spawn compileFinal preprocessFileLineNumbers "R3F_LOG\surveiller_conditions_actions_menu.sqf";

		/* Auto-détection permanente des objets sur le jeu */
		[] spawn compileFinal preprocessFileLineNumbers "R3F_LOG\surveiller_nouveaux_objets.sqf";

		/*
		 * Systéme assurant la protection contre les blessures lors du déplacement d'objets
		 * On choisit de ne pas faire tourner le systéme sur un serveur dédié par économie de ressources.
		 * Seuls les joueurs et les IA commandées par les joueurs (locales) seront protégés.
		 * Les IA n'étant pas commandées par un joueur ne seront pas protégées, ce qui est un moindre mal.
		 */
		//[] spawn compileFinal preprocessFileLineNumbers "R3F_LOG\systeme_protection_blessures.sqf";

		waitUntil {!(isNull (findDisplay 46))};
    	systemChat "-------- R3F Logistics Initialized --------";
	};

	R3F_LOG_active = true;

#else
	// Pour les actions du PC d'arti
	R3F_LOG_joueur_deplace_objet = objNull;
	R3F_LOG_active = false;
#endif