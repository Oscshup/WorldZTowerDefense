class Bullet {
  //Bullets current position
  PVector location;
  //where does the bullet shooting towards
  //How fast Bullet move on screen
  float speed = 4;

  float size = 1;

  int id;
  int id2;

  
  //bullet velocity
  PVector velocity;

  boolean hit = false;

  float damage;

  Bullet(float startX, float startY, float damage_, int id_, int id2_) {
    location = new PVector(startX, startY);
    id = id_;
    id2 = id2_;
    damage = damage_;
  }


  void update() {
    float angle = 0;
    if (listT.get(id).savedId != -1) {
      Zombie target = listZ.get(listT.get(id).savedId);

      if (target.health <= 0) {
        s.removeBullet(id2);
      }
      velocity = PVector.sub(target.location, location);
      velocity.setMag(speed); 
      location.add(velocity);
      angle = velocity.heading();
      if (size >= dist(location.x, location.y, target.location.x, target.location.y)) {
        target.health-=damage;
      }
    } else {
      angle = 0;
    }

    //compute rotation angle from velocity

    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    stroke(255,0,0);
    line(0, 0, size, 0);
    popMatrix();
  }
}
