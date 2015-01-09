#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "mpi.h"


#define KBdata 32768 //openmpi default buffer size
#define ndata KBdata/4 //number of ints that fit in buffer

int main(int argc, char *argv[]) {
	
	int myid, numprocs;
    int tag,source,destination,count;
    int buffer[ndata*2];
    MPI_Status status;
    MPI_Request request;
    
    int iter = 20;
    
    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    
    if (myid == 0 && numprocs == 2) 
    {
		int recvID = 1;
		double acum = 0;
		int i, tam = 3;
		double startT;
		for (i = 0; i < ndata*2; ++i) 
		{
			buffer[i] = i;
		}
		while (tam < ndata) 
		{
			double startTime = MPI_Wtime();
			
			MPI_Send(&buffer,tam,MPI_INT,recvID,0,MPI_COMM_WORLD);
			
			double endTime = MPI_Wtime();
			double elapsed = endTime - startTime;
			acum += elapsed;
			printf("%d, %f, elapsed: %f\n",tam,acum,elapsed);fflush(stdout);
			tam += 2;
		}
		printf("total: %f\nmean: %f\n", acum, acum/iter);	
	}
	else if (numprocs == 2) 
	{
		int i, tam = 3;
		sleep(10);
		while (tam < ndata) 
		{
			MPI_Recv(&buffer,ndata,MPI_INT,0,0,MPI_COMM_WORLD,&status);
			tam += 2;
		}
	}
	else 
	{
		printf("Need only 2 threads\n");
	}
    
   	MPI_Finalize();

    
    return 0;
}