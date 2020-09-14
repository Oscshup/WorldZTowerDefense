class Zombie {

  PVector location;
  PVector velocity;
  float health;
  float speed;
  float damage;
  float r;
  float dirX;
  float dirY;
  float rotate = PI;

  Zombie(float x_, float y_, float r_, float health_, PVector velocity_, float damage_) {
    location = new PVector(x_, y_);
    velocity = new PVector(velocity_.x, velocity_.y);
    r = r_;
    health = health_;
    speed = velocity.mag();
    damage = damage_;
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
    location.add(velocity);
  }
}



class Normal_Zombie extends Zombie {
  PImage  zNormal;
  Normal_Zombie(float x_, float y_, float r_, float health_, PVector velocity_, float damage_) {
    super(x_, y_, r_, health_, velocity_, damage_);
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
  Fast_Zombie(float x_, float y_, float r_, float health_, PVector velocity_, float damage_, color c_) {
    super(x_, y_, r_, health_, velocity_, damage_);
    dia = r*2;
    c = c_;
    zFast = loadImage("zHurtig.png");
    zFast.resize(50, 50);
    
  }

  void display() {
   pushMatrix();
   translate(location.x,location.y);
   rotate(rotate);
    image(zFast, 0,0);
    popMatrix();
    
  }
}
