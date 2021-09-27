class lazar {
  boolean created = true;
  PVector pos = s.pos.copy();
  PVector vel = PVector.fromAngle(s.pointing).copy();
  int r = 5;
  float launchAngle = atan(vel.y/vel.x);
  int speed = 30;
  boolean edgesPow = false;
  boolean hitAst = false;

  void show() {
    push();
    stroke(255);
    noFill();
    strokeWeight(3);
    ellipse(pos.x, pos.y, r, r);
    pop();

  }

  void update() {
    push();
    vel.setMag(speed);
    pos.add(vel);
    pop();
  }
  void edges() {
    if (pos.x >= width-5) {
      pos.x = 5;
    } else if (pos.x <= 5) {
      pos.x = width-5;
    } else if (pos.y >= height-5) {
      pos.y = 5;
    } else if (pos.y <= 5) {
      pos.y = height-5;
    }
  }
  
  void edgesV2() {
    if (pos.x >= width-5) {
      vel.x*=-1;
    } else if (pos.x <= 5) {
      vel.x*=-1;
    } else if (pos.y >= height-5) {
      vel.y*=-1;
    } else if (pos.y <= 5) {
      vel.y*=-1;
    }
  }
  //void checkAst() {
  //  for (asteroid a : asteroids) {
  //    float d = dist(pos.x, pos.y, a.pos.x, a.pos.y);
  //    if (d < a.averageR+r) {
  //      hitAst = true;
  //    }
  //  }
  //}
}
