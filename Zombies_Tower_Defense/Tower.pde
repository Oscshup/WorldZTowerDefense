class Tower {

  float price;
  float size;
  PVector location;

  Tower(float p_, float s_) {
    price = p_;
    size = s_;
  }

  void display() {
    point(location.x, location.y);
  }
}

class LongRange extends Tower {
  LongRange(float p_, float s_) {
    super(p_, s_);
  }

  void display() {
    point(location.x, location.y);
  }
}

class LR1 extends LongRange {
  LR1(float p_, float s_) {
    super(p_, s_);
  }

  void display() {
  }
}

class LR2 extends LongRange {
  LR2(float p_, float s_) {
    super(p_, s_);
  }
}

class LR3 extends LongRange {
  LR3(float p_, float s_) {
    super(p_, s_);
    p_*=100;
  }
}

class ShortRange extends Tower {
  ShortRange(float p_, float s_) {
    super(p_, s_);
    p_ *= 5;
  }
  void display() {
    point(location.x, location.y);
  }
}

class SR1 extends ShortRange {
  SR1(float p_, float s_) {
    super(p_, s_);
  }
}
class SR2 extends ShortRange {
  SR2(float p_, float s_) {
    super(p_, s_);
    p_ *= 10;
  }
}
class SR3 extends ShortRange {
  SR3(float p_, float s_) {
    super(p_, s_);
    p_ *= 100;
  }
}

class Special extends Tower {
  Special(float p_, float s_) {
    super(p_, s_);
  }
  void display() {
    point(location.x, location.y);
  }
}

class SP1 extends Special {
  SP1(float p_, float s_) {
    super(p_, s_);
  }
}
class SP2 extends Special {
  SP2(float p_, float s_) {
    super(p_, s_);
  }
}
class SP3 extends Special {
  SP3(float p_, float s_) {
    super(p_, s_);
  }
}
