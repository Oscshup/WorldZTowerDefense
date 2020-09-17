class Player {

  float health;

  int current;
  PImage[] img;

  Player(float health_, PImage[] tempImage) {
    health = health_;
    current = 0;
    img = tempImage;
    for (int i = 0; i < img.length; i++) {
      img[i].resize(50, 50);
    }
  }

  void update() {
    live();
    health-=0;
    if (health <= 0) {
      die();
    }
  }

  void die() {
    screenNumber = 2;
  }


  void live() {
    textSize(30);
    fill(0);
    textAlign(CENTER);  
    text(int(health), width-130, height/2-320);
    image(img[current], width-200, height/2-350);
  }
}
