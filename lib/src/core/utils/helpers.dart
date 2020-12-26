// Helper function to check possible combinations
bool hasPossibleCombinations(List<int> arr, int n) {
  if (arr.contains(n)) {
    return true;
  }

  if (arr[0] > n) {
    return false;
  }

  if (arr[arr.length - 1] > n) {
    arr.removeLast();
    return hasPossibleCombinations(arr, n);
  }

  final combinationsCount = (1 << arr.length);

  for (int i = 1; i < combinationsCount; i++) {
    int combinationSum = 0;
    for (int j = 0; j < arr.length; j++) {
      if (i & (1 << j) > 0) {
        combinationSum += arr[j];
      }
    }
    if (n == combinationSum) {
      return true;
    }
  }
  return false;
}