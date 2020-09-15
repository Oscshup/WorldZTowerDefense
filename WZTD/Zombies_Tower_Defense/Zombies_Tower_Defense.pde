float pathWidth;
Timer timer;
int levelsTotal = 3;
int levelNumber;
int totalTowers;
Map[] m = new Map[levelsTotal+1];
Screen s;
ArrayList<Tower> listT = new ArrayList<Tower>();
ArrayList<Zombie> listZ = new ArrayList<Zombie>();
Shop shop;
Player p;
int screenNumber;
int startHealth;

int waveNumber;
float shopLength;
StartButtons[] sb = new StartButtons[levelsTotal+1];

void setup() {
  size(1200, 700);
  Start();
}

void Start() {
  //timer = new Timer();
  for(int i = listT.size()-1; i >= 0; i--){
    listT.remove(i);
  }
  for(int i = listZ.size()-1; i >= 0; i--){
    listZ.remove(i);
  }
  totalTowers = 0;
  levelNumber = 0;
  startHealth = 500;
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
  shop = new Shop(200);

  // Disse towers bliver ikke brugt i spillet, men bruges så vi har et af hvert tower at referere til i shoppen.
  listT.add(new SR1(50, 50, new PVector(-10000, -10000), 2, false, true, totalTowers)); // Nummer 0
  totalTowers++;
  listT.add(new SR2(500, 50, new PVector(-10000, -10000), 10, false, true, totalTowers)); // Nummer 1
  totalTowers++;
  listT.add(new SR3(5000, 50, new PVector(-10000, -10000), 50, false, true, totalTowers)); // Nummer 2
  totalTowers++;
  listT.add(new LR1(100, 50, new PVector(-10000, -10000), 5, false, true, totalTowers)); // Nummer 3
  totalTowers++;
  listT.add(new LR2(1000, 50, new PVector(-10000, -10000), 10, false, true, totalTowers)); // Nummer 4
  totalTowers++;
  listT.add(new LR3(10000, 50, new PVector(-10000, -10000), 50, false, true, totalTowers)); // Nummer 5
  totalTowers++;
  listT.add(new SP1(10, 50, new PVector(-10000, -10000), 0, false, true, totalTowers)); // Nummer 6
  totalTowers++;
  listT.add(new SP2(20, 50, new PVector(-10000, -10000), 10, false, true, totalTowers)); // Nummer 7
  totalTowers++;
  listT.add(new SP3(1200, 50, new PVector(-10000, -10000), 0, false, true, totalTowers)); // Nummer 8
  totalTowers++;

  p = new Player(startHealth);
}

void draw() {
  s.update(screenNumber, levelNumber);
}

void mouseClicked() {
  if(screenNumber == 2){
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
}