class VAM_GUI
{
	idd = 4900;
	movingEnable = false;

	class controlsBackground {
		class OuterBG1: StdBG {
			colorBackground[] = COLOR_BROWN;
			x = 0.3225 * safezoneW + safezoneX;
			y = 0.3112 * safezoneH + safezoneY;
			w = 0.3548 * safezoneW;
			h = 0.4056 * safezoneH;
		};

		class OuterBG_F1: OuterBG1 {
			style = ST_FRAME;
		};

		class InnerBG1: OuterBG1 {
			colorBackground[] = COLOR_GREEN;
			x = 0.3293 * safezoneW + safezoneX;
			y = 0.3180 * safezoneH + safezoneY;
			w = 0.3412 * safezoneW;
			h = 0.3920 * safezoneH;
		};

		class InnerBG_F1: InnerBG1 {
			style = ST_FRAME;
		};

		class Header: StdHeader {
			text = "$STR_VAM_MAIN_MENU_NAME";
			x = 0.3425 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.028 * safezoneH;
		};
	};

	class controls {
		class VAM_Text_Camo: VAM_RscText {
			idc = -1;
			text = $STR_VAM_CAMOUFLAGE;
			x = 0.3425 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_Text_Comp: VAM_RscText {
			idc = -1;
			text = $STR_VAM_COMPONENT;
			x = 0.506562 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_Confirm: VAM_RscButton {
			idc = 4930;
			text = $STR_VAM_CONFIRM_MENU;
			action = "closeDialog 0;";
			x = 0.611562 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_List_Camo: VAM_RscListbox {
			idc = 4910;
			style = LB_TEXTURES;
			sizeEx = 0.035;
			x = 0.3425 * safezoneW + safezoneX;
			y = 0.405 * safezoneH + safezoneY;
			w = 0.150937 * safezoneW;
			h = 0.124 * safezoneH;
		};

		class VAM_List_Comp: VAM_RscListbox	{
			idc = 4920;
			style = LB_TEXTURES + LB_MULTI;
			sizeEx = 0.035;
			x = 0.506562 * safezoneW + safezoneX;
			y = 0.405 * safezoneH + safezoneY;
			w = 0.150937 * safezoneW;
			h = 0.124 * safezoneH;
		};

		class VAM_List_Arsenal: VAM_RscListbox	{
			idc = 4921;
			style = LB_TEXTURES + LB_MULTI;
			sizeEx = 0.035;
			tooltip = "Info";
			onLBDblClick = "[] spawn fnc_VAM_add_cargo;";
			x = 0.506562 * safezoneW + safezoneX;
			y = 0.560 * safezoneH + safezoneY;
			w = 0.150937 * safezoneW;
			h = 0.124 * safezoneH;
		};

		class VAM_Reset: VAM_RscButton {
			idc = 4940;
			text = $STR_VAM_RESET_VEHICLE;
			OnButtonClick = "[] spawn fnc_VAM_reset;";
			x = 0.559062 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_AddCargo: VAM_RscButton {
			idc = 4941;
			text = $STR_VAM_ARSENAL_VEHICLE;
			OnButtonClick = "[] spawn fnc_VAM_add_cargo;";
			x = 0.3725 * safezoneW + safezoneX;
			y = 0.590 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_Current_Vehicle_1: VAM_RscText {
			idc = -1;
			text = $STR_VAM_CURRENT_VEHICLE;
			x = 0.3425 * safezoneW + safezoneX;
			y = 0.630 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_Current_Vehicle_2: VAM_RscText {
			idc = -1;
			text = $STR_VAM_FREE_VEHICLE;
			x = 0.3425 * safezoneW + safezoneX;
			y = 0.655 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_Current_Vehicle_3: VAM_RscText {
			idc = 4952;
			sizeEx = 0.03;
			text = "<Placeholder>";
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.655 * safezoneH + safezoneY;
			w = 0.124687 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_Current_Vehicle_4: VAM_RscText {
			idc = 4950;
			sizeEx = 0.03;
			text = "<Placeholder>";
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.630 * safezoneH + safezoneY;
			w = 0.124687 * safezoneW;
			h = 0.028 * safezoneH;
		};

		class VAM_Current_Arsenal: VAM_RscText {
			idc = -1;
			text = $STR_VAM_ARSENAL;
			x = 0.506562 * safezoneW + safezoneX;
			y = 0.530 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
		};
	};
};
