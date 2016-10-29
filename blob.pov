#declare test_cam_loc=<20,20,-50>;
#include "test_platform.pov"
#include "pov2mesh.pov"
#declare Strength = 1.0;
#declare Radius1  = 1.0;

#declare My_Object=
   blob{
     threshold 0.6
     sphere{< 0.75,  0,   0>, Radius1, Strength scale <1,1,0.5>}
     sphere{<-0.375, 0.65,0>, Radius1, Strength}
     sphere{<-0.375,-0.65,0>, Radius1, Strength}
     scale 5
     pigment{rgb<1,0,0>}
   }

object {My_Object}
All_Trace(My_Object,<-6,-6,-6>,<6,6,6>,0.2,2,0.05)
background {rgb 1}

