
function [] = mbp()

% MacBook Pro TCK
data = [ 100 200 300 400 500 600 700 800 900 1000; ...
0.220 1.650 5.500 14.140 28.440 51.630 83.860 138.500 294.080 584.660; ... % Nussinov-CPU-plain
0.260 1.760 6.000 14.850 28.900 53.570 85.730 143.910 293.890 595.140; ... % Nussinov-CPU-BT
3.860 12.570 27.190 49.780 76.580 77.830 103.640 97.400 124.580 156.040; ... % Nussinov-CUDA-plain
2.510 8.410 39.390 72.400 73.000 103.820 108.950 139.000 176.920 220.460; ... % Nussinov-CUDA-BT
0.630 4.520 14.370 33.240 64.590 110.420 169.150 251.440 358.150 496.350; ... % Zuker-CPU-plain
0.680 4.850 15.910 37.310 75.080 135.180 220.190 325.310 478.670 647.570; ... % Zuker-CPU-BT
22.010 92.980 116.460 181.060 295.480 437.090 603.700 796.290 1014.540 1260.530; ... % Zuker-CUDA-plain
10.740 68.380 117.110 184.120 299.420 442.390 609.500 803.370 1024.430 1270.360 ]; % Zuker-CUDA-BT

h=figure;
subplot(121);
h1=semilogy(data(1,:),data(2,:),'r');
hold on;
h2=semilogy(data(1,:),data(3,:),'g');
h3=semilogy(data(1,:),data(4,:),'b');
h4=semilogy(data(1,:),data(5,:),'c');
hold off;
legend([h1,h2,h3,h4],{'Nussinov-CPU','Nussinov-CPU+BT','Nussinov-CUDA','Nussinov-CUDA+BT'},'Location','NorthWest');
xlabel('Input size');
ylabel('Running time (ms)');
subplot(122);
h5=semilogy(data(1,:),data(6,:),'r');
hold on;
h6=semilogy(data(1,:),data(7,:),'g');
h7=semilogy(data(1,:),data(8,:),'b');
h8=semilogy(data(1,:),data(9,:),'c');
hold off;
legend([h5,h6,h7,h8],{'Zuker-CPU','Zuker-CPU+BT','Zuker-CUDA','Zuker-CUDA+BT'},'Location','NorthWest');
xlabel('Input size');
ylabel('Running time (ms)');

%	file = 'var_zuker.eps';
%	set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 4]);
%	print(h,'-depsc',file); close(h);
%	unix(sprintf('epstopdf %s && rm %s',file,file));


end
