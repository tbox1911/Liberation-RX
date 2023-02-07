class liberation_notice {
	idd = 5138;
	movingEnable = false;
	controlsBackground[] = {};

	controls[] = { "OuterBG1", "OuterBG_F1", "InnerBG1", "InnerBG_F1", "Header", "ButtonClose", "NoticeControlGroup" };

	objects[] = {};

	class OuterBG1 : StdBG {
		colorBackground[] = COLOR_BROWN;
		x = (0.2 * safezoneW + safezoneX) - (2 * BORDERSIZE);
		y = (0.15 * safezoneH + safezoneY) - (3 * BORDERSIZE);
		w = (0.6 * safezoneW) + (4 * BORDERSIZE);
		h = (0.65 * safezoneH) + (6 * BORDERSIZE);
	};
	class OuterBG_F1 : OuterBG1 {
		style = ST_FRAME;
	};

	class InnerBG1 : OuterBG1 {
		colorBackground[] = COLOR_GREEN;
		x = (0.2 * safezoneW + safezoneX)  - ( BORDERSIZE);
		y = 0.2 * safezoneH + safezoneY - (1.5 * BORDERSIZE);
		w = (0.6 * safezoneW) +  (2 * BORDERSIZE);
		h = 0.55 * safezoneH  + (3 * BORDERSIZE);
	};
	class InnerBG_F1 : InnerBG1 {
		style = ST_FRAME;
	};
	class Header : StdHeader {
		x = 0.2 * safezoneW + safezoneX - (BORDERSIZE);
		y = 0.14 * safezoneH + safezoneY;
		w = 0.6 * safezoneW + ( 2 * BORDERSIZE);
		h = 0.05 * safezoneH - (BORDERSIZE);
		text = "-- First Time Player Notice --";
	};

	class ButtonClose : StdButton {
		idc = 752;
		x = 0.45 * safezoneW + safezoneX;
		y = 0.77 * safezoneH + safezoneY;
		w = 0.09 * safezoneW;
		h = 0.035 * safezoneH;
		text = "OK !";
		action = "closeDialog 0";
	};

	class NoticeControlGroup {
	 	type = 15;
	 	idc = -1;
	 	style = 0;
		x = 0;
		y = 0;
		w = (0.45 * safezoneW) - (2 * BORDERSIZE);
		h = 0.45 * safezoneH  + (3 * BORDERSIZE);
		colorScrollbar[] = COLOR_WHITE;

	 	class VScrollbar {
	 		color[] = COLOR_WHITE;
	 		width = 0.01 * safezoneW;
			autoScrollSpeed = -1;
			autoScrollDelay = 5;
			autoScrollRewind = 0;
	 	};

	 	class HScrollbar {
	 		color[] = COLOR_WHITE;
	 		height = 0.012 * safezoneH;
	 	};

	 	class ScrollBar	{
			color[] = COLOR_WHITE;
			colorActive[] = COLOR_WHITE;
			colorDisabled[] = COLOR_WHITE;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	 	};

	 	class Controls	{
			class NoticeStructuredText {
				idc = 515;
				type = CT_STRUCTURED_TEXT;
				colorBackground[] = COLOR_NOALPHA;
				style = ST_LEFT;
	 			x = 0;
	 			y = 0;
				w = (0.4 * safezoneW);
				h = (0.8 * safezoneH);	
				text = "$STR_NOTICE_TEXT1";
				size = 0.025 * safezoneH;
				sizeEx = 0.025 * safezoneH;
				shadow = 2;
				font = FONTM;
				color = "#e0e0e0";
				align = "left";
				valign = "top";
			};			
	 	};
	};
};