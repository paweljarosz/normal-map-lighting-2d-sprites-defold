varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform lowp vec4 cloak;
uniform lowp vec4 armor;
uniform lowp vec4 gloves;
uniform lowp vec4 sword;
uniform lowp vec4 boots;
uniform lowp vec4 necklace;
uniform lowp vec4 blade;
uniform lowp vec4 element;
uniform lowp vec4 skin;

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    lowp vec4 pixel_color = texture2D(texture_sampler, var_texcoord0.xy);

    if (pixel_color.r > 0.95) {    //RED
        if (pixel_color.g < 0.05) {
            if (pixel_color.b > 0.6) {
                pixel_color = necklace * pixel_color.b * 1.5;   // FULL PINK  -- necklace  --  magenta
            }
            else { // if (pixel_color.b > 0.3){
                pixel_color = boots * pixel_color.b * 1;    // RED-BLUE  -- boots -- pink
            }
        } else if (pixel_color.b < 0.05) {
            pixel_color = cloak * pixel_color.g * 1.5;    // RED-GREEN -- cloak  -- orange
        }
    } else if (pixel_color.b > 0.95) {    //BLUE
        if (pixel_color.g < 0.05) {
            pixel_color = sword * pixel_color.r * 1.5;    // BLUE-RED  -- sword  -- violet
        } else if (pixel_color.r < 0.05) {
            pixel_color = armor * pixel_color.g * 1.5;    // BLUE-GREEN -- armor  -- navy
        }
    } else if (pixel_color.g > 0.95) {    //GREEN
        if (pixel_color.r < 0.05) {
            pixel_color = gloves * pixel_color.b * 1.5;    // GREEN-BLUE -- gloves  -- turquise
        } else if (pixel_color.b < 0.05) {
            if (pixel_color.r > 0.6) {
                pixel_color = blade * pixel_color.r * 1.5;    // GREEN-RED -- blade  -- lemon
            }
            else {
                pixel_color = element * pixel_color.r * 1.5;    // FULL YELLOW -- element  -- yellow
                //pixel_color.a = 0.05;
            }
        }
    } else if ((pixel_color.r > 0.8) && (pixel_color.g > 0.5)) {
        pixel_color = skin * pixel_color.b * 1.5;              // SKIN
    }

    if (pixel_color.a > 0.1) {
        pixel_color.a = 1;
    }

    gl_FragColor = pixel_color * vec4(tint.xyz * tint.w, tint.w);
}
