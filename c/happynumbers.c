// using namespace std;
#include <stdio.h>

#define CACHE 256
enum { h_unknown = 0, h_yes, h_no };
unsigned char buf[CACHE] = {0, h_yes, 0};

struct happynumbers
{
	int happys[];
	int norms[];
};


int isHappy(int);
int* fillArray(int,int);

int main(){
	int x, y;
    printf("First Argument:");
	scanf("%d",&x);
	printf("Second Argument:");
	scanf("%d",&y);
	
	int* nums = fillArray(x,y);
	for (int i=0; i<sizeof(nums); i++) printf("%d",nums[i]);
}

int* fillArray(int x, int y){
	if (x > y){
		int i = x;
		x = y;
		y = i;
	}
	int* nums;
	int count = 0;
	for (int n = x; n < y; n++){
		nums[count] = n;
		count++;
	}
	return nums;
}



int isHappy(int n)
{
	int sum = 0, x, nn;
	if (n < CACHE) {
		if (buf[n]) return 2 - buf[n];
		buf[n] = h_no;
	}

	for (nn = n; nn; nn /= 10) x = nn % 10, sum += x * x;

	x = isHappy(sum);
	if (n < CACHE) buf[n] = 2 - x;
	return x;
}