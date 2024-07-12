class Scene2 {
  PShape svg;
  float bgX1, bgX2; // X-coordinates of the backgrounds


  PImage[] fishImages;
  float[] fishX;
  float[] fishY;
  int[] fishType;
  int numFish = 10;  // Total number of fish
  float fishSpeed = 8.0;  // Initial speed of fish

  float[] birdX;
  float[] birdY;
  int numBirds = 3;  // Total number of birds

  PImage[] trashImages;  // Array to hold different trash images
  float[] trashX;
  float[] trashY;
  int[] trashType;
  int numTrash = 50;  // Total number of trash items

  boolean animationStarted = false;  // Flag to indicate if animation has started
  int startTime;  // Variable to store the start time of the animation

  float angle = 0;  // Angle for wing flapping

  Scene2() {
     frameRate(1000);
    svg = loadShape("../GMMASSETS/backgroundlautt.svg");


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
      fishY[i] = random(height / 2 + 100, height - 100);  // Random vertical position in the lower half
      fishType[i] = int(random(2));  // Randomly select fish type (0 or 1)
    }

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
    for (int i = 0; i < numTrash; i++) {
      trashX[i] = width + random(100, 1000);  // Start off-screen to the right
      trashY[i] = height / 2 + 50;  // Random vertical position in the upper half for trash
      trashType[i] = int(random(3));  // Randomly select trash type (0, 1, or 2)
    }

    startTime = millis();  // Record the start time of the animation
    bgX1 = 0;  // Initialize first background position
    bgX2 = width;  // Initialize second background position to the right of the first
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

    // Check if animation should start showing trash
    if (!animationStarted && millis() - startTime > 65000) {
      animationStarted = true;  // Animation has started after 30 seconds
      fishSpeed = 20.0;  // Increase fish speed
    }

    // Draw and animate fish
    for (int i = 0; i < numFish; i++) {
      PImage currentFish = fishImages[fishType[i]];
      image(currentFish, fishX[i], fishY[i], currentFish.width / 5, currentFish.height / 5);  // Draw fish
      fishX[i] -= fishSpeed;  // Move fish to the left with current speed

      // Reset fish position if it moves off the left edge
      if (!animationStarted) {
        if (fishX[i] < -currentFish.width / 4) {
          fishX[i] = random(width, width + 500);  // Start off-screen to the right again
          fishY[i] = random(height / 2 + 100, height - 100);  // Random vertical position in the lower half
          fishType[i] = int(random(2));  // Randomly select fish type (0 or 1)
        }
      }
    }

    // Update angle for wing flapping
    angle += 0.1;

    // Draw and animate birds
    for (int i = 0; i < numBirds; i++) {
      drawBird(birdX[i], birdY[i], 50);  // Use drawBird function to draw birds
      birdX[i] += 10;  // Move bird to the right

      // Reset bird position if it moves off the right edge
      if (birdX[i] > width) {
        birdX[i] = random(-200, -100);  // Start off-screen to the left again
        birdY[i] = random(50, height / 2 - 300);  // Random vertical position in the upper half
      }
    }

    // Draw trash only if animation has started
    if (animationStarted) {
      for (int i = 0; i < numTrash; i++) {
        PImage currentTrash = trashImages[trashType[i]];
        image(currentTrash, trashX[i], trashY[i], currentTrash.width / 4, currentTrash.height / 4);  // Draw trash
        trashX[i] -= 6;  // Move trash to the left

        // Reset trash position if it moves off the left edge
        if (trashX[i] < -currentTrash.width / 4) {
          trashX[i] = width + random(100, 1000);  // Start off-screen to the right again
          trashY[i] = height / 2 + 50;  // Random vertical position in the upper half for trash
          trashType[i] = int(random(3));  // Randomly select trash type (0, 1, or 2)
        }
      }
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
