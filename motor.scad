function select_dist(ang,r1,r2)=
    (ang%180==0) ?r1:r2;
;
module motor_holes(r1,r2,plate_thick=10){
    for(ang = [0:90:360]){
        rotate([0,0,ang])
            translate([select_dist(ang,r1,r2),0,0])
                cylinder(r=motor_hole_r,h=plate_thick*2,center=true,$fn=64);
    }
    cylinder(r=2.5,h=plate_thick*2,center=true,$fn=64);
}

difference(){
    hull(){
        cylinder(r=35*.5,h=13,$fn=64);
        translate([0,0,-2])
            cylinder(r=32*.5,h=2,$fn=64);
    }
    motor_holes(r1=16*.5,r2=19*.5);
    translate([0,0,10])
        motor_holes(r1=12*.5,r2=12*.5);
}