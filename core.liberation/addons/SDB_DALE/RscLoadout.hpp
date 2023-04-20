#define DALE_VAR_DLGWIDTHIMG			0.650
#define DALE_VAR_DLGHEIGHTIMG			0.600
#define DALE_VAR_DLGWIDTHSECTION		0.100
#define DALE_VAR_DLGHEIGHTSECTION		0.020

class DALE_RscButton {
	idc = 2000;
	x = 0;
	y = 0;
	w = __EVAL(safezoneW * DALE_VAR_DLGHEIGHTSECTION);
	h = __EVAL(safezoneH * DALE_VAR_DLGHEIGHTSECTION);
	text = "";

	borderSize = 0;
	colorBackground[] 			= {0,0,0,0.8};
	colorBackgroundActive[] 	= {1,1,1,0.8};
	colorBackgroundDisabled[] 	= {0.8,0.8,0.8,0.3};
	colorBorder[] 				= {0,0,0,0.8};
	colorDisabled[] 			= {1,1,1,0.3};
	colorFocused[] 				= {0,0,0,0.8};
	colorShadow[] 				= {0,0,0,0};
	colorText[] 				= {1,1,1,1};
	deletable = 0;
	fade = 0;
	font = "PuristaLight";
	offsetPressedX = 0;
	offsetPressedY = 0;
	offsetX = 0;
	offsetY = 0;
	shadow = 2;
	sizeEx = __EVAL(safezoneH * 0.02);
	soundClick[] 	= {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEnter[] 	= {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundEscape[] 	= {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	soundPush[] 	= {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	style = __EVAL(2+48+2048);
	type = 1;
};
class DALE_RscCombo {
	idc = 3000;
	x = 0;
	y = 0;
	w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHSECTION);
	h = __EVAL(safezoneH * DALE_VAR_DLGHEIGHTSECTION);

	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";

	colorActive[] = {1,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorPictureRightSelected[] = {1,1,1,1};
	colorScrollbar[] = {1,0,0,1};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorTextRight[] = {1,1,1,1};

	deletable = 0;
	fade = 0;
	font = "PuristaLight";
	maxHistoryDelay = 1;
	rowHeight = __EVAL(safezoneH * 0.02);
	sizeEx = __EVAL(safezoneH * 0.02);
	shadow = 0;
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	style = 528;
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	type = 4;
	wholeHeight = 0.45;
	class ComboScrollBar {
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollEnabled = 1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,0.8};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {0.5,0.5,0.5,0.4};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	};
};

class DALE_RscLoadout {
	idd = -1;
	onLoad 		= "uiNamespace setVariable [""DALE_RscLoadout"",_this select 0];";
	onUnload	= "uiNamespace setVariable [""DALE_RscLoadout"",nil];";

	iconDriver = "a3\ui_f\data\IGUI\Cfg\CommandBar\imageDriver_ca.paa";
	iconGunner = "a3\ui_f\data\IGUI\Cfg\CommandBar\imageGunner_ca.paa";
	movingEnable = false;

	class controls {
		class title {
			idc = 1000;
			x = __EVAL(safezoneX + safezoneW * (0.500-DALE_VAR_DLGWIDTHIMG/2));
			y = __EVAL(safezoneY + safezoneH * (0.475-DALE_VAR_DLGHEIGHTIMG/2));
			w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHIMG);
			h = __EVAL(safezoneH * DALE_VAR_DLGHEIGHTSECTION);
			text = "";

			colorbackground[] = {0.77,0.51,0.08,0.8};
			colorText[] = {1,1,1,1};
			deletable = 0;
			fade = 0;
			size = __EVAL(safezoneH * DALE_VAR_DLGHEIGHTSECTION);
			shadow = 1;
			style = 0;
			type = 13;
			class Attributes {
				font = "PuristaLight";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class background {
			idc = 1001;
			x = __EVAL(safezoneX + safezoneW * (0.500-DALE_VAR_DLGWIDTHIMG/2));
			y = __EVAL(safezoneY + safezoneH * (0.500-DALE_VAR_DLGHEIGHTIMG/2));
			w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHIMG);
			h = __EVAL(safezoneH * DALE_VAR_DLGHEIGHTIMG);
			text = "";

			colorbackground[] = {0.2,0.2,0.2,0.95};
			colorText[] = {0,0,0,0};
			font = "PuristaLight";
			sizeEx = 0;
			shadow = 0;
			style = 128;
			type = 0;
		};
		class picture {
			idc = 1002;
			x = __EVAL(safezoneX + safezoneW * (0.500-DALE_VAR_DLGWIDTHIMG/2));
			y = __EVAL(safezoneY + safezoneH * (0.500-DALE_VAR_DLGHEIGHTIMG/2));
			w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHIMG);
			h = __EVAL(safezoneH * DALE_VAR_DLGHEIGHTIMG);
			text = "";

			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			deletable = 0;
			fade = 0;
			fixedWidth = 0;
			font = "TahomaB";
			lineSpacing = 0;
			shadow = 0;
			sizeEx = 0;
			style = __EVAL(48+2048);
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,0.65};
			tooltipColorText[] = {1,1,1,1};
			type = 0;
		};
		class comboPreset: DALE_RscCombo {
			idc = 1003;
			x = __EVAL(safezoneX + safezoneW * (0.505-DALE_VAR_DLGWIDTHIMG/2));
			y = __EVAL(safezoneY + safezoneH * (0.505-DALE_VAR_DLGHEIGHTIMG/2));
			w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHSECTION*2);
		};
		class comboPriority: DALE_RscCombo {
			idc = 1004;
			x = __EVAL(safezoneX + safezoneW * (0.495+DALE_VAR_DLGWIDTHIMG/2-2*DALE_VAR_DLGWIDTHSECTION));
			y = __EVAL(safezoneY + safezoneH * (0.505-DALE_VAR_DLGHEIGHTIMG/2));
			w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHSECTION*2);
		};
		class buttonClose: DALE_RscButton {
			idc = 1005;
			x = __EVAL(safezoneX + safezoneW * (0.500+DALE_VAR_DLGWIDTHIMG/2-1*DALE_VAR_DLGWIDTHSECTION));
			y = __EVAL(safezoneY + safezoneH * (0.505+DALE_VAR_DLGHEIGHTIMG/2));
			w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHSECTION);
			text = $STR_DALE_Dialogs_Cancel;
			onButtonClick = "(ctrlParent (_this select 0)) closeDisplay 0;";
			style = 2;
		};
		class buttonApply: DALE_RscButton {
			idc = 1006;
			x = __EVAL(safezoneX + safezoneW * (0.495+DALE_VAR_DLGWIDTHIMG/2-2*DALE_VAR_DLGWIDTHSECTION));
			y = __EVAL(safezoneY + safezoneH * (0.505+DALE_VAR_DLGHEIGHTIMG/2));
			w = __EVAL(safezoneW * DALE_VAR_DLGWIDTHSECTION);
			text = $STR_DALE_Dialogs_Apply;
			onButtonClick = "_this call DALE_fnc_dlgLoadoutApply;";
			style = 2;
		};
	};
};