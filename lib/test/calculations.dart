
void main() async {

  List<int> allData = [];

  List.generate(111, (index) => {
    allData.add(index)
  });

  calculate(allData.length);

}

int loopCounter = 1;

int initialCounter = 1;

void calculate(int lengthValue) {

  for (int i = initialCounter; i < lengthValue; i++) {

    loopCounter++;

  }

  initialCounter++;

  if (initialCounter < lengthValue) {

    calculate(lengthValue);

  } else {

    print(">>> >> > ${loopCounter - 1}");

  }

}