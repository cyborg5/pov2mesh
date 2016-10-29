#ifdef (has_camera) #local org_has_camera= has_camera;#end
#ifdef (has_lights) #local org_has_lights= has_lights;#end
#declare has_camera=0;

#macro Grid_Trace(Object,StartR,EndR,DeltaR,DirR,StartC,EndC,DeltaC,DirC,CamL,CamD,DotR)
   #local Norm=<0,0,0>;  
   #local R=StartR;
   #while(R<EndR)
      #local C=StartC;
      #while(C<EndC)
         #local Coord=R*DirR+C*DirC;
         #local Hit=trace(Object,CamL+Coord,CamD,Norm);
         #if(vlength(Norm))
            #debug concat(vstr(3, Hit, " ",0,6), "\n")
            #if(DotR)
               sphere{Hit,DotR}
            #end
         #end
         #local C=C+DeltaC;
      #end
      #local R=R+DeltaR;
   #end
#end

#macro Cyln_Trace(Object,StartR,EndR,DeltaR,DirR,StartH,EndH,DeltaH,DirH,CamL,CamD,DotR)
   #local Norm=<0,0,0>;
   #local H=StartH;
   #while(H<EndH)
      #local R=StartR;
      #while(R<EndR)          
         #local Hit=trace(Object,vrotate(CamL+H*DirH,R*DirR),vrotate(CamD,R*DirR),Norm);                       
         #if(vlength(Norm))
            #debug concat(vstr(3, Hit, " ",0,6), "\n")
            #if(DotR)
               sphere{Hit,DotR}
            #end
         #end
         #local R=R+DeltaR;
      #end 
      #local H=H+DeltaH;
   #end
#end

#macro All_Trace (Object,GridMin,GridMax,Deltas,DeltaAng,Dot)
  Grid_Trace(Object,GridMin.x,GridMax.x,Deltas,x,GridMin.y,GridMax.y,Deltas,y,GridMin*z,z,Dot) //front
  Grid_Trace(Object,GridMin.x,GridMax.x,Deltas,x,GridMin.y,GridMax.y,Deltas,y,GridMax*z,-z,Dot) //back 
  Grid_Trace(Object,GridMin.x,GridMax.x,Deltas,x,GridMin.z,GridMax.z,Deltas,z,GridMax*y,-y,Dot) //top
  Grid_Trace(Object,GridMin.x,GridMax.x,Deltas,x,GridMin.z,GridMax.z,Deltas,z,GridMin*y,y,Dot) //bottom
  Grid_Trace(Object,GridMin.z,GridMax.z,Deltas,z,GridMin.y,GridMax.y,Deltas,y,GridMin*x,x,Dot) //left
  Grid_Trace(Object,GridMin.z,GridMax.z,Deltas,z,GridMin.y,GridMax.y,Deltas,y,GridMax*x,-x,Dot) //right
  Cyln_Trace (Object,0,360,DeltaAng,y,GridMin.y,GridMax.y,Deltas,y,GridMax*x,-x,Dot) //outside in                 
  Cyln_Trace (Object,0,360,DeltaAng,y,GridMin.y,GridMax.y,Deltas,y,0,x,Dot) //inside out
  #if(Dot)
    cylinder{<GridMin.x,GridMax.y,GridMax.z>,<GridMax.x,GridMax.y,GridMax.z>,Dot}
    cylinder{<GridMin.x,GridMin.y,GridMax.z>,<GridMax.x,GridMin.y,GridMax.z>,Dot}
    cylinder{<GridMin.x,GridMin.y,GridMax.z>,<GridMin.x,GridMax.y,GridMax.z>,Dot}
    cylinder{<GridMax.x,GridMin.y,GridMax.z>,<GridMax.x,GridMax.y,GridMax.z>,Dot}
    cylinder{<GridMin.x,GridMax.y,GridMin.z>,<GridMax.x,GridMax.y,GridMin.z>,Dot}
    cylinder{<GridMin.x,GridMin.y,GridMin.z>,<GridMax.x,GridMin.y,GridMin.z>,Dot}
    cylinder{<GridMin.x,GridMin.y,GridMin.z>,<GridMin.x,GridMax.y,GridMin.z>,Dot}
    cylinder{<GridMax.x,GridMin.y,GridMin.z>,<GridMax.x,GridMax.y,GridMin.z>,Dot}
    cylinder{<GridMin.x,GridMin.y,GridMin.z>,<GridMin.x,GridMin.y,GridMax.z>,Dot}
    cylinder{<GridMax.x,GridMin.y,GridMin.z>,<GridMax.x,GridMin.y,GridMax.z>,Dot}
    cylinder{<GridMin.x,GridMax.y,GridMin.z>,<GridMin.x,GridMax.y,GridMax.z>,Dot}
    cylinder{<GridMax.x,GridMax.y,GridMin.z>,<GridMax.x,GridMax.y,GridMax.z>,Dot}
  #end
#end

#ifdef (org_has_camera)
#else

#macro Test_Scene ()    
#declare Things= 
   merge {
      torus {4,1}
      torus {4,1 rotate x*90}
      torus {4,1 rotate z*90}
      pigment {checker rgb<1,1,0>,rgb 1 scale 0.25}                               
      no_shadow
   }
   
object{Things}
union {
  All_Trace(Things,<-6,-6,-6>,<6,6,6>,0.2,2,0.05)
  no_shadow
  translate x*12
}

background {rgb 1}
/*
light_source {< 1000, 1000, -1000>, 0.6}
light_source {<-1000, 1000, -1000>, 0.6}
  */
#end
#declare has_lights=0;
#declare has_camera=0;
#declare test_cam_orthographic=0;
#declare test_cam_angle=15;
#declare test_cam_look=<6,0,0>;
#declare test_cam_loc=<40,40,-100>;
#include "test_platform.pov"
#end
#ifdef (org_has_camera) #declare has_camera=org_has_camera;#end
#ifdef (org_has_lights) #declare has_lights=org_has_lights;#end
