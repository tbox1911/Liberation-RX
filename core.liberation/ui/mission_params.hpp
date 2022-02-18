class Params
{
	class MissionOptions{
		title = $STR_PARAMS_MISSIONOPTIONS;
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Unitcap{
		title = $STR_PARAMS_UNITCAP;
		values[] = {0.5,0.75,1,1.25,1.5,2};
		texts[] = {$STR_PARAMS_UNITCAP1,$STR_PARAMS_UNITCAP2,$STR_PARAMS_UNITCAP3,$STR_PARAMS_UNITCAP4,$STR_PARAMS_UNITCAP5,$STR_PARAMS_UNITCAP6};
		default = 2;
	};
	class FancyInfo {
		title = $STR_FANCY;
		values[] = { 2, 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, "Info", $STR_PARAMS_DISABLED };
		default = 0;
	};
	class HideOpfor {
		title = $STR_OPFORMARK;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class EnableArsenal {
		title = $STR_ARSENAL;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class LimitedArsenal {
		title = $STR_LIMIT_ARSENAL;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class EnableFilter {
		title = $STR_FILTER_ARSENAL;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};	
	class EnableLock {
		title = $STR_VEH_LOCK;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class Thermic {
		title = $STR_THERMAL;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class DeathChat {
		title = $STR_DEATHCHAT;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class Space5 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class ModPresetWest {
		title = "MOD Preset - Friendly";
		values[] = { 0,1,2,3,4,5,6,7,8,9,10 };
		texts[] = { "A3 NATO", "A3 CSAT", "A3 AAF", "CUP BAF Desert", "CUP USMC", "RHS USAF", "RHS AFRF", "GM WEST", "GM WEST Winter", "OPTRE West", "WS UNA" };
		default = 5;
	};
	class ModPresetEast {
		title = "MOD Preset - Enemy";
		values[] = { 0,1,2,3,4,5,6,7,8,9,10,11 };
		texts[] = { "A3 CSAT", "A3 NATO", "A3 AAF", "A3 CSAT Urban", "CUP Takistan", "EJW Taliban", "RHS AFRF", "RHS USAF", "GM EAST", "GM EAST Winter", "OPTRE East", "WS FIA"};
		default = 6;
	};
	class ForcedLoadout {
		title = $STR_FORCE_LOADOUT;
		values[] = { 0,1,2 };
		texts[] = { $STR_PARAMS_DISABLED, "Preset 1", "Preset 2" };
		default = 1;
	};
	class EnglishOpfor {
		title = "Force Opfor to speak english";
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class FobType{
		title = $STR_PARAM_FOB_TYPE ;
		values[] = {0,1};
		texts[] = {"Huron", "Truck"};
		default = 1;
	};
	class HuronType{
		title = $STR_PARAM_HURON_TYPE ;
		values[] = {0,1,2,3};
		texts[] = {$STR_PARAMS_DISABLED, "CH-67 Huron", "CH-49 Mohawk", "UH-80 Ghost Hawk"};
		default = 0;
	};
	class Space1 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Difficulty {
		title = $STR_PARAMS_DIFFICULTY;
		values[] = { 0.5, 0.75, 1, 1.25, 1.5, 2, 4, 10 };
		texts[] = { $STR_PARAMS_DIFFICULTY1, $STR_PARAMS_DIFFICULTY2, $STR_PARAMS_DIFFICULTY3, $STR_PARAMS_DIFFICULTY4, $STR_PARAMS_DIFFICULTY5, $STR_PARAMS_DIFFICULTY6, $STR_PARAMS_DIFFICULTY7, $STR_PARAMS_DIFFICULTY8 };
		default = 2;
	};
	class Aggressivity{
		title = $STR_AGGRESSIVITY_PARAM;
		values[] = {0.25,0.5,1,2,4};
		texts[] = {$STR_AGGRESSIVITY_PARAM0, $STR_AGGRESSIVITY_PARAM1,$STR_AGGRESSIVITY_PARAM2,$STR_AGGRESSIVITY_PARAM3,$STR_AGGRESSIVITY_PARAM4};
		default = 1;
	};
	class AdaptToPlayercount{
		title = $STR_PARAM_ADAPT_TO_PLAYERCOUNT;
		values[] = {1,0};
		texts[] = {$STR_PARAMS_ENABLED,$STR_PARAMS_DISABLED};
		default = 1;
	};
	class SectorRadius{
		title = $STR_PARAM_SECTOR_RADIUS;
		values[] = {0,300,400,500,600,700,800,900,1000,1200,1500};
		texts[] = {$STR_PARAMS_DISABLED,300,400,500,600,700,800,900,1000,1200,1500};
		default = 600;
	};
	class DayDuration {
		title = $STR_PARAMS_DAYDURATION;
        values[] = {7, 6, 4, 3, 2, 1};
        texts[] = {"3.43","4","6","8","12","24"};
		default = 7;
	};
	class ShorterNights {
		title = $STR_SHORTER_NIGHTS_PARAM;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class Weather {
		title = $STR_WEATHER_PARAM;
		values[] = { 1,2,3,4 };
		texts[] = { $STR_WEATHER_PARAM1, $STR_WEATHER_PARAM2, $STR_WEATHER_PARAM3, $STR_WEATHER_PARAM4 };
		default = 4;
	};
	class ResourcesMultiplier {
		title = $STR_PARAMS_RESOURCESMULTIPLIER;
		values[] = { 0.25, 0.5, 0.75, 1, 1.25, 1.5, 2, 3, 5, 10, 20, 50 };
		texts[] = { "x0.25", "x0.5", "x0.75", "x1", "x1.25","x1.5","x2","x3","x5","x10","x20","x50" };
		default = 1;
	};
	class Space2 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Fatigue {
		title = $STR_PARAMS_FATIGUE;
		values[] = { 0, 1 };
		texts[] = { $STR_PARAMS_DISABLED, $STR_PARAMS_ENABLED };
		default = 0;
	};
	class Revive {
		title = $STR_PARAMS_REVIVE;
		values[] = { 3, 2, 1, 0 };
		texts[] = { $STR_PARAMS_REVIVE3, $STR_PARAMS_REVIVE2, $STR_PARAMS_REVIVE1, $STR_PARAMS_DISABLED };
		default = 2;
	};
	class TK_mode {
		title = $STR_TK_MODE;
		values[] = { 0, 1, 2 };
		texts[] = { $STR_TK_MODE_STRICT, $STR_TK_MODE_RELAX, $STR_PARAMS_DISABLED };
		default = 2;
	};
	class TK_count {
		title = $STR_TK_COUNT;
		values[] = { 3, 4, 5, 6, 7, 8, 9, 10 };
		texts[] = { 3, 4, 5, 6, 7, 8, 9, 10 };
		default = 10;
	};
	class PassiveIncome{
		title = $STR_PARAM_PASSIVE_INCOME;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class Civilians{
		title = $STR_PARAMS_CIVILIANS;
		values[] = {0,0.5,1,2};
		texts[] = {$STR_PARAMS_CIVILIANS1,$STR_PARAMS_CIVILIANS2,$STR_PARAMS_CIVILIANS3,$STR_PARAMS_CIVILIANS4};
		default = 1;
	};
	class WildLife{
		title = $STR_PARAM_WILDLIFE;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class Patrol{
		title = $STR_PARAM_PATROL;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class TeamkillPenalty{
		title = $STR_PARAM_TEAMKILL_PENALTY;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class AmmoBounties{
		title = $STR_AMMO_BOUNTIES;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class CivPenalties{
		title = $STR_CIV_PENALTIES;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class HaloJump{
		title = $STR_HALO_PARAM;
		values[] = {1,5,10,15,20,30,0};
		texts[] = { $STR_HALO_PARAM1, $STR_HALO_PARAM2, $STR_HALO_PARAM3, $STR_HALO_PARAM4, $STR_HALO_PARAM5, $STR_HALO_PARAM6, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class BluforDefenders{
		title = $STR_PARAM_BLUFOR_DEFENDERS;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class Autodanger{
		title = $STR_PARAM_AUTODANGER;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class MaximumFobs{
		title = $STR_PARAM_FOBS_COUNT;
		values[] = {3,5,7,10,15,20,26};
		texts[] = {3,5,7,10,15,20,26};
		default = 3;
	};
	class SquadSize{
		title = $STR_PARAM_SQUAD_SIZE_START;
		values[] = {0,1,2,3,4,5,6,7,8,9,10};
		texts[] = {0,1,2,3,4,5,6,7,8,9,10};
		default = 3;
	};
	class MaxSquadSize{
		title = $STR_PARAM_SQUAD_SIZE;
		values[] = {0,1,2,3,4,5,6,7,8,9,10};
		texts[] = {0,1,2,3,4,5,6,7,8,9,10};
		default = 3;
	};
	class MaxSpawnPoint{
		title = $STR_PARAM_SPAWN_MAX;
		values[] = {0,1,2,3,4};
		texts[] = {0,1,2,3,4};
		default = 0;
	};
	class Space3 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class TechnicalOptions{
		title = $STR_PARAMS_TECHNICALOPTIONS;
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Permissions{
		title = $STR_PERMISSIONS_PARAM;
		values[] = {1,0};
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class CleanupVehicles {
		title = $STR_CLEANUP_PARAM;
		values[] = { 0,1,2,4 };
		texts[] = { $STR_PARAMS_DISABLED, $STR_CLEANUP_PARAM1, $STR_CLEANUP_PARAM2, $STR_CLEANUP_PARAM3 };
		default = 1;
	};
	class Introduction {
		title = $STR_PARAMS_INTRO;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class DeploymentCinematic {
		title = $STR_PARAMS_DEPLOYMENTCAMERA;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
/*	class FirstFob {
		title = $STR_PARAMS_FIRSTFOB;
		values[] = { 1, 0 };
		texts[] = { $STR_YES, $STR_NO };
		default = 0;
	};*/
	class AdminMenu {
		title = "Enable the Admin Menu";
		values[] = { 1, 0 };
		texts[] = { $STR_YES, $STR_NO };
		default = 0;
	};
	class Space4 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Whitelist {
		title = $STR_WHITELIST_PARAM;
		values[] = { 1, 0 };
		texts[] = { $STR_WHITELIST_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class WipeSave1{
		title = $STR_WIPE_TITLE;
		values[] = {0,1};
		texts[] =  {$STR_WIPE_NO,$STR_WIPE_YES};
		default = 0;
	};
	class WipeSave2{
		title = $STR_WIPE_TITLE_2;
		values[] = {0,1};
		texts[] = {$STR_WIPE_NO,$STR_WIPE_YES};
		default = 0;
	};
	class ForceLoading{
		title = "Force save game loading.";
		values[] = {0,1};
		texts[] = { $STR_NO,$STR_YES };
		default = 0;
	};
	class DisableRemoteSensors{
		title = "Disable Remote Sensors (experimental!)";
		values[] = {0,1,2};
		texts[] = {"No","Disable for clients without local AIs","Disable for all clients"};
		default = 1;
	};
};
