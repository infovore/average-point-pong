void drawPaddles() {
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);
}

void animateBall() {
  
  // if ball is going left
  if (xDirection < 0 && xPos <= 0 ) {
    xDirection = -xDirection;
  } else {
    // if the ball is to the rightof the right paddle
    if (xPos >= rightPaddleX) {
      // if ball is between top and bottom of paddle 
      if((yPos > rightPaddleY) && (yPos <= (rightPaddleY + paddleHeight))) {
        xDirection = -xDirection;
      }
    }
  }
  

  // if it goes off the right hand side
  
  if (xPos > width) {
    score++;
    resetBall();
  }
  
  if(yPos + ballSize/2 > 480 || yPos - ballSize/2 < 0) {
    yDirection = -yDirection;
  }
  
  xPos = xPos + xDirection;
  yPos = yPos + yDirection;
    
  // draw ball
  fill(255);
  rect(xPos, yPos, ballSize, ballSize);
}

void resetBall() {
  xPos = width/2;
  yPos = height/2;
}
