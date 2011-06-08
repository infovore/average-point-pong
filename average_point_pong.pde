
// average point pong
// based on code by
// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan
// http://www.shiffman.net
// https://github.com/shiffman/libfreenect/tree/master/wrappers/java/processing

// pong stuff

// set up ball

int ballSize = 10;
int xDirection = 1; // start going right
int yDirection = 1; // start going down
int xPos, yPos;
int leftScore, rightScore;

// set up paddles

int leftPaddleX, rightPaddleX, leftPaddleY, rightPaddleY;
int paddleHeight = 120;
int paddleWidth = 30;

// kinect stuff

import org.openkinect.*;
import org.openkinect.processing.*;

KinectTracker tracker;
Kinect kinect;

void setup() {
  size(640,520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  // set up the pong stuff
  
  // set up ball
  xPos = width/2;
  yPos = height/2;
  
  // set up paddles;
  leftPaddleX = 50;
  rightPaddleX = width - 100;
  leftPaddleY = height/2 - paddleHeight/2;
  rightPaddleY = height/2 - paddleHeight/2;
}

void draw() {
  background(255);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50,100,250,200);
  noStroke();
  ellipse(v1.x,v1.y,20,20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100,250,50,200);
  noStroke();
  ellipse(v2.x,v2.y,20,20);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + (int)frameRate + "    " + "UP increase threshold, DOWN decrease threshold",10,500);
  
  // finally, draw the pong stuff
  fill(255);
  drawPaddles();  
  animateBall();
}

void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } 
    else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}

void stop() {
  tracker.quit();
  super.stop();
}

