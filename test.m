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

