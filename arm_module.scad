plate_r = 35*.5;
plate_thick=4;
motor_hole_dist=16*.5;
motor_hole_r=1.5;

motor_z_size=10;

/*total_z_translation = 52;
total_x_translation = -44;*/

function select_dist(ang,r1,r2)=
    (ang%180==0) ?r1:r2;
;
module motor_holes(r1,r2){
    for(ang = [0:90:360]){
        rotate([0,0,ang])
            translate([select_dist(ang,r1,r2),0,0])
                cylinder(r=motor_hole_r,h=plate_thick*2,center=true,$fn=64);
    }
    cylinder(r=3,h=plate_thick*2,center=true,$fn=64);
}
module motor_plate(r1=motor_hole_dist,r2=motor_hole_dist){
    difference(){
        cylinder(r=plate_r,h=plate_thick,center=true,$fn=64);
        motor_holes(r1,r2);
    }
}
module main_arm(total_z_translation,total_x_translation,no_second=true){
    $fn=64;
        minkowski(){
            difference(){
                union(){
                    translate([-10-4.3+total_x_translation,-6,21])
                            rotate([0,55,0])
                                cube([25,12,12]);
                    translate([-10-4.5+total_x_translation,-6,20.5])
                        cube([12,12,total_z_translation-5]);
                    translate([total_x_translation,-5,2-plate_thick*.5]){
                            cube([18,10,10]);
                            }
                }
                union(){
                    /*if(total_z_translation>60){
                    translate([total_x_translation-8,0,35])
                        rotate([0,90,0])
                            slot(rad=1.5+2);
                    }*/
                }
            }
            sphere(r=2);
        }
}
module arm(total_z_translation = 75, total_x_translation = -40){
    difference(){
        union(){
            hull(){
                translate([0,0,motor_z_size])
                    cylinder(r=plate_r,h=plate_thick,center=true,$fn=64);
                difference(){
                    main_arm(total_z_translation, total_x_translation);
                    translate([0,0,500+13])
                        cube([1000,1000,1000],center=true);
                }
            }
            hull(){
                translate([total_x_translation,0,total_z_translation])
                    rotate([0,90,0])
                        cylinder(r=plate_r,h=plate_thick,center=true,$fn=64);
                difference(){
                    main_arm(total_z_translation, total_x_translation);
                    translate([0,0,-500+total_z_translation-plate_r-10])
                        cube([1000,1000,1000],center=true);
                }
            }
            main_arm(total_z_translation, total_x_translation);
        }
        translate([0,0,-plate_thick*.5-50+motor_z_size])
            cylinder(r=plate_r*1.1,h=100,center=true,$fn=64);
        translate([0,0,motor_z_size])
            cylinder(r=plate_r,h=plate_thick*1.1,center=true,$fn=64);
        translate([total_x_translation,0,total_z_translation]){
            translate([0,0,-16*.5])
                rotate([0,90,0]){
                    cylinder(r=1.5,h=1000,center=true,$fn=64);
                    translate([0,0,-12-7])
                        cylinder(r=3,h=10,center=true,$fn=64);
                }
            translate([0,0,16*.5]){
                rotate([0,90,0]){
                    cylinder(r=1.5,h=1000,center=true,$fn=64);
                    translate([0,0,-12-7])
                        cylinder(r=3,h=10,center=true,$fn=64);
                }
            }
            rotate([0,90,0])
                cylinder(r=2.5,h=1000,center=true,$fn=64);
        }
        scale([1,1,100])
            motor_holes(motor_hole_dist,motor_hole_dist);
        /*translate([-25,0,0])
            cylinder(r=4,h=1000,center=true,$fn=64);*/
        /*translate([-25,0,-2])
            rotate([0,0,-30])
            cube([2,20,30]);*/
    }
}

module slot(width=15,rad=1.5){
    rotate([90,0,0])
        cylinder(r=rad,h=100,center=true,$fn=64);
    translate([width*.5,0,0])
        cube([width,100,rad*2],center=true);
    translate([width,0,0])
        rotate([90,0,0])
            cylinder(r=rad,h=100,center=true,$fn=64);    
}

module make_arm(total_z_translation = 75, total_x_translation = -40){
    difference(){
        union(){
            arm(total_z_translation,total_x_translation);
            translate([0,0,motor_z_size])
                motor_plate();
            translate([total_x_translation,0,total_z_translation])
                rotate([0,90,0])
                    motor_plate(r1=16*.5,r2=19*.5);

        }
        translate([total_x_translation,0,total_z_translation])
            rotate([0,90,0])
                cylinder(r=plate_r*1.1, h=200);
        rotate([0,0,-90])
            translate([1,0,-2])
                cube([2,20,40]);
        rotate([0,0,0])
            translate([total_x_translation-20,0,total_z_translation])
                rotate([50,0,0])
                    cube([40,2,40]); 
            translate([total_x_translation-5,-4,13])
                cable_spiral();         
    }
}

module cable_spiral(){
    linear_extrude(height = 35, center = false, convexity = 10, twist = -180)
    translate([13, 0, 0])
    circle(r = 3, $fn=32);
}

make_arm();