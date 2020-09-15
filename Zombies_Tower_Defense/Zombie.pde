class Zombie {

  PVector location;
  PVector velocity;
  float health;
  float speed = 1;
  float damage;
  float r;
  float dirX;
  float dirY;
  float MaxHealth = 100;

  Zombie(float x_, float y_, float r_, float health_, float damage_) {
    location = new PVector(x_, y_);
    velocity = new PVector(startVel(m[levelNumber]).x, startVel(m[levelNumber]).y);
    r = r_;
    health = health_;
    damage = damage_;
  }

  PVector startVel (Map m) {
    PVector StartVel = new PVector(0, 0);
    if (m.zombieStart.y == m.yStart) {
      StartVel.add(0, speed);
    } else if (m.zombieStart.x == m.xStart) {
      StartVel.add(speed, 0);
    }
    return StartVel;
  }

  void damagePlayer() {
    p.health -= damage;
    health = 0;
  }

  void die() {
    //Her skal zombie forsvinde fra index
    speed = 0;
    location.y = -1000;
  }

  void update() {
    if (health <= 0) {
      die();
    }
  }
  


  void display() {
    point(location.x, location.y);
  }

  void move() {

    if (abs(velocity.y) == abs(speed) ) {
      PVector tempVel = new PVector(0, 0);
      tempVel.add(velocity.normalize());
      if (get(int(location.x), int(location.y+velocity.y+(tempVel.y*pathWidth/2))) != m[0].brown) {
        if (get(int(location.x+pathWidth/2), int(location.y)) != m[0].brown) {
          velocity = new PVector(-1, 0);
        } else if (get(int(location.x-pathWidth/2), int(location.y)) != m[0].brown) {
          velocity = new PVector(1, 0);
        }
      }
    } else if (abs(velocity.x) == abs(speed)) {
      PVector tempVel = new PVector(0, 0);
      tempVel.add(velocity.normalize());
      if (get(int(location.x+velocity.x+(tempVel.x*pathWidth/2)), int(location.y)) != m[0].brown) {
        if (get(int(location.x+pathWidth/2), int(location.y)) != m[0].brown) {
          velocity = new PVector(0, -1);
        } else if (get(int(location.x-pathWidth/2), int(location.y)) != m[0].brown) {
          velocity = new PVector(0, 1);
        }
      }
    }

    location.add(velocity);
  }
}
