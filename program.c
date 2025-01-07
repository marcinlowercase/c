#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
	long l;
	int i;
	short s;
	char c;
	float f;
	double d;

	printf("Hello, world!\n");
	printf("Size of long: %d\n", sizeof(l));
	printf("Size of int: %d\n", sizeof(i));
	printf("Size of short: %d\n", sizeof(s));
	printf("Size of char: %d\n", sizeof(c));
	printf("Size of float: %d\n", sizeof(f));
	printf("Size of double: %d\n", sizeof(d));

	return EXIT_SUCCESS;
}
