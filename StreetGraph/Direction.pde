// =============================================
//      Some universal helper functions
// =============================================

/**
 * Simmple graph layout system
 * http://processingjs.nihongoresources.com/graphs
 * This code is in the public domain
 */

// this is the interface for graph reflowing algorithms
interface FlowAlgorithm {
  // returns "true" if done, or "false" if not done
  boolean reflow(DirectedGraph g);
}

/**
 * Simmple graph layout system
 * http://processingjs.nihongoresources.com/graphs
 * This code is in the public domain
 */

/**
 * Flow algorithm for drawing nodes in a circle
 */
class CircleFlowAlgorithm implements FlowAlgorithm
{
  // draw all nodes in a big circle,
  // without trying to find the best
  // arrangement possible.

  boolean reflow(DirectedGraph g)
  {
    float interval = 2*PI / (float)g.size();
    int cx = width/2;
    int cy = height/2;
    float vl = cx - (2*g.getNode(0).rad) - 10;
    for(int a=0; a<g.size(); a++)
    {
      int[] nc = rotateCoordinate(vl, 0, (float)a*interval);
      g.getNode(a).posX = cx+nc[0];
      g.getNode(a).posY = cy+nc[1];
    }
    return true;
  }
}

// universal helper function: get the angle (in radians) for a particular dx/dy
float getDirection(double dx, double dy) {
  // quadrant offsets
  double d1 = 0.0;
  double d2 = PI/2.0;
  double d3 = PI;
  double d4 = 3.0*PI/2.0;
  // compute angle basd on dx and dy values
  double angle = 0;
  float adx = abs((float)dx);
  float ady = abs((float)dy);
  // Vertical lines are one of two angles
  if (dx==0) { 
    angle = (dy>=0? d2 : d4);
  }
  // Horizontal lines are also one of two angles
  else if (dy==0) { 
    angle = (dx>=0? d1 : d3);
  }
  // The rest requires trigonometry (note: two use dx/dy and two use dy/dx!)
  else if (dx>0 && dy>0) { 
    angle = d1 + atan(ady/adx);
  }    // direction: X+, Y+
  else if (dx<0 && dy>0) { 
    angle = d2 + atan(adx/ady);
  }    // direction: X-, Y+
  else if (dx<0 && dy<0) { 
    angle = d3 + atan(ady/adx);
  }    // direction: X-, Y-
  else if (dx>0 && dy<0) { 
    angle = d4 + atan(adx/ady);
  }    // direction: X+, Y-
  // return directionality in positive radians
  return (float)(angle + 2*PI)%(2*PI);
}

// universal helper function: rotate a coordinate over (0,0) by [angle] radians
int[] rotateCoordinate(float x, float y, float angle) {
  int[] rc = {0, 0};
  rc[0] = (int)(x*cos(angle) - y*sin(angle));
  rc[1] = (int)(x*sin(angle) + y*cos(angle));
  return rc;
}

// universal helper function for Processing.js - 1.1 does not support ArrayList.addAll yet
void addAll(ArrayList a, ArrayList b) { 
  for (Object o : b) { 
    a.add(o);
  }
}
