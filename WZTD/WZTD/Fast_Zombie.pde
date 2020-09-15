class Fast_Zombie extends Zombie{

  float dia;
  color c;

  Fast_Zombie(float x_, float y_, float r_, float health_, float damage_, color c_){
    super(x_, y_, r_, health_, damage_);
    dia = r*2;
    c = c_;
  }

  void display(){
    fill(c);
    stroke(0);
    strokeWeight(1);
    circle(location.x, location.y, dia);
  }

}
