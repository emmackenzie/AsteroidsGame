SpaceShip bob = new SpaceShip();
Star [] stars = new Star[200];
//Bullet sue = new Bullet();
  //Asteroid rock = new Asteroid();
ArrayList <Asteroid> rockCluster = new ArrayList <Asteroid>();
boolean rockets = false;
public void setup() 
{ 
  size(500,500);
  background(0);

  for (int i = 0; i < stars.length; i ++)
      stars[i] = new Star();

  for(int i = 0; i < 15; i ++)
  {
      rockCluster.add(new Asteroid());
  }
}

public void draw() 
{
  background(0);

    for (int i = 0; i < stars.length; i ++)
      stars[i].draw();
  
 
 // remove asteroids from array list when touching ship
   for(int i = 0; i < rockCluster.size(); i ++)
    {
       if (dist(bob.getX(), bob.getY(), rockCluster.get(i).getX(), rockCluster.get(i).getY()) < 10 )
          rockCluster.remove(i);
       else
        {
          rockCluster.get(i).show();
          rockCluster.get(i).move();
        }
    }
 bob.move();
    bob.show();
    
}

public void keyPressed()
{
    // ship enters hyperspace
    if (key == ' ')
    {
      bob.setDirectionX(0);
      bob.setDirectionY(0);
      bob.setX((int)(Math.random()*500));
      bob.setY((int)(Math.random()*500));
      bob.setPointDirection((int) (Math.random()*360));
    } 
     // ship moves left
      if (key == 's')
        bob.turn(-10);
    //ship moves right
      if (key == 'f')
          bob.turn(10);
      if (key == 'j')
      {
        bob.accelerate(.1);
        rockets = true;
      }
      if (key == 'k')
        bob.accelerate(- .1);
}
public void keyReleased() 
{
  rockets = false;
}

class Star 
{
  private int myX, myY;
  private int myColor;

  public Star()
  {
    myX = (int)(Math.random() * 500);
    myY = (int)(Math.random() * 500);
    myColor = color(255);
  }

  public void draw()
  {
    noStroke();
    fill(myColor);
    ellipse(myX, myY, 3,3);
  }
}



class SpaceShip extends Floater  
{   

  public SpaceShip() 
  {
    corners = 13;
    int[] xS =  {-13,-16,-10,-10,-5,10,18,10,-5,-10,-10,-16,-13};
    int [] yS = {3,8,8,13,13,3,0,-3,-13,-13,-8,-8,-3};
    xCorners = xS;
    yCorners = yS;


    myColor = color(152,152,152);
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }

  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()   {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX()  {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY()  {return myDirectionY;}
  public void setPointDirection(int degrees)  {myPointDirection = degrees;}
  public double getPointDirection() {return (int)myPointDirection;}

public void show ()
  {  
    fill(myColor);   
    stroke(myColor);    
    
    //convert degrees to radians for sin and cos     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    translate((float)myCenterX, (float)myCenterY);
    rotate((float)dRadians);
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
     
    endShape(CLOSE);
    // if(rockets == true)
    // {
    //   fill(255,0,0);
    //   noStroke();

    //   beginShape();
    //   endShape(CLOSE);
      
    // int[] xS =  {-17,-22,-20,-22,-20,-22,-17};
    // int [] yS = {-5,-5,-3,0,3,5,5};
    // xCorners = xS;
    // yCorners = yS;
    // }
    rotate(-1*(float)dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }
}

class Bullet extends Floater
{
  public Bullet (SpaceShip theShip){
    myCenterX = bob.getX();
    myCenterY = bob.getY();
    myPointDirection = bob.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + bob.getDirectionX(); 
    myDirectionY = 5 * Math.sin(dRadians) + bob.getDirectionY();
    myColor = color(255,0,0);
  }

  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()   {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX()  {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY()  {return myDirectionY;}
  public void setPointDirection(int degrees)  {myPointDirection = degrees;}
  public double getPointDirection() {return (int)myPointDirection;}

  public void show ()
  {
    fill(myColor);   
    stroke(myColor);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    
   //ellipse((double)myCenterX,(double)myCenterY,5,5);

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }    
  

}

class Asteroid extends Floater 
{
  private int rotationSpeed;
  public Asteroid()
  {
    rotationSpeed = (int)(Math.random()*7) -3;

    corners = 6;

    xCorners = new int[corners];
    yCorners = new int[corners];

    xCorners[0] = (int)(Math.random()*5) -6;
    yCorners[0] =(int)(Math.random()*5) +5;
    xCorners[1] = (int)(Math.random()*5) +6;
    yCorners[1] = (int)(Math.random()*5) +5;
    xCorners[2] = (int)(Math.random()*5) +10;
    yCorners[2] = (int)(Math.random()*5);
    xCorners[3] = (int)(Math.random()*5) +6;
    yCorners[3] = (int)(Math.random()*5) -5;
    xCorners[4] = (int)(Math.random()*5) -6;
    yCorners[4] = (int)(Math.random()*5) -5;
    xCorners[5] = (int)(Math.random()*5) -10;
    yCorners[5] = (int)(Math.random()*5);


    myColor = color(255,85,85);
    myCenterX = Math.random()*500;
    myCenterY = Math.random()*500;
    myDirectionX = Math.random()*3 - 1;
    myDirectionY = Math.random()*3 - 1;
    myPointDirection = Math.random()*360;
  }

  public void move()
  {
    turn(rotationSpeed);
    super.move();
  }

  public void show()
  {
    
    noFill();  
    strokeWeight(3);
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

  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()   {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX()  {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY()  {return myDirectionY;}
  public void setPointDirection(int degrees)  {myPointDirection = degrees;}
  public double getPointDirection() {return (int)myPointDirection;}
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
  public void turn (int nDegreesOfRotation)   
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
    if(myCenterX >width)     
      myCenterX = 0;        
    else if (myCenterX<0)    
      myCenterX = width;        
    if(myCenterY >height)  
      myCenterY = 0;      
    else if (myCenterY < 0)    
      myCenterY = height;      
  } 


   public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    
    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }   
} 

