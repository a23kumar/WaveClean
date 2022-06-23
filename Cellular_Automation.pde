int n = 100;// Do not change variables in lines 1-6
float padding = 10;
String[][] cells ;
String[][] cellsNext;
String[][] vortex;
float cellSize;

//The colours that each cell value will hold
color land = color(1, 52, 32);
color water = color(100, 149, 237);
color plasticBag = color(255, 0, 0);
color styrofoam = color(28, 25, 52);
color debris = color(169, 169, 169);
color randomPlastics = color(204, 204, 0);


//Probabilities are in percentages. For example, 0.03 = 3%, 0.005 = 0.5% with a max malue 1 (100%)
//You can modify these probablities how much ever you want, but 
float plasticBagSpawn = 0.005;
float styrofoamSpawn = 0.005;
float debrisSpawn = 0.005;
float randomPlasticSpawn = 0.005;

void setup() {
  size(650, 650);
  frameRate(15);  
  cells = new String[n][n];
  cellsNext = new String[n][n];
  vortex = new String[n][n];
  cellSize = (width-2*padding)/n;
  firstGeneration();//Initialize first generation in setup 
}


void draw() {

  noStroke();
  background(255);

  float y = padding;
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      float x = padding + j*cellSize;
      if (cells[i][j] != null)
      {
        if (cells[i][j].equals("land"))
          fill(land);
        else if (cells[i][j].equals("water"))
          fill(water);
        else if (cells[i][j].equals("plastic bag"))
          fill(plasticBag);    
        else if (cells[i][j].equals("debris"))
          fill(debris);
        else if (cells[i][j].equals("random plastics"))
          fill(randomPlastics);
        else if (cells[i][j].equals("styrofoam"))
          fill(styrofoam);

        rect(x, y, cellSize, cellSize);
      } else {
        print("found null");
      }
    }
    y += cellSize;
  }
  nextGen();

  replace();
}


