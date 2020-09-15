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

  void pauseScreen(int level) {
    background(255);
  }
}
