// Longest Increasing Sequence (Pure C++)

#include <iostream>
using namespace std;

int main() {
	cout << "Enter the array's length: " << endl;
	int arrLength;
	cin >> arrLength;

	cout << "Enter the elemetns: " << endl;
	int* arr = new int[arrLength];
	for (int i = 0; i < arrLength; i++) {
		cin >> arr[i];
	}

	int maxCount = 1;		// Count of the longest increasing sequence
	int maxEndIndex = 1;	// Ending index of the longest increasing sequence
	int tempCount = 1;		// The current increasing seqences count 

	for (int i = 1; i < arrLength; i++) {
		if (arr[i] > arr[i - 1]) {
			tempCount++;

			// If we have reached the end of the array and the whole array was increasing sequence
			if (i == arrLength - 1) {
				if (tempCount > maxCount) {
					maxCount = tempCount;
					tempCount = 1;
					maxEndIndex = i;
				}
			}
		}
		else {
			if (tempCount > maxCount) {
				maxCount = tempCount;
				tempCount = 1;
				maxEndIndex = i - 1;
			}
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