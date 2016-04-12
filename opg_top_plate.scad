cam_plate_mount_w = 24;
cam_plate_mount_bw = 45; // Back width
cam_plate_mount_l = 37;

arms = 6;
main_hole_r = 5;

arm_length = 30;
base_height = 10;

plate_width = 55+20;

center_hole_r = 14;

module main_holes(radius=main_hole_r){
    translate([0,0,base_height*.5]){
        for(ang = [0:360/arms:360]){
            rotate([0,0,ang])
                translate([arm_length,0,0])
                    cylinder(r=radius,h=base_height,center=true, $fn=64);
            
        }
        cylinder(r=center_hole_r,h=base_height,center=true, $fn=64);
    }
}

module main_plate(){
    translate([0,0,1])
        cylinder(r=plate_width*.5,2,center=true);
    translate([40,0,1])
        cylinder(r=plate_width*.5,2,center=true);
    translate([0,-plate_width*.5])
        cube([40,plate_width,2]);
}

module mount_holes(){
   translate([-cam_plate_mount_l*.5, cam_plate_mount_w*.5,0])
        cylinder(r=1.5,h=20,center=true, $fn=64);
   translate([-cam_plate_mount_l*.5, -cam_plate_mount_w*.5,0])
        cylinder(r=1.5,h=20,center=true, $fn=64);    
   translate([cam_plate_mount_l*.5, cam_plate_mount_bw*.5,0])
        cylinder(r=1.5,h=20,center=true, $fn=64);
   translate([cam_plate_mount_l*.5, -cam_plate_mount_bw*.5,0])
        cylinder(r=1.5,h=20,center=true, $fn=64);
    translate([45,0,0]){
       translate([cam_plate_mount_l*.5, cam_plate_mount_bw*.5,0])
            cylinder(r=1.5,h=20,center=true, $fn=64);
       translate([cam_plate_mount_l*.5, -cam_plate_mount_bw*.5,0])
            cylinder(r=1.5,h=20,center=true, $fn=64);
        
    }
}

difference(){
    main_plate();
    translate([0,0,-1])
        rotate([0,0,360/arms*.5])
            main_holes();
    mount_holes();
   
}
//main_holes();