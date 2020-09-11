class Zombie{
  
  PVector location;
  PVector velocity;
  float health;
  float speed;
  float damage;
  float r;
  float dirX;
  float dirY;
  
  Zombie(float x_, float y_, float r_, float health_, PVector velocity_, float damage_){
    location = new PVector(x_, y_);
    velocity = new PVector(velocity_.x, velocity_.y);
    r = r_;
    health = health_;
    speed = velocity.mag();
    damage = damage_;
  }
  
  void damagePlayer(){
    p.health -= damage;
    health = 0;
  }
  
  void die(){
    speed = 0;
    location.y = -1000;
  }
  
  void update(){
    if(health <= 0){
      die();
    }
  }
  
  void display(){
    point(location.x,location.y);
  }
  
  void move(){
    location.add(velocity);
  }
  
}
