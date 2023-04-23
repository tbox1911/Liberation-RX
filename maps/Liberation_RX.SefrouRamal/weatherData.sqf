// Cloud cover values, chances for Winter/Spring/Summer/Fall
cloudsList = [

	[	0.0, 0.15,
		0.3, 0.17,
		0.5, 0.13,
		0.7, 0.20,
		0.9, 0.35
	],

	[	0.0, 0.02,
		0.3, 0.05,
		0.5, 0.19,
		0.7, 0.24,
		0.9, 0.58
	],

	[	0.0, 0.01,
		0.3, 0.02,
		0.5, 0.05,
		0.7, 0.25,
		0.9, 0.67
	],

	[	0.0, 0.02,
		0.3, 0.08,
		0.5, 0.14,
		0.7, 0.26,
		0.9, 0.48
	]
];

// [value, Chance %]]
rainList =
[
	[0.17, 7], // Winter
	[0.4, 30], // Spring
	[0.6, 50], // Summer
	[0.17, 29] // Fall
];

// Chance
thunderstormsList =
[
	5, // Winter
	30, // Spring
	50, // Summer
	29 // Fall
];

//Fog for Mornings/Evenings
fogList = 
[
	[0.07, 0.11, 60],
	[0.10, 0.11, 60],
	[0.14, 0.11, 60],
	[0.09, 0.11, 60]
];

// chanceFog - chance of fog in the morning and evening
chanceFog = 80;