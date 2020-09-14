class Screen {
  PImage background;
  boolean waveActive = false;

  Screen() {
    background =loadImage("grass.png");
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
    image(background, 0, 0, width, height);
    m[level].display();
    shop.display();

    //tower attack the zombie, if distance is smaller than the radius, attack!
    for (Tower tower : t) {
      PVector target = new PVector( width-100, 100);
      if (dist(tower.location.x, tower.location.y, target.x, target.y) < tower.AttackRadius ) {

        //shoot every number frames
        if (frameCount % 10 == 0) {
          tower.shoot();
        }
        //---------------------
      }
    }

    for (Bullet b : bullets) {
      b.update();
    }


    if (waveActive == true) {
      z.move();
      z.update();
      z.display();
    }
  }

  void startWave(int waveNumber_, float startX_, float startY_) {
    waveActive = true;
    PVector tempVel = new PVector(0, 1);
    z = new Fast_Zombie(startX_, startY_, 20, 50, tempVel, 10, color(150, 70, 30));
  }

  void endScreen() {
    background(255);
  }

  void pauseScreen(int level) {
    background(255);
  }
}
