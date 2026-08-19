#include <stdio.h>
struct buffer{
int block;
int busy;
int valid;
};
struct buffer b;
void brelse(){
b.busy = 0;
printf("Buffer released.\n");
printf("Buffer inserted into freelist");
printf("Waking up waiting process...\n");
printf("Buffer status updated:Busy =%d\n",b.busy);
}
int main(){
printf("Enter blk no.");
scanf("%d",&b.block);
printf("Enter busy status(0=free,1=busy):");
scanf("%d",&b.busy);
printf("Enter valid status(0=invalid,1=valid):");
scanf("%d",&b.valid);
printf("\n Before brelse():\n");
printf("Block =%d\n ",b.block);
printf("busy =%d \n",b.busy);
printf("VAlid = 5d \n",b.valid);
printf("\n Executing brelse()....\n");
brelse();
printf("\n After brelse:"); 
printf("Block = %d \n",b.block);
printf("Busy = %d \n",b.busy);
printf("Valid = %d \n",b.valid);
reutrn 0;
}
