word(n,e,u). word(t,o,p). word(t,o,t).
word(b,r,o,t). word(g,r,a,u). word(h,a,l,t). word(a,l,l,e).
word(j,e,t,z,t). word(s,a,g,e,n). word(u,n,t,e,n). word(z,e,c,k,e).

solution(C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12) :-
    word(C2,C3,C4,C5),
    word(C8,C9,C10,C11,C12),
    word(C1,C3,C6,C8),
    word(C5,C7,C10).
