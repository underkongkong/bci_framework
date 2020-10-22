while 1 
    load('buffer.mat');
    h = animatedline;
    axis([0,1000,-1,1]) % 1000指x轴点数
    
    x = linspace(0,1000,1000);
    y = all_signal(1,:);
    for k = 1:length(x)
        addpoints(h,x(k),y(k));
        drawnow
    end
end