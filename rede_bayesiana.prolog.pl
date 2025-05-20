% Fatos
0.6::str(dry); 0.3::str(wet); 0.1::str(snow_covered).
0.9::flw(f); 0.1::flw(t).
0.95::b(t); 0.05::b(f).
0.95::k(t); 0.05::k(f).

% R dinamo deslizante
0.9::r(t) :- flw(f), str(dry).
0.7::r(t) :- flw(f), str(wet).
0.3::r(t) :- flw(f), str(snow_covered).
0.7::r(t) :- flw(t), str(dry).
0.5::r(t) :- flw(t), str(wet).
0.2::r(t) :- flw(t), str(snow_covered).

% V mostra tensão
0.95::v(t) :- r(t).
0.10::v(t) :- r(f).

% Li ligada
0.99::li(t) :- v(t).
0.05::li(t) :- v(f).

% Consulta
query(v(t)).
evidence(str(snow_covered)).