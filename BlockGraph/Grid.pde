class Grid {
  ArrayList<Block> grid;
  ArrayList<Road> road;

  int gridX;
  int gridY;

  int startPosX;
  int startPosY;

  int endPosX;
  int endPosY;

  int blockSize = 20;

  //roads
  int stepX = 10;
  int stepY = 10;


  //draw roads
  boolean drawRoads = false;

  //current
  Block currentBlock;

  //build grid
  Grid(int startPosX, int startPosY, int gridX, int gridY) {
    this.gridX = gridX;
    this.gridY = gridY;

    this.startPosX = startPosX;
    this.startPosY = startPosY;

    this.endPosX = gridX * blockSize + stepX * (gridX - 1); 
    this.endPosY = gridY * blockSize + stepY * (gridY - 1);

    grid = new ArrayList<Block>();
    road = new ArrayList<Road>();
    createGrid();
  }

  void draw() {
    for (Block bl : grid) {
      bl.draw();
      if (currentBlock != null) {
        if (bl.getId() == currentBlock.getId()) {
          bl.drawSelected();
        }
      }
      bl.lego();
      bl.drawContour();
    }

    //
    if (drawRoads) {
      for (Road rd : road) {
        rd.draw();
      }
    }
  }

  void drawLines() {
  }

  void drawContour() {
    noFill();
    stroke(255);
    strokeWeight(1.5);
    rect(startPosX, startPosY, endPosX, endPosY);

    strokeWeight(1);
  }

  //draw road
  void drawRoad() {
  }

  //create grid
  void createGrid() {

    grid.clear();
    road.clear();

    //fill grid
    for (int i = 0; i < gridX; i++) {
      for (int j = 0; j < gridY; j++) {
        int posx = startPosX + blockSize * i + stepX * i;
        int posy = startPosY + blockSize * j + stepY * j;
        Block block  = new Block(posx, posy);
        block.setBlockSize(blockSize);
        block.setId(j + i * gridY);
        grid.add(block);
      }
    }

    //Roads

    for (int i = 0; i < gridX; i++) {
      for (int j = 0; j < gridY; j++) {
        int posx = startPosX + blockSize * i + stepX * i + blockSize;
        int posy = startPosY + blockSize * j + stepY * j;

        int lengthX = 10;
        int lengthY = 20;

        Road rd  = new Road(posx, posy, lengthX, lengthY);
        road.add(rd);
      }
    }
  }

  /*
  Values
   */
  void setGridDim(float  [] dim) {
    gridX = int(dim[0]);
    gridY = int(dim[1]);

    endPosX = gridX * blockSize + stepX * (gridX - 1); 
    endPosY = gridY * blockSize + stepY * (gridY - 1);

    createGrid();
  }

  void setSetSpace(float [] space) {

    stepX = int(space[0]);
    stepY = int(space[1]);

    endPosX = gridX * blockSize + stepX * (gridX - 1); 
    endPosY = gridY * blockSize + stepY * (gridY - 1);

    createGrid();
  }

  Block getCurrenBlock(int posx, int posy) {
    for (Block bl : grid) {
      float ds = dist(posx, posy, bl.posx, bl.posy);
      if (ds < blockSize) {
        currentBlock = bl;
        return bl;
      }
    }

    return null;
  }
}
