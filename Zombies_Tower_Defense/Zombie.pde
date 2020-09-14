class Zombie {

  PVector location;
  PVector velocity;
  float health;
  float speed = 1;
  float Bspeed;
  float damage;
  float r;
  float dirX;
  float dirY;
  float rotate =HALF_PI;

  Zombie(float x_, float y_, float r_, float health_, float damage_) {
    location = new PVector(x_, y_);
    velocity = new PVector(startVel(m[levelNumber]).x, startVel(m[levelNumber]).y);
    println(velocity);
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
   if (levelNumber == 1) {
      dirX = 1;
      dirY = 0;
      rotate = HALF_PI;
    }
    if (levelNumber == 2) {
      dirX = 0;
      dirY = 1;
      rotate = PI;
    }
    if (levelNumber == 3) {
      dirX = 0;
      dirY = 1;
      rotate = PI;
    }
   // color c = ;
if (get(int(location.x+(pathWidth/2*dirX)),int(location.y+(pathWidth/2*dirY))) != m[0].brown && get(int(location.x+(pathWidth/2*dirX+2)),int(location.y+(pathWidth/2*dirY+2))) != m[0].brown ){
  println("not brown");  
  rotate=0;
}



    location.add(velocity);
  }
}


class Normal_Zombie extends Zombie {
  PImage  zNormal;
  Normal_Zombie(float x_, float y_, float r_, float health_, float damage_) {
    super(x_, y_, r_, health_, damage_);
    zNormal = loadImage("zNormal.png");
    zNormal.resize(50, 50);
  }

  void display() {
    shop.money ++;
    image(zNormal, 20, 20);
  }
}


class Fast_Zombie extends Zombie {

  float dia;
  color c;
  PImage  zFast;
  Fast_Zombie(float x_, float y_, float r_, float health_, float damage_, color c_) {
    super(x_, y_, r_, health_, damage_);
    dia = r*2;
    c = c_;
    zFast = loadImage("zHurtig.png");
    zFast.resize(50, 50);
    
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(rotate);
    imageMode(CENTER);
    image(zFast, 0, 0);
    popMatrix();
  }
}
