n(red, green).
n(green, red).
n(red, blue).
n(blue, red).
n(blue, green).
n(green, blue).

colors(CH, A, D, I, F, B, N) :- 
  CH = red,
  n(CH, A), n(CH, I), n(CH, F), n(CH, D),
  n(A, D), n(A, I),
  n(I, F),
  n(F, B),
  n(D, B), n(D, N),
  n(B, N).
