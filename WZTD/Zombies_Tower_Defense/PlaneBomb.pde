class PlaneBomb {

  PVector location;
  PVector velocity;
  float frictionSize = 0.1;
  int startTime;
  int totalTime = 1000;
  boolean bombActive = true;
  boolean explosionActive = false;
  PImage[] explosionsImg;
  int currentBomb = 0;
  int idB;
  int idT;
  float angle;
  float blastRadius;
  float damage;

  Tower plane;

  PlaneBomb(PVector location_, PVector velocity_, PImage[] explosionsImg_, int idB_, int idT_, float angle_, float blastRadius_, float damage_) {
    idT = idT_;
    float angle = angle_;
    for (int i = 0; i < listT.size(); i++) {
      if (listT.get(i).id == idT) {
        plane = listT.get(i);
      }
    }
    location = new PVector(location_.x, location_.y);
    velocity = new PVector(velocity_.x, velocity_.y);
    startTime = millis();
    explosionsImg = explosionsImg_;
    idB = idB_;
    blastRadius = blastRadius_;
    damage = damage_;
  }

  void update() {
    if (bombActive == true) {
      velocity.mult(0.9);
      location.add(velocity);
      if (millis()-startTime >= totalTime) {
        explode();
      }
    } else if (explosionActive == true) {
    }
    display();
  }

  void explode() {
    bombActive = false;
    explosionActive = true;
  }

  void display() {
    if (explosionActive == true) {
      imageMode(CENTER);
      image(explosionsImg[currentBomb], location.x, location.y);
      if (frameCount % 7 == 0) {
        currentBomb++;
      }
      if (currentBomb == 12) {
        explosionActive = false;
        for(int i = listZ.size()-1; i >= 0; i--){
          float distance = dist(location.x,location.y, listZ.get(i).location.x, listZ.get(i).location.y);
          if(distance < blastRadius){
            listZ.get(i).health-=damage;
          }
        }
        plane.removeBomb(idB);
      }
    } else if (bombActive == true) {
      imageMode(CENTER);
      image(planeBomb, location.x, location.y);
    }
  }
}
