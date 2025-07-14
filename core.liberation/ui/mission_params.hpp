class Params
{
	class MissionOptions{
		title = $STR_PARAMS_MISSIONOPTIONS;
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Space0 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class OpenParams {
		title = "Open Mission Parameters";
		values[] = { 0, 1 };
		texts[] = { $STR_PARAMS_DISABLED, $STR_PARAMS_ENABLED };
		default = 0;
	};
	class Space1 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Whitelist {
		title = $STR_WHITELIST_PARAM;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 1;
	};
	class Exclusive {
		title = $STR_EXCLUSIVE_PARAM;
		values[] = { 1, 0 };
		texts[] = { $STR_PARAMS_ENABLED, $STR_PARAMS_DISABLED };
		default = 0;
	};
	class Space2 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class WipeContext {
		title = $STR_WIPE_CONTEXT;
		values[] = { 0, 1 };
		texts[] = { $STR_WIPE_NO, $STR_WIPE_YES };
		default = 0;
	};
	class WipeSave1 {
		title = $STR_WIPE_TITLE;
		values[] = { 0, 1 };
		texts[] =  { $STR_WIPE_NO, $STR_WIPE_YES };
		default = 0;
	};
	class WipeSave2 {
		title = $STR_WIPE_TITLE_2;
		values[] = { 0, 1 };
		texts[] = { $STR_WIPE_NO, $STR_WIPE_YES };
		default = 0;
	};
	class Space3 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class ForceLoading {
		title = "Force loading (ignore mod/save errors)";
		values[] = {0,1};
		texts[] = { $STR_NO,$STR_YES };
		default = 0;
	};
	class LogSettings {
		title = "Log Mission Settings at startup";
		values[] = {0,1};
		texts[] = { $STR_NO,$STR_YES };
		default = 0;
	};
	class Space99 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
};
