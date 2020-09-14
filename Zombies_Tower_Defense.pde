float pathWidth;
Timer timer;
int levelsTotal = 3;
int levelNumber = 3;
Map[] m = new Map[levelsTotal+1];
Screen s;
ArrayList<Tower> t = new ArrayList<Tower>();
ArrayList<Zombie> z = new ArrayList<Zombie>();
Shop shop;
Player p;
int screenNumber = 0;
int startHealth = 100;

int waveNumber = 1;
float shopLength = 300;
StartButtons[] sb = new StartButtons[levelsTotal+1];

void setup() {
  frameRate(200);
  size(1200, 700);
  timer = new Timer();
  pathWidth = (width-shopLength)/13;
  for (int i = 0; i < m.length; i++) {
    m[i] = new Map(pathWidth, i, width-shopLength, height, 0, 0);
  }
  for (int i = 0; i < sb.length; i++) {
    sb[i] = new StartButtons(i*width/4, height/2, width/4, width/4, i);
  }
  s = new Screen();
  shop = new Shop(200);
  t.add(new LR1(100, 50, new PVector(mouseX, mouseY)));
  p = new Player(100);
}

void draw() {
  s.update(screenNumber, levelNumber);
}

void mouseClicked() {
  if (screenNumber == 0) {
    for (int i = 0; i < sb.length; i++) {
      int tempLevel = sb[i].clicked();
      if (tempLevel != 0) {
        screenNumber = 1;
        levelNumber = tempLevel;
      }
    }
  }
}

void keyPressed() {
  if (key == ENTER) {
    s.startWave(waveNumber, m[levelNumber].zombieStart.x, m[levelNumber].zombieStart.y);
  }
}
