import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

//your variable declarations here
SpaceShip spaceDandy;
Star[] space;
public void setup() {
  //your code here
  size(600,600);
  spaceDandy = new SpaceShip();
  space = new Star[100];
  for (int i = 0; i < space.length; i++){
    space[i] = new Star();
    space[i].show();
  }
}
public void draw() {
  //your code here
  background(0);
  for (int i = 0; i < space.length; i++){
    space[i].show();
  }
  spaceDandy.show();
  spaceDandy.move();
}
public void keyPressed() {
  if(keyCode == UP) {spaceDandy.accelerate(0.1f);}
  else if(keyCode == DOWN) {spaceDandy.accelerate(-0.1f);}
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
    myX = (int)(Math.random()*600);
    myY = (int)(Math.random()*600);
  }

  public void show(){
    ellipse(myX,myY,3,3);
  }
}
class SpaceShip extends Floater  { 
  public SpaceShip() {
    corners = 4;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -2;
    yCorners[0] = 0;
    xCorners[1] = -8;
    yCorners[1] = 8;
    xCorners[2] = 16;
    yCorners[2] = 0;
    xCorners[3] = -8;
    yCorners[3] = -8;
    myColor = color(255, 255, 255);
    myCenterX = 300;
    myCenterY = 300;
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

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}