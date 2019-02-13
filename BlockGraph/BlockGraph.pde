import controlP5.*;

ControlP5 cp5;

Accordion accordionGrid;

void setup() {
  size(1000, 600);
  smooth(8);

  makeGraph();

  cp5 = new ControlP5(this);

  // group number 1, contains 2 bangs
  Group g1 = cp5.addGroup("Gird")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150);

  cp5.addSlider("road_0")
    .setPosition(10, 10)
    .setSize(125, 15)
    .setRange(-49, 49)
    .setGroup(g1)
    ;

  cp5.addSlider("road_1")
    .setPosition(10, 50)
    .setSize(125, 15)
    .setRange(0, 3)
    .setGroup(g1)
    .setNumberOfTickMarks(4)
    ;

  accordionGrid = cp5.addAccordion("Master")
    .setPosition(10, 10)
    .setWidth(230)
    .addItem(g1);

  accordionGrid.open(0, 1, 2);
  accordionGrid.setCollapseMode(Accordion.MULTI);
}

void draw() {
  background(255);

  streetGraph.draw();
}

void road_0(float a){
  println("road_0 "+a);
  
  stepMid =int(a);
  makeGraph();
}
