DirectedGraph streetGraph = null;

int stepMid =50;
int stepUp;

void makeGraph() {
  streetGraph = new DirectedGraph();

  int startX = 400;
  int startY = 200;
  int stepX  = 100;
  int stepY  = 100;


  Node n1 = new Node("block 1", startX, startY);
  Node n2 = new Node("block 2", startX + stepX, startY);
  Node n3 = new Node("block 3", startX, startY + stepY);
  Node n4 = new Node("block 4", startX + stepX, startY + stepY);

  //5, 6 
  Node n5 = new Node("block 5", startX, startY - stepY);
  Node n6 = new Node("block 6", startX + stepX, startY - stepY);

  //7, 8
  Node n7 = new Node("block 7", startX - stepX, startY);
  Node n8 = new Node("block 8", startX + stepX*2 + stepMid, startY);

  //9, 10 
  Node n9 = new Node("block 9", startX - stepX, startY + stepY);
  Node n10 = new Node("block 10", startX + stepX*2+ stepMid, startY + stepY);

  //11, 12
  Node n11 = new Node("block 11", startX, startY + stepY*2 + stepMid);
  Node n12 = new Node("block 12", startX + stepX, startY + stepY*2 + stepMid);

  if (stepMid>0) {
    n1.setBlockSize(50+stepMid);
    n2.setBlockSize(50+stepMid);
    n3.setBlockSize(50+stepMid);
    n4.setBlockSize(50+stepMid);
  }

  // add nodes to graph
  streetGraph.addNode(n1);
  streetGraph.addNode(n2);
  streetGraph.addNode(n3);
  streetGraph.addNode(n4);
  streetGraph.addNode(n5);
  streetGraph.addNode(n6);
  streetGraph.addNode(n7);
  streetGraph.addNode(n8);
  streetGraph.addNode(n9);
  streetGraph.addNode(n10);
  streetGraph.addNode(n11);
  streetGraph.addNode(n12);

  //graph1
  streetGraph.linkNodes(n1, n2);
  streetGraph.linkNodes(n1, n3);
  streetGraph.linkNodes(n1, n5);
  streetGraph.linkNodes(n1, n7);

  //graph2
  streetGraph.linkNodes(n2, n6);
  streetGraph.linkNodes(n2, n8);
  streetGraph.linkNodes(n2, n4);

  //graph3
  streetGraph.linkNodes(n3, n9);
  streetGraph.linkNodes(n3, n4);
  streetGraph.linkNodes(n3, n11);

  //graph4
  streetGraph.linkNodes(n4, n10);
  streetGraph.linkNodes(n4, n12);

  //graph5
  //streetGraph.linkNodes(n5, n1);
  streetGraph.linkNodes(n5, n6);

  //graph7
  streetGraph.linkNodes(n7, n9);

  //graph8
  streetGraph.linkNodes(n8, n10);

  //graph11
  streetGraph.linkNodes(n11, n12);
}
