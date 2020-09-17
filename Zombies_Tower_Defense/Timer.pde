class Timer{
  
  int savedTime;
  int totalTime;
  
  Timer(){
  }
  
  void start(int totalTimeTemp){
    savedTime = millis();
    totalTime = totalTimeTemp;
  }
  
  boolean isFinished(){
    int passedTime = millis() - savedTime;
    if(passedTime >= totalTime){
      return true;
    }
    else{
      return false;
    }
  }
}
