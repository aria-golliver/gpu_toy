struct quaternion
{
    vec4 d;
};

quaternion qtimes(in quaternion a, in quaternion b){
    float y0 = dot(a.d.xyzw, b.d.xyzw * vec4(1., -1., -1., -1.));
    float y1 = dot(a.d.xyzw, b.d.yxwz * vec4(1.,  1.,  1., -1.));
    float y2 = dot(a.d.xyzw, b.d.zwxy * vec4(1., -1.,  1.,  1.));
    float y3 = dot(a.d.xyzw, b.d.wzyx * vec4(1.,  1., -1.,  1.));

    quaternion q;
    q.d = vec4(y0, y1, y2, y3);

    return q;
}

quaternion qtimes(in float f, in quaternion a){
    quaternion q;
    q.d = vec4(f) * a.d;
    return q;
}

quaternion qplus(in quaternion a, in quaternion b){
    quaternion q;
    q.d = a.d + b.d;

    return q;
}

float qabsq(in quaternion q){
    return dot(q.d, q.d);
}

float calcDistance(quaternion z, quaternion c){
    quaternion dz;
    dz.d = vec4(1., 0., 0., 0.);

    float m2 = 0.;
    float keep_going = 1.;


    for(float i = 0.; i < 12.; i++){
        if(keep_going > 0.){
            dz = qtimes(2., qtimes(dz,z));
            z = qplus(qtimes(z,z), c);
            m2 = qabsq(z);
            if(m2 > 100.){
                keep_going = 0.;
            }
        }
    }

    return sqrt(m2/qabsq(dz)) * 0.5 * log(sqrt(m2));
}

float calcDistance_atDelta(in vec3 surf_center, in quaternion c, in vec3 delta){
    vec3 z_pos = surf_center + delta;
    quaternion z;
    z.d = vec4(z_pos.x, z_pos.y, z_pos.z, 0.);

    return calcDistance(z, c);
}

vec3 make_abs(in vec3 v){
    return vec3(abs(v.x), abs(v.y), abs(v.z));
}

