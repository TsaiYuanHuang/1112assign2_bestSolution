  
final int GAME_START   = 0;
final int GAME_RUN     = 1;
final int GAME_WIN     = 2;
final int GAME_LOSE    = 3;

int gameState = 0 ; 
  
int health = 0 ;


PImage start1 ;
PImage start2 ;
PImage end1 ;
PImage end2 ;

PImage fighter ; 
PImage enemy ; 
PImage treasure ; 
PImage background1 ; 
PImage background2 ;
PImage hp ;

float background1X ;
float background2X ;
float backgroundSpeed = 1 ; 

float treasureX = 0 ;
float treasureY = 0 ; 

float flightX = 0 ;
float flightY = 0 ;
float flightSpeed = 4 ;
 
float enemyX = 0 ;
float enemyY = 0 ; 

float enemyXSpeed = 3 ;
float enemyYSpeed = 3 ;

float hpLong = 200;
float hpProportional = 200/100 ;

boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;

void setup () {
  
  size(640, 480) ;
  textAlign(CENTER);

  fighter    = loadImage("data/img/fighter.png"); 
  enemy      = loadImage("data/img/enemy.png"); 
  treasure   = loadImage("data/img/treasure.png"); 
  background1 = loadImage("data/img/bg1.png");
  background2 = loadImage("data/img/bg2.png");
  hp = loadImage("data/img/hp.png");
  
  start1 = loadImage("data/img/start1.png");
  start2 = loadImage("data/img/start2.png");
  end1 = loadImage("data/img/end1.png");
  end2 = loadImage("data/img/end2.png");

  background1X = -640 ; 
  background2X = 0 ;

  treasureX   = random(width  - treasure.width) ; 
  treasureY   = random(height - treasure.height) ; 

  enemyX      = 0   ;   
  enemyY      = random(height - enemy.height);
    
  flightX     = width - fighter.width ;
  flightY     = height/2 - fighter.height/2 ;
  
  health      = 100 ;
  gameState   = GAME_START ;
}

void draw() {
  switch(gameState){
      
    case GAME_START:
      // button hovering effect
       hpLong = 200 ;
      if (mouseX > 200 && mouseX < 470 && 
          mouseY > 370 && mouseY < 420){
          if(mousePressed){
            //click
            gameState = GAME_RUN;
          }
          image(start1,0,0);
      }
      else {
          image(start2,0,0) ;
      }
      
      break;
    
    case GAME_RUN:
      background(0);
     //init set
      // move the background      
      background1X += backgroundSpeed ;
      background2X += backgroundSpeed ;
      // scroll the backgrounds
      background1X++ ;
      background2X++ ;
      if (background1X==640){   
        background1X = -640 ;
      }
      if (background2X==640){  
        background2X = -640 ;
      }
      
      // move enemy
      enemyX += enemyXSpeed ;
      enemyX %= width;
      
      // show background
      image(background1 , background1X, 0);
      image(background2 , background2X, 0);
      
      // show treasure, player and enemy 
      image(treasure, treasureX, treasureY);
      image(fighter, flightX , flightY) ;
      image(enemy, enemyX , enemyY  ) ;
         
      // show health
      fill (255,0,0) ;
      rect(15,10,hpLong, 20 ) ;
      image(hp,10,10);
      
   //playing
     //move enemy when flighter in 300px
       //enemy left&up
     if( dist(enemyX,enemyY,flightX,flightY) <= 300){
       if(enemyX < flightX && enemyY < flightY){
         enemyX += enemyXSpeed ;
         enemyY += enemyYSpeed ;
       }
       //enemy left&down
       if(enemyX < flightX && enemyY > flightY){
         enemyX += enemyXSpeed ;
         enemyY -= enemyYSpeed ;
       }
     }
      
     //move fighter
     if(upPressed){
       flightY -= flightSpeed;
       //boundary detection
       if(flightY < 0){
         flightY = 0;
       }
     }
     if(downPressed){
       flightY += flightSpeed;
       //boundary detection
       if(flightY > height-fighter.height){
         flightY = height-fighter.height;
       }
     }
     if(rightPressed){
       flightX += flightSpeed;
       //boundary detection
       if(flightX >  width-fighter.width){
         flightX = width-fighter.width;
       }
     }
     if(leftPressed){
       flightX -= flightSpeed;
       //boundary detection
       if(flightX < 0){
         flightX = 0;
       }
     }
     
     //check enemy
     if((flightX <= enemyX+enemy.width && flightX+ fighter.width >= enemyX) && (flightY <= enemyY+enemy.height && flightY+fighter.height >= enemyY)){
       hpLong = hpLong - 20*hpProportional ;
       enemyX = 0 ;   
       enemyY = random(height - enemy.height) ;
     }
     
     //check treature
      if((flightX <= treasureX+treasure.width && flightX+ fighter.width >= treasureX) && (flightY <= treasureY+treasure.height && flightY+fighter.height >= treasureY)){
       if(hpLong < 200){
         hpLong = hpLong + 10*hpProportional ;
       }
       treasureX = random(width  - treasure.width) ; 
       treasureY = random(height - treasure.height) ; 
     }
   //losed
      if(hpLong <=0 ){
        gameState = GAME_LOSE ;
      }
      
      break;
      
    case GAME_LOSE:
      // button hovering effect
      if (mouseX > 200 && mouseX < 470 && 
          mouseY > 300 && mouseY < 360){
          if(mousePressed){
            gameState = GAME_START;
          }
          image(end1,0,0);
      }
      else {
          image(end2,0,0) ;
      }
      
      break;

  }
  
}


void keyPressed(){
  // DO NOT REMOVE THIS PART!!!
  // USED FOR DEBUGGING
  switch (key){
    case '1':
      gameState = GAME_START;
      break;
    case '2':
      gameState = GAME_RUN;
      break;
    case '3':
      gameState = GAME_LOSE;
      break;
  }
  // Your code start from here
   if(key == CODED){
     switch ( keyCode){
       case UP :
         upPressed = true;
         break;
       case DOWN :
         downPressed = true;
         break;
       case RIGHT :
         rightPressed = true;
         break;
       case LEFT :
         leftPressed = true;
         break;
     }
   }
}

void keyReleased(){
  if(key == CODED){
    switch ( keyCode){
      case UP :
        upPressed = false;
        break;
      case DOWN :
        downPressed = false;
        break;
      case RIGHT :
        rightPressed = false;
        break;
      case LEFT :
        leftPressed = false;
        break;
    }
  }
}
