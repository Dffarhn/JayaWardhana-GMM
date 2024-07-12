class Scene5 {
  PShape svg;
  float bgX1, bgX2; // X-coordinates of the backgrounds
  PImage[] fishImages;
  float[] fishX;
  float[] fishY;
  float[] fishAngle;  // Angle for circular motion of fish
  float fishRadius = 100;  // Radius for fish circular motion
  int[] fishType;
  int numFish = 10;  // Total number of fish
  float fishSpeed = 8.0;  // Initial speed of fish

    float angle = 0; // Angle for circular motion of birds
   PImage boatImage;
  float boatX;
  float boatY;
  float boatSpeed = 2.0;  // Speed of the boat moving from left to right
  float oscillationSpeed = 0.05;  // Speed of the up-down oscillation
  float oscillationMagnitude = 40;  // Magnitude of the up-down oscillation
  float oscillationAngle = 10;  // Angle for the sin() function to control up-down movement
  
  int headWidth = 25;
  int headHeight = 30;
  int bodyWidth = 20;
  int bodyHeight = 32;
  int armWidth = 8;
  int armHeight = 25;


  boolean animationStarted = false;  // Flag to indicate if animation has started
  int startTime;  // Variable to store the start time of the animation

  Scene5() {
     frameRate(1000);
     svg = loadShape("../GMMASSETS/backgroundlautt.svg");
     bgX1 = 0;  // Initialize first background position
     bgX2 = width;  // Initialize second background position to the right of the first
    
    
        // Load boat image and increase size
    boatImage = loadImage("../GMMASSETS/kapalfix.png");
    boatImage.resize(boatImage.width * 2, boatImage.height * 2);  // Increase boat size


    // Load fish images
    fishImages = new PImage[2];
    fishImages[0] = loadImage("../GMMASSETS/ikanfix.png");  // Load the first fish image
    fishImages[1] = loadImage("../GMMASSETS/ikan2fix.png");  // Load the second fish image
    
    // Initialize fish positions, angles, and types
    fishX = new float[numFish];
    fishY = new float[numFish];
    fishAngle = new float[numFish];
    fishType = new int[numFish];
    for (int i = 0; i < numFish; i++) {
      fishX[i] = random(width, width + 500);  // Start off-screen to the right
      fishY[i] = random(height / 2+100, height - 100);  // Random vertical position in the lower half
      fishAngle[i] = random(TWO_PI);  // Random initial angle for circular motion
      fishType[i] = int(random(2));  // Randomly select fish type (0 or 1)
    }

   

    startTime = millis();  // Record the start time of the animation
    
        // Set initial boat position
    boatX = -boatImage.width / 3;  // Start offscreen on the left
    boatY = height / 2 - 50;
  }

  void drawScene() {
    background(255);  // Set the background color to white
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
    fill(255, 204, 0);  // Set fill color to yellow
    noStroke();  // Disable stroke
    ellipse(850, 150, 100, 100);  // Draw sun at the top 
    
     // Pusat lingkaran
    float centerX = width / 2;
    float centerY = 100;

    // Jari-jari lingkaran
    float radius = 50;

    // Hitung posisi x dan y burung
    float birdX1 = centerX + cos(angle) * radius;
    float birdY1 = centerY + sin(angle) * radius;

    float birdX2 = centerX + cos(angle + PI / 3) * radius;
    float birdY2 = centerY + sin(angle + PI / 3) * radius;

    float birdX3 = centerX + cos(angle + 2 * PI / 3) * radius;
    float birdY3 = centerY + sin(angle + 2 * PI / 3) * radius;

    // Gambar burung
    drawBird(birdX1, birdY1, 50);
    drawBird(birdX2, birdY2, 50);
    drawBird(birdX3, birdY3, 50);

    // Tingkatkan sudut untuk gerakan
    angle += 0.15; // Kecepatan gerakan burung

    // Check if animation should start showing fish
    if (!animationStarted && millis() - startTime > 80000) {
      animationStarted = true;  // Animation has started after 30 seconds
      fishSpeed = 10.0;  // Increase fish speed
    }

    // Draw and animate fish
    for (int i = 0; i < numFish; i++) {
      float x = width / 2 + cos(fishAngle[i]) * fishRadius;
      float y = height / 2 + 300 + sin(fishAngle[i]) * fishRadius;
      PImage currentFish = fishImages[fishType[i]];
      image(currentFish, x, y, currentFish.width / 5, currentFish.height / 5);  // Draw fish
      
      fishAngle[i] += 0.03;  // Adjust speed of circular motion
      
      // Reset fish position if it completes one circle
      if (fishAngle[i] >= TWO_PI) {
        fishAngle[i] = 0;
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
    float wingY = y - wingHeight * 0.005 + sin(angle) * 10;

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
    translate(bodyWidth - 60, 0);
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