float cam_slow = 4.;
vec4 do_everything(in vec3 e,
                   in vec3 w,
                   in vec3 u,
                   in vec3 v,
                   in quaternion c,
                   in float l,
                   in float r,
                   in float t,
                   in float b,
                   in float d,
                   in float dx,
                   in float dy,
                  in vec2 fragCoord){
    float rad = 2.;
    float U = l + (r - l) * (fragCoord.x + dx) / (iResolution.x);
    float V = b + (t - b) * (fragCoord.y + dy) / (iResolution.y);

    vec3 ray_dir = normalize(w*vec3(-d) + u * vec3(U) + v * vec3(V));
    vec3 ray_e = e;
    float MAX_DIST = 2. * length(e);


    quaternion z0;
    z0.d = vec4(ray_e, 0.);

    float init_dist = calcDistance(z0, c);

    float dist = init_dist;

    const float max_iters = 64.;
    float marched_iters = 0.;
    float keep_going = 1.;

    const float alpha = 0.0001;
    const float clarity = 0.;

    for(float iters = 0.; iters < max_iters; iters++){
        if(keep_going > 0.){
            vec3 z2_pos = ray_e + ray_dir * vec3(dist);

            quaternion z2;
            z2.d = vec4(z2_pos, 0.);

            float newdist = calcDistance(z2, c);
            if(abs(dist) > MAX_DIST || abs(newdist) > MAX_DIST || (keep_going > 0. && dist == 0.)){
                dist = 0.;
                keep_going = 0.;
            }

            if(newdist < alpha * pow(dist, clarity)){
                keep_going = 0.;
            }

            dist += newdist * keep_going;
            marched_iters = marched_iters + keep_going;
        }
    }

    if(dist == 0.){
        return vec4(0,0.,0.,0.);
    } else {
        float AO_VEC = max(1. - marched_iters / max_iters, .05);
        vec3 grad_center = ray_e + ray_dir * vec3(dist);
        //float grad_delta = 0.0001;
        float grad_delta = alpha * pow(dist, clarity);
        // calculate gradiant!
        float dist_left  = calcDistance_atDelta(grad_center, c, vec3(grad_delta) * u);
        float dist_right = calcDistance_atDelta(grad_center, c, vec3(-grad_delta) * u);
        float dist_up    = calcDistance_atDelta(grad_center, c, vec3(-grad_delta) * v);
        float dist_down  = calcDistance_atDelta(grad_center, c, vec3(grad_delta) * v);
        float dist_for    = calcDistance_atDelta(grad_center, c, vec3(-grad_delta) * ray_dir);
        float dist_bak  = calcDistance_atDelta(grad_center, c, vec3(grad_delta) * ray_dir);
        vec3 GRAD_VEC = normalize(make_abs(vec3((dist_left - dist_right) / (2. * grad_delta),
                                                (dist_up   - dist_down)  / (2. * grad_delta),
                                                (dist_for  - dist_bak)   / (2. * grad_delta))));
        
        // done with gradiant


        vec3 light_pos = vec3(rad * sin(texture(texture_x, vec2(0,0)).r * 3.1415923 / cam_slow), rad * cos(texture(texture_x, vec2(0,0)).r * 3.1415923 / cam_slow), rad);
        
        vec3 ray_light_e = ray_e + ray_dir * vec3(dist * .99);
        vec3 ray_light_dir = normalize(light_pos - ray_light_e);
        
        float dist_to_light = abs(distance(light_pos, ray_light_e));

        keep_going = 1.;
        marched_iters = 0.;
        dist = 0.;
        const float max_iters_l = max_iters;
        for(float iters = 0.; iters < max_iters_l; iters++){
            vec3 z2_pos = ray_light_e + ray_light_dir * vec3(dist);

            quaternion z2;
            z2.d = vec4(z2_pos.x, z2_pos.y, z2_pos.z, 0.);

            float newdist = calcDistance(z2, c);
            if(abs(dist) > MAX_DIST || abs(newdist) > MAX_DIST || (keep_going == 0. && dist == 0.)){
                dist = 0.;
                keep_going = 0.;
            }

            if(newdist < alpha * pow(dist, clarity)){
                keep_going = 0.;
            }

            dist += newdist * keep_going;
            marched_iters = marched_iters + keep_going;
        }

        float LIGHT_VEC = 1.;
        if(dist == 0. || dist > dist_to_light){
            LIGHT_VEC = 1.;
        } else {
            LIGHT_VEC = .5;
        }

        vec3 COL_VEC = LIGHT_VEC * AO_VEC * GRAD_VEC;
        return vec4(COL_VEC, 1.);
    }
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float bandIntensity0 = .1;
    float bandIntensity1 = .1;
    float bandIntensity2 = .1;
    float bandIntensity3 = .1;

    // ray generation
    float rad = 2. * texture(texture_w, vec2(0,0)).r;
    float e_x = rad * sin(texture(texture_x, vec2(0,0)).r * 3.1415923 / cam_slow);
    float e_y = rad * cos(texture(texture_x, vec2(0,0)).r * 3.1415923 / cam_slow);
    float e_z = 0.;

    float SS = 1.;
    
    float l = -iResolution.x * SS;
    float r =  iResolution.x * SS;
    float t =  iResolution.y * SS;
    float b = -iResolution.y * SS;
    float d =  iResolution.y * SS;

    vec3 e = vec3(e_x, e_y, e_z);
    vec3 lookpoint = vec3(0.,0.,0.);
    vec3 upnorm = vec3(0.,0.,1.);


    vec3 lookdir = lookpoint - e;

    vec4 TOTAL_COLOR = vec4(0.);

    vec3 w = normalize(lookdir) * vec3(-1., -1., -1.);
    vec3 u = normalize(cross(upnorm, w));
    vec3 v = normalize(cross(w, u));

    quaternion c;
    c.d.x = .33;
    c.d.z = .66;
    c.d.y = 0;
    c.d.w = 0;
    
    TOTAL_COLOR += do_everything(e, w, u, v, c, l, r, t, b, d, 0., 0., fragCoord);

    fragColor = TOTAL_COLOR / vec4(SS*SS);
}
