n(yellow,red). n(red,yellow).
n(red,green). n(green,red).
n(green,yellow). n(yellow,green).

color(LU,NW,OW,SZ,UR,ZG) :-
    UR = yellow,
    n(LU,NW), n(LU,OW), n(LU,SZ), n(LU,ZG),
    n(NW,OW), n(NW,SZ), n(NW,UR),
    n(OW,UR),
    n(SZ,UR), n(SZ,ZG).

