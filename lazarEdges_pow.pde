class lazarEdges_pow {
  PVector pos = new PVector(0, 0, 0);
  boolean touched = false;
  int r = 40;
  int number = 1;
  boolean draw = false;
  boolean edgePower = false;
  int lazarEdgeTimer = 0;
  boolean count = false;


  void getLocation() {
    pos.x = random(width);
    pos.y = random(height);
  }

  void show() {
    if (draw) {
      if (touched == true) {
        push();
        fill(255);
        stroke(0, 0, 255);
        strokeWeight(3);
        ellipse(width-50, height-50, r*.75, r*.75);
        pop();
      } else {
        push();
        fill(255);
        stroke(0, 0, 255);
        strokeWeight(3);
        ellipse(pos.x, pos.y, r, r);
        pop();
      }
    }
  }

  void checkShip() {
    float d = dist(pos.x, pos.y, s.pos.x, s.pos.y);
    if (d < s.r+r) {
      touched = true;
    }
  }
}
