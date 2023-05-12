class liberation_squad {
	idd = 5155;
	movingEnable = false;
	controlsBackground[] = {};

	controls[] = {"OuterBG", "RecycleBG","OuterBG_F", "InnerBG", "InnerBG_F", "OuterCenterPanel","Header","SquadList","DeployMap", "ButtonClose",
	"NameLabel", "ClassLabel", "HealthLabel", "DistanceLabel", "PrimaryLabel", "PrimaryMagsLabel", "SecondaryLabel", "SecondaryMagsLabel", "LoadoutLabel",
	"VehicleLabel","ResupplyButton", "LikeMeButton", "ReplaceButton", "RenameButton", "RemoveButton", "ConfirmButton", "CancelButton", "PiPZone",
	 "GREUH_Squad_OuterBG","GREUH_Squad_InnerBG","GREUH_Squad_OuterBG_F","GREUH_Squad_InnerBG_F","GREUH_ButtonName_Rename","GREUH_ButtonName_Abort","GREUH_Squad_TextField"};

	objects[] = {};

	class GREUH_OuterBG {
		idc = -1;
		type =  CT_STATIC;
		style = ST_SINGLE;
		colorText[] = COLOR_BLACK;
		colorBackground[] = COLOR_BROWN;
		font = FONTM;
		sizeEx = 0.023;
		x = (0.15 * safezoneW + safezoneX) - ( 2 * BORDERSIZE);
		y = ((BASE_Y + 0.02) * safezoneH) + safezoneY - (3 * BORDERSIZE);
		w = (0.2 * safezoneW) + (4 * BORDERSIZE);
		h = (0.79 * safezoneH) + (6 * BORDERSIZE);
		text = "";
	};
	class GREUH_OuterBG_F : GREUH_OuterBG {
		style = ST_FRAME;
	};
	class GREUH_InnerBG : GREUH_OuterBG {
		colorBackground[] = COLOR_GREEN;
		x = (0.15 * safezoneW + safezoneX)  - ( BORDERSIZE);
		y = ((BASE_Y + 0.07) * safezoneH) + safezoneY - (1.5 * BORDERSIZE);
		w = 0.2 * safezoneW +  (2 * BORDERSIZE);
		h = 0.74 * safezoneH  + (3 * BORDERSIZE);
	};
	class GREUH_InnerBG_F : GREUH_InnerBG {
		style = ST_FRAME;
	};

	class GREUH_ButtonGeneric {
		idc = -1;
		type = CT_BUTTON;
		style = ST_CENTER;
		default = false;
		font = FONTM;
		sizeEx = 0.018 * safezoneH;
		colorText[] = { 0, 0, 0, 1 };
		colorFocused[] = { 1, 1, 1, 1 };
		colorDisabled[] = { 0.2, 0.2, 0.2, 0.7 };
		colorBackground[] = { 0.8, 0.8, 0.8, 0.8 };
		colorBackgroundDisabled[] = { 0.5, 0.5, 0.5, 0.5 };
		colorBackgroundActive[] = { 1, 1, 1, 1 };
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = { 0, 0, 0, 0.5 };
		colorBorder[] = { 0, 0, 0, 1 };
		borderSize = 0;
		soundEnter[] = { "", 0, 1 };          // no sound
		soundPush[] = {"\a3\Ui_f\data\Sound\CfgIngameUI\hintExpand", 0.891251, 1};
		soundClick[] = { "", 0, 1 };          // no sound
		soundEscape[] = { "", 0, 1 };          // no sound
		x = 0.15 * safezoneW + safezoneX;
		w = 0.2 * safezoneW; h = 0.03 * safezoneH;
		text = "";
		action = "";
		shadow = 1;
	};

	class RecycleBG : BgPicture {
		x = (0.2 * safezoneW + safezoneX) - (2 * BORDERSIZE);
		y = (0.2 * safezoneH + safezoneY) - (3 * BORDERSIZE);
		w = (0.6 * safezoneW) + (4 * BORDERSIZE);
		h = (0.6 * safezoneH) + (6 * BORDERSIZE);
	};
	class DeployMap : kndr_MapControl {
		idc = 100;
		x = (0.32 * safezoneW + safezoneX)  + BORDERSIZE;
		y = (0.6 * safezoneH + safezoneY);
		w = (0.12 * safezoneW);
		h = (0.2 * safezoneH);
	};

	class OuterBG : StdBG{
		colorBackground[] = COLOR_BROWN;
		x = (0.2 * safezoneW + safezoneX) - (2 * BORDERSIZE);
		y = (0.2 * safezoneH + safezoneY) - (3 * BORDERSIZE);
		w = (0.6 * safezoneW) + (4 * BORDERSIZE);
		h = (0.6 * safezoneH) + (6 * BORDERSIZE);
	};
	class OuterBG_F : OuterBG {
		style = ST_FRAME;
	};
	class InnerBG : OuterBG {
		colorBackground[] = COLOR_GREEN;
		x = (0.2 * safezoneW + safezoneX) - BORDERSIZE;
		y = (0.25 * safezoneH + safezoneY) - (1.5 * BORDERSIZE);
		w = (0.6 * safezoneW) + (2 * BORDERSIZE);
		h = (0.55 * safezoneH) + (3 * BORDERSIZE);
	};
	class InnerBG_F : InnerBG {
		style = ST_FRAME;
	};
	class OuterCenterPanel : StdBG {
		colorBackground[] = COLOR_GREEN;
		style = ST_FRAME;
		x = 0.32 * safezoneW + safezoneX + BORDERSIZE;
		w = 0.12 * safezoneW;
		y = 0.25 * safezoneH + safezoneY;
		h = (0.35 * safezoneH) - (1.5 * BORDERSIZE);
	};
	class Header : StdHeader{
		x = 0.2 * safezoneW + safezoneX - (BORDERSIZE);
		y = 0.19 * safezoneH + safezoneY;
		w = 0.6 * safezoneW + ( 2 * BORDERSIZE);
		h = 0.05 * safezoneH - (BORDERSIZE);
		text = $STR_SQUAD_MANAGEMENT;
	};
	class SquadList : StdListBox {
		idc = 101;
		x = 0.2 * safezoneW + safezoneX;
		w = 0.12 * safezoneW;
		y = 0.25 * safezoneH + safezoneY;
		h = (0.35 * safezoneH) - (1.5 * BORDERSIZE);
		shadow = 2;
		onLBSelChanged="";
	};

	class ResupplyButton : StdButton{
		idc = 210;
		x = (0.2 * safezoneW + safezoneX);
		y = (0.6 * safezoneH + safezoneY);
		w = (0.055 * safezoneW);
		h = (0.04 * safezoneH);
		sizeEx = 0.025 * safezoneH;
		text = $STR_PROMOTE;
		tooltip = $STR_PROMOTE_TOOLTIP;
		action = "GRLIB_squadaction = 1";
	};
	class LikeMeButton : StdButton{
		idc = 215;
		x = (0.265 * safezoneW + safezoneX);
		y = (0.6 * safezoneH + safezoneY);
		w = (0.055 * safezoneW);
		h = (0.04 * safezoneH);
		sizeEx = 0.025 * safezoneH;
		text = $STR_LIKEME;
		action = "GRLIB_squadaction = 4";
	};

	class ReplaceButton : StdButton{
		idc = 212;
		x = (0.2 * safezoneW + safezoneX);
		y = (0.65 * safezoneH + safezoneY);
		w = (0.055 * safezoneW);
		h = (0.04 * safezoneH);
		sizeEx = 0.025 * safezoneH;
		text = $STR_DEPLOY_ON_MEMBER;
		tooltip = $STR_DEPLOY_ON_MEMBER_TOOLTIP;
		action = "GRLIB_squadaction = 3";
	};
	class RenameButton : StdButton{
		idc = 217;
		x = (0.265 * safezoneW + safezoneX);
		y = (0.65 * safezoneH + safezoneY);
		w = (0.055 * safezoneW);
		h = (0.04 * safezoneH);
		sizeEx = 0.025 * safezoneH;
		text = $STR_RENAME_BUTTON;
		tooltip = "Rename unit.";
		action = "GRLIB_squadaction = 5";
	};

	class RemoveButton : StdButton{
		idc = 211;
		x = (0.2 * safezoneW + safezoneX);
		y = (0.7 * safezoneH + safezoneY);
		w = (0.12 * safezoneW);
		h = (0.04 * safezoneH);
		sizeEx = 0.025 * safezoneH;
		text = $STR_REMOVE_MEMBER;
		tooltip = $STR_REMOVE_MEMBER_TOOLTIP;
		action = "GRLIB_squadaction = 2";
	};
	class ConfirmButton : StdButton{
		idc = 213;
		x = (0.2 * safezoneW + safezoneX);
		y = (0.75 * safezoneH + safezoneY);
		w = (0.055 * safezoneW);
		h = (0.04 * safezoneH);
		sizeEx = 0.025 * safezoneH;
		text = $STR_CONFIRM;
		action = "GRLIB_squadconfirm = 1";
	};
	class CancelButton : StdButton{
		idc = 214;
		x = (0.265 * safezoneW + safezoneX);
		y = (0.75 * safezoneH + safezoneY);
		w = (0.055 * safezoneW);
		h = (0.04 * safezoneH);
		sizeEx = 0.025 * safezoneH;
		text = $STR_RECYCLING_CANCEL;
		action = "GRLIB_squadconfirm = 0";
	};
	class ButtonClose : StdButton{
		x = 0.785 * safezoneW + safezoneX;
		w = 0.015 * safezoneW;
		h = 0.02 * safezoneH;
		y = 0.195 * safezoneH + safezoneY;
		text = "X";
		action = "closeDialog 0";
	};
	class StdSquadLabel : StdText{
		x = (0.32 * safezoneW + safezoneX)  + (BORDERSIZE);
		w = (0.12 * safezoneW) - BORDERSIZE;
		h = (0.03 * safezoneH);
		shadow = 2;
		sizeEx = 0.018 * safezoneH;
		text = "";
	};
	class NameLabel : StdSquadLabel{
		idc = 201;
		style = ST_CENTER;
		y = 0.25 * safezoneH + safezoneY;
		sizeEx = 0.022 * safezoneH;
	};
	class ClassLabel : StdSquadLabel{
		idc = 202;
		y = 0.3 * safezoneH + safezoneY;
	};
	class HealthLabel : StdSquadLabel{
		idc = 203;
		y = 0.325 * safezoneH + safezoneY;
	};
	class DistanceLabel : StdSquadLabel{
		idc = 204;
		y = 0.35 * safezoneH + safezoneY;
	};
	class PrimaryLabel : StdSquadLabel{
		idc = 205;
		y = 0.4 * safezoneH + safezoneY;
	};
	class PrimaryMagsLabel : StdSquadLabel{
		idc = 206;
		y = 0.425 * safezoneH + safezoneY;
	};
	class SecondaryLabel : StdSquadLabel{
		idc = 207;
		y = 0.475 * safezoneH + safezoneY;
	};
	class SecondaryMagsLabel : StdSquadLabel{
		idc = 208;
		y = 0.5 * safezoneH + safezoneY;
	};
	class LoadoutLabel : StdSquadLabel{
		idc = 216;
		y = 0.525 * safezoneH + safezoneY;
	};
	class VehicleLabel : StdSquadLabel{
		idc = 209;
		y = 0.55 * safezoneH + safezoneY;
	};
	class PiPZone {
		idc = 333;
		type = CT_STATIC;
		style = ST_PICTURE;
		colorText[] = {1,1,1,1};
        colorBackground[] = {1,1,1,1};
		font = FONTM;
		sizeEx = 0.023;
		x = 0.44 * safezoneW + safezoneX + ( 2 * BORDERSIZE);
		y = (0.25 * safezoneH + safezoneY);
		w = (0.36 * safezoneW) - ( 2 * BORDERSIZE) ;
		h = (0.55 * safezoneH);
		text = "#(argb,512,512,1)r2t(rtt,1.333)";
		moving = false;
	};

//Rename
	class GREUH_Squad_OuterBG : GREUH_OuterBG {
		idc = 521;
		style = ST_SINGLE;
		x = (0.32 * safezoneW + safezoneX) - (BORDERSIZE);
		y = ((BASE_Y + 0.18) * safezoneH) + safezoneY - (1.5 * BORDERSIZE);
		w = 0.2 * safezoneW +  (2 * BORDERSIZE);
		h = 0.05 * safezoneH  + (3 * BORDERSIZE);
	};
	class GREUH_Squad_InnerBG : GREUH_OuterBG {
		idc = 522;
		colorBackground[] = COLOR_GREEN;
		x = (0.32 * safezoneW + safezoneX);
		y = ((BASE_Y + 0.18) * safezoneH) + safezoneY;
		w = 0.2 * safezoneW;
		h = 0.05 * safezoneH;
	};
	class GREUH_Squad_OuterBG_F : GREUH_Squad_OuterBG {
		idc = 523;
		style = ST_FRAME;
	};
	class GREUH_Squad_InnerBG_F : GREUH_Squad_InnerBG {
		idc = 524;
		style = ST_FRAME;
	};
	class GREUH_ButtonName : GREUH_ButtonGeneric {
		w = ((0.2 * safezoneW) / 5) - BORDERSIZE;
		y = ((BASE_Y + 0.19) * safezoneH) + safezoneY;
	};
	class GREUH_ButtonName_Rename : GREUH_ButtonName {
		idc = 525;
		x = 0.4375 * safezoneW + safezoneX;
		text = $STR_RENAME_BUTTON;
		action = "unitname = ctrlText 527;";
	};
	class GREUH_ButtonName_Abort : GREUH_ButtonName {
		idc = 526;
		x = (0.4375 * safezoneW + safezoneX) + ((0.2 * safezoneW) / 5);
		text = $STR_CANCEL_BUTTON;
		action = "GRLIB_squadaction = -1;";
	};
	class GREUH_Squad_TextField : GREUH_ButtonName {
		idc = 527;
		type = CT_EDIT;
		style = ST_LEFT;
		x = (0.32 * safezoneW + safezoneX) + BORDERSIZE;
		w = 0.11 * safezoneW;
		text = "";
		action = "";
		colorText[] = COLOR_WHITE;
		colorSelection[] = COLOR_BRIGHTGREEN;
		autocomplete = "";
	};

};
