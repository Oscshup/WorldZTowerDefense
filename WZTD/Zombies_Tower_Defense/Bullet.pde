class Bullet {
  //Bullets current position
  PVector location;
  //where does the bullet shooting towards
  //How fast Bullet move on screen
  float speed = 4;
  float size = 1;

  IntList zombiesHitId = new IntList();

  boolean dead = false;
  boolean sniper = false;

  int idT;
  int idZ;
  int idB;

  PVector velocity;

  boolean hit = false;

  float damage;

  Bullet(float startX, float startY, float damage_, int idT_, int idZ_, int idB_) {
    location = new PVector(startX, startY);
    idT = idT_;
    idZ = idZ_;
    idB = idB_;
    damage = damage_;

    for (int j = listT.size()-1; j >= 0; j--) {
      if (listT.get(j).id == idT && listT.get(j).p == 100) {
        sniper = true;
        break;
      }
    }
    if (idZ != -1 && listZ.size() != 0 && sniper == true) {
      Zombie target2 = listZ.get(0);
      for (int i = listZ.size()-1; i >= 0; i--) {
        if (listZ.get(i).id == idZ) {
          target2 = listZ.get(i);
        }
      }
      velocity = PVector.sub(target2.location, location);
      velocity.setMag(speed);
    }
  }


  void update() {
    if (idZ != -1 && listZ.size() != 0) {
      
      Zombie target = listZ.get(0);
      for (int i = listZ.size()-1; i >= 0; i--) {
        if (listZ.get(i).id == idZ) {
          target = listZ.get(i);
        }
      }
      if (sniper == false) {
        velocity = PVector.sub(target.location, location);
        velocity.setMag(speed);
      }
      location.add(velocity);
      float angle = velocity.heading();
      for (int i = listZ.size()-1; i >= 0; i--) {
        if (size+10 >= dist(location.x, location.y, listZ.get(i).location.x, listZ.get(i).location.y)) {
          boolean hitZombieBefore = false;
          for (int k = 0; k < zombiesHitId.size(); k++) {
            if (listZ.get(i).id == zombiesHitId.get(k)) {
              hitZombieBefore = true;
            }
          }
          if (hitZombieBefore == false) {
            listZ.get(i).health-=damage;
            zombiesHitId.append(listZ.get(i).id);
          }
          if (sniper == false) {
            location.x = -1000000;
            dead = true;
            break;
          }
        }
      }
      if (location.x > m[levelNumber].xMax || location.x < 0 || location.y > m[levelNumber].yMax) {
        location.x = -1000000;
        dead = true;
      }

      pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      stroke(0);
      line(0, 0, size, 0);
      popMatrix();
    }
  }
}
