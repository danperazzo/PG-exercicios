function get_point_bezier(P, t) {

    var len = P.length

    if (len ==1){
        return P[0]
    }

    var intert_P = []

    for (i=1;i<len;i++){
    
        P_x = P[i][0]*t+P[i-1][0]*(1-t)
        P_y = P[i][1]*t+P[i-1][1]*(1-t)

        intert_P.push([P_x,P_y])
    
    }

    return get_point_bezier(intert_P, t)
  } 
