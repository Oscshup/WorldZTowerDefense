class Bullet {
  //Bullets current position
  PVector location;
  //where does the bullet shooting towards
  //How fast Bullet move on screen
  float speed = 4;

  float size = 1;

  int id;

  //bullet velocity
  PVector velocity;
  
  boolean hit = false;

  float damage;

  Bullet(float startX, float startY, float damage_, int id_) {
    location = new PVector(startX, startY);
    id = id_;
    damage = damage_;
  }


  void update(Zombie z) {
    float opacity = 255;
    if(z.health <= 0){
      opacity = 0;
    }
    velocity = PVector.sub(z.location, location);
    velocity.setMag(speed); 
    location.add(velocity);
    float angle = velocity.heading();
    if(size >= dist(location.x, location.y, z.location.x, z.location.y)){
      opacity = 0;
      z.health-=damage;
    }

    //compute rotation angle from velocity
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    stroke(0, opacity);
    line(0, 0, size, 0);
    popMatrix();
  }

 
}
