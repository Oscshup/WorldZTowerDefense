class Life {
  PVector location;
  PVector acceleration, velocity;
  float r;

  float health = 100;
  float maxHealth = 100;
  float healthDecrease = 1;
  int healthBarWidth = 60;


  Life(float x, float y, float r_) {
    location = new PVector(x, y);
    acceleration = new PVector(0.6, 0);
    velocity = new PVector(0,0);
    r = r_;
  }

  void health() {
    noStroke();
    fill(200, 100);
    rectMode(CORNER);
    rect(location.x-(healthBarWidth/2), location.y - 30, healthBarWidth, 5);
    if (health > 60) {
      fill(46, 204, 113);
    } else if (health > 30) {
      fill(230, 126, 34);
    } else {
      fill(231, 76, 60);
    }
    rectMode(CORNER);
    rect(location.x-(healthBarWidth/2), location.y - 30, healthBarWidth*(health/maxHealth), 5);
  }


  void display() {
    fill(255, 0, 0);
    ellipse(location.x, location.y, r, r);
  }


  void move() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
}
