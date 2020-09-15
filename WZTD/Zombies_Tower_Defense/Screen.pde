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
<<<<<<< Updated upstream:WZTD/Zombies_Tower_Defense/Screen.pde
    background(0, 230, 0);
    m[level].display();
    shop.display();
    p.update();
=======
    imageMode(CORNER);
    image(background,0,0);
    //background(0, 230, 0);
    m[level].display();
    shop.display();
    p.update();

    for (Tower tower : listT) {
      if (tower.active == true && tower.placed == true) {
        if (tower.savedId != -1 ) {
          PVector target = new PVector(listZ.get(tower.savedId).location.x, listZ.get(tower.savedId).location.y);
          if (dist(tower.location.x, tower.location.y, target.x, target.y) < tower.AttackRadius) {

            if (frameCount % 30 == 0) {
              tower.shoot();
            }
          }
        }
      }
    }

    for(int i = bullets.size()-1; i >= 0; i--){
      bullets.get(i).update();
    }

>>>>>>> Stashed changes:Zombies_Tower_Defense/Screen.pde
    if (waveActive == true) {
      for (int i = 0; i < listZ.size(); i++) {
        listZ.get(i).move();
        listZ.get(i).update();
        listZ.get(i).display();
      }
    }
    for(int i = 0; i < listT.size(); i++){
      listT.get(i).update();
    }
    for(int i = bullets.size()-1; i >= 0; i--){
      if (bullets.get(i).location.x < 0){
        bullets.remove(i);
      }
    }
  }

  void startWave(int waveNumber_, float startX_, float startY_) {
    waveActive = true;
    listZ.add(new Fast_Zombie(startX_, startY_, 20, 50, 10, color(150, 70, 30)));
  }

  void endScreen() {
    background(0);
    fill(255,0,0);
    textSize(40);
    String dieText = "GAME OVER!\nYOU DIED";
    String restartText = "Click to go to menu!";
    textAlign(CENTER);
    text(dieText, width/2, height/2);
    fill(255);
    text(restartText, width/2, 100); 
  }
<<<<<<< Updated upstream:WZTD/Zombies_Tower_Defense/Screen.pde

  void pauseScreen(int level) {
    background(255);
  }
=======
>>>>>>> Stashed changes:Zombies_Tower_Defense/Screen.pde
}
