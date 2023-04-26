% Definimos una función llamada "EDO_RungeKutta" que toma los siguientes argumentos de entrada:
% u0: un vector de dos elementos que representa las condiciones iniciales x0 e y0
% t0: el tiempo inicial
% t1: el tiempo final
% n: el número de pasos de tiempo
% rA: tasa de crecimiento de la especie A
% rB: tasa de crecimiento de la especie B
% KA: capacidad de carga de la especie A
% KB: capacidad de carga de la especie B
% m: tasa de interacción entre las especies

function u = EDO_RungeKutta(u0, t0, t1, n, rA, rB, KA, KB, m)

  % Calcular el tamaño del paso h
  h = (t1 - t0) / n;

  % Crear un vector de tiempo
  t = t0:h:t1;

  % Crear vectores de solución para x y y
  x = zeros(1, n + 1);
  y = zeros(1, n + 1);

  % Asignar condiciones iniciales
  x(1) = u0(1);
  y(1) = u0(2);

  % Definir las funciones f1 y f2
  f1 = @(t, x, y) rA * x * (1 - x/KA) - m * (x - y);
  f2 = @(t, x, y) rB * y * (1 - y/KB) - m * (y - x);

  % Calcular los valores de k1, k2, k3 y k4 para cada paso de tiempo
  for i = 2:n + 1
    k1 = h * [f1(t(i-1), x(i-1), y(i-1)), f2(t(i-1), x(i-1), y(i-1))];
    k2 = h * [f1(t(i-1) + h/2, x(i-1) + k1(1)/2, y(i-1) + k1(2)/2), f2(t(i-1) + h/2, x(i-1) + k1(1)/2, y(i-1) + k1(2)/2)];
    k3 = h * [f1(t(i-1) + h/2, x(i-1) + k2(1)/2, y(i-1) + k2(2)/2), f2(t(i-1) + h/2, x(i-1) + k2(1)/2, y(i-1) + k2(2)/2)];
    k4 = h * [f1(t(i-1) + h, x(i-1) + k3(1), y(i-1) + k3(2)), f2(t(i-1) + h, x(i-1) + k3(1), y(i-1) + k3(2))];

    % Actualizar los valores de x e y para el siguiente paso
    x(i) = x(i-1) + 1/6 * (k1(1) + 2 * k2(1) + 2 * k3(1) + k4(1));
    y(i) = y(i-1) + 1/6 * (k1(2) + 2 * k2(2) + 2 * k3(2) + k4(2));
  end

  % Devolver los valores finales de x y y como un vector
  u = [x(end), y(end)];
end

