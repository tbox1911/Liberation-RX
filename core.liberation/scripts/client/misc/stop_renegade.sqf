waitUntil {sleep 1;GRLIB_player_spawned};

while { true } do {
  waitUntil {sleep 1; alive player && lifeState player != 'incapacitated' && side player != GRLIB_side_friendly};
  sleep 10;
  if (alive player && lifeState player != 'incapacitated' && side player != GRLIB_side_friendly) then {
    systemchat format ["Player %1 wrong side !! (%2), try to fix group...", name player, side player];
    if (isNull my_group) then {
      [] call get_group;
    };
    player addrating 2000;
    [player] joinSilent my_group;
    my_group selectLeader player;
  };
};
