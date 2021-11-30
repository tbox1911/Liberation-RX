#define AI_GROUP_SMALL 8
#define AI_GROUP_MEDIUM 12
#define AI_GROUP_LARGE 16

private _ret = AI_GROUP_SMALL;
private _nb_player = count AllPlayers;

if (_nb_player > 2) then { _ret = AI_GROUP_MEDIUM };
if (_nb_player > 5) then { _ret = AI_GROUP_LARGE };

//_ret = _ret + floor(random (_ret/2));
_ret;
