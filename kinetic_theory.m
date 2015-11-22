function [XHist,VHist] = kinetic_theory(X,V,m,r,box_dims,dt,tf)

xdims = box_dims(1:2);
ydims = box_dims(3:4);
zdims = box_dims(5:6);

XHist = zeros([size(X,1) size(X,2) 1+length(dt:dt:tf)]);
VHist = zeros(size(XHist));

XHist(:,:,1) = X;
VHist(:,:,1) = V;

locationInHist = 2;
for t = dt:dt:tf
  X = X + dt*V; %update positions
  V = V - 2 * horzcat( ((X(:,1)<xdims(1)) + (X(:,1)>xdims(2))), ((X(:,2)<ydims(1)) + (X(:,2)>ydims(2))), ((X(:,3)<zdims(1)) + (X(:,3)>zdims(2))) ) .* V; %collisions with walls
  [rows,cols] = size(X);
  for i=1:rows
    for j=1:i-1
      if (norm(X(i,:)-X(j,:)) <= r(i) + r(j))
        [p1,p2] = collision(X(i,:)',m(i)*V(i,:)',m(i),X(j,:)',m(j)*V(j,:)',m(j));
        V(i,:) = p1'/m(i);
        V(j,:) = p2'/m(j);
      end
    end
  end
  XHist(:,:,locationInHist) = X;
  VHist(:,:,locationInHist) = V;
  locationInHist = locationInHist + 1;
end