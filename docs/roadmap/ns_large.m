function [] = ns_large()
	% device memory
	MD=1024*1024*1024;
	% data sizes
	Sc=4;
	Sb=4;
	Si=1;
	Sw=0;

	X = [];
	for n=1024:64:128*1024
		X(end+1,:) = xfer(n,Sc,Sb,Si,Sw,MD);
	end

	h=figure;
	hold on;
	h1=plot(X(:,1),X(:,3),'b');
	h2=plot(X(:,1),X(:,4),'g');
	h3=plot(X(:,1),X(:,5),'r');

	legend([h1,h2,h3],{'Rectangle','Triangle','Parallelogram'},'Location','NorthWest');
	xlabel('Input size');
	ylabel('Data transferred (GB)');
	d_save(h,'ns_large.eps',9,4);
end

function d_save(h,file,width,height)
	set(gcf,'PaperUnits','inches','PaperPosition',[0 0 width height]);
	print(h,'-depsc',file); close(h);
	unix(sprintf('epstopdf %s && rm %s',file,file));
end

function [b] = blks(n, Sc,Sb,Si,Sw,MD)
	b=1;
	for ii={100000,10000,1000,100,10,1}, i=ii{1};
		while 2*n*(Si+Sw) + 2*n*n*Sc + (n*n*Sb)/(b+i) > MD*(b+i)
			b=b+i;
		end
	end
end

function [V] = xfer(n, Sc,Sb,Si,Sw,MD)
	b=blks(n, Sc,Sb,Si,Sw,MD);
	if (b==1)
		V = [n 1 0 0 0];
	else
		b2=b*b; b3=b*b*b;
		bs = Sc * n*n/(b*b) /(1024*1024*1024); % In Gb
		V = [ n b ...
			bs * ( b3/2 + 1.5*b2 -2*b + 1) ... % Rect
			bs * ( b3/3 + b2/2 + b/6) ... % Tri
			bs * b3 ]; % Para
	end
end
