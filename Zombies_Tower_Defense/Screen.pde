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
    p.update();


    for (Tower tower : t) {
      if (tower.active == true && tower.placed == true) {
        println("HI");
        for (Zombie zombie : z) {
          PVector target = new PVector(zombie.location.x, zombie.location.y);
          if (dist(tower.location.x, tower.location.y, target.x, target.y) < tower.AttackRadius) {

            if (frameCount % 30 == 0) {
              tower.shoot();
            }
          }
        }
      }
    }

    for (Bullet b : bullets) {

      PVector zLocation = new PVector(z.get(b.id).location.x, z.get(b.id).location.y);
      b.update(zLocation);
    }


    if (waveActive == true) {
      for (int i = 0; i < z.size(); i++) {
        z.get(i).move();
        z.get(i).update();
        z.get(i).display();
      }
    }
    for (int i = 0; i < t.size(); i++) {
      t.get(i).update();
    }
  }

  void startWave(int waveNumber_, float startX_, float startY_) {
    waveActive = true;
    z.add(new Fast_Zombie(startX_, startY_, 20, 50, 10, color(150, 70, 30)));
  }

  void endScreen() {
    background(0);
    fill(255, 0, 0);
    textSize(40);
    String dieText = "GAME OVER!\nYOU DIED";
    String restartText = "Click to go to menu!";
    textAlign(CENTER);
    text(dieText, width/2, height/2);
    fill(255);
    text(restartText, width/2, 100);
  }

  void pauseScreen(int level) {
    background(255);
  }
}
