
# Trabalho de Inteligência Artificial - Redes Bayesianas e ProbLog

## 1ª Questão

### (a) Desenho da Rede de Causalidade

A estrutura causal entre as variáveis fornecidas pode ser representada como:

```
Flw     B     K     Str
          \   |   /
             R
              \
               V
                \
                 Li
```

### (b) Tabelas de Probabilidades Condicionais (CPTs)

#### Variáveis marginais:

```prolog
0.6::str(dry); 0.3::str(wet); 0.1::str(snow_covered).
0.9::flw(f); 0.1::flw(t).
0.95::b(t); 0.05::b(f).
0.95::k(t); 0.05::k(f).
```

#### Dinamo deslizante (R | Flw, Str):

```prolog
0.9::r(t) :- flw(f), str(dry).
0.7::r(t) :- flw(f), str(wet).
0.3::r(t) :- flw(f), str(snow_covered).
0.7::r(t) :- flw(t), str(dry).
0.5::r(t) :- flw(t), str(wet).
0.2::r(t) :- flw(t), str(snow_covered).
```

#### Tensão (V | R):

```prolog
0.95::v(t) :- r(t).
0.1::v(t) :- r(f).
```

#### Luz ligada (Li | V):

```prolog
0.99::li(t) :- v(t).
0.05::li(t) :- v(f).
```

### (c) Valores Plausíveis

Os valores inseridos nas CPTs acima foram assumidos com base em cenários plausíveis de falha e funcionamento de um farol de bicicleta movido a dínamo.

### (d) Aresta entre `Str` e `Li`

Como temos as relações condicionais:

- \( P(Li | V, R) = P(Li | V) \)
- \( P(V | R, Str) = P(V | R) \)

Concluímos que `Li` não depende diretamente nem indiretamente de `Str`, portanto **não existe aresta entre `Str` e `Li`** na rede.

### (e) Cálculo de \( P(V | Str = snow\_covered) \)

Supondo `Flw = f`:

- \( P(R = t | Flw = f, Str = snow\_covered) = 0.3 \)
- \( P(V = t | R = t) = 0.95 \)
- \( P(V = t | R = f) = 0.1 \)

\(
P(V = t | Str = snow\_covered) = 0.3 \times 0.95 + 0.7 \times 0.1 = 0.355
\)

---

## 2ª Questão - Implementação em ProbLog

```prolog
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
```



---


