function [] = var_zuker()
	T=load('var_zuker.dat');

	h=figure;
	close all;

	subplot(131);
	median_mean_conf_int(T, 'Zuker folding running time (seconds)');
	title(sprintf('Running time boxplot'));

	subplot(132);
	qqplot(T);
	title(sprintf('QQPlot of Zuker running time versus normal distribution'));
	ylabel('Running time quantiles');
	xlabel('Normal distribution quantiles');


	subplot(133);
	qqplot(T,unifrnd(0,1,500,1));
	title(sprintf('QQPlot of Zuker running time versus uniform distribution'));
	ylabel('Running time quantiles');
	xlabel('Uniform distribution quantiles');

	%lorenz_curve(T);
	%title(sprintf('Lorenz curve'));

	file = 'var_zuker.eps';
	set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 4]);
	print(h,'-depsc',file); close(h);
	unix(sprintf('epstopdf %s && rm %s',file,file));

end

function median_mean_conf_int(X, label)
	% confidence level is 1-alpha
	alpha = 0.05;

	%figure;
	% median, ci for median based on order statistic
	boxplot(X, 1); % equivalent to boxplot(X,'notch','on');
	% ylim([ymin ymax])
	xlabel('Median with 95% CI (boxplot) and mean with 95% CI');
	ylabel(label);

	% mean, ci for mean assuming the data is normal
	m = mean(X);
	n = length(X);
	line([0.75 1.25], [m m], 'Color', 'r', 'LineStyle', '-');

	% conf interval for mean, using normal approx
	ci = tinv(1-alpha/2, n-1) * std(X)/sqrt(n);
	line([0.5 1.5], [m+ci m+ci], 'Color', 'b', 'LineStyle', ':');
	line([0.5 1.5], [m-ci m-ci], 'Color', 'b', 'LineStyle', ':');

	fprintf('%s Mean: %.3f [%.3f, %.3f] <%.3f>\n',label,m,m-ci,m+ci,2*ci/m);
	SX=sort(X);
	[j k]=median_ci(length(SX));
	fprintf('%s Median: %.3f [%.3f, %.3f] <%.3f>\n\n',label,median(SX),SX(j),SX(k), (SX(k)-SX(j)) /median(SX) );


	legend('Mean', 'CI for the mean', 'Location', 'NorthEast');
	set(legend,'FontSize',10);
end

function lorenz_curve(X)
	% shift everything to positive values
	% this should not be necessary for correct data
	xmin = min(X);
	if xmin < 0
   	X = X - xmin;
	end

	X = sort(X);
	n = length(X);

	F = (1:n)/n;
	S = cumsum(X);
	xsum = sum(X);
	L = [0; S/xsum];
	F = [0 F];

	%figure;
	plot(F, L,'b');
	hold on;
	plot([0; 1],[0; 1],'r');

	legend(['Lorenz curve'], 'Location', 'NorthWest');
	set(legend,'FontSize',14);
	xlabel(sprintf('Lorenz curve gap=%.3f',lorenzcgap(X)));
end

% LORENZ CURVE GAP
function gap = lorenzcgap(X)
	X = sort(X);
	n = length(X);
	i0 = 1;
	m = mean(X);
	for i = 1:length(X),
   	if (X(i) <= m), i0=i; end
	end
	gap = i0 / n  - sum(X(1:i0))/(m*n);
end

% MEDIAN CONFIDENCE INTERVAL (n, gamma=.95, q=.5)
% n: number of samples
% gamma: the desired confidence
% q: the probability of binomial distribution
function [j,k,p] = median_ci(n,gamma,q)
	if nargin < 2, gamma=.95; end
	if nargin < 3, q=.5; end
	d = (1-gamma)/2;
	j=1;
	if (binocdf(j-1,n,q) > d)
		warning('Not enough samples to achieve desired confidence')
	else
		if n<150
			while (binocdf(j+7,n,q) <= d) j=j+8; end
			while (binocdf(j,n,q) <= d) j=j+1; end
		else
			eta = (1+gamma)/2;
			j = floor(n*q-eta*sqrt(n*q*(1-q)));
		end
	end
	k = n-j+1;
	p = 1-2*binocdf(j-1,n,q);
end
