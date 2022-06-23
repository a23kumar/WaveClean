//CODE TO GENERATE THE FIRST ITERATION OF WASTE IN THE WATER
void firstGeneration() {
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      cells[i][j] = "water";
    }
  }
  setInitialLand();
}

void setInitialLand() {//Generates the initial but constant peice of land

  //Draw out land on the east side of the model
  for (int e = 5; e < 95; e++) {
    for (int f = n-5; f < n; f++) {
      cells[e][f] = "land";
    }
  }

  setInitialPlasticBags();
}

void setInitialPlasticBags() {//Generates new generation of plastic bags
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) { 
      float findProb = random(0, 1);
      if (findProb >= 1 - plasticBagSpawn) {
        if (cells[i][j].equals("land")) {
          try {
            if (cells[i+1][j].equals("water")) {
              cells[i+1][j] = "plastic bag";
            }
            if (cells[i-1][j].equals("water")) {
              cells[i-1][j] = "plastic bag";
            }
            if (cells[i][j+1].equals("water")) {
              cells[i][j+1] = "plastic bag";
            }
            if (cells[i][j-1].equals("water")) {
              cells[i][j-1] = "plastic bag";
            }
          }
          catch (Exception e) {
          }
        }
      }
    }
  }
  setInitialDebris();
}

void setInitialDebris() {//Generates new generation of debris
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      float findProb = random(0, 1);
      if (findProb >= 1 - debrisSpawn) {
        if (cells[i][j].equals("land")) {
          try {
            if (cells[i+1][j].equals("water")) {
              cells[i+1][j] = "debris";
            }
            if (cells[i-1][j].equals("water")) {
              cells[i-1][j] = "debris";
            }
            if (cells[i][j+1].equals("water")) {
              cells[i][j+1] = "debris";
            }
            if (cells[i][j-1].equals("water")) {
              cells[i][j-1] = "debris";
            }
          }
          catch (Exception e) {
          }
        }
      }
    }
  }
  setInitialRandomPlastics();
}

void setInitialRandomPlastics() {//Generates new generation of random plastics
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      float findProb = random(0, 1);
      if (findProb >= 1 - randomPlasticSpawn) {
        if (cells[i][j].equals("land")) {
          try {
            if (cells[i+1][j].equals("water")) {
              cells[i+1][j] = "random plastics";
            }
            if (cells[i-1][j].equals("water")) {
              cells[i-1][j] = "random plastics";
            }
            if (cells[i][j+1].equals("water")) {
              cells[i][j+1] = "random plastics";
            }
            if (cells[i][j-1].equals("water")) {
              cells[i][j-1] = "random plastics";
            }
          }
          catch (Exception e) {
          }
        }
      }
    }
  }
  setInitialStyrofoam();
}

void setInitialStyrofoam() {//Generates new generation of styrofoam
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      float findProb = random(0, 1);
      if (findProb >= 1 - styrofoamSpawn) {
        if (cells[i][j].equals("land")) {
          try {
            if (cells[i+1][j].equals("water")) {
              cells[i+1][j] = "styrofoam";
            }
            if (cells[i-1][j].equals("water")) {
              cells[i-1][j] = "styrofoam";
            }
            if (cells[i][j+1].equals("water")) {
              cells[i][j+1] = "styrofoam";
            }
            if (cells[i][j-1].equals("water")) {
              cells[i][j-1] = "styrofoam";
            }
          }
          catch (Exception e) {
          }
        }
      }
    }
  }
}
