void drawPaddles() {
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight);
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);
}

void animateBall() {
  
  // if ball is going left
  if (xDirection < 0) {
    // if the ball is to the left of the left paddle
    if (xPos <= leftPaddleX) {
      // if ball is between top and bottom of paddle 
      if(((leftPaddleY - (paddleHeight/2)) <= yPos) && (yPos <= (leftPaddleY + (paddleHeight/2)))) {
        xDirection = -xDirection;
      }
    }
  } else {
    // if the ball is to the rightof the right paddle
    if (xPos >= rightPaddleX) {
      // if ball is between top and bottom of paddle 
      if(((rightPaddleY - (paddleHeight/2)) <= yPos) && (yPos <= (rightPaddleY + (paddleHeight/2)))) {
        xDirection = -xDirection;
      }
    }
  }
  
  // if it goes off the left hand side
  if (xPos < 0) {
    rightScore++;
    resetBall();
  }
  
  // if it goes off the right hand side
  
  if (xPos > width) {
    leftScore++;
    resetBall();
  }
  
  if(yPos + ballSize/2 > height || yPos - ballSize/2 < 0) {
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
