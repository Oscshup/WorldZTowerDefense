class Tower {

  int p;
  float s;
  PVector location;
  float damage;
  boolean active;
  boolean placed;
  int id;
  float range;
  float fireRate;
  float angle = 0;
  int savedId;




  Tower(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    p = p_;
    s = s_;
    id = id_;
    range = range_;
    fireRate = fireRate_;
    location = new PVector(location_.x, location_.y);
    damage = damage_;
    active = active_;
    placed = placed_;
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {

    return new Tower(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }

  void update() {
    if (placed == false) {
      location.x = mouseX;
      location.y = mouseY;
    }
    if (active == true && placed == true) {
      float highestDistanceTravelled = 0;
      savedId = -1;
      for (int i = listZ.size()-1; i >= 0; i--) {
        float dis = dist(listZ.get(i).location.x, listZ.get(i).location.y, location.x, location.y);
        if (dis<=range) {
          if (listZ.get(i).distanceTravelled > highestDistanceTravelled) {
            highestDistanceTravelled = listZ.get(i).distanceTravelled;
            savedId = listZ.get(i).id;
          }
        }
      }
      if (listZ.size() > 0 && savedId != -1) {
        for (int i = listZ.size()-1; i >= 0; i--) {
          if (listZ.get(i).id == savedId) {
            PVector distance = PVector.sub(listZ.get(i).location, location);
            angle = distance.heading();
          }
        }
      } else {
        angle = 0;
      }
    }
    if (active == true) {
      pushMatrix();
      translate(location.x, location.y);
      turn(angle);
      display();
      popMatrix();
    }
  }

  void turn(float angle) {
    rotate(angle);
  }

  void onClick() {
    if (placed == false) {
      boolean checkTemp = false;
      ArrayList<Square> squareList = m[levelNumber].listLevelSquares[levelNumber-1];
      for (int i = 0; i < squareList.size(); i++) {
        if (checkForPath(location.x, location.y, s/2, squareList.get(i).x, squareList.get(i).y, squareList.get(i).w, squareList.get(i).h) == true) {
          checkTemp = true;
        }
        if (location.x >width-shopLength) {
          checkTemp = true;
        }
      }
      for (Tower t : listT) {
        if (t.id != id) {
          float distance = dist(t.location.x, t.location.y, location.x, location.y);
          float minDist = t.s/2+s/2-15;
          if (distance <= minDist) {
            checkTemp = true;
          }
        }
      }
      if (checkTemp == false) {
        placed = true;
        shop.money-=p;
        totalTowers++;
      }
    }
  }


  boolean checkForPath(float tX, float tY, float tR, float pX, float pY, float pW, float pH) {

    pX-=pW/2/*+width/48*/;
    pY-=pH/2/*+height/28*/;

    float testX = tX;
    float testY = tY;

    if (tX < pX)         testX = pX+7;
    else if (tX > pX+pW) testX = pX+pW-7;
    if (tY < pY)         testY = pY+7;
    else if (tY > pY+pH) testY = pY+pH-7;

    float distX = tX-testX;
    float distY = tY-testY;
    float distance = sqrt( (distX*distX) + (distY*distY) );
    if (distance <= tR) {
      return true;
    }
    return false;
  }

  boolean checkForTower() {
    return true;
  }

  void display() {
    point(location.x, location.y);
  }

  void turn() {
  }

  void shoot() {
    if (active == true && placed == true) {
      for (int i = listZ.size()-1; i >= 0; i--) {
        Zombie z = listZ.get(i);
        if (z.id == savedId && frameCount % 60/fireRate == 0 && dist(location.x, location.y, z.location.x, z.location.y) < range) {
          Bullet b = new Bullet(location.x, location.y, damage, id, savedId, totalBullets);
          bullets.add(b);
        }
      }
    }
  }
}

class LongRange extends Tower {
  LongRange(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }

  void display() {
    point(location.x, location.y);
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new Tower(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}

class LR1 extends LongRange {
  LR1(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }

  void display() {
    imageMode(CENTER);
    image(shop.lr1, 0, 0);
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new LR1(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}

class LR2 extends LongRange {
  LR2(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.lr2, 0, 0);
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new LR2(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}

class LR3 extends LongRange {


  PImage launcher;
  PImage raketNed;
  PImage raketOp;
  float blastRadius;
  int up = constrain(50, 50, 200);
  int launched = 0;
  int dir = 3;
  float down = 0;
  float delay = 0;
  float max = 200/dir;

  LR3(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_, float bR_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
    p_*=100;

    launcher = loadImage("eLauncher.png");
    raketNed = loadImage("raketNed.png");
    raketOp = loadImage("raketOp.png");

    launcher.resize(100, 100);
    raketNed.resize(50, 50);
    raketOp.resize(50, 50);
  }
  void display() {
    imageMode(CENTER);
    image(launcher, 0, 0);
  }

  void turn(float angle) {
    rotate(PI);
  }

  void shoot() {
    if (active == true && placed == true) {
      for (int i = listZ.size()-1; i >= 0; i--) {
        Zombie z = listZ.get(i);
        if (z.id == savedId && frameCount % 60/fireRate == 0 && launched == 0) {
          launched = 1;
          dir = 3;
          down = 0;
          delay = 0;
          max = 200/dir;
        }
      }
    }
    if (launched ==1) {
      pushMatrix();
      translate(location.x+30, location.y+5);
      imageMode(CENTER);

      if (dir == 3) {
        image(raketOp, 0, 0, up, up);
      }
      up+=dir;
      if (up > max) {
        down = 1;
      } 
      if (down == 1) {
        delay++;
        if (delay >100) {
          int targetNumber = -1;
          for (int i = 0; i < listZ.size(); i++) {
            if (listZ.get(i).id == savedId) {
              targetNumber = i;
            }
          }
          if (targetNumber != -1) {
            dir = -3;
            if ( up !=0 && down != 0) {
              pushMatrix();
              translate( listZ.get(targetNumber).location.x-location.x-30, listZ.get(targetNumber).location.x-location.y-5);
              image(raketNed, 0, 0, up, up);
              popMatrix();
            }
          }
        }
      }
      if (up <= 0) {
        up = 0;
        down = 0;
        delay = 0;
        launched = 0;
      }
      popMatrix();
    }
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new LR3(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers, blastRadius);
  }
}

class ShortRange extends Tower {
  ShortRange(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    point(location.x, location.y);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new Tower(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}

class SR1 extends ShortRange {
  SR1(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sr1, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SR1(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}
class SR2 extends ShortRange {
  SR2(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sr2, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SR2(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}
class SR3 extends ShortRange {
  SR3(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sr3, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SR3(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}

class Special extends Tower {
  Special(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    point(location.x, location.y);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new Tower(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}

class SP1 extends Special {
  SP1(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sp1, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SP1(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}
class SP2 extends Special {
  SP2(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sp2, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SP2(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}
class SP3 extends Special {
  SP3(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sp1, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SP3(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}
