float pathWidth;
Timer timer;
int levelsTotal = 3;
int levelNumber;
Map[] m = new Map[levelsTotal+1];
Screen s;
ArrayList<Tower> t = new ArrayList<Tower>();
ArrayList<Zombie> z = new ArrayList<Zombie>();
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
  for(int i = t.size()-1; i >= 0; i--){
    t.remove(i);
  }
  for(int i = z.size()-1; i >= 0; i--){
    z.remove(i);
  }
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
  t.add(new SR1(50, 50, new PVector(-10000, -10000), 2, false, true)); // Nummer 0
  t.add(new SR2(500, 50, new PVector(-10000, -10000), 10, false, true)); // Nummer 1
  t.add(new SR3(5000, 50, new PVector(-10000, -10000), 50, false, true)); // Nummer 2
  t.add(new LR1(100, 50, new PVector(-10000, -10000), 5, false, true)); // Nummer 3
  t.add(new LR2(1000, 50, new PVector(-10000, -10000), 10, false, true)); // Nummer 4
  t.add(new LR3(10000, 50, new PVector(-10000, -10000), 50, false, true)); // Nummer 5
  t.add(new SP1(10, 50, new PVector(-10000, -10000), 0, false, true)); // Nummer 6
  t.add(new SP2(20, 50, new PVector(-10000, -10000), 10, false, true)); // Nummer 7
  t.add(new SP3(1200, 50, new PVector(-10000, -10000), 0, false, true)); // Nummer 8
  

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
    if (t.get(t.size()-1).placed == false) {
      t.get(t.size()-1).onClick();
    }
    shop.onClick();
  }
  
}

void keyPressed() {
  if (key == ENTER) {
    s.startWave(waveNumber, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y);
  }
}
