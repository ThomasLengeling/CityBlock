class Block {
  int posx;
  int posy;

  int tam;

  int id;
  int prevId;

  Block(int posx, int posy) {
    this.posx = posx;
    this.posy = posy;
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
  }

  void drawSelected() {
    fill(0, 200, 255, 150);
    rect(posx, posy, tam, tam);
  }

  void setBlockSize(int tam) {
    this.tam = tam;
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
}
