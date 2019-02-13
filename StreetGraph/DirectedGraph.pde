/**
 * Simmple graph layout system
 * http://processingjs.nihongoresources.com/graphs
 * This code is in the public domain
 */

// this class models a directed graph, consisting of any number of nodes
class DirectedGraph {

  ArrayList<Building> nodes = new ArrayList<Building>();
  FlowAlgorithm flower = new CircleFlowAlgorithm();

  int id = 0;

  void setFlowAlgorithm(FlowAlgorithm f) {
    flower = f;
  }

  void addNode(Building node) {
    if (!nodes.contains(node)) {
      node.setId(nodes.size());
      println("add "+node.getId());
      nodes.add(node);
    }
  }

  int size() { 
    return nodes.size();
  }

  boolean linkNodes(Building n1, Building n2) {
    if (nodes.contains(n1) && nodes.contains(n2)) {
      n1.addOutgoingLink(n2);
      n2.addIncomingLink(n1);
      return true;
    }
    println("connot connect");
    return false;
  }

  Building getNode(int index) {
    return nodes.get(index);
  }

  Building getNode(String label) {
    //find the string with the index
    boolean found;
    int index = -1;
    for (Building n : nodes) {
      if (n.label.equals(label)) {
        found = true;
        index = n.getId();
      }
    }
    if (index != -1) {
      return nodes.get(index);
    }

    return nodes.get(0);
  }

  //get the closest node
  Building getClosestNode(float posX, float posY) {
    int index = -1;
    Building node = new Building("null", 30, 0, 0);
    for (Building n : nodes) {
      float dis = dist(posX, posY, n.getCenterX(), n.getCenterY());
      if (dis  > 2 && dis < 28) {
        index = n.getId();
        println(index);
        return nodes.get(index);
      }
    }

    return node;
  }

  //build Node
  ArrayList<Building> getNodes() {
    return nodes;
  }

  ArrayList<Building> getRoots() {
    ArrayList<Building> roots = new ArrayList<Building>();
    for (Building n : nodes) {
      if (n.getIncomingLinksCount()==0) {
        roots.add(n);
      }
    }
    return roots;
  }

  ArrayList<Building> getLeaves() {
    ArrayList<Building> leaves = new ArrayList<Building>();
    for (Building n : nodes) {
      if (n.getOutgoingLinksCount()==0) {
        leaves.add(n);
      }
    }
    return leaves;
  }

  // the method most people will care about
  boolean reflow() { 
    return flower.reflow(this);
  }

  // this does nothing other than tell nodes to draw themselves.
  void drawGraph() {
    for (Building n : nodes) {
      n.draw();
    }
  }

  void drawNextBlock(){
    for (Building n : nodes) {
      n.drawNextBlock();
    }
  }

  //draw lego
  void drawLego() {
    for (Building n : nodes) {
      n.drawLego();
    }
  }
}
