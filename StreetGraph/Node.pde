/**
 * Simmple graph layout system
 * http://processingjs.nihongoresources.com/graphs
 * This code is in the public domain
 */

// This is a generic node in a graph
class Node
{
  ArrayList<Building> inlinks = new ArrayList<Building>();
  ArrayList<Building> outlinks = new ArrayList<Building>();

  String label;

  int blockSize;

  //corner
  int posX  = 0;
  int posY  = 0;

  //center
  int centPosX = 0;
  int centPosY = 0;

  int rad = 5;

  int id;

  int[] arrowhead = {0, -4, 0, 4, 7, 0};

  //direction type
  int dir = 0;


  PVector corners[];

  Node(String label, int blockSize, int posX, int posY) {
    this.label =label;
    this.blockSize = blockSize;
    this.id = -1;

    this.posX = posX;
    this.posY = posY;

    this.centPosX = int(posX + blockSize/2.0);//; + rad);
    this.centPosY = int(posY + blockSize/2.0);// + rad);

    corners = new  PVector[4];
    {
      float cornerX = posX;
      float cornerY = posY;
      corners[0] = new PVector(cornerX, cornerY);
    }

    {
      float cornerX = posX + blockSize;
      float cornerY = posY;
      corners[1] = new PVector(cornerX, cornerY);
    }

    {
      float cornerX = posX + blockSize;
      float cornerY = posY + blockSize;
      corners[2] = new PVector(cornerX, cornerY);
    }

    {
      float cornerX = posX;
      float cornerY = posY + blockSize;
      corners[3] = new PVector(cornerX, cornerY);
    }

    println("created Node "+ label);
  }

  void fillCorners() {
    {
      float cornerX = posX;
      float cornerY = posY;
      corners[0] = new PVector(cornerX, cornerY);
    }

    {
      float cornerX = posX + blockSize;
      float cornerY = posY;
      corners[1] = new PVector(cornerX, cornerY);
    }

    {
      float cornerX = posX + blockSize;
      float cornerY = posY + blockSize;
      corners[2] = new PVector(cornerX, cornerY);
    }

    {
      float cornerX = posX;
      float cornerY = posY + blockSize;
      corners[3] = new PVector(cornerX, cornerY);
    }
  }

  void setId(int i) {
    this.id = i;
  }

  int getId() {
    return id;
  }

  void setDir(int dir) {
    this.dir = dir;
  }

  void addIncomingLink(Building n) {
    if (!inlinks.contains(n)) {
      inlinks.add(n);
    }
  }

  ArrayList<Building> getIncomingLinks() {
    return inlinks;
  }

  int getIncomingLinksCount() {
    return inlinks.size();
  }

  void addOutgoingLink(Building n) {
    if (!outlinks.contains(n)) {
      outlinks.add(n);
    }
  }

  ArrayList<Building> getOutgoingLinks() {
    return outlinks;
  }

  int getOutgoingLinksCount() {
    return outlinks.size();
  }

  float getShortestLinkLength() {
    if (inlinks.size()==0 && outlinks.size()==0) { 
      return -1;
    }
    float l = 100;
    for (Node inode : inlinks) {
      int dx = inode.posX - posX;
      int dy = inode.posY - posY;
      float il = sqrt(dx*dx + dy*dy);
      if (il<l) { 
        l=il;
      }
    }
    for (Building onode : outlinks) {
      int dx = onode.posX - posX;
      int dy = onode.posX - posY;
      float ol = sqrt(dx*dx + dy*dy);
      if (ol<l) { 
        l=ol;
      }
    }
    return l;
  }

  boolean equals(Building other) {
    if (this==other) return true;
    return label.equals(other.label);
  }

  //corner Position
  void setPosition(int x, int y) {
    posX = x; 
    posY = y;

    //update the centerPosition
    this.centPosX = int(posX + blockSize/2.0);
    this.centPosY = int(posY + blockSize/2.0);

    fillCorners();
  }

  int getPosX() {
    return posX;
  }

  int getPosY() {
    return posY;
  }

  //center position

  int getCenterX() {
    return centPosX;
  }

  int getCenterY() {
    return centPosY;
  }

  //sent Rad, for visualization of the Graph 
  void setRadi(int rad) {
    this.rad = rad;
  }

  void setBlockSize(int tam) {
    blockSize = tam;
  }

  //draw Node
  void draw() {

    stroke(0);
    fill(255);

    for (Node o : outlinks) {
      drawArrow(centPosX, centPosY, o.centPosX, o.centPosY);
    }

    ellipse(centPosX, centPosY, rad * 2, rad * 2);
    fill(255);

    text(label+" - "+id+" "+dir, posX - rad * 2, posY + rad * 2);
  }

