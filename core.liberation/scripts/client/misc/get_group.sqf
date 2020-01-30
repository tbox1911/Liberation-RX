// Group Managment
waitUntil {sleep 1;! isNil "global_locked_group"};
waitUntil {sleep 1;alive player};

my_group = createGroup [GRLIB_side_friendly, true];

while { my_group in global_locked_group } do {
	my_group = createGroup [GRLIB_side_friendly, true];
	sleep 1;
};

[player] joinSilent my_group;
[my_group, "add"] remoteExec ["addel_group", 2];

my_group;