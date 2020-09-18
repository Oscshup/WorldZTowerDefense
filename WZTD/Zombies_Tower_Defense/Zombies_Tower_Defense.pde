import processing.sound.*; // Installér library "Sound", som er lavet af Processing Foundation
Sound sound;

SoundFile musik;

int startMoney;
float pathWidth;
int levelsTotal = 3;
int levelNumber;
int totalTowers;
int totalZombies;
int totalBullets;
int timeBetweenWaves = 10000;
Timer timer = new Timer();
Map[] m = new Map[levelsTotal+1];
Screen s;
ArrayList<Tower> listT = new ArrayList<Tower>();
ArrayList<Zombie> listZ = new ArrayList<Zombie>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
Shop shop;
Player p;
int screenNumber;
int startHealth;
PImage[] levelImages = new PImage[levelsTotal+1];

int skillPoints;

int waveNumber;
float shopLength;
StartButtons[] sb = new StartButtons[levelsTotal+1];

PImage[] sentrys = new PImage[4];
PImage[] lives = new PImage[1];
PImage planeBomb;
PImage[] explosionRocket = new PImage[12];
PImage[] explosionPlane = new PImage[12];
PImage[] explosionMine = new PImage[12];
PImage[] supplyDropImg = new PImage[4];

int highScore;
String highScoreText;
String[] highScoreLoad;

Loading l = new Loading();
boolean timeCountdown;
float timeLoading;

void setup() {
  frameRate(60);
  size(1200, 700);
  
  musik = new SoundFile(this,"TDZW.mp3");
  
  planeBomb = loadImage("Bomb.png");
  sound = new Sound(this);
  musik.loop(1,0.1);
  l.startL(); 
  Start();
}

void Start() {
  highScoreLoad = loadStrings("HighScore.txt");
  highScore = int(highScoreLoad[0]);

  for (int i = 0; i < supplyDropImg.length; i++) {
    supplyDropImg[i] = loadImage("sup" + i + ".png");
  }

  for (int i = 0; i < explosionRocket.length; i++) {
    explosionRocket[i] = loadImage("explosion" + i + ".png");
    explosionPlane[i] = loadImage("explosion" + i + ".png");
    explosionMine[i] = loadImage("explosion" + i + ".png");
  }

  //planeBomb.resize(50, 50);

  for (int i = 0; i < sentrys.length; i++) {
    sentrys[i] = loadImage("Mini" + i + ".png");
  }

  lives[0] = loadImage("Heart.png");

  for (int i = listT.size()-1; i >= 0; i--) {
    listT.remove(i);
  }
  for (int i = listZ.size()-1; i >= 0; i--) {
    listZ.remove(i);
  }
  timeCountdown = false;
  timeLoading = 500;
  skillPoints = 0;
  startMoney = 200;
  totalTowers = 0;
  totalZombies = 0;
  totalBullets = 0;
  levelNumber = 0;
  startHealth = 100;
  waveNumber = 0;
  screenNumber = 0;
  shopLength = 300;
  pathWidth = (width-shopLength)/13;
  for (int i = 0; i < m.length; i++) {
    m[i] = new Map(pathWidth, i, width-shopLength, height, 0, 0);
  }
  for (int i = 0; i < sb.length; i++) {
    sb[i] = new StartButtons(i*width/4, height/2, width/4, width/4, i);
  }
  s = new Screen();
  shop = new Shop(startMoney);

  // Disse towers bliver ikke brugt i spillet, men bruges så vi har et af hvert tower at referere til i shoppen.
  
  //Damage, range, fireRate
  
  listT.add(new SR1(50, 50, new PVector(-10000, -10000), 5, 200, 1000, false, true, totalTowers)); // Nummer 0
  totalTowers++;
  listT.add(new SR2(500, 50, new PVector(-10000, -10000), 5, 200, 250, false, true, totalTowers)); // Nummer 1
  totalTowers++;
  listT.add(new SR3(sentrys, 10000, 50, new PVector(-10000, -10000), 3, 200, 50, false, true, totalTowers)); // Nummer 2
  totalTowers++;
  listT.add(new LR1(100, 50, new PVector(-10000, -10000), 8, 1.5*sqrt( (width*width) + (height*height)), 3000, false, true, totalTowers)); // Nummer 3
  totalTowers++;
  listT.add(new LR2(explosionPlane, 1000, 100, new PVector(-10000, -10000), 20, 200, 200, false, true, totalTowers, 50, 800)); // Nummer 4
  totalTowers++;
  listT.add(new LR3(explosionRocket, 5000, 50, new PVector(-10000, -10000), 40, 1.5*sqrt( (width*width) + (height*height)), 20000, false, true, totalTowers, 130)); // Nummer 5
  totalTowers++;
  listT.add(new SP1(10, 50, new PVector(-10000, -10000), 0, pathWidth, 0, false, true, totalTowers)); // Nummer 6
  totalTowers++;
  listT.add(new SP2(explosionMine, 20, 50, new PVector(-10000, -10000), 10, pathWidth*2, 0, false, true, totalTowers)); // Nummer 7
  totalTowers++;
  listT.add(new SP3(supplyDropImg, 1200, 50, new PVector(-10000, -10000), 0, 0, 0, false, true, totalTowers)); // Nummer 8
  totalTowers++;

  p = new Player(startHealth, lives);
}

void draw() {
  s.update(screenNumber, levelNumber);
}

void mouseClicked() {
  if (screenNumber == 2) {
    timeCountdown = true;
    screenNumber = 3;
  } else if (screenNumber == 0) {
    for (int i = 0; i < sb.length; i++) {
      int tempLevel = sb[i].clicked();
      if (tempLevel != 0) {
        screenNumber = 1;
        levelNumber = tempLevel;
      }
    }
  } else if (screenNumber == 1) {
    for (int i = 9; i < listT.size(); i++) {
      if (listT.get(i).p != listT.get(8).p) {
        listT.get(i).onClick();
      }
    }
    for (int i = 9; i < listT.size(); i++) {
      if (listT.get(i).p == listT.get(8).p) {
        listT.get(i).onClick();
      }
    }
    shop.onClick();
  }
}

void keyPressed() {
  if (key == 'p') {
    if (looping) {
      noLoop();
      background(150, 199);
      String textPause = "Paused";
      textSize(60);
      fill(0);
      textAlign(CENTER);
      text(textPause, width/2, height/2);
    } else loop();
  }
}
