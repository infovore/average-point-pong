// average point pong
// based on code by
// Daniel Shiffman
//
// complete rubbish: wave your hand at the right to make the
// paddle go up and down. don't miss the ball. "losses" are shown top left.
//
// see
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

int rightPaddleX, rightPaddleY;
int paddleHeight = 120;
int paddleWidth = 30;

// set up font

int fontSize = 36;
int score;

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
  yPos = 480/2;
  
  // set up paddles;
  rightPaddleX = width - 100;
  rightPaddleY = height/2 - paddleHeight/2;
  score = 0;
  
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
  
  // move the paddles
  
  // if lerped x is between paddle x and paddle x + w
  if((v2.x > (rightPaddleX -25)) && (v2.x < (rightPaddleX + paddleWidth + 25))) {
//    // if lerped y is greater thanpaddle Y and less than paddle Y + 25
//    if((v2.y > rightPaddleY) && (v2.y < (rightPaddleY + 25))) {
//      // mpve up
//      rightPaddleY = rightPaddleY + 10;    
//    }
//    
//    if((v2.y < (rightPaddleY + paddleHeight)) && (v2.y > (rightPaddleY + paddleHeight - 25))) {
//      rightPaddleY = rightPaddleY - 10;
//    }

    rightPaddleY = int(v2.y - paddleHeight /2 );
  }
  
  // finally, draw the pong stuff
  fill(255);
  drawPaddles();  
  animateBall();
  text(leftScore, fontSize, fontSize);
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
  if(key == 114) {
    resetBall();
  }
}

void stop() {
  tracker.quit();
  super.stop();
}

