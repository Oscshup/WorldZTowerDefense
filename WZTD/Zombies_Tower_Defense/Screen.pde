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
    background(0, 230, 0);
    m[level].display();
    shop.display();
    p.update();

    for (Tower tower : listT) {
      if (tower.active == true && tower.placed == true) {
        for (Zombie zombie : listZ) {
          PVector target = new PVector(zombie.location.x, zombie.location.y);
          if (dist(tower.location.x, tower.location.y, target.x, target.y) < tower.range) {

            if (frameCount % 60/tower.fireRate == 0) {
              tower.shoot();
            }
          }
        }
      }
    }

    // Kills the zombies

    for (int i = bullets.size()-1; i >= 0; i--) {
      bullets.get(i).update();
    }
    println("Bullet.size(): " + bullets.size());
    if (waveActive == true) {
      for (int i = listZ.size()-1; i >= 0; i--) {
        listZ.get(i).move();
        listZ.get(i).update();
        listZ.get(i).display();
        listZ.get(i).checkDead();
      }
    }
    for (int i = 0; i < listT.size(); i++) {
      listT.get(i).update();
    }
  }

  void dieZombies(int idZombieDie) {
    shop.money+=listZ.get(idZombieDie).deathPrice;
    listZ.remove(idZombieDie);
    for (int i = listZ.size()-1; i >= idZombieDie; i--) {
      listZ.get(i).id-=1;
    }
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).idZ > idZombieDie) {
        bullets.get(i).idZ-=1;
      }
    }
  }

  void removeBullet(int idBulletDie) {
    println("Bullet.size(): " + bullets.size() + " , bulletID: " + idBulletDie);
    bullets.remove(idBulletDie);
    for (int i = bullets.size()-1; i >= idBulletDie; i--) {
      bullets.get(i).idB--;
    }
  }

  void startWave(int waveNumber_, float startX_, float startY_) {
    waveActive = true;
    //listZ.add(new Fast_Zombie(20, startX_, startY_, 50, 10, 20, 2, listZ.size()));
    listZ.add(new Normal_Zombie(5, startX_, startY_, 50, 20, 10, 0.8, listZ.size()));
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
