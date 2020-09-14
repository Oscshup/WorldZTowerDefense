class Screen {

  boolean waveActive = false;

  Screen() {
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
    background(0, 230, 0);
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
      for (int i = 0; i < z.size(); i++) {
        z.get(i).move();
        z.get(i).update();
        z.get(i).display();
      }
    }
    for(int i = 0; i < t.size(); i++){
      t.get(i).update();
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
