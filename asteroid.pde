class asteroid {
  int speed = 3;
  int spawnSpacing = 60;
  PVector pos = new PVector (random(width), random(height), 0);
  PVector vel = new PVector (random(-speed, speed), random(-speed, speed), 0);
  int vertices = int(random(10, 15));
  float[] radii = new float[vertices];
  float averageR = 0;
  float totalR = 0;
  boolean hit = false;
  int check = 0;


  void choosePos() {
    int choice = int(random(3));
    if (choice == 0) {
      pos.x = random(0, spawnSpacing*2);
      pos.y = random(height-spawnSpacing, height+spawnSpacing);
    } else if (choice == 1) {
      pos.x = random(spawnSpacing, width-spawnSpacing);
      pos.y = random(0, spawnSpacing*2);
    } else if (choice == 2) {
      pos.x = random(width-spawnSpacing*2, width);
      pos.y = random(height-spawnSpacing, height+spawnSpacing);
    } else if (choice == 3) {
      pos.x = random(spawnSpacing, width-spawnSpacing);
      pos.y = random(height - spawnSpacing*2, height);
    }
  }

  void generateShape() {
    for (int i = 0; i < vertices; i++) {
      int offset = int(random(-10, 10));
      radii[i] = random(20, 50) + offset;
      totalR += radii[i];
      averageR = totalR/vertices;
    }
  }

  void show() {
    push();
    beginShape();
    for (int i = 0; i < vertices; i++) {
      float theta = map(i, 0, vertices, 0, 2*PI);
      vertex(pos.x+radii[i]*cos(theta), pos.y+radii[i]*sin(theta));
    }
    if (hit) {
      stroke(0, 255, 0);
    } else {
      stroke(255, 0, 0);
    }
    strokeWeight(3);
    noFill();
    endShape(CLOSE);
    pop();
  }

  void update() {
    vel.setMag(speed);
    pos.add(vel);
  }

  void edges() {
    if (pos.x >= width+spawnSpacing/3) {
      pos.x = -spawnSpacing/3;
    } else if (pos.x <= -spawnSpacing/3) {
      pos.x = width+spawnSpacing/3;
    } else if (pos.y >= height+spawnSpacing/3) {
      pos.y = -spawnSpacing/3;
    } else if (pos.y <= -spawnSpacing/3) {
      pos.y = height+spawnSpacing/3;
    }
  }

  void checkShip() {
    float d = dist(pos.x, pos.y, s.pos.x, s.pos.y);
    if (d < averageR + s.r) {

    }
  }
  void checkLazar() {
    for (lazar l : lazars) {
      float d = dist(pos.x, pos.y, l.pos.x, l.pos.y);
      if (d < averageR+l.r) {
        stroke(0, 255, 0);
        hit = true;
        l.hitAst = true;
      }
    }
  }
  void newGeneration() {
    for (int i = 0; i < 1; i++) {
      asteroids.add(new asteroid());
    }
  }
}
