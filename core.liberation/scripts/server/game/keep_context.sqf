GRLIB_permissions = [];
GRLIB_player_scores = [];

if (GRLIB_param_wipe_keepscore == 1) then {
    diag_log "--- LRX Config: Keep players scores and perms.";
    GRLIB_permissions = profileNamespace getVariable GRLIB_save_key select 13;
    {
        if (_x select 1 > GRLIB_perm_tank) then {
            _x set [1, GRLIB_perm_tank];	// score
        };
        if (_x select 2 > 3000) then {
            _x set [2, 3000];		// ammo
        };
        if (_x select 3 > 400) then {
            _x set [3, 400];		// fuel
        };
        GRLIB_player_scores pushback _x;
    } foreach (profileNamespace getVariable GRLIB_save_key select 16);
};

if (GRLIB_param_wipe_keepcontext == 1) then {
    diag_log "--- LRX Config: Keep players context.";
    GRLIB_player_context = (profileNamespace getVariable GRLIB_save_key select 14);
};
