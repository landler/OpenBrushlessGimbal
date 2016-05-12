/*translate([-38,-2.7,0])
import("SuspensionFrame.STL", convexity=3);*/

    
arms = 6;
main_hole_r = 5.5;
main_hole_sub_r = 4.5;
arm_length = 30;
base_height = 0.5;
rounding_radius = 1;
center_r = 15;
center_rounding_r = 3.9;
center_hole_r = 5;

motor_hole_dist_1 = 19*.5;
motor_hole_dist_2 = 16*.5;
motor_hole_r = 1.5;

minkowski_iters = 32;


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

module main_arms(){
    for(ang = [0:360/arms:360]){
                rotate([0,0,ang])
                    translate([arm_length*.5,0,base_height*.5])
                        //cube([arm_length,4,base_height], center=true);
                        polyhedron(points=[
                            [arm_length*.5, 6, base_height*.5],
                            [arm_length*.5, -6, base_height*.5],
                            [arm_length*.5, -6, -base_height*.5],
                            [arm_length*.5, 6, -base_height*.5],
                            [-arm_length*.5, 2, base_height*.5],
                            [-arm_length*.5, -2, base_height*.5],
                            [-arm_length*.5, -2, -base_height*.5],
                            [-arm_length*.5, 2, -base_height*.5]
                             ], faces=[
                            [0,1,2,3],    
                            [4,5,1,0],
                            [7,6,5,4],
                            [5,6,2,1],
                            [6,7,3,2],
                            [7,4,0,3]
                            ], convexity=6);
                
            }
    
}
module center_with_roundings(){
    difference(){
        cylinder(r=center_r,h=base_height);
        for(ang = [0:360/arms:360]){
                rotate([0,0,ang+(360/arms)*.5])
                    translate([center_r,0,0])
                        cylinder(r=center_rounding_r,h=20,center=true, $fn=32);
        }
    }
}

module main_hull(){
    $fn=minkowski_iters;
    minkowski(){
        union(){
            main_holes(radius=main_hole_r*1.3);
            main_arms();    
            center_with_roundings();
        }
        sphere(r=rounding_radius);
    }
}
module center_reinforcment(){
    difference(){
        translate([0,0,-arm_length*1.8])
            sphere(r=arm_length*2, $fn=64);
        union(){
            translate([0,0,-500+base_height+rounding_radius])
                cube([arm_length*4,arm_length*4,1000],center=true);
            for(ang = [0:360/arms:360]){
                rotate([0,0, ang+(360/arms)*.5])
                    translate([center_r,0,0])
                        rotate([0,0,-45]){
                            $fn=minkowski_iters;
                            minkowski(){
                                cube([100,100,100]);
                                sphere(r=center_rounding_r);
                            }
                        }
            }
            cylinder(r=center_hole_r+rounding_radius,h=200,center=true, $fn=64);
        }
    }
}

module center_reinforcment_rounded(){
    $fn = minkowski_iters;
    minkowski(){
        center_reinforcment();
        sphere(r=rounding_radius);
    }
}

module make_holes(dist=motor_hole_dist_1){
    translate([dist,0,-50])
        cylinder(r=motor_hole_r,h=100, $fn=64);
    translate([-dist,0,-50])
        cylinder(r=motor_hole_r,h=100, $fn=64);
    
    translate([dist,0,4])
        cylinder(r=motor_hole_r*2,h=100,$fn=64);
    translate([-dist,0,4])
        cylinder(r=motor_hole_r*2,h=100,$fn=64);
}
module motor_holes(){
    make_holes(dist=motor_hole_dist_1);
    rotate([0,0,90])
        make_holes(dist=motor_hole_dist_2);
}


difference(){
    union(){
        main_hull();
        center_reinforcment_rounded();
    }
    translate([0,0,-rounding_radius])
        scale([1,1,10])
            main_holes(radius = main_hole_sub_r);
    rotate([0,0,360/arms*2])
        motor_holes();
}