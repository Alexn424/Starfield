boolean isLeft = false;
boolean isRight = false;
boolean isJump = false;
boolean lastjump = false;
boolean inCircle = true;

Particle [] puberts= new Particle [250];
boolean showRing = true;
Guy bob;
Ring john = new Ring(250, 250, 200, PI/4);
void setup() {
  size(500, 500);

  bob = new Guy(john.myRadius);
  for(int i = 0; i < puberts.length; i++){
    puberts[i] = new Particle();
}
}



void keyPressed() {
  if (key == 'a' || key == 'A') isLeft = true;
  if (key == 'd' || key == 'D') isRight = true;
  if (key == ' ') isJump = true;
}

void keyReleased() {
  if (key == 'a' || key == 'A') isLeft = false;
  if (key == 'd' || key == 'D') isRight = false;
  if (key == ' ') isJump = false;
}

Odd bartholomew = new Odd();
public void draw() {
  background(#000000);
  john.rotateGap();
  if (showRing){
    john.show();
    fill(#FFFFFF);
    noStroke();
    bob.show();
  }
  boolean jump = false;
  if (isLeft) {
    bob.moveLeft();
  }
  if (isRight) {
    bob.moveRight();
  }
  if (isJump) {
    jump = true;
  }
  if (jump && !lastjump) {
    bob.jump();
  }
  
  if (bob.hit() && inCircle){
     
     float xDiff = bob.currentX-250;
     float yDiff = bob.currentY-250;
     float angle = atan2(yDiff, xDiff);
     if(angle < 0){
       angle += 2*PI;
     }
     float targetStart = john.gapStart%(2* PI);
     float targetEnd = john.gapEnd%(2*PI);
     if (targetStart < 0) targetStart += TWO_PI;
     if (targetEnd < 0) targetEnd += TWO_PI;
     boolean inGap;
     if(targetStart <= targetEnd){
       inGap = angle >= targetStart && angle <= targetEnd;
     }
     else{
       inGap = angle >= targetStart || angle <= targetEnd;
     }
     if (inGap){
       inCircle = false;
       showRing = false;
       
     }
     else{
       bob.velocityX = -bob.velocityX*1.4;
       bob.velocityY = -bob.velocityY*1.6;
     }
  }
  if (!showRing){
    for(int i = 0; i < puberts.length; i++){
      puberts[i].move();
      puberts[i].show();
    }
    bartholomew.move();
    bartholomew.show();
  }
  bob.update();
  bob.fall();

  lastjump = jump;
}


class Guy {
  int currentX, currentY, jumpHeight, ringRadius;
  float velocityY, velocityX, fallRate;
  Guy(int radius) {
    jumpHeight = 20;
    currentX = 250;
    currentY= 250;
    fallRate = 1;
    velocityY = 0 ;
    velocityX = 1;
    ringRadius = radius;
  }

  void moveLeft() {
    currentX -= 4;
    if (currentX <= 15) {
      currentX = 15;
    }
  }
  void moveRight() {
    currentX += 4;
    if (currentX >= 485) {
      currentX = 485;
    }
  }
  void fall() {
    velocityY += fallRate;
    velocityY *= 0.9;
    if (currentY <= 15) {
      currentY = 15;
    }
    if (currentY >= 485) {
      currentY = 485;
    }
    if (currentX <= 15) {
      currentX = 15;
    }
    if (currentX >= 485) {
      currentX = 485;
    }
  } 
  void jump() {
    velocityY -= jumpHeight;
  }
  void update(){
    currentY += velocityY;
    currentX += velocityX;

    if (velocityX >= 6){
      velocityX = 6;
    }
    if (velocityY >= 6){
      velocityY = 6;
    }
    
  }
  void show() {
    
    ellipse(currentX, currentY, 30, 30);
  
  }
  boolean hit(){
    boolean condition = false;
    if (dist(currentX, currentY, 250, 250) >= ringRadius/2 -15){
      condition = true;
      
    }
    return condition;
  }
}

class Ring{
  int myX, myY, arcX, arcY, myColor, myRadius, mySpeed;
  float gapStart, gapEnd;
  Ring(int x, int y, int radius, float gap){
    myRadius = radius;
    myColor = (int)(Math.random() * 150)+100;
    mySpeed = 2;
    gapStart = 0;
    gapEnd = gap;
    myX = x;
    myY = y;
  }
  void rotateGap(){
    float rotRate = PI/100;
    gapStart -= rotRate;
    gapEnd -= rotRate;
  }
  void show(){
    noStroke();
    fill(myColor, 0, myColor);
    ellipse(myX, myY, myRadius+20, myRadius+20);
    fill(0);
    ellipse(myX, myY, myRadius, myRadius);
    stroke(0);
    fill(0);
    arc(myX, myY,myRadius+20, myRadius+20, gapStart, gapEnd);
  }

}

class Particle{
  float myX, myY, myAngle;
  int mySize, myColor;
  Particle(){
    myAngle = (float)(Math.random()*(2*PI));
    myX = 250+150*cos(myAngle);
    myY = 250+150*sin(myAngle);
    mySize = 5;
    myColor = 200;
  }
  void move(){
    myX += 5*cos(myAngle);
    myY += 5*sin(myAngle);
  }
  void show(){
    fill(myColor,30,10);
    ellipse(myX, myY, mySize,mySize);
    fill(0);
  }
  
}
class Odd extends Particle{
  Odd(){
    myAngle = (float)(Math.random()*(2*PI));
    myX = 250+150*cos(myAngle);
    myY = 250+150*sin(myAngle);
    mySize = 50;
    myColor = 255;
}
}












