void createSimpleGraph() {

  //Building
  streetGraph = new DirectedGraph();

  int startX = 100;
  int startY = 100;

  int stepX  = 100;
  int stepY  = 100;

  int blockS = 50;

  Building n1 = new Building("Node_0", blockS, startX, startY);
  Building n2 = new Building("Node_1", blockS, startX + stepX, startY);
  Building n3 = new Building("Node_2", blockS, startX, startY + stepY);
  Building n4 = new Building("Node_3", blockS, startX + stepX, startY + stepY);

  // add nodes to graph
  streetGraph.addNode(n1);
  streetGraph.addNode(n2);
  streetGraph.addNode(n3);
  streetGraph.addNode(n4);

  streetGraph.linkNodes(n1, n2);
  streetGraph.linkNodes(n3, n1);
  streetGraph.linkNodes(n2, n4);
  streetGraph.linkNodes(n4, n3);
}


void createGraph() {

  //Building
  streetGraph = new DirectedGraph();

  int startX = 230;
  int startY = 50;
  
  int stepX  = 75;
  int stepY  = 75;

  int blockS = 50;

  int dimX = 5;
  int dimY = 6;

  for (int i = 0; i < dimX; i++) {
    for (int j = 0; j < dimY; j++) {
      int posX = startX + stepX * j;
      int posY = startY + stepY * i;

      int index =  j + i * dimY;

      String label = "Node_"+ index;

      // add nodes to graph
      Building nodeB = new Building(label, blockS, posX, posY);
      streetGraph.addNode(nodeB);
    }
  }


  //down
  {
    //odds
    int counter = 0;
    for (int i = 0; i < dimX - 1; i++) {
      for (int j = 2; j < dimY; j++) {
        int indexA = j + i * dimY;
        int indexB = j + (i + 1) * dimY;

        Building nodeA = streetGraph.getNode(indexA);
        Building nodeB = streetGraph.getNode(indexB);
        if (counter % 2 == 0) {
          nodeA.setDir(1);
          streetGraph.linkNodes(nodeA, nodeB);
        }
        counter++;
      }
    }
    //even
    counter = 0;
    for (int i = 0; i < dimX - 1; i++) {
      for (int j = 0; j < dimY; j++) {
        int indexA = j + i * dimY;
        int indexB = j + (i + 1) * dimY;

        Building nodeA = streetGraph.getNode(indexA);
        Building nodeB = streetGraph.getNode(indexB);
        if (counter % 2 == 1) {
          nodeA.setDir(2);
          nodeB.setDir(4);
          streetGraph.linkNodes(nodeA, nodeB);
        }
        counter++;
      }
    }
  }

  //left
  { //right to left

    for (int i = 1; i < dimX; i++) {
      for (int j = 1; j < dimY; j++) {
        int indexA = j + i * dimY;
        int indexB = j + i * dimY - 1;
        Building nodeA = streetGraph.getNode(indexA);
        Building nodeB = streetGraph.getNode(indexB);
        streetGraph.linkNodes(nodeA, nodeB);
      }
    }
  }
  
    //left
  { //right to left

    for (int i = 1; i < dimX; i++) {
      for (int j = 0; j < 1; j++) {
        int indexA = j + i * dimY;
        int indexB = j + (i - 1) * dimY;
        Building nodeA = streetGraph.getNode(indexA);
        Building nodeB = streetGraph.getNode(indexB);
        streetGraph.linkNodes(nodeA, nodeB);
         nodeA.setDir(3);
      }
    }
  }




  {
    //top right
    int counter = 0;
    for (int i = 0; i < 1; i++) {
      for (int j = 0; j < dimY - 1; j++) {
        int indexA = j + i * dimY;
        int indexB = j + i * dimY + 1;

        Building nodeA = streetGraph.getNode(indexA);
        Building nodeB = streetGraph.getNode(indexB);

        nodeA.setDir(0);
        nodeB.setDir(0);
        streetGraph.linkNodes(nodeA, nodeB);
      }

      counter++;
    }
  }
}
