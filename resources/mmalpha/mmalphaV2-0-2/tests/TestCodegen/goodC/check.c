#include<stdio.h>
#include<stdlib.h>
#include<string.h>

/*FILE *fopen(const char *filename, const char *mode);*/



main(int argc,char * argv[])
{
  FILE  *outNow,*outPrev;
  float temp1,temp2;
  char *inpstr;
  int n,i;
  
 
 

  system("rm temp");
  
  inpstr = "lx < inLx >temp"; 

  system(inpstr);

 
  outNow  = fopen("temp","r");
  outPrev = fopen("outLx","r");    /*open the file written and previous output file */
 
 

  n=0;
  while( fscanf(outNow,"%f",&temp1) != EOF |  fscanf(outPrev,"%f",&temp2) != EOF )
    { 
      if(temp1 != temp2)
	{
	  n=1;
	}
    }

  fclose(outNow);
  fclose(outPrev);
  
  if(n==1)
    {
      fprintf(stderr,"Lx was not ok");
   
    }else{
      fprintf(stderr,"Lx was  ok");
     
    }
  
  
}



