function r = poblacion_func(x, r_A, K_A)
  r = r_A .* x./ (1 + x .* (r_A - 1) ./ K_A);
endfunction

