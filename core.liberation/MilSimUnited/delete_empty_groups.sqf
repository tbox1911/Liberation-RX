while(limit_hc_gr) do {
    {
        if ((count units _x) isEqualto 0) then {
            deletegroup _x;
        };
    } count allgroups;
    sleep 1;
};