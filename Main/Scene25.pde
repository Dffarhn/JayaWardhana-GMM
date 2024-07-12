class Scene25 {
  PShape svg;
  float bgX1, bgX2; // X-coordinates of the backgrounds
  PImage boatImage;
  float[] birdX;
  float[] birdY;
  float[] birdAngle;  // Angle for circular motion of birds
  float birdRadius = 50;  // Radius for bird circular motion
  int numBirds = 3;  // Total number of birds
  
  int headWidth = 25;
  int headHeight = 30;
  int bodyWidth = 20;
  int bodyHeight = 32;
  int armWidth = 8;
  int armHeight = 25;
  
  float boatX;
  float boatY;
  float boatSpeed = 8.0;  // Speed of the boat moving from left to right
  float oscillationSpeed = 0.05;  // Speed of the up-down oscillation
  float oscillationMagnitude = 40;  // Magnitude of the up-down oscillation
  float oscillationAngle = 5;  // Angle for the sin() function to control up-down movement

  boolean animationStarted = false;  // Flag to indicate if animation has started
  int startTime;  // Variable to store the start time of the animation

  Scene25() {
    // Load background images
     frameRate(1000);
     svg = loadShape("../GMMASSETS/backgroundlautt.svg");
     bgX1 = 0;  // Initialize first background position
     bgX2 = width;  // Initialize second background position to the right of the first
     
    // Load boat image and increase size
    boatImage = loadImage("../GMMASSETS/kapalfix.png");
    boatImage.resize(boatImage.width * 2, boatImage.height * 2);  // Increase boat size

    // Initialize bird positions and types
    birdX = new float[numBirds];
    birdY = new float[numBirds];
    birdAngle = new float[numBirds];
    for (int i = 0; i < numBirds; i++) {
      birdX[i] = random(-200, -100);
      birdY[i] = random(50, height / 2 - 300);
      birdAngle[i] = random(TWO_PI);  // Random initial angle for circular motion
    }

    startTime = millis();  // Record the start time of the animation

    // Set initial boat position
    boatX = -boatImage.width / 3;  // Start offscreen on the left
    boatY = height / 2 - 50;
  }

  void drawScene() {
    background(255);
    // Move the backgrounds to the left
    bgX1 -= 20; // Speed of background movement
    bgX2 -= 20; // Speed of background movement

    // Reset background positions to loop seamlessly
    if (bgX1 <= -width) {
      bgX1 = bgX2 + width;
    }
    if (bgX2 <= -width) {
      bgX2 = bgX1 + width;
    }

    // Draw the backgrounds
    shape(svg, bgX1, 0, width, height);
    shape(svg, bgX2, 0, width, height);

    // Draw sun
    fill(255, 204, 0);
    noStroke();
    ellipse(850, 150, 100, 100);

    // Check if animation should start showing birds
    if (!animationStarted && millis() - startTime > 30000) {
      animationStarted = true;
    }

    // Draw and animate birds
    for (int i = 0; i < numBirds; i++) {
      float x = width / 2 + cos(birdAngle[i]) * birdRadius;
      float y = birdY[i] + sin(birdAngle[i]) * birdRadius;
      drawBird(x, y, 40);  // Use the new drawBird function with a size of 40
      birdAngle[i] += 0.03;  // Adjust speed of circular motion

      // Reset bird position if it completes one circle
      if (birdAngle[i] >= TWO_PI) {
        birdAngle[i] = 0;
      }
    }

    // Update boat position
    boatX += boatSpeed;
    
    // Update oscillation angle and calculate new boatY
    oscillationAngle += oscillationSpeed;
    float oscillationOffset = sin(oscillationAngle) * oscillationMagnitude;

    // Draw boat with oscillation
    image(boatImage, boatX, boatY + oscillationOffset, boatImage.width / 3, boatImage.height / 3);

    // Draw human head on the boat
    drawHumanHead(boatX + 100, boatY + 110 + oscillationOffset);

    // Draw garbage net at the tail of the boat
    drawGarbageNet(boatX, boatY + 170 + oscillationOffset, boatImage.width / 3);
    drawGarbageNet(boatX, boatY + 190 + oscillationOffset, boatImage.width / 3);
    drawGarbageNet(boatX, boatY + 210 + oscillationOffset, boatImage.width / 3);
  }

  void drawHumanHead(float x, float y) {
    //// Draw bezier curves for head shape
    //noStroke();
    //fill(255, 204, 153);  // Skin color
    //beginShape();
    //vertex(x - 20, y);
    //bezierVertex(x - 20, y - 40, x + 20, y - 40, x + 20, y);
    //bezierVertex(x + 20, y + 20, x - 20, y + 20, x - 20, y);
    //endShape(CLOSE);
    
    //// Draw eyes
    //fill(0);
    //ellipse(x - 10, y - 10, 6, 12);  // Left eye
    //ellipse(x + 10, y - 10, 6, 12);  // Right eye
    
    //// Draw nose
    //triangle(x, y + 5, x - 5, y + 15, x + 5, y + 15);
    
    //// Draw mouth
    //fill(255);
    //rect(x - 5, y + 20, 10, 3);
    stroke(0);
    // Draw head
    fill(255, 224, 189); // skin color
    rect(x-20, y-40, headWidth, headHeight, 10); // head
  
    // Draw hair
    fill(0); // black color
    rect(x-20, y-50, headWidth, 15, 10); // hair
  
    // Draw body
    fill(#bca990); // white color for the coat
    rect(x-18, y-10, bodyWidth, bodyHeight); // body
  
    // Draw arms
    rect(x-26, y-10, armWidth, armHeight); // left arm
    rect(x+2, y-10, armWidth, armHeight); // right arm
  
    // Draw eyes
    fill(0); // black color
    ellipse(x-12, y-27, 4, 4); // left eye
    ellipse(x-2, y-27, 4, 4); // right eye
  
    // Draw mouth
    line(x-12, y-18, x, y-18); // mouth
    
  }

  void drawGarbageNet(float x, float y, float boatWidth) {
    // Draw garbage net (jaring-jaring sampah)
    fill(102, 51, 0); // Brown color for net
    noStroke();

    float netWidth = boatWidth / 2;
    float netHeight = 30;

    // Main structure
    rect(x + boatWidth / 2 - netWidth / 2, y, netWidth, netHeight);

    // Rope lines
    stroke(0);
    strokeWeight(2);
    int numLines = 5;  // Number of vertical lines
    float lineSpacing = netWidth / (numLines - 1);  // Spacing between lines

    // Draw vertical lines for the net
    for (int i = 0; i < numLines; i++) {
      line(x + boatWidth / 2 - netWidth / 2 + i * lineSpacing, y,
           x + boatWidth / 2 - netWidth / 2 + i * lineSpacing, y + netHeight);
    }
  }

  void drawBird(float x, float y, float size) {
    float bodyWidth = size;
    float bodyHeight = size * 0.7;
    float wingWidth = bodyWidth * 0.5;
    float wingHeight = bodyHeight * 0.6;
    float headSize = bodyWidth * 0.4;
    float beakSize = headSize * 0.3;
    float legLength = bodyHeight * 0.3;
    float legWidth = size * 0.03;

    // Draw body
    fill(135, 206, 250); // Light blue color
    ellipse(x, y, bodyWidth, bodyHeight);

    // Calculate wing position based on angle
    float wingY = y - wingHeight * 0.005 + sin(birdAngle[0]) * 10;  // Use birdAngle[0] for now

    // Draw wing
    fill(70, 130, 180); // Darker blue color
    beginShape();
    vertex(x + wingWidth * 0.03, wingY - wingHeight * 0.5);
    vertex(x + wingWidth * 0.05, wingY - wingHeight * 0.6);
    vertex(x + wingWidth * 0.9, wingY - wingHeight * 0.8);
    vertex(x + wingWidth * 0.08, wingY);
    endShape(CLOSE);

    // Draw head
    fill(135, 206, 250); // Light blue color
    ellipse(x - bodyWidth * 0.4, y - bodyHeight * 0.4, headSize, headSize);

    // Draw beak
    pushMatrix();
    translate(bodyWidth - 47, 0);
    fill(255, 165, 0); // Orange color
    triangle(x - bodyWidth * 0.5, y - bodyHeight * 0.3, x - bodyWidth * 0.5 + beakSize, y - bodyHeight * 0.25, x - bodyWidth * 0.5 + beakSize, y - bodyHeight * 0.35);
    popMatrix();

    // Draw eye
    fill(0); // Black color
    ellipse(x - bodyWidth * 0.45, y - bodyHeight * 0.45, headSize * 0.2, headSize * 0.2);

    // Draw legs
    stroke(255, 165, 0); // Orange color
    strokeWeight(legWidth);
    line(x - bodyWidth * 0.1, y + bodyHeight * 0.3, x - bodyWidth * 0.1, y + bodyHeight * 0.3 + legLength);
    line(x + bodyWidth * 0.1, y + bodyHeight * 0.3, x + bodyWidth * 0.1, y + bodyHeight * 0.3 + legLength);
    noStroke();

    // Draw feet
    stroke(255, 165, 0); // Orange color
    strokeWeight(legWidth);
    line(x - bodyWidth * 0.1, y + bodyHeight * 0.3 + legLength, x - bodyWidth * 0.15, y + bodyHeight * 0.3 + legLength + legWidth);
    line(x - bodyWidth * 0.1, y + bodyHeight * 0.3 + legLength, x - bodyWidth * 0.05, y + bodyHeight * 0.3 + legLength + legWidth);
    line(x + bodyWidth * 0.1, y + bodyHeight * 0.3 + legLength, x + bodyWidth * 0.15, y + bodyHeight * 0.3 + legLength + legWidth);
    line(x + bodyWidth * 0.1, y + bodyHeight * 0.3 + legLength, x + bodyWidth * 0.05, y + bodyHeight * 0.3 + legLength + legWidth);
    noStroke();
  }
}
