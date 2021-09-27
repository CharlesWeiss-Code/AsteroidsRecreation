// possibly add a flowfeild to randomize motion of lazarEdges_pow 
// add lives
// make stats (where u spend the most time aka what quadrent had the most time) etc...
PImage img;
PImage jet;

ArrayList<lazar> lazars = new ArrayList<lazar>();
ArrayList<asteroid> asteroids = new ArrayList<asteroid>();
float asteroidsL = 10;
boolean generateAsteroids = false;
boolean start = true;

// powerUp 
int powerUpTimer = 0;
int lazarEdgeTimer = 0;
int powerUpTimerMax = floor(random(600, 6000));

//difficulty & stats
float difficulty = 1.3;
int level  = 0;
boolean showStats = false;
int quad1, quad2, quad3, quad4 = 0;
boolean doOnce = false;


boolean endGameStats = false;
// next gen asteroids stuff
int nextGenAsteroidsTimer = 0;

ship s;
lazarEdges_pow p;



void setup() {
  img = loadImage("stars.jpeg");
  jet = loadImage("jet.png");
  p = new lazarEdges_pow();
  if (start) {
    for (int i = 0; i < asteroidsL; i ++) {
      asteroids.add(new asteroid());
      generateAsteroids = true;
    }
  }
  start = false;
  fullScreen();
  s = new ship();
}

void draw() {

  img.resize(width, height);
  background(img);
  shipStuff();
  lazarStuff();
  asteroidStuff();
  lazarEdgesPowStuff();
  powerUpTimer++;
  nextGenStuff();
  stats();
  newRound();
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    s.move = true;
  } else if (key == 'a' || key == 'A') {
    s.lefting = true;
  } else if (key == 'd' || key == 'D') {
    s.righting = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    s.move = false;
  } else if (key == 'a' || key == 'A') {
    s.lefting = false;
  } else if (key == 'd' || key == 'D') {
    s.righting = false;
  } else if (key == 's' || key == 'S') {
    s.flip();
  } else if  (key == 'x' || key == 'X') {
    if (p.touched) {
      p.draw = false;
      p.count = true;
    }
  }
  if (s.deathCount > 120) {
    if (key == 'n' || key == 'N') {
      powerUpTimer = 0;
      s.deathCount = 0;
      //for (PVector v : locations) {
      //  locations.remove(v);
      //}
      asteroidsL = 10;
      level = 0;

      s.pos.x = width/2;
      s.pos.y = height/2;
      s.vel.x = 0;
      s.vel.y = 0;
      s.dead = false;


      // delete locations of ship
      generateNewRound();
    }
  }
}


void mousePressed() {
  if (s.dead == false) {
    lazars.add(new lazar());
  }
}

void lazarStuff() {
  for (int i = lazars.size()-1; i > 0; i--) {
    lazars.get(i).show();
    lazars.get(i).update();
    if (p.edgePower) {
      lazars.get(i).edgesV2();
    }
    if (lazars.size() > 0) {
      if (lazars.get(i).hitAst == true) {
        lazars.remove(lazars.get(i));
      }
    }
  }
}

void shipStuff() {
  s.show();
  s.update();
  s.edges();
  s.checkAst();
  s.die();
}

void asteroidStuff() {
  if (generateAsteroids) {
    for (asteroid a : asteroids) {
      a.generateShape();
      a.choosePos();
    }
  }
  generateAsteroids = false;
  asteroidUpdate();
}

void asteroidUpdate() {
  for (int i = asteroids.size()-1; i > 0; i--) {
    asteroids.get(i).show();
    asteroids.get(i).update();
    asteroids.get(i).edges();
    asteroids.get(i).checkShip();
    asteroids.get(i).checkLazar();
    if (asteroids.get(i).hit == true) {
      asteroids.remove(asteroids.get(i));
    }
  }
}

void lazarEdgesPowStuff() {
  if (powerUpTimer == powerUpTimerMax) {
    p.getLocation();
    p.draw = true;
  } else if (powerUpTimer > powerUpTimerMax) {
    p.show();
    p.checkShip();
  }
  if (p.count == true) {
    p.touched = false;
    powerUpTimer = 0;
    push();
    stroke(0, 0, 255);
    strokeWeight(4);
    line(0, 0, width, 0);
    line(width, 0, width, height);
    line(0, height, width, height);
    line(0, 0, 0, height);
    pop();
    lazarEdgeTimer++;
    if (lazarEdgeTimer < 600) {
      p.edgePower = true;
    } else {
      p.count = false;
      lazarEdgeTimer = 0;
      p.edgePower = false;
    }
  }
}

void removeLasars(lazar l) {
  if (p.edgePower == false) {
    if (l.pos.x > width+1 || l.pos.x < -1 || l.pos.y > height+1 || l.pos.y < -1) {
      lazars.remove(l);
    }
  }
}

void nextGenStuff() {
  if (asteroids.size() == 1) {
    if (nextGenAsteroidsTimer < 180) {
      String nextGen = ("NEXT LEVEL");
      textSize(91);
      textAlign(CENTER);
      text(nextGen, width/2, height/2);
    } else if (nextGenAsteroidsTimer == 181) {
      level++;
      nextGenAsteroidsTimer = 0;
      asteroidsL *= difficulty;
      for (int i = 0; i < floor(asteroidsL); i++) {
        asteroids.add(new asteroid());
      }
      generateAsteroids = true;
      asteroidStuff();
    }
    nextGenAsteroidsTimer++;
  }
  String levelCount = "Level: ";
  textSize(20);
  textAlign(LEFT);
  text(levelCount, 25, 32);
  text(level+1, 85, 32);
}

void stats() {
  String totalAsteroids = "Asteroids in this Level: ";
  String Asteroids = "Asteroids left: ";
  int AsteroidsLeft = int(asteroidsL-(asteroidsL-asteroids.size())-1);
  textSize(20);
  textAlign(LEFT);
  text(totalAsteroids, 25, 64);
  text(int(asteroidsL), 250, 64);
  text(Asteroids, 25, 96);
  text(AsteroidsLeft, 170, 96);
}

void newRound() {
  if (s.dead) {
    if (s.deathCount > 120) {
      String PressN = "Press 'N' For a New Game";
      textSize(60);
      textAlign(CENTER);
      text(PressN, width/2, height/3);
    }
  }
}

void generateNewRound() {

  for (int i = asteroids.size()-1; i > 0; i--) {
    asteroids.remove(asteroids.get(i));
  }
  for (int i = lazars.size()-1; i > 0; i --) {
    lazars.remove(lazars.get(i));
  }
  for (int i = 0; i <asteroidsL; i ++) {
    asteroids.add(new asteroid());
    generateAsteroids = true;
  }
}
