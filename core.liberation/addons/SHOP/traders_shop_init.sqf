SHOP_list = light_vehicles + heavy_vehicles + air_vehicles + support_vehicles + opfor_recyclable + ind_recyclable;
SHOP_ratio = 0.75;  // range 0.5 - 0.8

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";