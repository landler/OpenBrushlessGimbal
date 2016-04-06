/*translate([0,40,0])
    translate([-38.7,-30.2,0])
        import("GoPro3Box.STL", convexity=3);*/
    
    
base_plate_height = 2.5;
motor_hole_r = 1.5;
    
imu_size = [23+3, 16+3, 9];    

gopro_cg = [30.03,6.96,0];  // https://gopro.com/support/articles/hero3-faqs
    
function select_dist(ang,r1,r2)=
    (ang%180==0) ?r1:r2;
;
module motor_holes(r1,r2){
    for(ang = [0:90:360]){
        rotate([0,0,ang])
            translate([select_dist(ang,r1,r2),0,0])
                cylinder(r=motor_hole_r,h=base_plate_height*2,center=true,$fn=64);
    }
    cylinder(r=2.5,h=base_plate_height*2,center=true,$fn=64);
}
    
    
module base_plate(){
    difference(){
        translate([0,0,base_plate_height*.5])
            cube([45,25,base_plate_height],center=true);
        
        translate([0,-25*.5+gopro_cg[1],0]){
            rotate([0,0,0]){
                translate([0,0,-base_plate_height*.5])
                    cylinder(r=2.5,h=base_plate_height*2,$fn=64);
                
                translate([0,0,.1])
                    motor_holes(12*.5,12*.5);
            }
        }
    }
}

edge_size= [45,25,60];

module gopro_edges(){
    translate([-edge_size[0]*.5,-edge_size[1]*.5,base_plate_height]){
        difference(){
            cube(edge_size);
            translate([0.5,0.5,-0.1])
                cube(edge_size + [0,0,1]);
            translate([-0.1,-0.1,10])
                cube(edge_size - [3,3,-1]);

        }
    }
}

module rounded_edges(){
    difference(){
        minkowski(){
            gopro_edges();
            sphere(r=1,$fn=64);
        }
        translate([-edge_size[0]*.5,-edge_size[1]*.5,base_plate_height]){
            translate([edge_size[0],0,0])
                cube(edge_size);
            translate([0,edge_size[1],0])
                cube(edge_size);
        }

    }
    
}
module outer_plates(){
    translate([-edge_size[0]*.5,-edge_size[1]*.5,base_plate_height]){
        difference(){
            cube(edge_size);
            translate([-2,-2,-0.1])
                cube(edge_size+[0,0,0.2]);
            translate([17,0,0.3])
                cube([10,27,5]);
            translate([6,0,55.2])
                cube([30,37,5]);
        }
    }
}


module standoffs(){
    translate([-42*.5,-22*.5,base_plate_height])
        cube([3,3,3]);
    translate([42*.5-3,-22*.5,base_plate_height])
        cube([3,3,3]);
    translate([42*.5-3,22*.5-3,base_plate_height])
        cube([3,3,3]);
    translate([-42*.5,22*.5-3,base_plate_height])
        cube([3,3,3]);
    translate([0,9.7,0])
        cube([1.2,0.8,56]);
    translate([19.7,-0.6,0])
        cube([0.8,1.2,56]);
}

module imu_holder(){
    
    translate([0,17,30])
    rotate([90,0,0])
    difference(){
        translate([0,0,15])
        rotate([90,0,90])
        cylinder(r=20,h=35,center=true, $fn=64);
        scale([1.1,1.1,1.1])
            cube(imu_size,center=true);
        scale([1.0,1.0,1.5])
            cube(imu_size,center=true);
        scale([0.7,3.0,1.5])
            cube(imu_size,center=true);
        scale([3.0,0.7,1.5])
            cube(imu_size,center=true);
        translate([-500-imu_size[0]*.5,-500,imu_size[2]*.5])
            cube([1000,1000,1000]);
    }
    
}

/*translate([0,0,31])
    cube([42,22,60],center=true);*/
    

base_plate();
rounded_edges();
outer_plates();
standoffs();
imu_holder();