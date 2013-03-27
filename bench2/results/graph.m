
function [] = mbp()
	[D, axis, D2, axis2] = data()

	% D=[1=vienna; 2=adp; 3=lms; 4-7=cpu(NuPlain,NuBT, ZuPlain, ZuBT); 8-11=gpu(NuPlain,NuBT, ZuPlain, ZuBT)];
	do_graph('small_zu.eps','Zuker',D,axis,[1,2,6,7,10,11],{'-k','--k','-rd','-gx','-bs','-mo'},{'ViennaRNA','ADP fusion','CPU','CPU+BT','GPU','GPU+BT'})
	do_graph('small_nu.eps','Nussinov',D,axis,[3,4,5,8,9],{'-k','-rd','-gx','-bs','-mo'},{'LMS','CPU','CPU+BT','GPU','GPU+BT'})

	% D2 = [ 1-4=cpu(NuPlain,NuBT, ZuPlain, ZuBT); 5-8=gpu(NuPlain,NuBT, ZuPlain, ZuBT) ]
	do_graph('large_nu.eps','Nussinov',D2,axis2,[1,2,5,6],{'-rd','-gx','-bs','-mo'},{'CPU','CPU+BT','GPU','GPU+BT'})
	do_graph('large_zu.eps','Zuker',D2,axis2,[3,4,7,8],{'-rd','-gx','-bs','-mo'},{'CPU','CPU+BT','GPU','GPU+BT'})

end

% specs: http://www.mathworks.ch/ch/help/matlab/ref/linespec.html
function do_graph(file,name,D,axis,lines,specs,labels)
	h=figure;
	hh=[];
	%cc = hsv(length(lines));
	for i=1:length(lines),
		hh(end+1)=semilogy(axis,D(lines(i),:),specs{i},'linewidth',1.5,'markersize',8);
		hold on;
	end
	hold off;
	legend(hh,labels,'Location','SouthEast');
	xlabel('RNA sequence length');
	ylabel(sprintf('%s alg. running time in seconds (log scale)',name));
	set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 5]);
	print(h,'-depsc',file); close(h);
	unix(sprintf('epstopdf %s && rm %s',file,file));
end
