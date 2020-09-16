class Tower {

  int p;
  float s;
  PVector location;
  PVector distance;
  float damage;
  boolean active;
  boolean placed;
  int id;
  int id2;
  float AttackRadius = 100;
  float angle = 0;
  int savedId;

  Tower(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    p = p_;
    s = s_;
    id = id_;
    location = new PVector(location_.x, location_.y);
    damage = damage_;
    active = active_;
    placed = placed_;
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {

    return new Tower(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }



  void update() {
    if (placed == false) {
      location.x = mouseX;
      location.y = mouseY;
    } 
    if (active == true) {
      float highestDistanceTravelled = 0;
      savedId = -1;
      for (int i = 0; i < listZ.size(); i++) {
        float dis = dist(listZ.get(i).location.x, listZ.get(i).location.y, location.x, location.y);
        if (dis<=AttackRadius) {
          if (listZ.get(i).distanceTravelled > highestDistanceTravelled) {
            highestDistanceTravelled = listZ.get(i).distanceTravelled;
            savedId = listZ.get(i).id;
          }
        }
      }
      if (listZ.size() > 0 && savedId != -1) {
        distance = PVector.sub(listZ.get(savedId).location, location);
        angle = distance.heading();
      } else {
        angle = 0;
      }
      pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      display();
      popMatrix();
    }
  }

  void onClick() {
    if (placed == false) {
      boolean checkTemp = false;
      ArrayList<Square> squareList = m[levelNumber].listLevelSquares[levelNumber-1];
      println(squareList.size());
      for (int i = 0; i < squareList.size(); i++) {
        if (checkForPath(location.x, location.y, s/2, squareList.get(i).x, squareList.get(i).y, squareList.get(i).w, squareList.get(i).h) == true) {
          checkTemp = true;
        }
      }
      for (Tower t : listT) {
        if (t.id != id) {
          float distance = dist(t.location.x, t.location.y, location.x, location.y);
          float minDist = t.s/2+s/2;
          if (distance <= minDist) {
            checkTemp = true;
          }
        }
      }
      if (checkTemp == false) {
        placed = true;
        totalTowers++;
      }
    }
  }


  boolean checkForPath(float tX, float tY, float tR, float pX, float pY, float pW, float pH) {

    pX-=pW/2+width/48;
    pY-=pH/2+height/28;

    float testX = tX;
    float testY = tY;

    if (tX < pX)         testX = pX;
    else if (tX > pX+pW) testX = pX+pW;
    if (tY < pY)         testY = pY;
    else if (tY > pY+pH) testY = pY+pH;

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
    Bullet b = new Bullet(location.x, location.y, damage, id,id2);
    bullets.add(b);
    //println(b);
  }
}

class LongRange extends Tower {
  LongRange(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }

  void display() {
    point(location.x, location.y);
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new Tower(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}

class LR1 extends LongRange {
  LR1(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }

  void display() {
    imageMode(CENTER);
    image(shop.lr1, 0, 0);
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    println(placedNew);
    return new LR1(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}

class LR2 extends LongRange {
  LR2(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.lr2, 0, 0);
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new LR2(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}

class LR3 extends LongRange {
  LR3(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
    p_*=100;
  }
  void display() {
    imageMode(CENTER);
    image(shop.lr3, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new LR3(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}

class ShortRange extends Tower {
  ShortRange(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    point(location.x, location.y);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new Tower(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}

class SR1 extends ShortRange {
  SR1(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sr1, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SR1(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}
class SR2 extends ShortRange {
  SR2(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sr2, 0, 0);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SR2(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}
class SR3 extends ShortRange {
  SR3(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sr3, 0, 0);
  }
  void turn() {
  }
  void shoot() {
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SR3(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}

class Special extends Tower {
  Special(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    point(location.x, location.y);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new Tower(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}

class SP1 extends Special {
  SP1(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sp1, location.x, location.y);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SP1(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}
class SP2 extends Special {
  SP2(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sp2, location.x, location.y);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SP2(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}
class SP3 extends Special {
  SP3(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, active_, placed_, id_);
  }
  void display() {
    imageMode(CENTER);
    image(shop.sp3, location.x, location.y);
  }
  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SP3(p, s, locationNew, damage, activeNew, placedNew, totalTowers);
  }
}