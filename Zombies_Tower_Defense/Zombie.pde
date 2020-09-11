class Zombie {

  PVector location;
  PVector velocity;
  float health;
  float speed;
  float damage;
  float r;
  float dirX;
  float dirY;

  float maxZhealth;
  float healthDecrease;


  Zombie(float x_, float y_, float r_, float health_, PVector velocity_, float damage_) {
    location = new PVector(x_, y_);
    velocity = new PVector(velocity_.x, velocity_.y);
    r = r_;
    health = health_;
    speed = velocity.mag();
    damage = damage_;
    maxZhealth = 100;
    healthDecrease = 1;
  }

  void damagePlayer() {
    p.health -= damage;
    health = 0;
  }

  boolean delete() {
    if (maxZhealth <= 0.0) {
      return true;
    } else {
      return false;
    }
  }

  //Her skal der laves en if statement hvor bullt rammer zombie
  void ZtakeDamage() { 
    maxZhealth -= healthDecrease;
  } 


  void update() {
  }

  void display() {
    println(maxZhealth);
    point(location.x, location.y);
  }

  void move() {
    location.add(velocity);
  }
}
