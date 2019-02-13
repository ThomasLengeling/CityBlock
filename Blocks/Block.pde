class Block {

  //corner position
  int posx;
  int posy;

  //center position
  int centerPosX;
  int centerPosY;

  //size of the block
  int tam = 10; //default size

  //unique id
  int id;

  //modfied type of block
  int typeId =-1;

  //selected
  boolean selected = false;

  color colorMap;

  Block(int posx, int posy) {
    this.posx = posx;
    this.posy = posy;

    //update center
    centerPosX = posx + int((float)tam/2.0);
    centerPosY = posy + int((float)tam/2.0);

    id = int(random(0, 4));

    colorMap = color(0);
  }

  void draw() {
    noStroke();
    fill(0);
    rect(posx, posy, tam, tam);
  }

  void lego() {
    stroke(200);
    noFill();
    int eTam = 2;
    stroke(150);
    line(posx + tam/2.0, posy, posx + tam/2.0, posy + tam);
    line(posx, posy + tam/2.0, posx + tam, posy + tam/2.0); 

    ellipse(posx + tam/4.0, posy + tam/4.0, eTam, eTam);
    ellipse(posx + 3*(tam/4.0), posy + tam/4.0, eTam, eTam);

    ellipse(posx + (tam/4.0), posy + 3*(tam/4.0), eTam, eTam);
    ellipse(posx + 3*(tam/4.0), posy + 3*(tam/4.0), eTam, eTam);
  }

  void drawContour() {
    noFill();
    stroke(255);
    rect(posx, posy, tam, tam);

    if (selected) {
      fill(255);
      rect(posx, posy, tam+1, tam+1);
    }

    if (typeId == 0) {
      fill(255, 100, 55, 150);
      rect(posx, posy, tam, tam);
    }
    if (typeId == 1) {
      fill(200, 0, 255, 150);
      rect(posx, posy, tam, tam);
    }

    if (typeId == 2) {
      fill(0, 200, 255, 150);
      rect(posx, posy, tam, tam);
    }

    if (typeId == 3) {
      fill(180, 150);
      rect(posx, posy, tam, tam);
    }

    if (typeId == 4) {
      fill(colorMap);
      rect(posx, posy, tam, tam);
    }
  }

  void setColorMap(color m) {
    colorMap = m;
  }

  int getCenterX() {
    return  centerPosX;
  }
  int getCenterY() {
    return centerPosY;
  }

  void enableSelected() {
    selected = true;
  }

  void disableSelection() {
    selected = false;
  }

  void setBlockSize(int tam) {
    this.tam = tam;

    //update center
    centerPosX = posx + int((float)tam/2.0);
    centerPosY = posy + int((float)tam/2.0);
  }

  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return id;
  }

  float getBlockSize() {
    return tam;
  }

  int getType() {
    return  typeId;
  }

  void setType(int type) {
    typeId = type;
  }
}
