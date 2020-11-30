#include <stdio.h>
int main() {
	int i = 4;
	//~ L1:
	for (;;) {
		L1__continue: {}
		printf("%d\n", i);
		i++;
		if (i < 8) {
			goto L1__continue;
		} else {
			goto L1__break;
		}
	}
	L1__break: {}
}
