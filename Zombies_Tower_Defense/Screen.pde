class Screen {

  boolean waveActive = false;
  PImage background;

  Screen() {
    background = loadImage("grass.png");
  }


  void update(int screen, int level) {
    if (screen == 0) {
      startScreen();
    } else if (screen == 1) {
      gameScreen(level);
    } else if (screen == 2) {
      endScreen();
    } else {
      pauseScreen(level);
    }
  }


  void startScreen() {
    background(255);
    for (int i = 0; i < sb.length; i++) {
      sb[i].display();
    }
  }

  void gameScreen(int level) {
     imageMode(CORNER); /// WHY THE FUCK DOES THIS HAPPEN
    //image(background, 0, 0, width, height);
    background(0,255,0);


    m[level].display();
    shop.display();
    if (waveActive == true) {
      for (int i = 0; i < z.size(); i++) {
        z.get(i).move();
        z.get(i).update();
        z.get(i).display();
      }
    }
  }

  void startWave(int waveNumber_, float startX_, float startY_) {
    waveActive = true;
    z.add(new Fast_Zombie(startX_, startY_, 20, 50, 10, color(150, 70, 30)));
  }

  void endScreen() {
    background(255);
  }

  void pauseScreen(int level) {
    background(255);
  }
}