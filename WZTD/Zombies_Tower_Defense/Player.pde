class Player{

  float health;

  Player(float health_){
    health = health_;
  }
  
  void update(){
    health-=1;
    if(health <= 0){
      die();
    }
  }
  
  void die(){
    screenNumber = 2;
  }

}