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

  //For the rocket launcher
  boolean rocketActive = false;

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
      stroke(0, 200);
      strokeWeight(4);
      noFill();
      circle(location.x, location.y, range);
      stroke(0, 120);
      strokeWeight(2);
      if (checkLocation() == true) {
        fill(0, 255, 0, 120);
      } else {
        fill(255, 0, 0, 120);
      }
      circle(location.x, location.y, s);
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
      } /*else {
       angle = 0;
       }*/
    }
    if (active == true) {
      pushMatrix();
      translate(location.x, location.y);
      turn(angle);
      if (p == 10000) {
        translate(-location.x, -location.y);
      }
      display();
      popMatrix();
    }
  }
  void turn(float angle) {
    rotate(angle);
  }

  boolean checkLocation() {
    ArrayList<Square> squareList = m[levelNumber].listLevelSquares[levelNumber-1];
    for (int i = 0; i < squareList.size(); i++) {
      if (checkForPath(location.x, location.y, s/2, squareList.get(i).x, squareList.get(i).y, squareList.get(i).w, squareList.get(i).h) == true) {
        return false;
      }
    }
    for (Tower t : listT) {
      if (t.id != id) {
        float distance = dist(t.location.x, t.location.y, location.x, location.y);
        float minDist = t.s/2+s/2-15;
        if (distance <= minDist) {
          return false;
        }
      }
    }
    if (location.x > m[levelNumber].xMax-25) {
      return false;
    }
    return true;
  }

  void onClick() {
    if (placed == false) {
      if (checkLocation() == true) {
        placed = true;
        shop.money-=p;
        totalTowers++;
      }
    } else {
      if (p == 1200) {
        PVector locationTemp = new PVector(mouseX, mouseY);
        boolean activeTemp = true;
        boolean placedTemp = false;
       listT.add(listT.get(int(random(0,6))).getInstance(locationTemp, activeTemp, placedTemp));
        s.removeTower(id);
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

  void display() {
    point(location.x, location.y);
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

  // For the rockets and bombs
  void explode(float targetX_, float targetY_) {
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
  void turn(float angle) {
    rotate(angle+PI/2);
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new LR2(p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}

class LR3 extends LongRange {
  PImage launcher;
  float blastRadius;
  Rocket rocket;
  float explosionOpacity;
  PVector explodeCoords = new PVector(0, 0);
  boolean explosionActive = false;
  float lockAngle;

  LR3(int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_, float bR_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
    p_*=100;
    blastRadius = bR_;
    explosionOpacity = 255;

    launcher = loadImage("eLauncher.png");
    launcher.resize(100, 100);
  }
  void display() {
    imageMode(CENTER);
    image(launcher, location.x, location.y);
    if (rocketActive == false && explosionActive == false) {
      translate(location.x, location.y);
      rotate(-angle-PI/2);
      translate(-location.x, -location.y);
    } else {
      translate(location.x, location.y);
      rotate(-lockAngle-PI/2);
      translate(-location.x, -location.y);
    }

    if (rocketActive == true) {
      rocket.update();
      rocket.display();
    }
    if (explosionActive == true) {
      fill(255, 0, 0, explosionOpacity);
      explosionOpacity-=2;
      if (explosionOpacity <= 0) {
        explosionActive = false;
        explosionOpacity = 255;
      } else {
        noStroke();
        circle(explodeCoords.x, explodeCoords.y, blastRadius*2);
      }
    }
  }
  void explode(float targetX_, float targetY_) {
    explosionActive = true;
    explodeCoords.set(targetX_, targetY_);
  }

  void turn(float angle) {
    if (rocketActive == false && explosionActive == false) {
      rotate(angle+PI/2);
    } else {
      rotate(lockAngle+PI/2);
    }
  }

  void shoot() {
    if (active == true && placed == true && rocketActive == false && explosionActive == false) {
      for (int i = 0; i < listZ.size(); i++) {
        if (listZ.get(i).id == savedId ) {
          rocket = new Rocket(id, listZ.get(i), blastRadius, fireRate, s, damage);
          rocketActive = true;
          lockAngle = angle;
          break;
        }
      }
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
  PImage[] images;
  int current;

  SR3(PImage[] tempImg, int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
    images = tempImg;
    current = 0;
    for (int i = 0; i < images.length; i++) {
      images[i].resize(100, 100);
    }
  }
  void display() {
    imageMode(CENTER);
    pushMatrix();
    rotate(-PI/2);
    boolean shooting = false;
    for (int i = listZ.size()-1; i >= 0; i--) {
      if (dist(location.x, location.y, listZ.get(i).location.x, listZ.get(i).location.y) <= range) {
        shooting =true;
        break;
      }
    }
    if (shooting == true) {
      image(images[current], 0, 0);
      current++;
      if (current >= 4) {
        current = 0;
      }
    } else {
      current = 0;
      image(images[current], 0, 0);
    }
    popMatrix();
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SR3(images, p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
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
  PImage[] img;
  int current = 0;



  SP3(PImage[] sup_, int p_, float s_, PVector location_, float damage_, float range_, float fireRate_, boolean active_, boolean placed_, int id_) {
    super(p_, s_, location_, damage_, range_, fireRate_, active_, placed_, id_);
    img = sup_;
    current = 0;
    for (int i = 0; i < img.length; i++) {
      img[i].resize(100, 100);
    }
  }

  void display() {
    imageMode(CENTER);


    if (placed == true) {
      if (frameCount % 60 == 0) {
        if (current < img.length-1) {
          current++;
        }
      }
      image(img[current], 0, 0);
    } else {
      current = 0;
      image(img[current], 0, 0);
    }
  }

  Tower getInstance(PVector locationNew, boolean activeNew, boolean placedNew) {
    return new SP3(img, p, s, locationNew, damage, range, fireRate, activeNew, placedNew, totalTowers);
  }
}