void nextGen() {//Conditions for each successive generation are declared here 
  //println("firstGeneration() is complete, entering next");
  //firstGeneration1();
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) { 
      try {
        //If the trash beside a land cell is debris
        if (cells[i][j].equals("debris") && (cells[i][j-1].equals("land")))
          cellsNext[i][j+1] = "debris";
        else if (cells[i][j].equals("debris") && (cells[i][j+1].equals("land")))
          cellsNext[i][j-1] = "debris";
        else if (cells[i][j].equals("debris") && (cells[i-1][j].equals("land")))
          cellsNext[i+1][j] = "debris";
        else if (cells[i][j].equals("debris") && (cells[i+1][j].equals("land")))
          cellsNext[i-1][j] = "debris";

        //If the waste beside a land cells is plastic bags
        if (cells[i][j].equals("plastic bag") && (cells[i][j-1].equals("land")))
          cellsNext[i][j+1] = "plastic bag";
        else if (cells[i][j].equals("plastic bag") && (cells[i][j+1].equals("land")))
          cellsNext[i][j-1] = "plastic bag";
        else if (cells[i][j].equals("plastic bag") && (cells[i-1][j].equals("land")))
          cellsNext[i+1][j] = "plastic bag";
        else if (cells[i][j].equals("plastic bag") && (cells[i+1][j].equals("land")))
          cellsNext[i-1][j] = "plastic bag";

        //If the waste beside a land cell is styrofoam
        if (cells[i][j].equals("styrofoam") && (cells[i][j-1].equals("land")))
          cellsNext[i][j+1] = "styrofoam";
        else if (cells[i][j].equals("styrofoam") && (cells[i][j+1].equals("land")))
          cellsNext[i][j-1] = "styrofoam";
        else if (cells[i][j].equals("styrofoam") && (cells[i-1][j].equals("land")))
          cellsNext[i+1][j] = "styrofoam";
        else if (cells[i][j].equals("styrofoam") && (cells[i+1][j].equals("land")))
          cellsNext[i-1][j] = "styrofoam";

        //If the waste beside a land cell is random plastic
        if (cells[i][j].equals("random plastics") && (cells[i][j-1].equals("land")))
          cellsNext[i][j+1] = "random plastics";
        else if (cells[i][j].equals("random plastics") && (cells[i][j+1].equals("land")))
          cellsNext[i][j-1] = "random plastics";
        else if (cells[i][j].equals("random plastics") && (cells[i-1][j].equals("land")))
          cellsNext[i+1][j] = "random plastics";
        else if (cells[i][j].equals("random plastics") && (cells[i+1][j].equals("land")))
          cellsNext[i-1][j] = "random plastics";
        if (cellsNext[i][j] == null)
          cellsNext[i][j] = "water";
      }
      catch(Exception e) {
      }
//EVERY LINE AFTER THIS IN THE NEXTGEN FUNCTION IS MEANT TO GIVE MOVEMENT TO THE WASTE WHEN IT IS NOT IN CLSOE PROXIMITY TO ANY LAND
      //i-1
      try {
        if (cellsNext[i][j].equals("plastic bag") && (cellsNext[i-1][j].equals("water"))) {
          int rand;
          rand = int(random(3));;
          if (rand == 0)//left
            cellsNext[i-1][j] = ("plastic bag");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("debris") && (cellsNext[i-1][j].equals("water"))) {
          int rand;
          rand = int(random(3));
          //println(rand);
          if (rand == 0)//left
            cellsNext[i-1][j] = ("debris");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("random plastics") && (cellsNext[i-1][j].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("random plastics");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("random plastics");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("styrofoam") && (cellsNext[i-1][j].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("styrofoam");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("styrofoam");
          cellsNext[i][j] = "water";
        }
      }
      catch(Exception e) {
      }
      //i+1
      try {
        if (cellsNext[i][j].equals("plastic bag") && (cellsNext[i+1][j].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("plastic bag");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("debris") && (cellsNext[i+1][j].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("debris");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("random plastics") && (cellsNext[i+1][j].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("random plastics");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("random plastics");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("styrofoam") && (cellsNext[i+1][j].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("styrofoam");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("styrofoam");
          cellsNext[i][j] = "water";
        }
      }
      catch(Exception e) {
      }
      //j-1
      try {
        if (cellsNext[i][j].equals("plastic bag") && (cellsNext[i][j-1].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("plastic bag");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("debris") && (cellsNext[i][j-1].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("debris");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("random plastics") && (cellsNext[i][j-1].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("random plastics");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("random plastics");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("styrofoam") && (cellsNext[i][j-1].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("styrofoam");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("styrofoam");
          cellsNext[i][j] = "water";
        }
      }
      catch(Exception e) {
      }
      //j+1
      try {
        if (cellsNext[i][j].equals("plastic bag") && (cellsNext[i][j+1].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("plastic bag");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("plastic bag");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("debris") && (cellsNext[i][j+1].equals("water"))) {
          int rand;
          rand = int(random(3));
          //println(rand);
          if (rand == 0)//left
            cellsNext[i-1][j] = ("debris");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("debris");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("plastic bag");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("random plastics") && (cellsNext[i][j+1].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("random plastics");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("random plastics");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("random plastics");
          cellsNext[i][j] = "water";
        }
        if (cellsNext[i][j].equals("styrofoam") && (cellsNext[i][j+1].equals("water"))) {
          int rand;
          rand = int(random(3));
          if (rand == 0)//left
            cellsNext[i-1][j] = ("styrofoam");
          cellsNext[i][j] = ("water");
          if (rand == 1)//right
            cellsNext[i+1][j] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 2)
            cellsNext[i][j-1] = ("styrofoam");
          cellsNext[i][j] = "water";
          if (rand == 3)
            cellsNext[i][j+1] = ("styrofoam");
          cellsNext[i][j] = "water";
        }
      }
      catch(Exception e) {
      }
    }
  }
  setInitialLand1();//Set the constant land and random generation of waste at the end of every generation
}

void replace() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      cells[i][j] = cellsNext[i][j];
    }
  }
}
