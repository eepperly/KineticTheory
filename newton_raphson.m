function xmin = newton_raphson (fun,jacobian,x0)
for i=1:100
  f = fun(x0);
  if (abs(f)<1e-12)
    break
  end
  J = jacobian(x0);
  if (det(J)==0)
    break
  end
  x0 = x0 - J\f;
end
xmin=x0;
end