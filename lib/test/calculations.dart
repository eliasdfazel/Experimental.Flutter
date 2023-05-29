/* *
Click A then Find B, C, D
Create Entry As Pair of AppPackages then Use Counter to Increase Importance!
Number Of Database ->



A, B, C
->
Section 1
1. A-B
2. A-C

Section 2
3. B-C



A, B, C, D
->
Section 1
1. A-B
2. A-C
3. A-D

Section 2
4. B-C
5. B-D

Section 3
6. C-D



A, B, C, D, E
->
Section 1
1. A-B
2. A-C
3. A-D
4. A-E

Section 2
5. B-C
6. B-D
7. B-E

Section 3
8. C-D
9. C-E

Section 4
10. D-E



A, B, C, D, E, F
->
Section 1
1. A-B
2. A-C
3. A-D
4. A-E
5. A-F

Section 2
6. B-C
7. B-D
8. B-E
9. B-F

Section 3
10. C-D
11. C-E
12. C-F

Section 4
13. D-E
14. D-F

Section 5
15. E-F

3   ->   3
4   ->   6
5   ->   10
6   ->   15
* */

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

  }

}