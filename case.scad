wallThickness = 2;
boardDimensionX = 85.5;
boardDimensionY = 54.2;
boardGap = 0.4;
sumThicknessGap = wallThickness + boardGap;
caseDimensionX = boardDimensionX + (sumThicknessGap * 2);
caseDimensionY = boardDimensionY + (sumThicknessGap * 2);
boardClearanceZ = 4 + wallThickness;

module basicBox ()
{
	difference ()
	{
		cube ([caseDimensionX, caseDimensionY, 17]);

		translate ([wallThickness, wallThickness, wallThickness])
		{
			cube ([boardDimensionX + boardGap * 2, boardDimensionY + boardGap * 2, 17]);
		}
	}
}

module stand (x, y)
{
	translate ([x, y, 0])
	{
		cylinder (boardClearanceZ, d = 7, $fn = 30);
	}
}

module bottomScrewHole (x, y)
{
	translate ([x, y, -1])
	{
		cylinder (boardClearanceZ + 2, d = 3, $fn = 30);
		cylinder ((1 + boardClearanceZ) - wallThickness, d = 6, $fn = 6);
	}
}

module topScrewHole (x, y)
{
	translate ([x, y, -1])
	{
		cylinder (9.6 + 2 + wallThickness, d = 3, $fn = 30);
		cylinder ((9.6 + wallThickness + 1) - 1.8, d = 5.4, $fn = 30);
	}
}
module topScrewMount (x, y)
{
	translate ([x, y, 0])
	{
		cylinder (wallThickness + 9.6, d = 6.4, $fn = 60);
	}
}

module frontHole(x, z, w, h)
{
	translate ([x, -10, z + 1.25])
	{
		cube ([w, 13, h + (boardGap * 2)]);
	}
}

module bottom () 
{
	difference ()
	{
		union ()
		{
			basicBox ();

			translate ([sumThicknessGap, sumThicknessGap, 0])
			{
				stand (4, 18.7);
				stand (boardDimensionX - 4, 18.7);
				stand (4, 50.2);
				stand (boardDimensionX - 4, 50.2);
			}

			// Additional support
			translate ([44, wallThickness + 5, 0])
			{
				cylinder (boardClearanceZ, d = 5, $fn = 30);
			}

			translate ([44, 53.5, 0])
			{
				cylinder (boardClearanceZ, d = 5, $fn = 30);
			}

			translate ([6.5 - sumThicknessGap, 7.5 - sumThicknessGap, 0])
			{
				cube ([6.66 + (2 * sumThicknessGap), 7.25 + (2 * sumThicknessGap), wallThickness +1]);
			}
		}
		union ()
		{
			// SD Card Socket
			frontHole (2.63, boardClearanceZ - boardGap, 12.45, 1.75);

			// HDMI Socket
			frontHole (18.71, boardClearanceZ - boardGap, 16.45, 7.27);

			// USB-OTG Socket
			frontHole (39.24, (boardClearanceZ - 0.5) - boardGap, 9.1, 4);

			// USB-Master Socket
			frontHole (50.2, boardClearanceZ - boardGap, 16.7, 8.4);

			// USB-Master Socket
			frontHole (70.5, boardClearanceZ - boardGap, 15.9, 8.4);

			// Power Connector
			translate ([71.5, caseDimensionY - 10, boardClearanceZ + 1.25])
			{
				cube ([9.8, 20, 7]);
			}

			// Switches
			translate ([6.5 - boardGap, 7.5 - boardGap, -1])
			{
				cube ([6.66 + (2 * boardGap), 7.25 + (2 * boardGap), boardClearanceZ + 2]);
			}

			// Screw Holes
			translate ([sumThicknessGap, sumThicknessGap, 0])
			{
				bottomScrewHole (4, 18.7);
				bottomScrewHole (boardDimensionX - 4, 18.7);
				bottomScrewHole (4, 50.2);
				bottomScrewHole (boardDimensionX - 4, 50.2);
			}
		}
	}
}

module topSupport (x, y, type)
{
	translate ([x, y, wallThickness])
	{
		if (type == "a")
			cube ([wallThickness, 6, 5]);
		if (type == "b")
			cube ([6, wallThickness, 5]);
	}
}

module top ()
{
	difference ()
	{
		union ()
		{
			cube ([caseDimensionX, caseDimensionY, wallThickness]);

			topSupport (sumThicknessGap, sumThicknessGap, "a");
			topSupport (caseDimensionX - (sumThicknessGap + wallThickness), sumThicknessGap, "a");
			topSupport (caseDimensionX - (sumThicknessGap + wallThickness), caseDimensionY - (sumThicknessGap + 6 + 17), "a");
			topSupport (sumThicknessGap, caseDimensionY - (sumThicknessGap + 6), "a");
			topSupport (55, sumThicknessGap, "b");
			topSupport (40, caseDimensionY - (sumThicknessGap + wallThickness), "b");

			topScrewMount (sumThicknessGap + 4, caseDimensionY - (18.7 + sumThicknessGap));
			topScrewMount (sumThicknessGap + (boardDimensionX - 4), caseDimensionY - (18.7 + sumThicknessGap));
			topScrewMount (sumThicknessGap + 4, caseDimensionY - (50.2 + sumThicknessGap));
			topScrewMount (sumThicknessGap + (boardDimensionX - 4), caseDimensionY - (50.2 + sumThicknessGap));
		}
		union ()
		{
			// GPIO
			translate ([10.5, sumThicknessGap, -1])
			{
				cube ([42, 6.75, wallThickness + 2]);
			}

			topScrewHole (sumThicknessGap + 4, caseDimensionY - (18.7 + sumThicknessGap));
			topScrewHole (sumThicknessGap + (boardDimensionX - 4), caseDimensionY - (18.7 + sumThicknessGap));
			topScrewHole (sumThicknessGap + 4, caseDimensionY - (50.2 + sumThicknessGap));
			topScrewHole (sumThicknessGap + (boardDimensionX - 4), caseDimensionY - (50.2 + sumThicknessGap));
		}
	}
}

union ()
{
	bottom ();

	translate ([0, caseDimensionY + 5, 0])
	{
		top ();
	}
}