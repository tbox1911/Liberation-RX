Vcm_Settings = 
{
	/*
		ADDITIONAL COMMANDS
		(group this) setVariable ["VCM_NOFLANK",true]; //This command will stop the AI squad from executing advanced movement maneuvers.
		(group this) setVariable ["VCM_NORESCUE",true]; //This command will stop the AI squad from responding to calls for backup.
		(group this) setVariable ["VCM_TOUGHSQUAD",true]; //This command will stop the AI squad from calling for backup.
		(group this) setVariable ["Vcm_Disable",true]; //This command will disable Vcom AI on a group entirely.
		(group this) setVariable ["VCM_DisableForm",true]; //This command will disable AI group from changing formations.	
		(group this) setVariable ["VCM_Skilldisable",true]; //This command will disable an AI group from being impacted by Vcom AI skill changes.	
		
	*/	

	Vcm_ActivateAI = true; //Set this to false to disable VcomAI. It can be set to true at any time to re-enable Vcom AI
	VcmAI_ActiveList = []; //Leave this alone.
	Vcm_ArtilleryArray = []; //Leave this alone
	
	//VCOM ARTILLERY. Only one kind of advanced artillery can be used at a time.
	VCM_ARTYENABLE = true; //Enable improved artillery handling from Vcom.
	VCM_ARTYLST = []; //List of all AI inside of artillery pieces, leave this alone.
	VCM_ARTYDELAY = 30; //Delay between squads requesting artillery
	VCM_ARTYWT = -(VCM_ARTYDELAY);
	VCM_ARTYET = -(VCM_ARTYDELAY);
	VCM_ARTYRT = -(VCM_ARTYDELAY);
	VCM_ARTYSIDES = [west,east,resistance];  //Sides that will use VCOM/FFE artillery
	VCM_AIMagLimit = 5; //Number of mags remaining before AI looks for ammo.
	VCM_Debug = false; //Enable debug mode.
	VCM_MINECHANCE = 75; //Chance to lay a mine
	VCM_SIDEENABLED = [west,east,resistance]; //Sides that will activate Vcom AI
	VCM_RAGDOLL = true; //Should AI ragdoll when hit
	VCM_RAGDOLLCHC = 50; //CHANCE AI RAGDOLL	
	VCM_FullSpeed = true; //Enforce full speedmode during combat (Does not reset after combat end)
	VCM_HEARINGDISTANCE = 800; //Distance AI hear unsuppressed gunshots.
	VCM_WARNDIST = 1000; //How far AI can request help from other groups.
	VCM_WARNDELAY = 30; //How long the AI have to survive before they can call in for support. This activates once the AI enter combat.
	VCM_STATICARMT = 300; //How long AI stay on static weapons when initially arming them. This is just for AI WITHOUT static bags. They will stay for this duration when NO ENEMIES ARE SEEN, or their group gets FAR away.	
	VCM_StealVeh = true; //Will the AI steal vehicles.
	VCM_ClassSteal = true; //If true, crewmen are required to steal tracked vehicles. Pilots are required to steal aircraft. false = anyone can steal any vehicle.
	VCM_AIDISTANCEVEHPATH = 100; //Distance AI check from the squad leader to steal vehicles
	VCM_ADVANCEDMOVEMENT = true; //True means AI will actively generate waypoints if no other waypoints are generated for the AI group (2 or more). False disables this advanced movements.
	VCM_FRMCHANGE = true; //AI GROUPS WILL CHANGE FORMATIONS TO THEIR BEST GUESS.
	VCM_SKILLCHANGE = true; //AI Groups will have their skills changed by Vcom.
	VCM_USECBASETTINGS = true;//If CBA is enabled on the host, use the CBA default settings. If false, use the filepatching settings instead.
	VCM_CARGOCHNG = true; //If true, Vcom will handle disembarking/re-embarking orders instead of vanilla. This is with the intention to prevent the endless embark/disembark loops AI are given.
	VCM_TURRETUNLOAD = true;//If true, AI will automatically disembark turret positions in vehicles, if the vehicle is badly damaged. This is to prevent AI leaving a tank, when the tracks are damaged.
	VCM_DISEMBARKRANGE = 200; //How far AI will disembark from their enemies. If the vehicle is damaged, they will disembark.
	
	//AI SKILL SETTINGS HERE!!!!!!!!!!!!
	//LOW DIFFICULTY
	//VCM_AIDIFA = [['aimingAccuracy',0.15],['aimingShake',0.1],['aimingSpeed',0.25],['commanding',1],['courage',1],['endurance',1],['general',0.5],['reloadSpeed',1],['spotDistance',0.8],['spotTime',0.8]];
		
	//MEDIUM DIFFICULTY
	VCM_AIDIFA = [['aimingAccuracy',0.25],['aimingShake',0.15],['aimingSpeed',0.35],['commanding',0.85],['courage',0.5],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];
	
	//HIGH DIFFICULTY
	//VCM_AIDIFA = [['aimingAccuracy',0.35],['aimingShake',0.4],['aimingSpeed',0.45],['commanding',1],['courage',1],['endurance',1],['general',0.5],['reloadSpeed',1],['spotDistance',0.8],['spotTime',0.8]];
	
	//SIDE SPECIFIC
	VCM_AIDIFWEST = [['aimingAccuracy',0.25],['aimingShake',0.15],['aimingSpeed',0.35],['commanding',0.85],['courage',0.5],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];
	VCM_AIDIFEAST = [['aimingAccuracy',0.25],['aimingShake',0.15],['aimingSpeed',0.35],['commanding',0.85],['courage',0.5],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];
	VCM_AIDIFRESISTANCE = [['aimingAccuracy',0.25],['aimingShake',0.15],['aimingSpeed',0.35],['commanding',0.85],['courage',0.5],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];
		
	VCM_AISIDESPEC =
	{
		private _Side = (side (group _this));
		switch (_Side) do {
			case west: 
			{
				{
					_this setSkill _x;
				} forEach VCM_AIDIFWEST;				
			};
			case east: 
			{
				{
					_this setSkill _x;
				} forEach VCM_AIDIFEAST;					
			}; 
			case resistance: 
			{
				{
					_this setSkill _x;
				} forEach VCM_AIDIFRESISTANCE;					
			}; 
		};		
	};
	
	
	VCM_CLASSNAMESPECIFIC = false; //Do you want the AI to have classname specific skill settings?
	VCM_SIDESPECIFICSKILL = false; //Do you want the AI to have side specific skill settings? This overrides classname specific skills.
	VCM_SKILL_CLASSNAMES = []; //Here you can assign certain unit classnames to specific skill levels. This will override the AI skill level above.
	
	/*
	EXAMPLE FOR VCM_SKILL_CLASSNAMES
	
	VCM_SKILL_CLASSNAMES = [["Classname1",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]],["Classname2",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]]];
	VCM_SKILL_CLASSNAMES = 	[
														["B_GEN_Soldier_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]],
														["B_G_Soldier_AR_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]]
													]; 
	
	*/

		
	VCM_AIDIFSET =
	{
		{
			private _unit = _x;
			_unit setSkill 0.9;
			_unit allowFleeing 0;			
			{
				_unit setSkill _x;
			} forEach VCM_AIDIFA;
			
			
			if (VCM_CLASSNAMESPECIFIC && {count VCM_SKILL_CLASSNAMES > 0}) then
			{
				{
					if (typeOf _unit isEqualTo (_x select 0)) exitWith
					{
						_ClassnameSet = true;
						_unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_unit setSkill ["aimingShake",((_x select 1) select 1)];_unit setSkill ["spotDistance",((_x select 1) select 2)];_unit setSkill ["spotTime",((_x select 1) select 3)];_unit setSkill ["courage",((_x select 1) select 4)];_unit setSkill ["commanding",((_x select 1) select 5)];	_unit setSkill ["aimingSpeed",((_x select 1) select 6)];_unit setSkill ["general",((_x select 1) select 7)];_unit setSkill ["endurance",((_x select 1) select 8)];_unit setSkill ["reloadSpeed",((_x select 1) select 9)];
					};
				} foreach VCM_SKILL_CLASSNAMES;
			};			
			
			if (VCM_SIDESPECIFICSKILL) then
			{
				_unit call VCM_AISIDESPEC;
			};
			
		} forEach (units _this);
	};
	
	diag_log "VCOM: Loaded Userconfig";

if (VCM_USECBASETTINGS) then {
    [] call VCM_fnc_CBASettings;
};

};