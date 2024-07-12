class Scene1 {
  PShape svg;
  PImage boatImage;
  float angle = 0; // Angle for circular motion of birds

  int startTime;  // Variable to store the start time of the animation

  float bgX1, bgX2; // X-coordinates of the backgrounds

  Scene1() {
    frameRate(1000);
    svg = loadShape("../GMMASSETS/backgroundlautt.svg");
    boatImage = loadImage("../GMMASSETS/kapalfix.png");
    boatImage.resize(boatImage.width * 2, boatImage.height * 2);  // Increase boat size

    startTime = millis();  // Record the start time of the animation
    bgX1 = 0;  // Initialize first background position
    bgX2 = width;  // Initialize second background position to the right of the first
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

    // Calculate bird positions
    float centerX = width / 2;
    float centerY = 120;
    float radius = 50;
    float birdX1 = centerX + cos(angle) * radius;
    float birdY1 = centerY + sin(angle) * radius;
    float birdX2 = centerX + cos(angle + PI / 3) * radius;
    float birdY2 = centerY + sin(angle + PI / 3) * radius;
    float birdX3 = centerX + cos(angle + 2 * PI / 3) * radius;
    float birdY3 = centerY + sin(angle + 2 * PI / 3) * radius;

    // Draw birds
    drawBird(birdX1, birdY1, 50);
    drawBird(birdX2, birdY2, 50);
    drawBird(birdX3, birdY3, 50);

    // Increase angle for bird movement
    angle += 0.1; // Speed of bird movement

    // Draw boat and make it move from left to right
    float boatX = map(millis() - startTime, 0, 30000, -boatImage.width, width);
    float boatY = height / 2 - 50;  // Move the boat down by adding 20 pixels
    image(boatImage, boatX, boatY, boatImage.width / 3, boatImage.height / 3);
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
