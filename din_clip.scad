$fa = 1;
$fs = 0.4;

br_clamp_w = 1;
br_clamp_width = 15;
br_clamp_len = 30;
br_clamp_d = 2;


module slide_in_bracket_h (inv = 0)
{
    br_pin_d = 2;
    br_pin_x = 0.75;
    br_clamp_top = br_clamp_len*0.7;


    br_clamp_top_c = br_clamp_w;
    // offset for clamp
    br_clamp_o = 1 - inv;

    br_pins = abs(br_clamp_len / br_pin_d)-1;
    br_w2 = (br_clamp_width) *0.5-br_pin_d*0.5-br_pin_x;
    p = [
        [0,0],
        [0, br_clamp_len],
        [br_w2-1.5, br_clamp_len],
        [br_w2,     br_clamp_len-1.5],
        [br_w2 + (1-inv) *br_clamp_o,     0]
    ];

    for (i=[0:1:br_pins])
    {
        translate([br_w2 - br_pin_x + 0.8* sin(180*i/br_pins)
            + br_clamp_o * (1-i/br_pins), i*br_pin_d + br_pin_d*0.5])
            circle(d=br_pin_d + inv*0.5);
    }
    difference()
    {
        polygon(p);
        if (inv == 0)
        {
            polygon([
                [br_clamp_width*0.2, 0],
                [br_clamp_width*0.2, br_clamp_top],
                [br_clamp_width*0.2+br_clamp_w, br_clamp_top],
                [br_clamp_width*0.2+br_clamp_w+ (1-inv) *br_clamp_o, 0]
            ]);
            translate([br_clamp_width*0.2+br_clamp_top_c*0.5, br_clamp_top])
                circle(d = br_clamp_top_c);
        }
    }
}
module slide_in_bracket(inv=0)
{
    br_holes = (1-inv) * abs(br_clamp_len / 4)-2;
    difference()
    {
        translate([0,0,-inv*0.2])
        linear_extrude(br_clamp_d+inv*0.4)
        {
            union()
            {
                slide_in_bracket_h(inv=inv);
                mirror([1,0,0])
                    slide_in_bracket_h(inv=inv);
            }
        }
        for (i=[0:1:br_holes])
        {
            translate([0,i*4 + 4, -0.5])
                linear_extrude(br_clamp_d+1)
                    circle(d=3);
        }
        if (!inv)
        {
            /* cut edge */
            translate([0,br_clamp_len,br_clamp_d])
                rotate([-45,0,0])
                    cube([br_clamp_width*1.5, br_clamp_d, br_clamp_d], center=true);
        }
    }
}

module din_clip(depth = 20)
{
    // clip height rail top to clip top: 9.448200 = 3.854950 + 5.593250
    dc_excess = 5;
    clip_tunnel_l = 15;
    din_rail_edge_x = 3.354950;
    din_rail_edge_y = 19.249500;
    // Remix of http://www.thingiverse.com/thing:806093
    p = [
        [0,21.183100+dc_excess+clip_tunnel_l],
        [3.354950+br_clamp_d+1,21.183100+clip_tunnel_l],
        [3.354950+br_clamp_d+1,19.249500], //br_clamp_d

    /* upper rail edge: 3.354950 */
        [3.354950,19.249500],
        [1.854950,19.249500],

        [1.854950,17.277800],

        [1.854950,-17.249500],[3.354950,-17.249500],
        [4.381350,-13.599100],[4.745650,-13.189900],
        [5.271050,-13.038600],[5.819850,-13.038600],
        [6.168450,-13.183100],[6.312950,-13.531700],
        [6.312950,-17.211400],[6.162650,-19.965300],
        [5.735850,-20.605000],[5.096250,-21.032700],
        [4.341350,-21.183100],
        [0,-21.183100-dc_excess]
        ];

        difference()
        {
            linear_extrude(depth)
                polygon(p);
            #translate([din_rail_edge_x+br_clamp_d, din_rail_edge_y-2+br_clamp_len, depth*0.5])
            rotate([180,90,0])
            slide_in_bracket(1);
        }
}

translate([20,0,0])
din_clip();

slide_in_bracket(0);
