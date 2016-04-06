cam_roll = 20;
cam_pitch = -10;
cam_yaw = 0;

total_z_translation = 75;

translate([0,0,-8])
    rotate([180,0,0])
        import("supsension.stl", convexity=4);

module centered_gopro(){    
    /*translate([-37.5,-31,0])
        import("GoPro3Box.STL",convexity=3);*/
    translate([0,5,0])
        import("opg_gopro_mount.stl",convexity=4);
}


rotate([0,0,cam_yaw]){
    import("opg_yaw_arm.stl", convexity=4);
    translate([0,0,-5])
        import("motor.stl",convexity=3);
        
    translate([-36,0,total_z_translation])
        rotate([0,90,0])
            import("motor.stl",convexity=3);            
    translate([-31,0,total_z_translation]){
        rotate([cam_roll,0,0]){
            rotate([90,0,90])
                rotate([0,0,180])
                import("opg_roll_arm.stl", convexity=4);
                
            translate([20+31,40,0])
                rotate([0,90,90+180])
                    import("motor.stl",convexity=3);
                    
                

            translate([20+31,27,0])
                rotate([90,-90+cam_pitch,0])
                    centered_gopro();
        }
    }
}