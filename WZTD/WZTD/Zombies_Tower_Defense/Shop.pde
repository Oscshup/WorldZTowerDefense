class Shop {
  PImage shopImg;
  PImage shopCoins;
  PImage sr1;
  PImage sr2;
  PImage lr1;
  PImage lr2;
  PImage sp1;  

  int money;
  int off = 50;

  int[] prices;
  Button[] b = new Button[9];

  Shop(int cur_) {
    money = cur_;
    shopImg = loadImage("shop.png");
    shopCoins = loadImage("coins.png");
    sr1  = loadImage("Handgun.gif");
    sr2  = loadImage("AR.png");
    lr1 = loadImage("rifle.png");
    lr2 = loadImage("Plane.png");
    sp1 = loadImage("Mine.png");
    shopCoins.resize(50, 50);
    sr1.resize(50, 50);
    sr2.resize(50, 50);
    lr1.resize(50, 50);
    lr2.resize(50, 50);
    sp1.resize(50, 50);
    shopImg.resize(int(shopLength), height+off);

    prices = new int[]{50, 500, 5000, 100, 1000, 10000, 10, 20, 1200};
    for (int i = 0; i < b.length; i++) {
      b[i] = new Button(width-shopLength/5, 270+i*height/(100/7)-10, width-(width-shopLength/5), height/(100/7)-10, 15, 15, 15, 15, i);
    }
  }

  void onClick() {
    for (int i = 0; i < 9; i++) {
      b[i].onClick();
    }
  }

  void display() {
    image(shopImg, width-shopLength, -off);
    image(shopCoins, width-shopLength+45, 175);
    image(sr1, width-shopLength+45, 225);
    image(sr2, width-shopLength+45, 275);
    image(lr1, width-shopLength+45, 375);
    image(lr2, width-shopLength+45, 425);
    image(sp1, width-shopLength+45, 525);
    textSize(32);
    fill(0);
    textAlign(CENTER);
    text("SHOP", width-shopLength+shopLength/3, 150);
    text(money, width-shopLength+shopLength/2, 210);
    for (int i = 0; i < 9; i++) {
      fill(0);
      stroke(0);
      textSize(30);
      text(prices[i], width-shopLength+shopLength/2, 270+i*height/(100/7));
      b[i].display();
    }
  }
}

class Button {

  float x;
  float y;
  float w;
  float h;
  float tl;
  float tr;
  float br;
  float bl;

  int id;

  Button(float x_, float y_, float w_, float h_, float tl_, float tr_, float br_, float bl_, int id_) {
    x=x_;
    y=y_;
    w=w_;
    h=h_;
    tl=tl_;
    tr=tr_;
    br=br_;
    bl=bl_;

    id = id_;
  }

  void display() {
    fill(0, 255, 0);
    stroke(0, 120, 0);
    strokeWeight(5);
    rectMode(CENTER);
    rect(x, y, w, h, tl, tr, br, bl);
    textSize(20);
    fill(0);
    stroke(0);
    text("Buy", width-shopLength/5, 270+id*height/(100/7)-5);
  }

  void onClick() {
    if (mouseX >= x-w/2 && mouseX <= x+w/2 && mouseY >= y-h/2 && mouseY <= y+h/2) {
      Tower tTemp = t.get(id);
      tTemp.location = new PVector(mouseX, mouseY);
      tTemp.active = true;
      tTemp.placed = false;
      t.add(tTemp);
    }
  }
}
