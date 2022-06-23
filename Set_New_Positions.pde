//CODE TO GENERATE EVERY OTHER ITERATION OF WASTE IN THE WATER
void firstGeneration1() {

  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      if(cellsNext[i][j] != "debris");
        cellsNext[i][j] = "water";
    }
  }
  setInitialLand1();
}

void setInitialLand1() {
//IF YOU WOULD LIKE TO PLAY AROUND WITH THE OTHER LANDMASSES YOU CAN DO SO

  //Draw out land on the north side of the model
  //for (int a = 0; a<10; a++) {
  //  for (int b = 40; b<70; b++) {
  //    cellsNext[a][b] = "land";
  //  }
  //}

  ////Draw out land on the east side of the model
  //for (int c = 40; c < 80; c++) {
  //  for (int d = 0; d < 10; d++) {
  //    cellsNext[c][d] = "land";
  //  }
  //}

  //Draw out land on the east side of the model
  for (int e = 5; e < 95; e++) {
    for (int f = n-5; f < n; f++) {
      cellsNext[e][f] = "land";
    }
  }
  //Places the water cells for each consecutive generation without wiping out the progress made by the cells
  for (int a = 0; a<n; a++) {
    for (int b = 0; b<n; b++) {
      if (cellsNext[a][b] == null)
        cellsNext[a][b] = "water";
    }
  }
  setInitialPlasticBags1();
}



void setInitialPlasticBags1() {//Generates new generation of plastic bags
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) { 
      float findProb = random(0, 1);
      //println(i, j, findProb);
      //println(cellsNext[i][j]);
      if (findProb >= 1 - plasticBagSpawn) {

        if ((cellsNext[i][j]).equals("land")) {
          try {
            if (cellsNext[i+1][j].equals("water")) {
              cellsNext[i+1][j] = "plastic bag";
            }
            if (cellsNext[i-1][j].equals("water")) {
              cellsNext[i-1][j] = "plastic bag";
            }
            if (cellsNext[i][j+1].equals("water")) {
              cellsNext[i][j+1] = "plastic bag";
            }
            if (cellsNext[i][j-1].equals("water")) {
              cellsNext[i][j-1] = "plastic bag";
            }
          }
          catch (Exception e) {}
        }
      }
    }
  }
  setInitialDebris1();
}

void setInitialDebris1() {//Generates new generation of debris
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      float findProb = random(0, 1);
      if (findProb >= 1 - debrisSpawn) {
        if ((cellsNext[i][j]).equals("land")) {
          try {
            if (cellsNext[i+1][j].equals("water")) {
              cellsNext[i+1][j] = "debris";
            }
            if (cellsNext[i-1][j].equals("water")) {
              cellsNext[i-1][j] = "debris";
            }
            if (cellsNext[i][j+1].equals("water")) {
              cellsNext[i][j+1] = "debris";
            }
            if (cellsNext[i][j-1].equals("water")) {
              cellsNext[i][j-1] = "debris";
            }
          }
          catch (Exception e) {
            fill(water);
          }
        }
      }
    }
  }
  setInitialRandomPlastics1();
}

void setInitialRandomPlastics1() {//Generates new generation of random plastics
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      float findProb = random(0, 1);
      if (findProb >= 1 - randomPlasticSpawn) {
        if ((cellsNext[i][j]).equals("land")) {
          try {
            if (cellsNext[i+1][j].equals("water")) {
              cellsNext[i+1][j] = "random plastics";
            }
            if (cellsNext[i-1][j].equals("water")) {
              cellsNext[i-1][j] = "random plastics";
            }
            if (cellsNext[i][j+1].equals("water")) {
              cellsNext[i][j+1] = "random plastics";
            }
            if (cellsNext[i][j-1].equals("water")) {
              cellsNext[i][j-1] = "random plastics";
            }
          }
          catch (Exception e) {}
        }
      }
    }
  }
  setInitialStyrofoam1();
}

void setInitialStyrofoam1() {//Generates new generation of styrofoam
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      float findProb = random(0, 1);
      if (findProb >= 1 - styrofoamSpawn) {
        if ((cellsNext[i][j]).equals("land")) {
          try {
            if (cellsNext[i+1][j].equals("water")) {
              cellsNext[i+1][j] = "styrofoam";
            }
            if (cellsNext[i-1][j].equals("water")) {
              cellsNext[i-1][j] = "styrofoam";
            }
            if (cellsNext[i][j+1].equals("water")) {
              cellsNext[i][j+1] = "styrofoam";
            }
            if (cellsNext[i][j-1].equals("water")) {
              cellsNext[i][j-1] = "styrofoam";
            }
          }
          catch (Exception e) {}
        }
      }
    }
  }
}
