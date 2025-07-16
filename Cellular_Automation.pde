// =====================================================================================
//region Global Variables and Constants

// --- Grid Settings (Do not change)
int n = 100;
float padding = 10;
String[][] cells;
String[][] cellsNext;
float cellSize;

// --- Cell Types (Constants)
static final String LAND = "land";
static final String WATER = "water";
static final String PLASTIC_BAG = "plastic bag";
static final String STYROFOAM = "styrofoam";
static final String DEBRIS = "debris";
static final String RANDOM_PLASTICS = "random plastics";

// --- Colors
color landColor = color(1, 52, 32);
color waterColor = color(100, 149, 237);
color plasticBagColor = color(255, 0, 0);
color styrofoamColor = color(28, 25, 52);
color debrisColor = color(169, 169, 169);
color randomPlasticsColor = color(204, 204, 0);

// --- Waste Spawn Probabilities (in percentages, e.g., 0.005 = 0.5%)
float plasticBagSpawn = 0.005;
float styrofoamSpawn = 0.005;
float debrisSpawn = 0.005;
float randomPlasticSpawn = 0.005;

//endregion

// =====================================================================================
//region Setup and Draw

void setup() {
  size(650, 650);
  frameRate(15);
  
  cells = new String[n][n];
  cellsNext = new String[n][n];
  cellSize = (width - 2 * padding) / n;
  
  initializeGrid();
}

void draw() {
  noStroke();
  background(255);
  
  drawGrid();
  
  // Compute the next generation
  nextGen();
  
  // Swap the cell buffers for the next frame
  String[][] temp = cells;
  cells = cellsNext;
  cellsNext = temp;
}

//endregion

// =====================================================================================
//region Core Simulation Logic

void nextGen() {
  // Reset the next generation grid
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      cellsNext[i][j] = cells[i][j];
    }
  }

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      // If the cell is water, it might get filled by moving waste
      if (cells[i][j].equals(WATER)) {
        moveWasteTo(i, j, PLASTIC_BAG);
        moveWasteTo(i, j, STYROFOAM);
        moveWasteTo(i, j, DEBRIS);
        moveWasteTo(i, j, RANDOM_PLASTICS);
      }
    }
  }
  
  // Add new waste for the next generation
  setInitialLand(cellsNext);
  spawnWasteNearLand(cellsNext, PLASTIC_BAG, plasticBagSpawn);
  spawnWasteNearLand(cellsNext, STYROFOAM, styrofoamSpawn);
  spawnWasteNearLand(cellsNext, DEBRIS, debrisSpawn);
  spawnWasteNearLand(cellsNext, RANDOM_PLASTICS, randomPlasticSpawn);
}

//endregion

// =====================================================================================
//region Helper Functions

void initializeGrid() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      cells[i][j] = WATER;
    }
  }
  setInitialLand(cells);
  spawnWasteNearLand(cells, PLASTIC_BAG, plasticBagSpawn);
  spawnWasteNearLand(cells, STYROFOAM, styrofoamSpawn);
  spawnWasteNearLand(cells, DEBRIS, debrisSpawn);
  spawnWasteNearLand(cells, RANDOM_PLASTICS, randomPlasticSpawn);
}

void setInitialLand(String[][] grid) {
  // Draw out land on the east side of the model
  for (int e = 5; e < 95; e++) {
    for (int f = n - 5; f < n; f++) {
      grid[e][f] = LAND;
    }
  }
}

void spawnWasteNearLand(String[][] grid, String wasteType, float spawnChance) {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (grid[i][j].equals(LAND)) {
        float findProb = random(1);
        if (findProb < spawnChance) {
          // Spawn in adjacent water cells
          if (i + 1 < n && grid[i + 1][j].equals(WATER)) grid[i + 1][j] = wasteType;
          if (i - 1 >= 0 && grid[i - 1][j].equals(WATER)) grid[i - 1][j] = wasteType;
          if (j + 1 < n && grid[i][j + 1].equals(WATER)) grid[i][j + 1] = wasteType;
          if (j - 1 >= 0 && grid[i][j - 1].equals(WATER)) grid[i][j - 1] = wasteType;
        }
      }
    }
  }
}

void moveWasteTo(int i, int j, String wasteType) {
  // Movement away from land
  if (j > 0 && cells[i][j-1].equals(wasteType) && cells[i][j].equals(WATER) && isLand(i, j-2)) cellsNext[i][j] = wasteType;
  if (j < n-1 && cells[i][j+1].equals(wasteType) && cells[i][j].equals(WATER) && isLand(i, j+2)) cellsNext[i][j] = wasteType;
  if (i > 0 && cells[i-1][j].equals(wasteType) && cells[i][j].equals(WATER) && isLand(i-2, j)) cellsNext[i][j] = wasteType;
  if (i < n-1 && cells[i+1][j].equals(wasteType) && cells[i][j].equals(WATER) && isLand(i+2, j)) cellsNext[i][j] = wasteType;

  // Random movement in water
  int rand = int(random(4));
  if (cells[i][j].equals(WATER)) {
    if (rand == 0 && i > 0 && cells[i-1][j].equals(wasteType) && !isLandNearby(i-1, j)) {
      cellsNext[i][j] = wasteType;
      cellsNext[i-1][j] = WATER;
    }
    if (rand == 1 && i < n-1 && cells[i+1][j].equals(wasteType) && !isLandNearby(i+1, j)) {
      cellsNext[i][j] = wasteType;
      cellsNext[i+1][j] = WATER;
    }
    if (rand == 2 && j > 0 && cells[i][j-1].equals(wasteType) && !isLandNearby(i, j-1)) {
      cellsNext[i][j] = wasteType;
      cellsNext[i][j-1] = WATER;
    }
    if (rand == 3 && j < n-1 && cells[i][j+1].equals(wasteType) && !isLandNearby(i, j+1)) {
      cellsNext[i][j] = wasteType;
      cellsNext[i][j+1] = WATER;
    }
  }
}

boolean isLand(int i, int j) {
  if (i >= 0 && i < n && j >= 0 && j < n) {
    return cells[i][j].equals(LAND);
  }
  return false;
}

boolean isLandNearby(int i, int j) {
    if (i > 0 && isLand(i-1, j)) return true;
    if (i < n-1 && isLand(i+1, j)) return true;
    if (j > 0 && isLand(i, j-1)) return true;
    if (j < n-1 && isLand(i, j+1)) return true;
    return false;
}

void drawGrid() {
  float y = padding;
  for (int i = 0; i < n; i++) {
    float x = padding;
    for (int j = 0; j < n; j++) {
      if (cells[i][j].equals(LAND)) fill(landColor);
      else if (cells[i][j].equals(WATER)) fill(waterColor);
      else if (cells[i][j].equals(PLASTIC_BAG)) fill(plasticBagColor);
      else if (cells[i][j].equals(DEBRIS)) fill(debrisColor);
      else if (cells[i][j].equals(RANDOM_PLASTICS)) fill(randomPlasticsColor);
      else if (cells[i][j].equals(STYROFOAM)) fill(styrofoamColor);
      
      rect(x, y, cellSize, cellSize);
      x += cellSize;
    }
    y += cellSize;
  }
}

//endregion