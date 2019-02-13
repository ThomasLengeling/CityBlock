class Building extends Node {
  //position
  int bPosX;
  int bPosY;
  
  //unique id
  int id;
  
  //type id
  int typeId;

  
  //building 
  Building(String label, int blockSize, int posX, int posY) {
    super(label, blockSize, posX, posY);
    this.posX = posX;
    this.posY = posY;
  }

  //draw lego
  void drawLego() {
    int eTam = 2;

    //contour
    noStroke();
    fill(0);
    rect(posX, posY, blockSize, blockSize);
    
    //draw lego holes
    noFill();
    stroke(150);
    line(posX + blockSize/2.0, posY, posX + blockSize/2.0, posY + blockSize);
    line(posX, posY + blockSize/2.0, posX + blockSize, posY + blockSize/2.0); 

    ellipse(posX + blockSize/4.0, posY + blockSize/4.0, eTam, eTam);
    ellipse(posX + 3*(blockSize/4.0), posY + blockSize/4.0, eTam, eTam);

    ellipse(posX + (blockSize/4.0), posY + 3*(blockSize/4.0), eTam, eTam);
    ellipse(posX + 3*(blockSize/4.0), posY + 3*(blockSize/4.0), eTam, eTam);
  }
  
  
}
