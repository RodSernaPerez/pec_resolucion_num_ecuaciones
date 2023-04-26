% Definimos una función llamada "EDO_EulerExp" que toma los siguientes argumentos de entrada:
% u0: un vector de dos elementos que representa las condiciones iniciales x0 e y0
% t0: el tiempo inicial
% t1: el tiempo final
% n: el número de pasos de tiempo
% rA: tasa de crecimiento de la especie A
% rB: tasa de crecimiento de la especie B
% KA: capacidad de carga de la especie A
% KB: capacidad de carga de la especie B
% m: tasa de interacción entre las especies

function u = EDO_EulerExp(u0, t0, t1, n, rA, rB, KA, KB, m)

% Calculamos el tamaño del paso de tiempo
timestep = (t1 - t0) / n;


t_vector = linspace(t0, t1, n + 1);

% Inicializamos los vectores x e y con ceros y agregamos las condiciones iniciales a x(1) e y(1)
x_vector = zeros(1, n+1);
y_vector = zeros(1, n+1);
x_vector(1) = u0(1);
y_vector(1) = u0(2);

% Definimos las funciones f1 y f2
f1 = @(t, x, y) rA * x * (1 - (x/KA)) - m * ( x - y);
f2 = @(t, x, y) rB * y * (1 - (y/KB)) - m * ( y - x);

% Calculamos los valores de x y y para cada paso de tiempo utilizando el método de Euler explícito
for i = 2:(n + 1)
  x_vector(i) = x_vector(i-1) + timestep * f1(t_vector(i-1), x_vector(i-1), y_vector(i-1));
  y_vector(i) = y_vector(i-1) + timestep * f2(t_vector(i-1), x_vector(i-1), y_vector(i-1));
end

% Devolvemos un vector que contiene los valores finales de x y y
u = [x_vector(n + 1), y_vector(n + 1)];
end