  //draw connected Block
  void drawBlock() {

    //drawPath
    stroke(255);
    fill(0, 150, 200);
    for (Node o : outlinks) {
      int px = int(posX);
      int py = int(posY);

      int dx = (o.posX - px);
      int dy = (o.posY - py);

      float angle = getDirection(dx, dy);
      float vl    = sqrt(dx * dx + dy * dy) - (blockSize);
      int[] end   = rotateCoordinate(vl, 0, angle);

      rect(posX + end[0], posY + end[1], blockSize, blockSize);
    }
  }

  //draw connected Block
  void drawNextBlock() {

    //drawPath
    stroke(255);
    fill(0, 150, 200);
    for (Node o : outlinks) {
      int px = int(centPosX);
      int py = int(centPosY);

      int dx = (o.centPosX - px);
      int dy = (o.centPosY - py);

      float angle = getDirection(dx, dy);
      float vl    = sqrt(dx * dx + dy * dy) - blockSize;
      int[] end   = rotateCoordinate(vl, 0, angle);

      // rect(posX + end[0], posY + end[1], blockSize, blockSize);

      float angle0 = map(end[0], -50.0, 50.0, 0, 255);
      float angle1 = map(end[1], -50.0, 50.0, 0, 255);

      //fill(0, angle0, angle1);
      //ellipse(centPosX + end[0], centPosY + end[1], 20, 20);

      if ((dir ==3 && o.dir == 3) || (dir ==3 && o.dir == 0) ) {
        beginShape();
        vertex(corners[0].x, corners[0].y);
        vertex(corners[1].x, corners[1].y);

        vertex(o.corners[2].x, o.corners[2].y);
        vertex(o.corners[3].x, o.corners[3].y);

        endShape();
      }

      if ((dir == 2 && o.dir == 2) || (dir == 2 && o.dir ==0) || (dir == 0 && o.dir == 2) || (dir ==0 && o.dir==1) || (dir ==1 && o.dir==1) || (dir ==1 && o.dir==0) || (dir == 2 && o.dir == 4) ) {
        beginShape();
        vertex(corners[2].x, corners[2].y);
        vertex(corners[3].x, corners[3].y);

        vertex(o.corners[0].x, o.corners[0].y);
        vertex(o.corners[1].x, o.corners[1].y);

        endShape();
      }

      //up fist
      if ((dir == 0 && o.dir == 0)) {
        beginShape();
        vertex(corners[1].x, corners[1].y);
        vertex(corners[2].x, corners[2].y);

        vertex(o.corners[3].x, o.corners[3].y);
        vertex(o.corners[0].x, o.corners[0].y);

        endShape();
      }

      //down last
      if ((dir == 4 && o.dir == 3) || (dir == 0 && o.dir == 4)||(dir == 4 && o.dir == 0)) {
        beginShape();
        vertex(corners[0].x, corners[0].y);
        vertex(corners[3].x, corners[3].y);

        vertex(o.corners[2].x, o.corners[2].y);
        vertex(o.corners[1].x, o.corners[1].y);

        endShape();
      }

      //
      //right to left
      if ((dir == 2 && o.dir == 3) || (dir == 1 && o.dir == 2) || (dir == 2 && o.dir == 1)) {
        beginShape();
        vertex(corners[0].x, corners[0].y);
        vertex(corners[3].x, corners[3].y);

        vertex(o.corners[2].x, o.corners[2].y);
        vertex(o.corners[1].x, o.corners[1].y);

        endShape();
      }
    }

    // drawCorners();
  }

  void drawCorners() {
    noStroke();
    fill(0, 100, 100);
    beginShape();
    for (PVector cor : corners) {
      vertex(cor.x, cor.y);
    }
    endShape();
  }

  //draw Arrow
  void drawArrow(int x, int y, int ox, int oy) {
    int dx = ox - x;
    int dy = oy - y;
    float angle = getDirection(dx, dy);
    float vl = sqrt(dx * dx + dy * dy) - sqrt(rad*rad*2)*1.5;
    int[] end = rotateCoordinate(vl, 0, angle);
    line(x, y, x+end[0], y+end[1]);
    drawArrowHead(x + end[0], y + end[1], angle);
  }

  void drawArrowHead(int ox, int oy, float angle) {
    int[] rc1 = rotateCoordinate(arrowhead[0], arrowhead[1], angle);
    int[] rc2 = rotateCoordinate(arrowhead[2], arrowhead[3], angle);
    int[] rc3 = rotateCoordinate(arrowhead[4], arrowhead[5], angle);
    int[] narrow = {ox+ rc1[0], oy+ rc1[1], ox+ rc2[0], oy+ rc2[1], ox+ rc3[0], oy+ rc3[1]};
    stroke(0);
    fill(255);
    triangle(narrow[0], narrow[1], narrow[2], narrow[3], narrow[4], narrow[5]);
  }
}
