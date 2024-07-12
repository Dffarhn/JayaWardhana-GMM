Scene1 scene1;
Scene2 scene2;
Scene3 scene3;
Scene25 scene25;
Scene5 scene5;
int startTime;
int currentScene = 1;

void setup() {
  size(1280, 720);

  scene1 = new Scene1();  // Initialize Scene1 object
  scene2 = new Scene2();  // Initialize Scene2 object
  scene3 = new Scene3();  // Initialize Scene3 object
  scene25 = new Scene25();  // Initialize Scene3 object
  scene5 = new Scene5();  // Initialize Scene3 object
  
  startTime = millis();
}

void draw() {
  int elapsedTime = millis() - startTime;
   //scene5.drawScene();  // Call draw method of Scene2

  
  if (elapsedTime < 30000) {
    scene1.drawScene();  // Call draw method of Scene1
  } else if (elapsedTime < 90000) {
    scene2.drawScene();  // Call draw method of Scene2
  } else if (elapsedTime < 130000) {
      scene25.drawScene();// Call draw method of Scene3
  } else if(elapsedTime <170000){
       scene3.drawScene();  
  } else if(elapsedTime < 220000){
    scene5.drawScene();
  
  }
}
