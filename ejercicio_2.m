%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                 Ejercicio 2                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apartado 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define los valores iniciales u1 y u2
u1 = [2, 2];
u2 = [1, 3];

% Define los parámetros del modelo
[rA, rB, KA, KB, m] = deal(2, 3, 5, 7, 15);

% Define el tamaño de paso y el tamaño inicial de paso
step = 0.001;
number_steps = 1;

% Define el tiempo inicial y el número de iteraciones
t0 = 0;

% Define el error máximo y un umbral de tolerancia para la diferencia
diff = inf;
th = 10^(-5);

v1 = u1;
v2 = u2;

% Ejecuta un bucle hasta que la diferencia entre las soluciones sea menor que el umbral de tolerancia
while diff > th
  % Resuelve la EDO para u1 y u2 usando el método de Euler explícito y el tamaño de paso actual
  v1 = EDO_EulerExp(v1, t0 + (number_steps -1) * step, t0 + number_steps * step, 1, rA, rB, KA, KB, m);
  v2 = EDO_EulerExp(v2, t0 + (number_steps -1) * step, t0 + number_steps * step, 1, rA, rB, KA, KB, m);

  % Calcula la diferencia entre las soluciones obtenidas
  diff = norm(v1 - v2);

  % Incrementa el número de pasos
  number_steps = number_steps + 1;
end

% Imprime los resultados finales
fprintf("METODO EXPLICITO DE EULER\n\n")
fprintf(sprintf("Resultado con valores iniciales [%.2f, %.2f]: [%.2f, %.2f]\n", u1(1), u1(2), v1(1), v1(2)));
fprintf(sprintf("Resultado con valores iniciales [%.2f, %.2f]: [%.2f, %.2f]\n", u2(1), u2(2), v2(1), v2(2)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apartado 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define los valores iniciales u1 y u2
u1 = [2, 2];
u2 = [1, 3];

% Define los parámetros del modelo
[rA, rB, KA, KB, m] = deal(2, 3, 5, 7, 15);

% Define el tamaño de paso y el tamaño inicial de paso
step = 0.001;
number_steps = 1;

% Define el tiempo inicial y el número de iteraciones
t0 = 0;

% Define el error máximo y un umbral de tolerancia para la diferencia
diff = inf;
th = 10^(-5);

v1 = u1;
v2 = u2;

% Ejecuta un bucle hasta que la diferencia entre las soluciones sea menor que el umbral de tolerancia
while diff > th
  % Resuelve la EDO para u1 y u2 usando el método de Runge Kutta y el tamaño de paso actual
  v1 = EDO_RungeKutta(v1, t0 + (number_steps -1) * step, t0 + number_steps * step, 1, rA, rB, KA, KB, m);
  v2 = EDO_RungeKutta(v2, t0 + (number_steps -1) * step, t0 + number_steps * step, 1, rA, rB, KA, KB, m);

  % Calcula la diferencia entre las soluciones obtenidas
  diff = norm(v1 - v2);

  % Incrementa el número de pasos
  number_steps = number_steps + 1;
end


% Imprime los resultados finales

printf("METODO DE RUNGE KUTTA\n\n")
printf(sprintf("Resultado con valores iniciales [%.2f, %.2f]: [%.2f, %.2f]\n", u1(1), u1(2), v1(1), v1(2)));
printf(sprintf("Resultado con valores iniciales [%.2f, %.2f]: [%.2f, %.2f]\n", u2(1), u2(2), v2(1), v2(2)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apartado 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = EDO_limite_convergencia(u1, u2, t0, rA, rB, KA, KB, m_list)
  % Función que calcula la convergencia de la solución de la EDO para diferentes valores de m
  % Parámetros:
  % - u1, u2: vectores que contienen los valores iniciales de las dos poblaciones
  % - t0: tiempo inicial
  % - rA, rB, KA, KB: parámetros de la EDO
  % - m_list: vector con los valores de m a evaluar
  % Retorna:
  % - results: vector con los resultados de la suma de las dos poblaciones para cada valor de m

  results = m_list;

  i = 1;

  th = 10^-5; % Valor de umbral de convergencia
  t0 = 0; % Tiempo inicial

  step = 0.001; % Tamaño del paso


  for m = m_list
    diff = inf;
    number_steps = 1;
    while diff > th % Mientras la diferencia entre las soluciones de las dos poblaciones sea mayor que el umbral
      u1 = EDO_EulerExp(u1, t0 + (number_steps - 1)* step, t0 + number_steps * step, 1, rA, rB, KA, KB, m);
      u2 = EDO_EulerExp(u2, t0 + (number_steps - 1)* step, t0 + number_steps * step, 1, rA, rB, KA, KB, m);
      diff = norm(u1 - u2); % Cálculo de la diferencia entre las soluciones de las dos poblaciones
      number_steps = number_steps + 1;
    end
    results(i) = u1(1) + u1(2); % Guardamos el resultado de la suma de las dos poblaciones
    i = i + 1;

  end
end

% Definimos los valores iniciales para las dos poblaciones
u1 = [2, 2];
u2 = [1, 3];

% Definimos el número de muestras para el parámetro 'm'
number_samples = 100;

% Generamos una lista de valores 'm' equidistantes desde 0 hasta 1
m_list = linspace(0, 50, number_samples);

% Definimos los valores de los parámetros 'rA', 'rB', 'KA' y 'KB'
% para el primer conjunto de simulaciones
[rA, rB, KA, KB] = deal(2, 3, 5, 7);

% Llamamos a la función 'EDO_limite_convergencia' para simular la
% convergencia de las dos poblaciones utilizando los valores
% de los parámetros definidos anteriormente
results = EDO_limite_convergencia(u1, u2, t0, rA, rB, KA, KB, m_list);

% Creamos una cadena de texto para el primer conjunto de parámetros
s1 = sprintf("rA = %.2f, rB = %.2f, KA=%.2f, KB=%.2f", rA, rB, KA, KB);

% Graficamos los resultados obtenidos en la simulación, utilizando
% marcadores de estilo 's' para el primer conjunto de simulaciones
plot(m_list, results, 's');

% Mantenemos la gráfica anterior y agregamos una nueva
hold on;

% Definimos los valores de los parámetros 'rA', 'rB', 'KA' y 'KB'
% para el segundo conjunto de simulaciones
[rA, rB, KA, KB] = deal(3, 2, 5, 7);

% Llamamos a la función 'EDO_limite_convergencia' para simular la
% convergencia de las dos poblaciones utilizando los valores
% de los parámetros definidos anteriormente
results = EDO_limite_convergencia(u1, u2, t0, rA, rB, KA, KB, m_list);

% Creamos una cadena de texto para el segundo conjunto de parámetros
s2 = sprintf("rA = %.2f, rB = %.2f, KA=%.2f, KB=%.2f", rA, rB, KA, KB);

% Graficamos los resultados obtenidos en la simulación, utilizando
% marcadores de estilo 'o' para el segundo conjunto de simulaciones
plot(m_list, results, 'o');

% Agregamos etiquetas a los ejes x e y de la gráfica
xlabel("Parametro m");
ylabel("Suma de las dos poblaciones");

% Agregamos una leyenda a la gráfica con las cadenas de texto creadas
% anteriormente
legend(s1, s2)

% Agregamos una cuadrícula a la gráfica
grid()

