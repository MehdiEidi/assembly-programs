// Longest Increasing Sequence (Inline Assembly)

#include <iostream>
using namespace std;

int main() {
	cout << "Enter the array's Length: " << endl;
	int arrLength;
	cin >> arrLength;

	cout << "Enter the elements: " << endl;
	int* arr = new int[arrLength];
	for (int i = 0; i < arrLength; i++) {
		cin >> arr[i];
	}

	int maxCount = 1;		// Count of the longest increasing sequence
	int maxEndIndex = 1;    // Ending index of the longest increasing sequence
	int tempCount = 1;		// The current increasing seqences count 

	for (int i = 1; i < arrLength; i++) {
		__asm {
			mov eax, i
			mov ebx, TYPE arr		// int is 4 bytes in my machine
			mul ebx					// eax = eax * ebx, ebx == 4
			add eax, arr			// eax = arr[i]
			mov ecx, eax			// ecx = arr[i]

			mov eax, i
			sub eax, 1				// i-1
			mov ebx, TYPE arr		// int is 4 byts in my machine
			mul ebx					// eax = eax * ebx, ebx == 4
			add eax, arr			// eax = arr[i-1]

			mov ecx, [ecx]			// ecx = arr[i]
			mov eax, [eax]			// eax = arr[i-1]
			cmp ecx, eax
			jg INCREASE				// if arr[i] > arr[i-1] 
			jle NOTINCREASE			// if not (arr[i] > arr[i-1])

		INCREASE :
			mov eax, tempCount
			inc eax
			mov tempCount, eax		// tempCount++

			mov eax, arrLength
			dec eax					// arrLength - 1
			mov ecx, i
			cmp ecx, eax
			je WHOLE				// if i == arrLength - 1
			jmp L3

		WHOLE :
			mov eax, tempCount
			mov ecx, maxCount
			cmp eax, ecx
			jg L1					// if tempCount > maxCount
			jmp L3

		L1 :
			mov eax, tempCount
			mov maxCount, eax		// maxCount = tempCount
			mov eax, i
			mov maxEndIndex, eax	// maxIndex = i
			jmp L3

		NOTINCREASE :
			mov eax, tempCount
			mov ecx, maxCount
			cmp eax, ecx
			jg L2					// if tempCount > maxCount
			jmp L3

		L2 :
			mov eax, tempCount
			mov maxCount, eax		// maxCount = tempCount
			mov tempCount, 1		// tempCount = 1
			mov eax, i
			dec eax					// i-1
			mov maxEndIndex, eax	// maxEndIndex = i-1

		L3 :
		}
	}

	cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
	cout << "Start index of Sequence: " << maxEndIndex - maxCount + 1 << endl;
	cout << "LIS Length: " << maxCount << endl;
	cout << "Sequence: ";
	for (int i = maxEndIndex - maxCount + 1; i <= maxEndIndex; i++) {
		cout << arr[i] << " ";
	}
	cout << endl;

	return 0;
}