while { true } do {
  waitUntil {sleep 1; alive player && lifeState player != 'incapacitated' && side player != GRLIB_side_friendly};
  sleep 10;
  if (alive player && lifeState player != 'incapacitated' && side player != GRLIB_side_friendly) then {
    //systemchat format ["Player %1 wrong side : (%2), try to fix group...", name player, side player];
    if (isNull my_group) then {
      my_group = createGroup [GRLIB_side_friendly, true];
      my_group setGroupId [format ["<%1>", name player]];
      [my_group, "add"] remoteExec ["addel_group", 2];
    };
    player setcaptive true;
    [player] joinSilent (my_group);
    (my_group) selectLeader player;
    player setcaptive false;
  };
  //sleep 5;
};
