public int numAsteroids = 10;
ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();
SpaceShip spaceDandy = new SpaceShip();
Star[] space = new Star[200];
ArrayList <Bullet> bullets = new ArrayList <Bullet>();

public void setup() {
  size(500,500);  
  for (int i = 0; i < space.length; i++){
    space[i] = new Star();
    space[i].show();
  }

  for(int i = 0; i < numAsteroids; i++){
    asteroids.add(new Asteroid());
  }
}
public void draw() {
  background(0);
  for (int i = 0; i < space.length; i++){
    space[i].show();
  }
  spaceDandy.show();
  spaceDandy.move();
  for(int aI = 0; aI < asteroids.size(); aI++) {
    if(dist(asteroids.get(aI).getX(), asteroids.get(aI).getY(), spaceDandy.getX(), spaceDandy.getY()) < 30) {
      spaceDandy.setX(350);
      spaceDandy.setY(350);
      spaceDandy.setDirectionX(0);
      spaceDandy.setDirectionY(0);
    }
    for(int bI = 0; bI < bullets.size(); bI++) {
      if(dist(asteroids.get(aI).getX(), asteroids.get(aI).getY(), bullets.get(bI).getX(), bullets.get(bI).getY()) < 20) {
        asteroids.remove(aI);
        bullets.remove(bI);
      }
    }
  }
  for(int bI = 0; bI < bullets.size(); bI++) {
    bullets.get(bI).show();
    bullets.get(bI).move();
  }
}
public void keyPressed() {
  if(keyCode == UP) {spaceDandy.accelerate(0.1);}
  else if(keyCode == DOWN) {spaceDandy.accelerate(-0.1);}
  else if(keyCode == LEFT) {spaceDandy.rotate(-20);}
  else if(keyCode == RIGHT) {spaceDandy.rotate(20);}
  else if(keyCode == 32) {
    spaceDandy.setX((int)(Math.random()*width));
    spaceDandy.setY((int)(Math.random()*height));
    spaceDandy.setPointDirection((int)(Math.random()*360));
    spaceDandy.setDirectionX(0);
    spaceDandy.setDirectionY(0);
  }
}

class Star {
  int myX;
  int myY;
  public Star() {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);
  }

  public void show(){
    noStroke();
    fill(255,255,255, random(40,100));
    float angle = TWO_PI / 5;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = myX + cos(a) * 2;
      float sy = myY + sin(a) * 2;
      vertex(sx, sy);
      sx = myX + cos(a+halfAngle) * 5;
      sy = myY + sin(a+halfAngle) * 5;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }

}

class Asteroid extends Floater {
  private int rotSpeed;
  public Asteroid() {   
  rotSpeed = (int)(Math.random()*2)+1;
    corners = 8;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -30;
    yCorners[0] = -15;
    xCorners[1] = -15;
    yCorners[1] = -30;
    xCorners[2] = 15;
    yCorners[2] = -30;
    xCorners[3] = 30;
    yCorners[3] = -15;
    xCorners[4] = 30;
    yCorners[4] = 15;
    xCorners[5] = 15;
    yCorners[5] = 30;
    xCorners[6] = -15;
    yCorners[6] = 30;
    xCorners[7] = -30;
    yCorners[7] = 15;

    myColor = color(92, 92, 92);   
    myCenterX = (int)(Math.random()*1000);
    myCenterY = (int)(Math.random()*500);
    myDirectionX = (int)(Math.random()*3)-1;
    myDirectionY = (int)(Math.random()*3)-1;
  }
  public void move(){
    rotate(rotSpeed);
    super.move();
  }

  public void setX(int x){myCenterX = x;}    
  public void setY(int y){myCenterY = y;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public void setDirectionY(double y){myDirectionY = y;} 
  public void setPointDirection(int degrees) {myPointDirection = degrees;}    

  public int getX() {return (int)myCenterX;}
  public int getY() {return (int)myCenterY;}
  public double getDirectionX() {return myDirectionX;}   
  public double getDirectionY() {return myDirectionY;}   
  public double getPointDirection() {return myPointDirection;} 

}
class Bullet extends Floater {
  private double dRadians;
  public Bullet(SpaceShip theShip){
    myColor = color(255, 255, 255);
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5*Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5*Math.sin(dRadians)+ theShip.getDirectionY();

  }
  public void setX(int x){myCenterX = x;}    
  public void setY(int y){myCenterY = y;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public void setDirectionY(double y){myDirectionY = y;} 
  public void setPointDirection(int degrees) {myPointDirection = degrees;}    

  public int getX() {return (int)myCenterX;}
  public int getY() {return (int)myCenterY;}
  public double getDirectionX() {return myDirectionX;}   
  public double getDirectionY() {return myDirectionY;}   
  public double getPointDirection() {return myPointDirection;} 
  
  public void show() {
    fill(myColor);
    ellipse((float)myCenterX,(float)myCenterY,10,10);
  }
  public void move() {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY; 
  }
}
class SpaceShip extends Floater  { 
  public SpaceShip() {
    corners = 4;
    xCorners = new int[corners];
    xCorners[0] = -2;
    yCorners[0] = 0;
    xCorners[1] = -8;
    yCorners[1] = 8;
    xCorners[2] = 16;
    yCorners[2] = 0;
    xCorners[3] = -8;
    yCorners[3] = -8;
    myColor = color(255, 255, 255);
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }

  public void setX(int x){myCenterX = x;}    
  public void setY(int y){myCenterY = y;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public void setDirectionY(double y){myDirectionY = y;} 
  public void setPointDirection(int degrees) {myPointDirection = degrees;}    

  public int getX() {return (int)myCenterX;}
  public int getY() {return (int)myCenterY;}
  public double getDirectionX() {return myDirectionX;}   
  public double getDirectionY() {return myDirectionY;}   
  public double getPointDirection() {return myPointDirection;} 
  
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width){     
      myCenterX = 0;    
    }    
    else if (myCenterX<0){     
      myCenterX = width;    
    }    
    if(myCenterY >height){    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0){     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

