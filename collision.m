function [mom1,mom2] = collision(pos1i,mom1i,mass1,pos2i,mom2i,mass2)

fun = @(x) [x(1) - mom1i(1) - x(7) * (pos2i(1)-pos1i(1)); ...
            x(2) - mom1i(2) - x(7) * (pos2i(2)-pos1i(2)); ...
            x(3) - mom1i(3) - x(7) * (pos2i(3)-pos1i(3)); ...
            x(4) - mom2i(1) + x(7) * (pos2i(1)-pos1i(1)); ...
            x(5) - mom2i(2) + x(7) * (pos2i(2)-pos1i(2)); ...
            x(6) - mom2i(3) + x(7) * (pos2i(3)-pos1i(3)); ...
            (x(1:3)'*x(1:3) - mom1i'*mom1i)/2/mass1 + (x(4:6)'*x(4:6) - mom2i'*mom2i)/2/mass2];

jac = @(x) [1,0,0,0,0,0,pos1i(1)-pos2i(1);
            0,1,0,0,0,0,pos1i(2)-pos2i(2);
            0,0,1,0,0,0,pos1i(3)-pos2i(3);
            0,0,0,1,0,0,pos2i(1)-pos1i(1);
            0,0,0,0,1,0,pos2i(2)-pos1i(2);
            0,0,0,0,0,1,pos2i(3)-pos1i(3);
            x(1)/mass1,x(2)/mass1,x(3)/mass1,x(4)/mass2,x(5)/mass2,x(6)/mass2,0];

mom_after = newton_raphson(fun,jac,[2*(0.5-rand())*mom1i(1);2*(0.5-rand())*mom1i(2);2*(0.5-rand())*mom1i(3);2*(0.5-rand())*mom2i(1);2*(0.5-rand())*mom2i(2);2*(0.5-rand())*mom2i(3);1]);
mom1 = mom_after(1:3);
mom2 = mom_after(4:6);
end