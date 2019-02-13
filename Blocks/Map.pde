class Map{
  PImage img;
  
  Map(){
    img = loadImage("map.jpg");
  }
  
  void draw(int x, int y, int w, int h){
    tint(255, 120);
    image(img, x, y, w, h);
  }
  
  PImage getImg(){
    return img;
  }
  
  //get the pixels
  
  
  
  
}
