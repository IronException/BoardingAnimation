

boolean bestMovement = false;


int seatLength = 8;
int seatWidth = 3; // is x2 cuz only one side

int[][] seats;

float seatWalkingDist = 0.2;

float speed = frameRate / 3.0;


Passenger[] passengers;

PImage[][] skins;

PImage bg, seat;

float frame; // 0 - 100
int steps;

Passenger[] map;
int mapStart;
int lineStart = -1;

int passengerNum;

boolean stop;

void setup(){
  fullScreen();
  frameRate(60);
  
  passengerNum = seatWidth * 2 * seatLength;
  
  
  // TODO v + lineStart?
  mapStart = passengerNum; // + abs(lineStart);
  map = new Passenger[mapStart + seatLength];
  
  
  seats = numericalOrder();
  
  steps = 0;
  
  
  loadPics(); // bg, seat
  skins = loadSkins();
  
  passengers = new Passenger[passengerNum];
  
  for(int i = 0; i < passengers.length; i ++){
    passengers[i] = new Passenger(lineStart - i, seats[i][0], seats[i][1], (int) random(skins.length));
    
  }
  
  
  size = height / (seatWidth * 2.0 + 1.0 + 2.0);
  
  float zw = (width - height / 2.0) / (seatLength + 2.0);
  if(zw < size){
    size = zw;
  }
  
  
  xPos = (width - height / 2.0) / 2.0 - seatLength * size / 2.0;
  yPos = height / 2.0 - size / 2.0 - seatWidth * size;
  
  
}

float size;

float xPos, yPos;

void draw(){
  
  frame = (frameCount % speed) * 100.0 / speed;
  if(frameCount % speed < 1 && !stop){
    nextAnimation();
  }
  
  
  renderBgAndTxt();
  
  renderSeats();
  
  renderPassengers();
  
  
}

public void renderBgAndTxt(){
  image(bg, 0, 0, width, height);
  
  String txt = "step: " + steps + "." + (frame + "").split("\\.")[1];
  text(txt, textAscent(), 2.0 * textAscent());
}

public void renderSeats(){
  float yCurPos;
  float xCurPos = xPos;
  
  for(int x = 0; x < seatLength; x ++){
    yCurPos = yPos;
    for(int y = 0; y < seatWidth * 2 + 1; y ++){
      
      image(seat, xCurPos, yCurPos, size, size);
      
      yCurPos += size;
      if(y == seatWidth - 1){
        yCurPos += size;
        y ++;
        // ^ this is to skip the middle row
      }
      
    }
    xCurPos += size;
  }
  
}

public void renderPassengers(){
  for(int i = 0; i < passengers.length; i ++){
    passengers[i].render();
  }
  
  
}

public void nextAnimation(){
  steps ++;
  
  boolean sbStanding = false;
  
  for(int i = 0; i < passengers.length; i ++){
    if(!passengers[i].tryToMove()){
      sbStanding = true;
    }
  }
  
  if(!bestMovement){
    for(int i = 0; i < passengers.length; i ++){
      passengers[i].updateOldPos();
    }
  }
  
  if(!sbStanding){
    stop = true;
  }
  
}

// dont need that anymore I guess
public void println(Passenger[] in){
  print("[");
  String cur;
  for(int i = 0; i < in.length; i ++){
    cur = "1";
    if(in[i] == null){
      cur = "0";
    }
    if(i != in.length - 1){
      cur += ", ";
    }
    print(cur);
  }
  println("]");
}







