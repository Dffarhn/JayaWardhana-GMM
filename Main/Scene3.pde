class Scene3 {
  PShape svg;
  float bgX1, bgX2; // X-coordinates of the backgrounds
  PImage boatImage;
  float angle =0;
  float[] birdX;
  float[] birdY;
  int numBirds = 3;  // Total number of birds
  
  PImage[] fishImages;
  float[] fishX;
  float[] fishY;
  int[] fishType;
  int numFish = 10;  // Total number of fish
  float fishSpeed = 20.0;  // Initial speed of fish
  
  PImage[] trashImages;  // Array to hold different trash images
  float[] trashX;
  float[] trashY;
  int[] trashType;
  boolean[] trashCollected;  // Array to keep track of collected trash
  int numTrash = 50;  // Total number of trash items

  float boatX;
  float boatY;
  float boatSpeed = 5.0;  // Speed of the boat moving from left to right
  
  int headWidth = 25;
  int headHeight = 30;
  int bodyWidth = 20;
  int bodyHeight = 32;
  int armWidth = 8;
  int armHeight = 25;

  boolean animationStarted = false;  // Flag to indicate if animation has started
  int startTime;  // Variable to store the start time of the animation

  Scene3() {
    // Load background images
     frameRate(1000);
     svg = loadShape("../GMMASSETS/backgroundlautt.svg");
     bgX1 = 0;  // Initialize first background position
     bgX2 = width;  // Initialize second background position to the right of the first
    
    
     // Load fish images
  fishImages = new PImage[2];
  fishImages[0] = loadImage("../GMMASSETS/ikanfix.png");  // Load the first fish image
  fishImages[1] = loadImage("../GMMASSETS/ikan2fix.png");  // Load the second fish image
    
        // Initialize fish positions and types
    fishX = new float[numFish];
    fishY = new float[numFish];
    fishType = new int[numFish];
    for (int i = 0; i < numFish; i++) {
      fishX[i] = random(width, width + 500);  // Start off-screen to the right
      fishY[i] = random(height / 2 + 200, height - 100);  // Random vertical position in the lower half
      fishType[i] = int(random(2));  // Randomly select fish type (0 or 1)
    }


    // Load boat image and increase size
    boatImage = loadImage("../GMMASSETS/kapalfix.png");
    boatImage.resize(boatImage.width * 2, boatImage.height * 2);  // Increase boat size

    
    // Initialize bird positions
    birdX = new float[numBirds];
    birdY = new float[numBirds];
    for (int i = 0; i < numBirds; i++) {
      birdX[i] = random(-800, -100);  // Start off-screen to the left
      birdY[i] = random(50, height / 2 - 300);  // Random vertical position in the upper half
    }
    
    // Load trash images
    trashImages = new PImage[3];  // Array for three different trash images
    trashImages[0] = loadImage("../GMMASSETS/sampahfix.png");  // Load the first trash image
    trashImages[1] = loadImage("../GMMASSETS/sampah2fix.png");  // Load the second trash image
    trashImages[2] = loadImage("../GMMASSETS/sampah3fixrm.png");  // Load the third trash image
    
    // Initialize trash positions and types
    trashX = new float[numTrash];
    trashY = new float[numTrash];
    trashType = new int[numTrash];
    trashCollected = new boolean[numTrash];
    for (int i = 0; i < numTrash; i++) {
      trashX[i] = width + random(100, 1000);  // Start off-screen to the right
      trashY[i] = height / 2 + 80;  // Random vertical position in the upper half for trash
      trashType[i] = int(random(3));  // Randomly select trash type (0, 1, or 2)
      trashCollected[i] = false;  // Initialize all trash items as not collected
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
    
     for (int i = 0; i < numFish; i++) {
    PImage currentFish = fishImages[fishType[i]];
    image(currentFish, fishX[i], fishY[i], currentFish.width / 5, currentFish.height / 5);  // Draw fish
    fishX[i] -= fishSpeed;  // Move fish to the left with current speed
    
    }
  

    // Update angle for wing flapping
    angle += 0.1;

    // Draw and animate birds
    for (int i = 0; i < numBirds; i++) {
      drawBird(birdX[i], birdY[i], 50);  // Use drawBird function to draw birds
      birdX[i] += 5;  // Move bird to the right

      // Reset bird position if it moves off the right edge
      if (birdX[i] > width) {
        birdX[i] = random(-200, -100);  // Start off-screen to the left again
        birdY[i] = random(50, height / 2 - 300);  // Random vertical position in the upper half
      }
    }

    // Update boat position
    boatX += boatSpeed;

    // Draw boat
    image(boatImage, boatX, boatY, boatImage.width / 3, boatImage.height / 3);

    // Draw human head on the boat
    drawHumanHead(boatX + 100, boatY + 110);

    // Draw garbage net at the tail of the boat
    float netX = boatX + boatImage.width / 3 - (boatImage.width / 3 / 2);
    float netY = boatY + 170;
    float netWidth = boatImage.width / 3 / 2;
    float netHeight = 30;
    drawGarbageNet(netX, netY, netWidth);
    drawGarbageNet(netX, netY + 20, netWidth);
    drawGarbageNet(netX, netY + 40, netWidth);

    // Update and draw trash items
    for (int i = 0; i < numTrash; i++) {
      if (!trashCollected[i]) {
        trashX[i] -= boatSpeed;  // Move trash to the left

        // Check for collision with garbage net
        if (trashX[i] >= netX && trashX[i] <= netX + netWidth) {
          trashCollected[i] = true;  // Mark trash as collected
        }

        // Draw trash item if not collected
        if (!trashCollected[i]) {
          PImage currentTrash = trashImages[trashType[i]];
          image(currentTrash, trashX[i], trashY[i], currentTrash.width / 4, currentTrash.height / 4);
        }
      }
    }
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

  void drawGarbageNet(float x, float y, float netWidth) {
    // Draw garbage net (jaring-jaring sampah)
    fill(102, 51, 0); // Brown color for net
    noStroke();

    float netHeight = 30;

    // Main structure
    rect(x, y, netWidth, netHeight);

    // Rope lines
    stroke(0);
    strokeWeight(2);
    int numLines = 5;  // Number of vertical lines
    float lineSpacing = netWidth / (numLines - 1);  // Spacing between lines

    // Draw vertical lines for the net
    for (int i = 0; i < numLines; i++) {
      line(x + i * lineSpacing, y, x + i * lineSpacing, y + netHeight);
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
