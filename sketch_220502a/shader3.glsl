#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float grosor=1.;

float plot(vec2 st, float pct){
  //smoothstep da salida suave entre dos valores (Hermite)
    vec2 l1 = st+-vec2(0.49);
  return 1.-smoothstep(pct-(grosor*0.01), grosor-(grosor*0.01), dot(l1,l1)*4.0); 
}

float scale = 30.0;

float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.-smoothstep(_radius-(_radius*0.01), _radius+(_radius*0.01), dot(l,l)*8.0);    
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
	vec2 mouse= u_mouse/u_resolution.xy;
	
	grosor= abs(sin(u_time/2.));
    
    vec3 color = vec3(0.0);	
	
	float val = mouse.x*1.0;
	
	float pct = plot(st,val);
    
    color = (1.0-pct)*color+pct*vec3(0.306,0.553,0.885);
    
    vec2 stc = gl_FragCoord.xy/u_resolution;
    float pctc = u_time/15., u_time;
    
     if (floor(mod(st.y*scale,2.)) == 1. )
        stc.x = stc.x + pct;
    else
        stc.x = stc.x + pctc;
    
    if (floor(mod(st.y*scale,2.0)) == 0. )
        stc.x = -stc.x + pct;
    else
        stc.x = -stc.x + pctc;
    
    stc = fract(stc*scale);
    
    color += vec3(circle(stc,0.5));
	
	gl_FragColor = vec4(color,1.0);
}
