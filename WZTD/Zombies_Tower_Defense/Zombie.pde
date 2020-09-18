class Zombie {

  PVector location;
  PVector velocity;
  float health;
  float startHealth;
  float speed;
  float damage;
  float dirX;
  float dirY;
  float rotate=0;
  float tempDir = 0;
  float distanceTravelled = 0;
  int id;
  int deathPrice;
  int deathSkillPoints;
  float dia;
  
  boolean slowed = false;
  boolean dead = false;

  ArrayList<Checkpoint> checkpointList;
  int checkpointLength;
  PVector target = new PVector(0, 0);

  Zombie(int deathPrice_, int deathSkillPoints_, float x_, float y_, float dia_, float health_, float damage_, float speed_, int id_) {
    speed = speed_;
    deathPrice = deathPrice_;
    deathSkillPoints = deathSkillPoints_;
    id = id_;
    dia = dia_;
    location = new PVector(x_, y_);
    velocity = new PVector(startVel(m[levelNumber]).x, startVel(m[levelNumber]).y);
    checkpointList = m[levelNumber].listLevelCheckpoints[levelNumber-1];
    startHealth = health_;
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
    checkDead();
    p.health -= damage;
    health = 0;
    s.skillPointsEarned-=deathSkillPoints;
  }

  void displayHealth() {
    float healthBarWidth = dia;
    noStroke();
    fill(255, 100);
    rectMode(CORNER);
    rect(location.x-(healthBarWidth/2), location.y - 30, healthBarWidth, 5);
    if (health > startHealth*0.6) {
      fill(46, 204, 113);
    } else if (health > startHealth*0.3) {
      fill(230, 126, 34);
    } else {
      fill(231, 76, 60);
    }
    rectMode(CORNER);
    if (health >0) {
      rect(location.x-(healthBarWidth/2), location.y-30, healthBarWidth*(health/startHealth), 5);
    }
  }

  void checkDead() {
    if (health <= 0) {
      for (int i = bullets.size()-1; i >= 0; i--) {
        if (bullets.get(i).idZ == id && bullets.get(i).sniper == false) {
          bullets.remove(i);
        }
      }
      s.dieZombies(id, deathPrice);
      s.skillPointsEarned+=deathSkillPoints;
    }
  }

  void display() {
    point(location.x, location.y);
  }

  void move() {
    checkPoints();
    location.add(velocity);
    distanceTravelled+=velocity.mag();
  }

  void checkPoints() {
    boolean dead = false;
    float d = dist(location.x, location.y, target.x, target.y);
    if (d <= speed) {
      location.x = target.x;
      location.y = target.y;
      if (checkpointLength != checkpointList.size()-1) {
        checkpointLength++;
      } else {
        p.health-=damage;
        for (int i = bullets.size()-1; i >= 0; i--) {
          if (bullets.get(i).idZ == id && bullets.get(i).sniper == false) {
            bullets.remove(i);
          }
        }
        s.dieZombies(id, 0);
        dead = true;
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
  Normal_Zombie(int deathPrice_, int deathSkillPoints_, float x_, float y_, float dia_, float health_, float damage_, float speed_, int id_) {
    super(deathPrice_, deathSkillPoints_, x_, y_, dia_, health_, damage_, speed_, id_);
    zNormal = loadImage("zNormal.png");
    zNormal.resize(int(dia), int(dia));
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(rotate);
    imageMode(CENTER);
    image(zNormal, -3, 0);
    popMatrix();
    imageMode(CORNER);
  }
}


class Fast_Zombie extends Zombie {

  PImage  zFast;
  Fast_Zombie(int deathPrice_, int deathSkillPoints_, float x_, float y_, float dia_, float health_, float damage_, float speed_, int id_) {
    super(deathPrice_, deathSkillPoints_, x_, y_, dia_, health_, damage_, speed_, id_);
    zFast = loadImage("zHurtig.png");
    zFast.resize(int(dia), int(dia));
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

class Tank_Zombie extends Zombie {

  PImage  zTank;
  Tank_Zombie(int deathPrice_, int deathSkillPoints_, float x_, float y_, float dia_, float health_, float damage_, float speed_, int id_) {
    super(deathPrice_, deathSkillPoints_, x_, y_, dia_, health_, damage_, speed_, id_);
    zTank = loadImage("zTank.png");
    zTank.resize(int(dia), int(dia));
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(rotate);
    imageMode(CENTER);
    image(zTank, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }
}

class MiniBoss_Zombie extends Zombie {

  PImage  zMiniBoss;
  MiniBoss_Zombie(int deathPrice_, int deathSkillPoints_, float x_, float y_, float dia_, float health_, float damage_, float speed_, int id_) {
    super(deathPrice_, deathSkillPoints_, x_, y_, dia_, health_, damage_, speed_, id_);
    zMiniBoss = loadImage("zMiniBoss.png");
    zMiniBoss.resize(int(dia), int(dia)*2);
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(rotate);
    imageMode(CENTER);
    image(zMiniBoss, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }
}

class Boss_Zombie extends Zombie {

  PImage  zBoss;
  Boss_Zombie(int deathPrice_, int deathSkillPoints_, float x_, float y_, float dia_, float health_, float damage_, float speed_, int id_) {
    super(deathPrice_, deathSkillPoints_, x_, y_, dia_, health_, damage_, speed_, id_);
    zBoss = loadImage("zBoss.png");
    zBoss.resize(int(dia)*2, int(dia)*2);
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(rotate);
    imageMode(CENTER);
    image(zBoss, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }
}
