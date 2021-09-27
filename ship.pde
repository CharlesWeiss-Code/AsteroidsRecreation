class ship {
  PVector pos = new PVector (width/2, height/2, 0);
  PVector vel = new PVector (0, 0, 0);
  PVector acc = new PVector (0, .3, 0);
  int r = 15;
  float pointing = 0;
  boolean lefting, righting, flip, move, slowing = false;
  float sens = .1;
  float speed = 0;
  float decel = 5;
  boolean dead = false;
  int lives = 4;
  float deathSpin = 0;
  int deathCount = 0;
  int statsCount = 0;

  void show() {
    if (dead == false) {
      push();
      stroke(255);
      strokeWeight(3);
      noFill();
      translate(pos.x, pos.y);
      rotate(-PI/2+pointing);
      //image(jet,0,0);
      triangle (r, -r, -r, -r, 0, r);
      pop();
    } else {
      push();
      fill(255, 0, 0);
      translate(pos.x, pos.y);
      rotate(-PI/2+pointing+deathSpin);
      triangle(r, -r, -r, -r, 0, r);
      pop();
    }
  }

  void update() {
    if (dead == false) {
      if (move) {
        speed = 5;
      } 
      if (lefting) {
        pointing -=sens;
      }
      if (righting) {
        pointing +=sens;
      }
      if (move == false) {
        speed*=.95;
      }
      vel.x = cos(pointing);
      vel.y = sin(pointing);
      vel.setMag(speed);
      pos.add(vel);
    }
  }


  void edges() {
    if (dead == false) {
      if (pos.x >= width+r*2) {
        pos.x = -r*2;
      } else if (pos.x <= -r*2) {
        pos.x = width+r*2;
      } else if (pos.y >= height+r*2) {
        pos.y = -r*2;
      } else if (pos.y <= -r*2) {
        pos.y = height+r*2;
      }
    }
  }
  void flip() {
    vel.mult(-1);
    pointing -=PI;
  }
  void checkAst() {
    for (int i = asteroids.size()-1; i > 0; i--) {
      float d = dist(pos.x, pos.y, asteroids.get(i).pos.x, asteroids.get(i).pos.y);
      if (d < asteroids.get(i).averageR + r) {
        dead = true;
      }
    }
  }
  void die() {
    if (dead) {
      deathSpin+=.5;
      vel.add(acc);
      pos.add(vel);
      stroke(255, 0, 0);
      if (deathCount < 120) {
        String dead = "DEAD";
        textSize(200);
        textAlign(CENTER);
        text(dead, width/2, height/2);
      }
      deathCount++;
      statsCount++;
    }
  }
}
