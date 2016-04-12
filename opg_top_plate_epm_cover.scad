cam_plate_mount_w = 24;
cam_plate_mount_bw = 45; // Back width
cam_plate_mount_l = 37;

slot_gap = 47.8; // (40-3.1*2) * sqrt(2)


standoff_height = 15;

plate_width = 55;

slot_width = 3.2;
plate_thick = 3.5;

outer_hull_thick = 1;    

module standoff(){
    difference(){
        cylinder(r=4.5,h=standoff_height, $fn=32);
        translate([0,0,-1])
            cylinder(r=2,h=standoff_height+2, $fn=64);
    }
}
module standoffs(){
    translate([-cam_plate_mount_l*.5,-cam_plate_mount_w*.5,0])
        standoff();
    translate([-cam_plate_mount_l*.5,cam_plate_mount_w*.5,0])
        standoff();
    translate([cam_plate_mount_l*.5,cam_plate_mount_bw*.5,0])
        standoff();
    translate([cam_plate_mount_l*.5,-cam_plate_mount_bw*.5,0])
        standoff();
    translate([0,0,plate_thick]){
        translate([cam_plate_mount_l*.5,cam_plate_mount_bw*.5,0])
            standoff();
        translate([cam_plate_mount_l*.5,-cam_plate_mount_bw*.5,0])
            standoff();
    }
    
    translate([45,0,0]){
        translate([cam_plate_mount_l*.5,cam_plate_mount_bw*.5,0])
            standoff();
        translate([cam_plate_mount_l*.5,-cam_plate_mount_bw*.5,0])
            standoff();
    }
}
module plate(){
    translate([0,0,standoff_height]){
        difference(){
            union(){
                translate([-21-4+25,-plate_width*.5,0])
                    cube([93-25,plate_width,plate_thick]);
                translate([-21-4+30-5,0,plate_thick*.5])
                    cylinder(r=plate_width*.5,h=plate_thick,center=true);
            }
            union(){
                translate([-10+30,-slot_gap*.5-slot_width*.5,-1])
                    cube([35,slot_width,plate_thick+2]);
                translate([-10+30,slot_gap*.5-slot_width*.5,-1])
                    cube([35,slot_width,plate_thick+2]);
                translate([-20,-slot_width*.5,-1])
                    cube([80,slot_width,plate_thick+2]);
                
                translate([-cam_plate_mount_l*.5,-cam_plate_mount_w*.5,-1])
                    cylinder(r=2,h=plate_thick+2,$fn=64);
                translate([-cam_plate_mount_l*.5,cam_plate_mount_w*.5,-1])
                    cylinder(r=2,h=plate_thick+2,$fn=64);
                translate([cam_plate_mount_l*.5,cam_plate_mount_bw*.5,-1])
                    cylinder(r=2,h=plate_thick+2,$fn=64);
                translate([cam_plate_mount_l*.5,-cam_plate_mount_bw*.5,-1])
                    cylinder(r=2,h=plate_thick+2,$fn=64);
                translate([45,0,0]){
                    translate([cam_plate_mount_l*.5,cam_plate_mount_bw*.5,-1])
                        cylinder(r=2,h=plate_thick+2,$fn=64);
                    translate([cam_plate_mount_l*.5,-cam_plate_mount_bw*.5,-1])
                        cylinder(r=2,h=plate_thick+2,$fn=64);
                    
                }
                
                translate([59,20,-1])
                    cylinder(r=1.5,h=plate_thick+2,$fn=64);
                translate([59,10,-1])
                    cylinder(r=1.5,h=plate_thick+2,$fn=64);
                translate([59,-20,-1])
                    cylinder(r=1.5,h=plate_thick+2,$fn=64);
                translate([59,-10,-1])
                    cylinder(r=1.5,h=plate_thick+2,$fn=64);
            }
        }
    }
}

module outer_hull(){
    translate([0,0,standoff_height*.5])
    difference(){
        cylinder(r=plate_width*.5,h=standoff_height,center=true);
        cylinder(r=plate_width*.5-outer_hull_thick,h=standoff_height+1,center=true);
        translate([0,-500,-15])
            cube([1000,1000,30]);
    }
    translate([0,plate_width*.5-outer_hull_thick,0])
        cube([68,outer_hull_thick,standoff_height]);
    translate([0,-plate_width*.5,0])
        cube([68,outer_hull_thick,standoff_height]);    
}

module mouse_ears(){
    translate([0,0,standoff_height+plate_thick-0.15]){
        translate([68,plate_width*.5,0.15*.5])
         cylinder(r=5, h=0.15,center=true);
        translate([68,-plate_width*.5,0.15*.5])
         cylinder(r=5, h=0.15,center=true);
    }
}


standoffs();
plate();
outer_hull();
mouse_ears();