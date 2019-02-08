

public void loadPics(){
  
  bg = loadImage("bg.png");
  seat = loadImage("seat.png");
  
}

public PImage[][] loadSkins(){
  PImage rV = loadImage("skin.png");
  
  return new PImage[][]{{rV}};
}

