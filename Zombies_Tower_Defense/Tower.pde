class Tower{
  
  int p;
  float s;
  PVector location;
  float damage;
  boolean active;
  boolean placed;

  Tower(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    p = p_;
    s = s_;
    location = new PVector(location_.x, location_.y);
    damage = damage_;
    active = active_;
    placed = placed_;
  }
  
  void update(){
    if(placed == false){
      location.x = mouseX;
      location.y = mouseY;
    }
    if(active == true){
      turn();
      shoot();
      display();
    }
  }
  
  void onClick(){
    if(placed == false){
      
      placed = true;
    }
  }

  void display() {
    point(location.x, location.y);
  }
  
  void turn(){
    
  }
  
  void shoot(){
    
  }
}

class LongRange extends Tower {
  LongRange(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }

  void display() {
    point(location.x, location.y);
  }
}

class LR1 extends LongRange {
  LR1(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }

  void display() {
    image(shop.lr1, location.x, location.y);
  }
}

class LR2 extends LongRange {
  LR2(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    image(shop.lr2, location.x, location.y);
  }
}

class LR3 extends LongRange {
  LR3(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
    p_*=100;
  }
  void display() {
    point(location.x, location.y);
  }
}

class ShortRange extends Tower {
  ShortRange(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    point(location.x, location.y);
  }
}

class SR1 extends ShortRange {
  SR1(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    image(shop.sr1, location.x, location.y);
  }
}
class SR2 extends ShortRange {
  SR2(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    image(shop.sr2, location.x, location.y);
  }
}
class SR3 extends ShortRange {
  SR3(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    point(location.x, location.y);
  }
}

class Special extends Tower {
  Special(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    point(location.x, location.y);
  }
}

class SP1 extends Special {
  SP1(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    image(shop.sp1, location.x, location.y);
  }
}
class SP2 extends Special {
  SP2(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    point(location.x, location.y);
  }
}
class SP3 extends Special {
  SP3(int p_, float s_, PVector location_, float damage_, boolean active_, boolean placed_) {
    super(p_, s_, location_, damage_, active_, placed_);
  }
  void display() {
    point(location.x, location.y);
  }
}
