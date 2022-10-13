#include <stdio.h>
#include <math.h>

#define CACHE 256
enum { h_unknown = 0, h_yes, h_no };
unsigned char buf[CACHE] = {0, h_yes, 0};

//function declarations
int isHappy(int);
void fillArray(int,int);
void filter();
void swap(int *, int *);
void doubleSwap(double*,double*);
void bubbleSort(int *, int);
void normBubbleSort(double *, int);
void sortNorms();
double norm(int);

//globals
int numItems = 0, numHappies = 0;
int nums[1000], happies[1000];
double norms[1000];

// Asks the user for two positive integers
// and returns the 10 happy numbers between them
// with the greatest norms, sorted descending by the norms

// by Nate Jackson for CSC330

int main(){
	int x, y;
    printf("First Argument: ");
	scanf("%d",&x);
	printf("Second Argument: ");
	scanf("%d",&y);

	if (x == y){
		printf("NOBODYS HAPPY\n");
		return 1;
	}
	
	fillArray(x,y);
	filter();
	if (numHappies == 0){
		printf("NOBODYS HAPPY\n");
		return 1;
	}
	sortNorms();

	for (int i=0; i<10 && i<numHappies; i++) printf("%d\n",happies[i]);
	return 0;
}

//fills array with numbers between entered values
void fillArray(int x, int y){
	if (x > y){
		int i = x;
		x = y;
		y = i;
	}

	numItems = 0;
	for (int n = x; n <= y; n++){
		nums[numItems] = n;
		numItems++;
	}
}

//removes numbers from an array that are not happy
void filter() {
	numHappies = numItems;
	for (int i = 0; i < numItems; i++){
		if (!isHappy(nums[i])){
			nums[i] = 0;
			numHappies--;
		}
	}
	bubbleSort(nums, numItems);
	int numTrash = numItems-numHappies;
	for (int i = 0; i < numHappies; i++){
		happies[i] = nums[numTrash];
		numTrash++;
	}

}

//calls the norm of each happy number
//bubblesorts the happies by their norms
void sortNorms(){
	float n;
	for (int i = 0; i < numHappies; i++)
	{
		n = norm(happies[i]);
		norms[i] = n;
	}
	normBubbleSort(norms, numHappies);
}

//calculates the norm of a happy number
double norm(int n){
	int cache[1000], d = 0, cacheSize = 0;;
	double output = 0.0;
	while (n > 1){
		cache[cacheSize]=n;
		cacheSize++;
		int m = 0;
		while (n > 0){
			d = n % 10;
			m += d*d;
			n /= 10;
		}
		n = m;
	}
	
	for (int i = 0; i < cacheSize; i++){
		int j = cache[i] * cache[i];
		output += j;
	}
	output = sqrt(output);
	return output;
}

//determines if a number is happy
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

//from https://www.geeksforgeeks.org/c-program-for-bubble-sort/
void swap(int *xp, int *yp){
	int temp = *xp;
	*xp = *yp;
	*yp = temp;
}
//modified swap() to take doubles
void doubleSwap(double *xp, double *yp){
	double temp = *xp;
	*xp = *yp;
	*yp = temp;
}
// A function to implement bubble sort
//from https://www.geeksforgeeks.org/c-program-for-bubble-sort/
void bubbleSort(int arr[], int n){
	int i, j;
	for (i = 0; i < n-1; i++)
		// Last i elements are already in place
		for (j = 0; j < n-i-1; j++)
			if (arr[j] > arr[j+1]) swap(&arr[j], &arr[j+1]);
}

//same as bubbleSort(), but sorts the happies array
//in tandem with the argument norm array
void normBubbleSort(double arr[], int n){
	int i, j;
	for (i = 0; i < n-1; i++)
		for (j = 0; j < n-i-1; j++)
			if (arr[j] < arr[j+1]) {
				doubleSwap(&arr[j], &arr[j+1]);
				swap(&happies[j], &happies[j+1]);
			}
}

