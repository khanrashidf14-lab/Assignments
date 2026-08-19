#include <studio.h>
struct Buffer{
	int block;
	int data;
	int busy;
	int dwrite;
};
struct buffer b;

void bwrite(){
	if(b.dwrite){
		printf("\n Writing block % d to disk....\n",b.block);
		printf("Data written:%d \n",b.data);

		b.write = 0;
	}
	b.busy = 0;
	printf("Buffer released.\n");
	printf("Buffer added to free list.\n");
	}
int main(){
	printf("Enter block no.:");
	scanf("%d",&b.block);	

	printf("Enter data:");
	scanf("%d",&b.data);

	printf("Enter busy status(0 =free,1 = busy):");
	scanf("%d",&b.busy);

	printf("Enter delayed write status(0 =No,1=yes):");
	scanf("%d",&b.dwrite);

	printf("\n Before bwrite():\n");
	printf("Block =%d \n",b.block);
	printf("Data =%d \n",b.data);
	printf("Busy =%d \n",b.busy);
	printf("Delayed write =%d \n",b.write);

	printf("\n After bwrite():\n");
	printf("Busy =%d \n",b.busy);
	printf("Delayed write =%d \n",b.write);

	return 0;
}