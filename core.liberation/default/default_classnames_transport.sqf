// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
	["C_Offroad_01_F", -5, [0, -1.55, 0.2]],
	["C_IDAP_Offroad_01_F", -5, [0, -1.55, 0.2]],
	["C_Van_01_box_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2]],
	["C_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2]],
	["C_Van_02_transport_F", -5, [0,-1.75,0]],
	["C_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0]],
 	["C_IDAP_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0]],
	["C_IDAP_Van_02_transport_F", -5, [0,-1.75,0]],
	["C_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0]],
	["C_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0]],
	["C_IDAP_Truck_02_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0]],
	["C_IDAP_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0]],
	["C_IDAP_Heli_Transport_02_F", -6.5, [0, 4.2, -1.45], [0, 2.5, -1.45], [0, 0.8, -1.45], [0, -0.9, -1.45]]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above
box_transport_offset = box_transport_offset + [
	["B_supplyCrate_F", [0, 0, 0.1]],
	["Box_NATO_Wps_F", [0, 0, -0.6]],
	["Box_NATO_Ammo_F", [0, 0, -0.6]],
	["Box_NATO_Support_F", [0, 0, -0.6]],
	["Box_NATO_WpsSpecial_F", [0, 0, -0.6]],
	["Box_NATO_WpsLaunch_F", [0, 0, -0.6]],
	["Box_East_Wps_F", [0, 0, -0.6]],	
	["Box_NATO_AmmoVeh_F", [0, 0, 0]],
	["Box_East_AmmoVeh_F", [0, 0, 0]],
	["Box_IND_AmmoVeh_F", [0, 0, 0]],
	["Land_BarrelWater_F", [0, 0, -0.4]],
	["Land_MetalBarrel_F", [0, 0, -0.4]],
	["Land_MetalCase_01_large_F", [0, 0, -0.45]],
	["Land_ToolTrolley_02_F", [0, 0, -0.4]],
	["Land_FoodSacks_01_large_brown_idap_F", [0, 0, -0.4]]
];

// Flatbed transport for big objects
box_transport_big_config = box_transport_big_config + [
	["B_Truck_01_flatbed_F", -6.8, [0, -1.8, 0]],
	["B_T_Truck_01_flatbed_F", -6.8, [0, -1.8, 0]]
];

// Additional offset per big object
box_transport_big_offset = box_transport_big_offset + [
	["B_Slingload_01_Repair_F", [0, 0, 0.5]],
	["B_Slingload_01_Fuel_F", [0, 0, 0.5]],
	["B_Slingload_01_Ammo_F", [0, 0, 0.5]],
	["B_Slingload_01_Medevac_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_ammo_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_ammo_black_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_box_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_box_black_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_fuel_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_fuel_black_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_repair_F", [0, 0, 0.5]],
	["Land_Pod_Heli_Transport_04_repair_black_F", [0, 0, 0.5]],
	["Land_Cargo20_grey_F", [0, 0, 0.5]]
];

// Storage
box_transport_config = box_transport_config + [
	["ContainmentArea_02_black_F", -5,
		[-2.34961,1.80078,0.6],
		[-0.75,1.80078,0.6],
		[0.850586,1.80078,0.6],
		[2.4502,1.80078,0.6],
		[-2.34961,0,0.6],
		[-0.75,0,0.6],
		[0.850586,0,0.6],
		[2.4502,0,0.6],
		[-2.34961,-1.79883,0.6],
		[-0.75,-1.79883,0.6],
		[0.850586,-1.79883,0.6],
		[2.4502,-1.79883,0.6]
	],
	["ContainmentArea_01_black_F", -5,
		[-5.59961,3.60938,0.6],
		[-3.99902,3.60938,0.6],
		[-2.39941,3.60938,0.6],
		[-0.799805,3.60938,0.6],
		[0.800781,3.60938,0.6],
		[2.40039,3.60938,0.6],
		[4.00098,3.60938,0.6],
		[5.60059,3.60938,0.6],
		[-5.59961,1.80859,0.6],
		[-3.99902,1.80859,0.6],
		[-2.39941,1.80859,0.6],
		[-0.799805,1.80859,0.6],
		[0.800781,1.80859,0.6],
		[2.40039,1.80859,0.6],
		[4.00098,1.80859,0.6],
		[5.60059,1.80859,0.6],
		[-5.59961,0.00976563,0.6],
		[-3.99902,0.00976563,0.6],
		[-2.39941,0.00976563,0.6],
		[-0.799805,0.00976563,0.6],
		[0.800781,0.00976563,0.6],
		[2.40039,0.00976563,0.6],
		[4.00098,0.00976563,0.6],
		[5.60059,0.00976563,0.6],
		[-5.59961,-1.79102,0.6],
		[-3.99902,-1.79102,0.6],
		[-2.39941,-1.79102,0.6],
		[-0.799805,-1.79102,0.6],
		[0.800781,-1.79102,0.6],
		[2.40039,-1.79102,0.6],
		[4.00098,-1.79102,0.6],
		[5.60059,-1.79102,0.6],
		[-5.59961,-3.58984,0.6],
		[-3.99902,-3.58984,0.6],
		[-2.39941,-3.58984,0.6],
		[-0.799805,-3.58984,0.6],
		[0.800781,-3.58984,0.6],
		[2.40039,-3.58984,0.6],
		[4.00098,-3.58984,0.6],
		[5.60059,-3.58984,0.6]
	]
];
