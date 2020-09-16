int startMoney = 100000;
float pathWidth;
Timer timer;
int levelsTotal = 3;
int levelNumber;
int totalTowers;
int totalZombies;
int totalBullets;
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

int waveNumber;
float shopLength;
StartButtons[] sb = new StartButtons[levelsTotal+1];

PImage[] sentrys = new PImage[4];
PImage[] lives = new PImage[1];

void setup() {
  frameRate(60);
  size(1200, 700);
  Start();
}

void Start() {
  //Sentry animation
  for (int i = 0; i < sentrys.length; i++) {
    sentrys[i] = loadImage("Mini" + i + ".png");
  }
  
  lives[0] = loadImage("Heart.png");


  //timer = new Timer();
  for (int i = listT.size()-1; i >= 0; i--) {
    listT.remove(i);
  }
  for (int i = listZ.size()-1; i >= 0; i--) {
    listZ.remove(i);
  }
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
  listT.add(new SR1(50, 50, new PVector(-10000, -10000), 2, 100, 2, false, true, totalTowers)); // Nummer 0
  totalTowers++;
  listT.add(new SR2(500, 50, new PVector(-10000, -10000), 10, 100, 4, false, true, totalTowers)); // Nummer 1
  totalTowers++;
  listT.add(new SR3(sentrys, 5000, 50, new PVector(-10000, -10000), 50, 100, 10, false, true, totalTowers)); // Nummer 2
  totalTowers++;
  listT.add(new LR1(100, 50, new PVector(-10000, -10000), 4, 1000, 1, false, true, totalTowers)); // Nummer 3
  totalTowers++;
  listT.add(new LR2(1000, 50, new PVector(-10000, -10000), 10, 50, 0.25, false, true, totalTowers)); // Nummer 4
  totalTowers++;
  listT.add(new LR3(10000, 50, new PVector(-10000, -10000), 50, 200, 0.5, false, true, totalTowers)); // Nummer 5
  totalTowers++;
  listT.add(new SP1(10, 50, new PVector(-10000, -10000), 0, pathWidth, 0, false, true, totalTowers)); // Nummer 6
  totalTowers++;
  listT.add(new SP2(20, 50, new PVector(-10000, -10000), 10, pathWidth*2, 0, false, true, totalTowers)); // Nummer 7
  totalTowers++;
  listT.add(new SP3(1200, 50, new PVector(-10000, -10000), 0, 0, 0, false, true, totalTowers)); // Nummer 8
  totalTowers++;

  p = new Player(startHealth, lives);
}

void draw() {
  s.update(screenNumber, levelNumber);
}

void mouseClicked() {
  if (screenNumber == 2) {
    Start();
  } else if (screenNumber == 0) {
    for (int i = 0; i < sb.length; i++) {
      int tempLevel = sb[i].clicked();
      if (tempLevel != 0) {
        screenNumber = 1;
        levelNumber = tempLevel;
      }
    }
  } else if (screenNumber == 1) {
    if (listT.get(listT.size()-1).placed == false) {
      listT.get(listT.size()-1).onClick();
    }
    shop.onClick();
  }
}

void keyPressed() {
  if (key == ENTER) {
    s.startWave(waveNumber, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y);
  }

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
