class Zombie {

  PVector location;
  PVector velocity;
  float health;
  float speed = 1;
  float damage;
  float r;
  float dirX;
  float dirY;
  float rotate=0;
  float tempDir = 0;

  ArrayList<Checkpoint> checkpointList;
  int checkpointLength;
  PVector target = new PVector(0, 0);

  Zombie(float x_, float y_, float r_, float health_, float damage_) {
    location = new PVector(x_, y_);
    velocity = new PVector(startVel(m[levelNumber]).x, startVel(m[levelNumber]).y);
<<<<<<< Updated upstream:WZTD/Zombies_Tower_Defense/Zombie.pde
    println(velocity);
=======
    checkpointList = m[levelNumber].listLevelCheckpoints[levelNumber-1];
>>>>>>> Stashed changes:Zombies_Tower_Defense/Zombie.pde
    r = r_;
    health = health_;
    damage = damage_;

    checkpointLength = 0;
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

    checkPoints();

    circle(location.x+(pathWidth/2*dirX), location.y+(pathWidth/2*dirY), 5);
    location.add(velocity);
  }

<<<<<<< Updated upstream:WZTD/Zombies_Tower_Defense/Zombie.pde
    if (dirX == -1 && dirY ==0) {
      rotate = PI*1.5;
      velocity = new PVector(-1, 0);
    }
    if (dirX ==0 && dirY ==-1) {
      rotate = 0;
      velocity = new PVector(0, -1);
    }
    // color c = ;


    if (get(int(location.x+(pathWidth/2)*dirX), int(location.y+(pathWidth/2)*dirY)) != m[0].brown 
      && get(int(location.x+((pathWidth/2)+2)*dirX), int(location.y+((pathWidth/2)+2)*dirY+2*dirY)) != m[0].brown) {
      println("not brown");
      if (get(int(location.x+(pathWidth/2)*dirY), int(location.y+(pathWidth/2)*dirX)) != m[0].brown 
        && get(int(location.x+((pathWidth/2)+2)*dirY), int(location.y+((pathWidth/2)+2)*dirX)) != m[0].brown) {
        tempDir = dirX;
        dirX = -dirY;
        dirY = -tempDir;
      } else if (get(int(location.x+(pathWidth/2)*(-dirY)), int(location.y+(pathWidth/2)*(-dirX))) != m[0].brown 
        && get(int(location.x+(pathWidth/2)*(-dirY)+2), int(location.y+(pathWidth/2)*(-dirX+2))) != m[0].brown) {
        tempDir = dirX;
        dirX = dirY;
        dirY = tempDir;
=======
  void checkPoints() {
    float d = dist(location.x, location.y, target.x, target.y);
    if (d <= speed) {
      location.x = target.x;
      location.y = target.y;
      if (checkpointLength != checkpointList.size()-1) {
        checkpointLength++;
>>>>>>> Stashed changes:Zombies_Tower_Defense/Zombie.pde
      }
    }
    target.set(checkpointList.get(checkpointLength).x, checkpointList.get(checkpointLength).y);
    velocity = PVector.sub(target, location);
    velocity.setMag(speed);
    rotate = velocity.heading()+PI/2;
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
