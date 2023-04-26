%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                 Ejercicio 1                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apartado 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Esta función calcula el punto fijo de una función 'g' mediante el método iterativo.
% Recibe como entrada:
% - la función 'g' que se quiere calcular su punto fijo
% - el valor inicial 'x0'
% - la tolerancia 'tol' que indica la precisión deseada
% Devuelve:
% - 'x', el punto fijo obtenido
% - 'n', el número de iteraciones necesarias para alcanzar la precisión deseada

function [x, time] = punto_fijo(g, x0, tol)
  x = x0;
  err = inf;

  % Obtener el tiempo de inicio de la iteración
  tic;

  while err > tol
    x_next = g(x);
    err = abs(x_next - x);
    x = x_next;
  endwhile

  % Obtener el tiempo de finalización de la iteración y restar el tiempo de inicio
  time = toc;
endfunction


function [x, time] = biseccion(f, a, b, rel_tol)
  % La función biseccion encuentra la raíz de una función f(x) en el intervalo [a, b],
  % utilizando el método de bisección, el cual consiste en dividir el intervalo por la
  % mitad en cada iteración y verificar en qué mitad se encuentra la raíz. El proceso se
  % repite hasta que el error relativo es menor que una tolerancia dada.
  %
  % Argumentos:
  % - f: función a la que se le busca la raíz
  % - a, b: extremos del intervalo en el que se buscará la raíz
  % - rel_tol: tolerancia relativa deseada para el error en la solución
  %
  % Salidas:
  % - x: aproximación de la raíz encontrada
  % - time: tiempo que ha tardado en converger

  fa = f(a);
  fb = f(b);

  % Comprobamos si alguno de los valores dados inicialmente son soluciones
  if fa == 0, x=a; time=0; return; endif
  if fb == 0, x=b; time=0; return; endif

  % Si el valor inicial dado es mayor que el final, los intercambi
  if a > b, [a, b] = deal(b, a); endif

  % Comprueba si fa * fb < 0. Si no lo es, expande el intervalo hasta que lo sea
  while fa * fb > 0
    a = a / 2;
    b = 2 * b;
    fa = f(a);
    fb = f(b);
  endwhile

  tic % iniciar temporizador

  err_rel = abs((b - a) / b) % iniciamos el error
  while err_rel < rel_tol
    x = (a + b) / 2;
    fx = f(x);

    % Verificar en qué mitad del intervalo se encuentra la raíz
    if fa*fx < 0, b=x; fb=fx; else a=x; fa=fx; endif

    % Calcular el error relativo y verificar si se alcanzó la precisión deseada
    err_rel = abs((b - a) / b);
  endwhile
  time = toc;
  x = a;
endfunction


# Definimos la tolerancia
tolerance = 10^-12;

# Definimos los valores de r_A y K_A
r_A = 2;
K_A = 3.5;

# Definimos los valores iniciales para x0
x0_values = [2, 3, 4, 5];

# Iteramos sobre los valores de x0
for x0 = x0_values

  # Imprimimos el valor de x0
  printf("Resultados para x0=%.2f\n\n", x0);

  # Definimos la función f(x) y aplicamos el método del punto fijo
  f = @(x) poblacion_func(x, r_A, K_A);
  [result, iterations] = punto_fijo(f, x0, tolerance);
  printf("- Metodo del punto fijo. Resultado: %.2f. Alcanzado en %d segundos\n", result, iterations);

  # Definimos la función f(x) y aplicamos el método de la bisección
  f = @(x) poblacion_func(x, r_A, K_A) - x;
  [result, iterations] = biseccion(f, 0.1, 0.15, tolerance);
  printf("- Metodo de la biseccion. Resultado: %.2f. Alcanzado en %d segundos\n", result, iterations);

  # Imprimimos un salto de línea para separar los resultados
  printf("\n");
endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apartado 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Esta función calcula la dinámica de dos poblaciones (x, y) bajo un modelo de competencia, donde
% rA, rB, KA y KB son parámetros que definen la tasa de crecimiento y la capacidad de carga de cada
% población. El parámetro m es la proporción de la población que compite por los recursos de la población
% opuesta. La función utiliza el método de Punto Fijo (Fixed Point) para obtener la solución.

function u = EDF_PF(x0, y0, rA, rB, KA, KB, m)
    tol = 10^-12; % establece la tolerancia para la convergencia del método

    % define las funciones de las tasas de crecimiento de las poblaciones
    s_a = @(x) poblacion_func(x, rA, KA);
    s_b = @(x) poblacion_func(x, rB, KB);

    % inicia las poblaciones x e y y la solución u
    x = x0;
    y = y0;
    u = 0;

    % calcula la solución utilizando el método de Punto Fijo
    err_rel = inf;
    while err_rel > tol
      % calcula la población siguiente para cada especie
      x_next = (1-m) * s_a(x) + m * s_b(y);
      y_next = m * s_a(x) + (1- m) * s_b(y);

      % calcula el error relativo
      err_rel = abs(x_next - x + y_next - y) / (y + x);

      % actualiza las poblaciones y la solución
      x = x_next;
      y = y_next;
      u = [x, y];
    endwhile
  endfunction


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apartado 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Definimos un vector que contiene 100 elementos equiespaciados entre 0.0001 y 0.9999
m_vector = linspace(0, 1, 100);

% Definimos las variables x_0 e y_0 con valor 5
[x_0, y_0] = deal(5,5);

% Definimos las variables r_A, r_B, K_A y K_B con valores específicos
[rA, rB, KA, KB] = deal(2, 3, 5, 7);

% Utilizamos arrayfun para aplicar la función EDF_PF a cada elemento del vector m_vector y luego sumar los resultados
% Estos resultados se almacenan en el vector "results"
results = arrayfun(@(m) sum(EDF_PF(x_0, y_0, rA, rB, KA, KB, m)), m_vector);

% Graficamos los resultados en un gráfico de puntos con forma de cuadrado ("s")
plot(m_vector, results, 's');
hold on;

% Creamos una cadena de caracteres s1 que contiene información sobre los valores de las variables r_A, r_B, K_A y K_B
s1 = sprintf("rA = %.2f, rB = %.2f, KA=%.2f, KB=%.2f", rA, rB, KA, KB);

% Mantenemos el gráfico anterior y graficamos nuevos puntos con forma de "x" con distintos valores de r_A y r_B
[rA, rB, KA, KB] = deal(3, 2, 5, 7);
results = arrayfun(@(m) sum(EDF_PF(x_0, y_0, rA, rB, KA, KB, m)), m_vector);
plot(m_vector, results, 'x');


% Creamos una cadena de caracteres s2 que contiene información sobre los nuevos valores de r_A, r_B, K_A y K_B
s2 = sprintf("rA = %.2f, rB = %.2f, KA=%.2f, KB=%.2f", rA, rB, KA, KB);

% Agregamos etiquetas de eje y título al gráfico
xlabel("Parametro m");
ylabel("Suma de las dos poblaciones");
title(sprintf("Valores x_0=%.2f, y_0=%.2f", x_0, y_0));
grid on;

% Agregamos una leyenda al gráfico que incluye las cadenas s1 y s2
legend(s1, s2);
