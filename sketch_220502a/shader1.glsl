#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float scale = 21.0;

float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(l,l)*8.0);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);
    float pct = max(u_time, 3.*u_time);
    
     if (floor(mod(st.y*scale,2.0)) == 1. )
        st.x = st.x + pct;
    
    if (floor(mod(st.y*scale,2.0)) == 0. )
        st.x = -st.x + pct;
    
    
    //Escala en función de la escala adoptada
    st = fract(st*scale);

    // Dibuja un círculo en cada "celda"
    
    color = vec3(circle(st,0.5));

    gl_FragColor = vec4(color,1.0);
}