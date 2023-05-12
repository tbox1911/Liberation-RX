if (!isServer && hasInterface) exitWith {};

params [ "_new_fob", "_classname"];
private [ "_fob_building", "_fob_pos", "_fob_box_list", "_ruin_list" ];

GRLIB_all_fobs pushback _new_fob;

if (_classname == FOB_outpost) then { GRLIB_all_outposts pushBack _new_fob };
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

[ _new_fob, 0 ] remoteExec ["remote_call_fob", 0];
sleep 1;
stats_fobs_built = stats_fobs_built + 1;