class Bullet {
  //Bullets current position
  PVector location;
  //where does the bullet shooting towards
  //How fast Bullet move on screen
  float speed = 4;

  float size = 1;

  int idT;
  int idZ;
  int idB;

  //bullet velocity
  PVector velocity;

  boolean hit = false;

  float damage;

  Bullet(float startX, float startY, float damage_, int idT_, int idZ_, int idB_) {
    location = new PVector(startX, startY);
    idT = idT_;
    idZ = idZ_;
    idB = idB_;
    damage = damage_;
  }


  void update() {
    if (idZ != -1 && listZ.size() != 0 && idZ < listZ.size()) {
      //println("Zombie.size(): " + listZ.size() + " , zombieID: " + idZ);
      Zombie target = listZ.get(idZ);
      velocity = PVector.sub(target.location, location);
      velocity.setMag(speed); 
      location.add(velocity);
      float angle = velocity.heading();
      if (size+10 >= dist(location.x, location.y, target.location.x, target.location.y)) {
        target.health-=damage;
        location.x = -1000000;
        s.removeBullet(idB);
      }

      //compute rotation angle from velocity

      pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      stroke(0);
      line(0, 0, size, 0);
      popMatrix();
    }
  }
}
