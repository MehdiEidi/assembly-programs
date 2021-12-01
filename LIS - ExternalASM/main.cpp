// Longest Increasing Sequence (External Assembly Subroutine)

#include <iostream>
#include "LIS.h"
using namespace std;

int main() {
	cout << "Enter the array's length:" << endl;
	int arrLength;
	cin >> arrLength;

	cout << "Enter the elements:" << endl;
	int* arr = new int[arrLength];
	for (int i = 0; i < arrLength; i++) {
		cin >> arr[i];
	}

	// LIS is defined in an external assembly subroutine
	int maxStartIndex = LIS(arr, arrLength);

	int maxEndIndex = maxStartIndex;

	// Finding the maxEndIndex using maxStartIndex
	for (int i = maxStartIndex + 1; i < arrLength; i++) {
		if (arr[i] > arr[i - 1]) {
			maxEndIndex = i;
		} else {
			break;
		}
	}

	int maxCount = maxEndIndex - maxStartIndex + 1;

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