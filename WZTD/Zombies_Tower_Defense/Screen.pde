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
    }
  }


  void startScreen() {
    background(255);
    fill(0);
    textAlign(CENTER);
    textSize(40);
    String startText = "Pick a level!";
    text(startText, width/2, 100);
    for (int i = 0; i < sb.length; i++) {
      sb[i].display();
    }
  }

  void gameScreen(int level) {
    imageMode(CORNER);
    image(background,0,0);
    m[level].display();
    shop.display();
    p.update();


    // Kills the zombies
    for (Bullet b : bullets) {  
      b.update();
    }
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).dead == true) {
        bullets.remove(i);
      }
    }
    if (waveActive == true) {
      for (int i = listZ.size()-1; i >= 0; i--) {
        listZ.get(i).move();
        listZ.get(i).display();
        listZ.get(i).displayHealth();
        listZ.get(i).checkDead();
      }
    }
    for (int i = 0; i < listT.size(); i++) {
      listT.get(i).update();
      listT.get(i).shoot();
    }
  }

  void spawnZombie(char pressedKey) {
    if (screenNumber == 1) {
      waveActive = true;
      if (pressedKey == '1') {
        listZ.add(new Normal_Zombie(5, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 20, 1, 0.8, totalZombies));
        totalZombies++;
      } else if (pressedKey == '2') {
        listZ.add(new Fast_Zombie(20, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 10, 5, 2, totalZombies));
        totalZombies++;
      } else if (pressedKey == '3') {
        listZ.add(new Tank_Zombie(80, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 100, 20, 0.5, totalZombies));
        totalZombies++;
      } else if (pressedKey == '4') {
        listZ.add(new MiniBoss_Zombie(320, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 300, 40, 1, totalZombies));
        totalZombies++;
      } else if (pressedKey == '5') {
        listZ.add(new Boss_Zombie(1080, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 1000, 100, 0.7, totalZombies));
        totalZombies++;
      }
    }
  }

  void dieZombies(int idZombieDie) {
    for (int i = listZ.size()-1; i >= 0; i--) {
      if (listZ.get(i).id == idZombieDie) {
        shop.money+=listZ.get(i).deathPrice;
        listZ.remove(i);
      }
    }
  }

  void startWave(int waveNumber_, float startX_, float startY_) {
    waveActive = true;
    //listZ.add(new Fast_Zombie(20, startX_, startY_, 50, 10, 20, 2, totalZombies));
    listZ.add(new Normal_Zombie(5, startX_, startY_, 50, 20, 10, 0.8, totalZombies));
    totalZombies++;
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
}
