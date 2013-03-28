
function [] = mbp()
	[D, axis, D2, axis2] = data();

	% Arguments to remove 100-200 transients;
	% - Due to rounding issue and measurement precision, we do not have enough accuracy (Nussinov)
	% - Also we want to put more weight on large results
	% - We take median to avoid outlier putting too much weight in measurement

	% D=[ 1-4=cpu(NuPlain,NuBT, ZuPlain, ZuBT); 5-8=gpu(NuPlain,NuBT, ZuPlain, ZuBT); 9=adp_nu; 10=adp_zu; 11=vienna; 12=lms];
	d1 = D(1,3:10);
	d2 = D(9,3:10);
	d3 = []; for i=1:length(d1), d3(i)=d2(i)/d1(i); end
	disp(sprintf('Nussinov speedup = %.2f',median(d3))); disp(d3);

	d1 = D(3,3:10);
	d2 = D(10,3:10);
	d3 = []; for i=1:length(d1), d3(i)=d2(i)/d1(i); end
	disp(sprintf('Zuker speedup = %.2f',median(d3))); disp(d3);

	% D2 = [ 1-4=cpu(NuPlain,NuBT, ZuPlain, ZuBT); 5-8=gpu(NuPlain,NuBT, ZuPlain, ZuBT) ]

end
