HeliUnits= ["b_air","b_att_air"]; 
PlaneUnits= [ "b_plane_cas", "b_plane_cap", "b_plane_sead", "b_plane_multi", "b_plane", "b_plane_cargo"]; 
TankUnits= ["b_mech_inf", "b_armor", "b_art"]; 
 
player addEventHandler [  
	"GetInMan",   
	{  

		params ["_unit", "_role", "_vehicle", "_turret"]; 
//		systemChat format ["%1 - %2 ",_role, _turret];   Debug
		if !(SNC_VehRestriction) exitwith{};	
		
		if (_role == "Cargo") exitwith {}; 
		if (_vehicle isKindof "ParachuteBase") exitwith {}; 
		private _GrpRol = group _unit getVariable ["BIS_dg_rol","b_unknown"];  
		
 
		/* if ((typeOf _vehicle in opfor_battlegroup_vehicles) || (typeOf _vehicle in opfor_vehicles)) then {
			_vehicle setVehicleAmmo 0; 
			hint "keine Ahnung wie man das Ding abfeuert...";
		}; */

		
		if (_vehicle isKindof "Helicopter") then { 
			if (/*!(_GrpRol in HeliUnits) ||*/ !([player,2] call fetch_permission)) then{ 
				_unit action ["getOut", _vehicle]; 
				hint format ["Wrong Group Role or missing Permission", name player];
			}; 
		}; 

		if (_vehicle isKindof "Plane") then { 
			if (/*!(_GrpRol in PlaneUnits) ||*/ !([player,2] call fetch_permission)) then{ 
				_unit action ["getOut", _vehicle]; 
				hint format ["Wrong Group Role or missing Permission", name player];
			}; 
		}; 

		if (_vehicle isKindof "Tank") then { 
			if (/*!(_GrpRol in TankUnits) ||*/ !([player,1] call fetch_permission)) then{ 
				_unit action ["getOut", _vehicle]; 
				hint format ["Wrong Group Role or missing Permission", name player];
			}; 
		}; 
	}  
];
