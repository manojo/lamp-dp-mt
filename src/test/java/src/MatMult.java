import java.util.Random;

public class MatMult {
    private int[] mat;
    private int[] in;

    MatMult(int size) {
        Random r = new Random(0x123456789L);
        in = new int[size*2];
        in[0]=r.nextInt()%3247;
        for (int i=1;i<size;++i) {
            in[i]=(i&1)==1 ? r.nextInt() : in[i-1];
        }
        long time = System.currentTimeMillis();
        mat = new int[size*size];
        for (int i=size-1;i>=0;--i) {
            mat[i*size+i]=0;
            for (int j=i+1;j<size;++j) {
                int t = 0x7fffffff;
                for (int k=i;k<j;++k) {
                    int t2 = mat[i*size+k] + mat[(k+1)*size+j] + in[i*2] * in[k*2+1] * in[j*2+1];
                    if (t2<t) t=t2;
                }
                mat[i*size+j] = t;
            }
        }
        time = System.currentTimeMillis() - time;
        System.out.println("Time("+size+") = "+time+" ms");
    }


    public static void main(String[] args) {
        new MatMult(1024); // 1265 ms
        new MatMult(2048); // 22051 ms >> 1265*8 = 10120 ms
    }
}
