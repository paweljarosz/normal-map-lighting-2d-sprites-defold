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
uniform lowp vec4 jacket;
uniform lowp vec4 skin;
uniform lowp vec4 jeans;

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    lowp vec4 pixel_color = texture2D(texture_sampler, var_texcoord0.xy);

    lowp float dir_north_west = (1-pixel_color.g) * (pixel_color.b);
    lowp float dir_south_west = (1-pixel_color.g) * (1-pixel_color.b);
    lowp float dir_north_east = (pixel_color.g) * (pixel_color.b);
    lowp float dir_south_east = (pixel_color.g) * (1-pixel_color.b);
    lowp float dir_south = 0.5*(1-pixel_color.b);
    lowp float dir_north = 0.5*(pixel_color.b);
    lowp float dir_west = 0.5*(1-pixel_color.g);
    lowp float dir_east = 0.5*(pixel_color.g);

    lowp float direction = dir_west;
    lowp float ambient = 2;

    //TODO: Change G to Alpha (if a in <0.1, 0.9>- this means eyes, skin, etc)
    if ((pixel_color.g > 0.4) && (pixel_color.g < 0.6) && (pixel_color.r > 0.1)) {
        if (pixel_color.r > 0.9) {     
            pixel_color = skin * cloak * ambient * direction;
        } else if ((pixel_color.r > 0.8) && (pixel_color.r < 0.9)) {
            pixel_color = skin * boots * ambient * direction;
        } else if ((pixel_color.r > 0.7) && (pixel_color.r < 0.8)) {
            pixel_color = skin * sword;
        } else if ((pixel_color.r > 0.6) && (pixel_color.r < 0.7)) {
            pixel_color = skin * armor * ambient * direction;
        } else if ((pixel_color.r > 0.5) && (pixel_color.r < 0.6)) {
            pixel_color = skin * jeans * ambient * direction;
        } else if ((pixel_color.r > 0.4) && (pixel_color.r < 0.5)) {
            pixel_color = skin * necklace;
        } else if ((pixel_color.r > 0.3) && (pixel_color.r < 0.4)) {
            pixel_color = skin * gloves * ambient * direction;
        } else if ((pixel_color.r > 0.2) && (pixel_color.r < 0.3)) {
            pixel_color = skin * blade;
        } else if ((pixel_color.r > 0.1) && (pixel_color.r < 0.2)) {
            pixel_color = skin * jacket;
        }
    }

    if (pixel_color.a > 0.0) {
        pixel_color.a = 1;
    }

    gl_FragColor = pixel_color * vec4(tint.xyz * tint.w, tint.w);
}
