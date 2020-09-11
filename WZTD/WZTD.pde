Life lifes;


void setup() {
  size(800,800);
  
  lifes = new Life(200,200,30);
  
}



void draw() {
  background(255);
  lifes.health();
  lifes.move();
  lifes.display();
  
}
