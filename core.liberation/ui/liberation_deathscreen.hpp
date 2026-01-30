// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define ST_PICTURE          48
#define ST_FRAME            64
#define ST_LEFT             0x00
#define ST_RIGHT            0x01
#define ST_CENTER           0x02
#define COLOR_NOALPHA       { 0, 0, 0, 0 }
#define COLOR_BLACK         { 0, 0, 0, 1 }
#define COLOR_BLACK_ALPHA   { 0, 0, 0, 0.85 }
#define COLOR_WHITE         { 1, 1, 1, 1 }
#define COLOR_BLEEDOUT      { 0.66,0,0,0.8 }
#define COLOR_OPFOR_NOALPHA { 1, 0, 0, 1 }
#define FONTM               "puristaMedium"

class par_deathscreen {

	idd = 5651;
	movingEnable = false;
	controls[] = {
		"OuterBackground", "Skull", "WoundedLabel"
	};
	class OuterBackground {
		idc = -1;
		type =  CT_STATIC;
		style = ST_LEFT;
		colorText[] = COLOR_BLACK;
		colorBackground[] = COLOR_BLACK;
		font = FONTM;
		sizeEx = 0.023;
		x = -3; y = -3;
		w = 9;  h = 9;
		text = "";
	};
	class Skull {
		idc = 666;
		type =  CT_STATIC ;
		style = ST_PICTURE;
		colorText[] = { 1,1,1,0.15 };
		colorBackground[] = COLOR_NOALPHA;
		font = FONTM;
		sizeEx = 0.1 * safezoneH;
		x = 0.3 * safezoneW + safezoneX;
		w = 0.4 * safezoneW;
		y = 0.2 * safezoneH + safezoneY;
		h = 0.6 * safezoneH;
		text = "res\skull.paa";
	};
	class WoundedLabel {
		idc = -1;
		type =  CT_STATIC;
		style = ST_CENTER;
		colorText[] = COLOR_WHITE;
		colorBackground[] = COLOR_NOALPHA;
		font = FONTM;
		sizeEx = 0.07 * safezoneH;
		shadow = 1;
		x = 0.3 * safezoneW + safezoneX;
		y= 0.25 * safezoneH + safezoneY;
		w = 0.4 * safezoneW; h = 0.07 * safezoneH;
		text = $STR_REVIVE_LABEL;
	};
};

class par_respawn {
	idd = 5566;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {"PAR_BleedoutBar","DetectionFrame","PAR_Respawn","PAR_ReviveLabel","PAR_WoundedLabel","PAR_LRX_Tips"};
	objects[] = {};
	class RscButton {
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
		x = 0.45 * safezoneW + safezoneX;
		y = ((BASE_Y + 0.7) * safezoneH) + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.04 * safezoneH;
		text = "";
		action = "";
		shadow = 1;
	};
	class PAR_Respawn : RscButton {
		idc = 677;
		x = 0.45 * safezoneW + safezoneX;
		y = 0.75 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.04 * safezoneH;
		text = "Respawn";
		action = "closeDialog 0; player setDamage 1";
		colorDisabled[] = { 1, 1, 1, 1 };
	};
	class PAR_RecallMedic : RscButton {
		idc = 679;
		x = 0.45 * safezoneW + safezoneX;
		y = 0.80 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.04 * safezoneH;
		text = "Recall Medic";
		action = "[] spawn PAR_fn_medicRecall";
		colorDisabled[] = { 1, 1, 1, 1 };
	};
	class PAR_RscStructuredText{
		type = 13;
		idc = -1;
		style = 0;
		colorText[] = {1,1,1,1};
		class Attributes
		{
			font = "PuristaMedium";
			color = "#ffffff";
			align = "center";
			shadow = 2;
		};
		x = 0;
		y = 0;
		h = 0.035;
		w = 0.1;
		text = "";
		size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		shadow = 2;
    };	
	class PAR_LRX_Tips: PAR_RscStructuredText {
		idc = 676;
		text = "";
		x = 0.4 * safezoneW + safezoneX;
		y = 0.35 * safezoneH + safezoneY;
		w = 0.200 * safezoneW;
		h = 0.08 * safezoneH;
		sizeEx = -2 * GUI_GRID_H;
	};	
	class PAR_ReviveLabel {
		idc = 678;
		type =  CT_STATIC;
		style = ST_CENTER;
		colorText[] = COLOR_WHITE;
		colorBackground[] = COLOR_NOALPHA;
		font = FONTM;
		sizeEx = 0.02 * safezoneH;
		shadow = 1;
		x = 0.4 * safezoneW + safezoneX;
		y = 0.7 * safezoneH + safezoneY;
		w = 0.2 * safezoneW;
		h = 0.025 * safezoneH;
		text = "";
	};
	class PAR_WoundedLabel {
		idc = 4567;
		type =  CT_STATIC;
		style = ST_CENTER;
		colorText[] = COLOR_WHITE;
		colorBackground[] = COLOR_NOALPHA;
		font = FONTM;
		sizeEx = 0.07 * safezoneH;
		shadow = 1;
		x = 0.3 * safezoneW + safezoneX;
		y = 0.25 * safezoneH + safezoneY;
		w = 0.4 * safezoneW;
		h = 0.07 * safezoneH;
		text = $STR_REVIVE_LABEL;
	};
	class CaptureFrameStandard {
		type =  CT_STATIC;
		font = FONTM;
		sizeEx = 0.023;
		text = "";
	};
	class DetectionFrame : CaptureFrameStandard {
		idc = 681;
		style = ST_FRAME;
		colorText[] = COLOR_BLACK;
		colorBackground[] = COLOR_BLACK_ALPHA;
		x = 0.400 * safezoneW + safezoneX;
		y = 0.700 * safezoneH + safezoneY;
		w = 0.201 * safezoneW;
		h = 0.031 * safezoneH;
	};
	class PAR_BleedoutBar : DetectionFrame {
		idc = 680;
		style = CT_STATIC;
		colorText[] = COLOR_WHITE;
		colorBackground[] = COLOR_BLEEDOUT;
		font = FONTM;
		sizeEx = 0.023;
		x = 0.400 * safezoneW + safezoneX;
		y = 0.700 * safezoneH + safezoneY;
		w = 0.200 * safezoneW;
		h = 0.030 * safezoneH;
	};
};
