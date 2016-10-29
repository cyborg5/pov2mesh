/*Generic scene for testing objects. Defined the standard camera and some lighting conditions
  You can declare any of these parameters listed below to change the defaults.
 */
#ifndef (has_camera)
  #declare  has_camera=0;
#end
#ifndef (cam_right)
  #declare cam_right=x*4/3;
#end
#ifndef (has_lights)
  #declare  has_lights=0;
#end
#ifndef (test_cam_loc)          
  #declare test_cam_loc=<0,0, -120>;
#end
#ifndef (test_cam_look)
  #declare test_cam_look=<0,0,0>;
#end
#ifndef (test_cam_angle)
  #declare test_cam_angle=30;
#end
#ifndef (test_cam_orthographic)
  #declare test_cam_orthographic=0;
#end
#ifndef (test_lights_shadowless)
  #declare test_lights_shadowless=1;
#end
#if (has_camera)
  #else
  camera{#if (test_cam_orthographic) orthographic #end location test_cam_loc right cam_right look_at test_cam_look angle test_cam_angle }
  #declare has_camera=1;          
  #ifdef (Test_Scene)
     Test_Scene ()
  #end
  #undef Test_Scene 
#end
#if (has_lights)
  #else
  light_source{<400,500,-400>*3 color 0.8 #if(test_lights_shadowless)shadowless#end}
  light_source{<-400,50,-400>*3 color 0.8 #if(test_lights_shadowless)shadowless#end}
  #declare has_lights=1;
#end
