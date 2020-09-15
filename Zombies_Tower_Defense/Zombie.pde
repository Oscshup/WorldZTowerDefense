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
  float distanceTravelled = 0;
  int id;

  Zombie(float x_, float y_, float r_, float health_, float damage_, int id_) {
    id = id_;
    location = new PVector(x_, y_);
    velocity = new PVector(startVel(m[levelNumber]).x, startVel(m[levelNumber]).y);
    r = r_;
    health = health_;
    damage = damage_;

    if (levelNumber == 1) {
      dirX = 1;
      dirY = 0;
    }
    if (levelNumber == 2) {
      dirX = 0;
      dirY = 1;
    }
    if (levelNumber == 3) {
      dirX = 0;
      dirY = 1;
    }
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
    tempDir =0;

    if (dirX == 1 && dirY ==0) {
      rotate = HALF_PI;
      velocity = new PVector(1, 0);
    }

    if (dirX == 0 && dirY ==1) {
      rotate = PI;
      velocity = new PVector(0, 1);
    }

    if (dirX == -1 && dirY ==0) {
      rotate = PI*1.5;
      velocity = new PVector(-1, 0);
    }
    if (dirX ==0 && dirY ==-1) {
      rotate = 0;
      velocity = new PVector(0, -1);
    }
    // color c = ;


    if (get(int(location.x+(pathWidth/2)*dirX), int(location.y+(pathWidth/2)*dirY)) == color(0,230,0) 
      && get(int(location.x+((pathWidth/2)+2)*dirX), int(location.y+((pathWidth/2)+2)*dirY+2*dirY)) == color(0,230,0)) {
      if (get(int(location.x+(pathWidth/2)*dirY), int(location.y+(pathWidth/2)*dirX)) == color(0,230,0) 
        && get(int(location.x+((pathWidth/2)+2)*dirY), int(location.y+((pathWidth/2)+2)*dirX)) == color(0,230,0)) {
        tempDir = dirX;
        dirX = -dirY;
        dirY = -tempDir;
      } else if (get(int(location.x+(pathWidth/2)*(-dirY)), int(location.y+(pathWidth/2)*(-dirX))) == color(0,230,0) 
        && get(int(location.x+(pathWidth/2)*(-dirY)+2), int(location.y+(pathWidth/2)*(-dirX+2))) == color(0,230,0)) {
        tempDir = dirX;
        dirX = dirY;
        dirY = tempDir;
      }
    } else {
      //     println("brown");
    }


    circle(location.x+(pathWidth/2*dirX), location.y+(pathWidth/2*dirY), 5);
    location.add(velocity);
    distanceTravelled+=velocity.mag();
    println(distanceTravelled);
  }
}


class Normal_Zombie extends Zombie {
  PImage  zNormal;
  Normal_Zombie(float x_, float y_, float r_, float health_, float damage_, int id_) {
    super(x_, y_, r_, health_, damage_, id_);
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
  Fast_Zombie(float x_, float y_, float r_, float health_, float damage_, int id_, color c_) {
    super(x_, y_, r_, health_, damage_, id_);
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
    imageMode(CORNER);
  }
}
