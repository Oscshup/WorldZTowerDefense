class Screen {

  boolean waveActive = false;
  PImage background;

  String[] textTotal = loadStrings("Waves.txt");
  ArrayList[] waves = new ArrayList[textTotal.length];

  boolean timerActive = false;

  boolean zombieDead = false;

  int skillPointsEarned = 0;

  ArrayList<PVector> wRandom;

  Screen() {
    background = loadImage("grass.png");

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
  }

  void update(int screen, int level) {
    if (timeCountdown == true) {
      timeLoading--;
      if (timeLoading <= 0) {

        if (screenNumber == 3) {
          screenNumber = 0;
          Start();
        }
      }
    }
    if (screen == 0) {
      startScreen();
    } else if (screen == 1) {
      gameScreen(level);
    } else if (screen == 2) {
      loseScreen();
    } else if (screen == 3) {
      loadingScreen();
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
    image(background, 0, 0);
    //background(0, 230, 0);
    m[level].display();
    shop.display();
    p.update();

    for (Tower t : listT) {
      if (t.p == listT.get(6).p) {
        t.update();
        t.shoot();
      }
    }

    // Kills the zombies

    for (Bullet b : bullets) {  
      b.update();
    }
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).dead == true) {
        bullets.remove(i);
      }
    }
    if (waveActive == false && timer.isFinished() == true && timerActive == true) {
      waveActive = true;
      timerActive = false;
      waveNumber++;
      if (waveNumber > waves.length) {
        wRandom = new ArrayList<PVector>();
        int l = int(random(waveNumber*3, waveNumber*4));
        for (int i = 0; i < l; i++) {
          wRandom.add(new PVector(int(random(1, 6)), int(random(300, 1500))));
        }
      }
      timer2.start(100);
    }
    if (waveActive == true) {
      wave();
    } 
    if (listZ.size() != 0) {
      for (int i = listZ.size()-1; i >= 0; i--) {
        listZ.get(i).move(); 
        if (zombieDead == false) {
          listZ.get(i).display(); 
          listZ.get(i).displayHealth(); 
          listZ.get(i).checkDead();
        } else {
          zombieDead = false;
        }
      }
    }
    if (listZ.size() == 0 && timerActive == false && waveActive == false) {
      timer.start(timeBetweenWaves); 
      timerActive = true; 
      skillPoints+=skillPointsEarned; 
      skillPointsEarned = 0;
    }
    for (int i = 0; i < listT.size(); i++) {
      if (listT.get(i).p != listT.get(6).p) {
        listT.get(i).update(); 
        listT.get(i).shoot(); 
        if (listT.get(i).menuActive == true) {
          listT.get(i).drawMenu();
        }
      }
    }
    fill(255); 
    String waveText = "Wave number: " + waveNumber; 
    textAlign(CORNER); 
    textSize(20); 
    text(waveText, m[levelNumber].xMax-180, height/2-310); 
    if (timerActive == true) {
      int timeLeft = ceil((timer.totalTime-(millis()-timer.savedTime))/1000); 
      String timeToWaveText = "Next wave in: " + timeLeft; 
      text(timeToWaveText, m[levelNumber].xMax-180, height/2-280);
    }
    textAlign(CENTER);
  }

  void removeTower(int idT) {
    for (int i = listT.size()-1; i >= 0; i--) {
      if (listT.get(i).id == idT) {
        listT.remove(i);
        break;
      }
    }
  }

  void spawnZombie(int zombieType) {
    if (screenNumber == 1) {
      waveActive = true; 
      if (zombieType == 1) {
        listZ.add(new Normal_Zombie(5, 1, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 20, 1, 0.8, totalZombies)); 
        totalZombies++;
      } else if (zombieType == 2) {
        listZ.add(new Fast_Zombie(20, 2, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 10, 5, 2, totalZombies)); 
        totalZombies++;
      } else if (zombieType == 3) {
        listZ.add(new Tank_Zombie(80, 3, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 100, 20, 0.5, totalZombies)); 
        totalZombies++;
      } else if (zombieType == 4) {
        listZ.add(new MiniBoss_Zombie(320, 5, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 300, 40, 1, totalZombies)); 
        totalZombies++;
      } else if (zombieType == 5) {
        listZ.add(new Boss_Zombie(1080, 10, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y, 50, 1000, 100, 0.7, totalZombies)); 
        totalZombies++;
      }
    }
  }

  void dieZombies(int idZombieDie, int deathPrice) {
    for (int i = listZ.size()-1; i >= 0; i--) {
      if (listZ.get(i).id == idZombieDie) {
        shop.money+=deathPrice; 
        listZ.remove(i); 
        zombieDead = true;
      }
    }
  }

  int zombieNumber = 0; 
  Timer timer2 = new Timer(); 
  void wave() {
    ArrayList<PVector> w;
    if (waveNumber <= waves.length) {
      w = waves[waveNumber-1];
    } else {
      w = wRandom;
    }
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
  
  void loadingScreen() {
    l.display();
    textSize(50);
    String loseText = "YOU DESTROYED HUMANITY!";
    
    textAlign(CENTER);
    fill(random(200,255),0,0);
    text(loseText, width/2, height/2);
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
    text(highScoreText, width/2, height-100);
  }
}
