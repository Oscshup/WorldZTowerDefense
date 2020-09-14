class GameObject {
  
  int price;
  float size;
  float health;
  int cur;
  PVector tLocation;
  
  GameObject(int p_, float s_, int cur_, float health_, PVector tLocation_){
    health = health_;
    price = p_;
    size = s_;
    cur = cur_;
    tLocation = tLocation_;
  }
  
  void mouseClicked(){}
  void display(){}
  void move(){}
  void update(){}
  
}
