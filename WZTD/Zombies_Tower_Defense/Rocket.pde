class Rocket {

  PImage rocketImg = loadImage("Missile.png");
  Timer timer3 = new Timer();

  PVector location;
  PVector velocity;
  float speed;
  PVector target;

  int idT;
  int idZ;

  float blastRadius;
  float fireRate;
  float damage;

  int stage = 0;

  float s;

  Tower launcher;
  Zombie zombie;

  Rocket(int idT_, Zombie zombie_, float blastRadius_, float fireRate_, float s_, float damage_) {
    idT = idT_;
    zombie = zombie_;
    blastRadius = blastRadius_;
    fireRate = fireRate_;
    damage = damage_;
    speed = 5;
    s = s_;
    rocketImg.resize(int(50),int(50));
    for (int i = 0; i < listT.size(); i++) {
      if (listT.get(i).id == idT) {
        launcher = listT.get(i);
      }
    }
    location = new PVector(launcher.location.x, launcher.location.y);
    target = new PVector(zombie.location.x, zombie.location.y);
    velocity = PVector.sub(target, location);
    velocity.setMag(speed);
    timer3.start(300);
  
  }

  void update() {
    if (stage == 0 && timer3.isFinished()) {
      stage = 1;
    } 
    if (stage == 1) {
      if (dist(location.x, location.y, target.x, target.y) <= s) {
        explode();
      } else {
        location.add(velocity);
      }
    }
  }

  void explode() {
    for (int i = 0; i < listZ.size(); i++) {
      float distance = dist(target.x, target.y, listZ.get(i).location.x, listZ.get(i).location.y);
      if (distance <= blastRadius) {
        listZ.get(i).health-=damage;
      }
    }
    launcher.rocketActive = false;
    launcher.explode(target.x, target.y);
  }

  void display() {
    imageMode(CENTER);
 
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading()+PI/2);
    image(rocketImg, -10, 0);
    popMatrix();
  }
}
