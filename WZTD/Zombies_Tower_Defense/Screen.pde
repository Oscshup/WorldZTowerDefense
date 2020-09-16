class Screen {

  boolean waveActive = false;
<<<<<<< Updated upstream

  Screen() {
=======

  String[] textTotal = loadStrings("Waves.txt");
  ArrayList[] waves = new ArrayList[textTotal.length];

  boolean timerActive = false;

  Screen() {
    for (int i = 0; i < waves.length; i++) {
      waves[i] = new ArrayList<PVector>();
    }
    for (int i = 0; i < waves.length; i++) {
      String[] dataWave = split(textTotal[i], '.');
      PVector[] dataZombie = new PVector[dataWave.length];
      for (int j = 0; j < dataZombie.length; j++) {
        String[] tempPVector = split(dataWave[j], ',');
        dataZombie[j] = new PVector(int(tempPVector[0]), int(tempPVector[1]));
      }
      for (int j = 0; j < dataZombie.length; j++) {
        waves[i].add(new PVector(dataZombie[j].x, dataZombie[j].y));
      }
    }
>>>>>>> Stashed changes
  }

  void update(int screen, int level) {
    if (screen == 0) {
      startScreen();
    } else if (screen == 1) {
      gameScreen(level);
    } else if (screen == 2) {
      loseScreen();
    } else if (screen == 3) {
      winScreen();
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


    // Kills the zombies

    for (Bullet b : bullets) {  
      b.update();
    }
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).dead == true) {
        bullets.remove(i);
      }
    }
<<<<<<< Updated upstream
    if (waveActive == true) {
      for (int i = listZ.size()-1; i >= 0; i--) {
        listZ.get(i).move();
        listZ.get(i).display();
        listZ.get(i).displayHealth();
        listZ.get(i).checkDead();
=======
    if (waveActive == false && timer.isFinished() == true && timerActive == true) {
      waveActive = true;
      timerActive = false;
      waveNumber++;
      timer2.start(100);
    }
    if (waveActive == true && waveNumber <= waves.length) {
      wave();
    } 
    fill(0);
    String waveText = "Next wave in: " + waveNumber;
    textAlign(CORNER);
    textSize(20);
    text(waveText, 5, height-50);
    if (timerActive == true) {
      int timeLeft = timer2.totalTime-(millis()-timer2.savedTime);
      String timeToWaveText = "Next wave in: " + timeLeft;
      text(timeToWaveText, 5, height-20);
    }
    if (waveNumber > waves.length) {
      win();
    }
    for (int i = listZ.size()-1; i >= 0; i--) {
      listZ.get(i).move();
      listZ.get(i).display();
      listZ.get(i).displayHealth();
      listZ.get(i).checkDead();
    }
    if (listZ.size() == 0 && timerActive == false && waveActive == false) {
      if (waveNumber > waves.length) {
        win();
      } else {
        timer.start(timeBetweenWaves);
        timerActive = true;
>>>>>>> Stashed changes
      }
    }
    for (int i = 0; i < listT.size(); i++) {
      listT.get(i).update();
      listT.get(i).shoot();
    }
  }

<<<<<<< Updated upstream
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
=======
  void spawnZombie(int zombieType) {
    if (screenNumber == 1) {
      waveActive = true;
      if (zombieType == 1) {
        listZ.add(new Normal_Zombie(5, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 20, 1, 0.8, totalZombies));
        totalZombies++;
      } else if (zombieType == 2) {
        listZ.add(new Fast_Zombie(20, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 10, 5, 2, totalZombies));
        totalZombies++;
      } else if (zombieType == 3) {
        listZ.add(new Tank_Zombie(80, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 100, 20, 0.5, totalZombies));
        totalZombies++;
      } else if (zombieType == 4) {
        listZ.add(new MiniBoss_Zombie(320, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 300, 40, 1, totalZombies));
        totalZombies++;
      } else if (zombieType == 5) {
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
  void startWave(int waveNumber_, float startX_, float startY_) {
    waveActive = true;
    //listZ.add(new Fast_Zombie(20, startX_, startY_, 50, 10, 20, 2, totalZombies));
    //listZ.add(new Normal_Zombie(5, startX_, startY_, 50, 20, 10, 0.8, totalZombies));
    //totalZombies++;
=======
  int zombieNumber = 0;
  Timer timer2 = new Timer();

  void wave() {
    ArrayList<PVector> w = waves[waveNumber-1];
    if (zombieNumber < w.size()) {
      int zombieType = int(w.get(zombieNumber).x);
      int timeBetweenZombie = int(w.get(zombieNumber).y);
      if (timer2.isFinished()) {
        timer2.start(timeBetweenZombie);
        spawnZombie(zombieType);
        zombieNumber++;
      }
    }
    if (zombieNumber >= w.size()) {
      waveActive = false;
      zombieNumber = 0;
    }
  }

  void win() {
    delay(500);
    screenNumber = 3;
  }

  void winScreen() {
    background(255);
    textSize(50);
    String winText1 = "YOU WIN!";
    String winText2 = "Click to go to menu!";
    textAlign(CENTER);
    fill(0, 230, 0);
    text(winText1, width/2, height/2);
    fill(0);
    text(winText2, width/2, 100);
>>>>>>> Stashed changes
  }

  void loseScreen() {
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
