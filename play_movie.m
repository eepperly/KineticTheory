function play_movie(XHist,box_dims,frameSkipRate)
figure
scatplot = scatter3(XHist(:,1,1),XHist(:,2,1),XHist(:,3,1));
axis(box_dims);
for frame=2:frameSkipRate:size(XHist,3)
  set(scatplot,'XData',XHist(:,1,frame));
  set(scatplot,'YData',XHist(:,2,frame));
  set(scatplot,'ZData',XHist(:,3,frame));
  drawnow
end
end