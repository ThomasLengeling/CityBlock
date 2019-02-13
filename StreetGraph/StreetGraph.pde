import controlP5.*;

ControlP5 cp5;

Accordion accordionGrid;

DirectedGraph streetGraph = null;

boolean drawGraph = false;
boolean drawLego = true;
boolean drawNextBlock = false;

float  vAngle =0;

void setup() {
  size(1000, 600);
  smooth(8);

  //create graph
  createGraph();

  cp5 = new ControlP5(this);

  // group number 1, contains 2 bangs
  Group g1 = cp5.addGroup("Gird")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150);

  cp5.addSlider("vAngle")
    .setPosition(10, 10)
    .setSize(125, 15)
    .setRange(-200, 200)
    .setValue(47.5)
    .setGroup(g1)
    ;

  cp5.addSlider("")
    .setPosition(10, 50)
    .setSize(125, 15)
    .setRange(0, 3)
    .setGroup(g1)
    .setNumberOfTickMarks(4)
    ;

  accordionGrid = cp5.addAccordion("Master")
    .setPosition(10, 10)
    .setWidth(200)
    .addItem(g1);

  accordionGrid.open(0, 1, 2);
  accordionGrid.setCollapseMode(Accordion.MULTI);
}

void draw() {
  background(200);



  if (drawLego) {
    streetGraph.drawLego();
  }

  if (drawGraph) {
    streetGraph.drawGraph();
  }
  
  if(drawNextBlock){
   streetGraph.drawNextBlock(); 
  }


  println(streetGraph.getClosestNode(mouseX, mouseY).getId());
}

void keyPressed() {
  if (key == 'a') {
    drawGraph = !drawGraph;
  }

  if ( key == 's') {
    drawLego = !drawLego;
  }
  
  if(key == 'd'){
   drawNextBlock = !drawNextBlock; 
  }
}


void mouseDragged() {

  Building node = streetGraph.getClosestNode(mouseX, mouseY);
  node.setPosition(mouseX -25, mouseY-25);
  //find node depending on the mouse
}

void vAngle(float a) {

  vAngle = a;
}
