scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};
if (player diarySubjectExists "DALE") exitWith {};

private _subject = "DALE";
private _briefing = [
    localize "STR_RPL_DALE_INTRO_1",
    localize "STR_RPL_DALE_INTRO_2",
    localize "STR_RPL_DALE_INTRO_3",
    localize "STR_RPL_DALE_INTRO_4",
    localize "STR_RPL_DALE_INTRO_5",
    "<br />"
];


waitUntil {!isNull player};

player createDiarySubject [_subject,_subject];
player createDiaryRecord [_subject,[_subject,_briefing joinString "<br />"]]