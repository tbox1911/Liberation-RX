#define AI_GROUP_SMALL 8
#define AI_GROUP_MEDIUM 12
#define AI_GROUP_LARGE 16

private _ret = AI_GROUP_SMALL;
private _nb_player = count AllPlayers;

switch (true) do {
 case ( _nb_player > 5): {_ret = AI_GROUP_LARGE};
 case ( _nb_player > 2): {_ret = AI_GROUP_MEDIUM};
};

_ret = _ret + round(random (_ret*0.4));
_ret;
