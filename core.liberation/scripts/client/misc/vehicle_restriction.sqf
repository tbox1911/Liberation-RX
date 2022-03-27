HeliUnits= ["b_air","b_att_air"]; 
PlaneUnits= [ "b_plane_cas", "b_plane_cap", "b_plane_sead", "b_plane_multi", "b_plane", "b_plane_cargo"]; 
TankUnits= ["b_mech_inf", "b_armor", "b_art"]; 
 
player addEventHandler [  
	"GetInMan",   
	{  

		params ["_unit", "_role", "_vehicle", "_turret"]; 
//		systemChat format ["%1 - %2 ",_role, _turret];   Debug
		If !(SNC_VehRestriction) exitwith{};	
		
		If (_role == "Cargo") exitwith {}; 

		private _GrpRol = group _unit getVariable ["BIS_dg_rol","b_unknown"];  


		if (_vehicle isKindof "Helicopter") then { 
			if !(_GrpRol in HeliUnits) then{ 
				_unit action ["getOut", _vehicle]; 
				hint format ["Wrong Group Role", name player];
			}; 
		}; 

		if (_vehicle isKindof "Plane") then { 
			if !(_GrpRol in PlaneUnits) then{ 
				_unit action ["getOut", _vehicle]; 
				hint format ["Wrong Group Role", name player];
			}; 
		}; 

		if (_vehicle isKindof "Tank") then { 
			if !(_GrpRol in TankUnits) then{ 
				_unit action ["getOut", _vehicle]; 
				hint format ["Wrong Group Role", name player];
			}; 
		}; 
	}  
];