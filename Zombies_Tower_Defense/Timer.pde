class Timer{
  
  int savedTime;
  
  Timer(){
  }
  
  void start(){
    savedTime = millis();
  }
  
  boolean isFinished(int totalTime){
    int passedTime = millis() - savedTime;
    if(passedTime >= totalTime){
      return true;
    }
    else{
      return false;
    }
  }
}
