

public class Passenger {
  
  int xSeat, ySeat;
  
  int x, y;
  
  int xOld, yOld;
  
  boolean seatWalking;
  
  int coffer;
  
  int skin;
  //PImage[] skin; // koffer, holdKoffer, lookOut, sitting
  
  public Passenger(int startX, int xS, int yS, int skin){
    this.xSeat = xS;
    this.ySeat = yS;
    this.skin = skin;
    
    xOld = x = startX;
    yOld = y = seatWidth;
    
    map[mapStart + x] = this;
    
    coffer = 2;
  }
  
  
  public void render(){
    // TODO frame
    float xR = xOld + frame * (x - xOld) / 100.0;
    if(seatWalking){
      xR -= seatWalkingDist;
    }
    float yR = yOld + frame * (y - yOld) / 100.0;
    image(skins[skin][0], xPos + xR * size, yPos + yR * size, size, size);
  }
  
  
  
  public boolean tryToMove(){
    
    xOld = x;
    yOld = y;
    
    if(x == xSeat && y == ySeat){
      return true;
    }
    
    
    if(x == xSeat){
      if(coffer > 0){
        // TODO coffer dann rein
        
        coffer --;
        return false;
      }
      
      seatWalking = y != ySeat;
      if(seatWalking){
        if(bestMovement && y == seatWidth){
          map[mapStart + x] = null;
        }
        int go = -1;
        if(ySeat >= seatWidth){
          go = 1;
        }
        
        y += go;
        
        
      }
      return false;
    }
    
    
    if(map[mapStart + x + 1] == null){
      if(bestMovement){
        map[mapStart + x] = null;
        
      }
      
      x ++;
      map[mapStart + x] = this;
      
    }
    
    return false;
  }
  
  public void updateOldPos(){
    if(xOld == x && yOld == y){
      return;
    }
    
    if(yOld != seatWidth){
      return;
    }
    
    map[mapStart + xOld] = null;
    
  }
  
  
}