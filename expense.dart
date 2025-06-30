import 'dart:io';

Map<String, double> expense = {};
bool run = true;
double total = 0;

void main() {
  while (run) {
    clearTerminal();
    print("--------------------------");
    print(
      " 1.Add Expense \n 2.View Expense \n 3.DeletExpense \n 4.Edit Expense \n 5.Clear full Data  \n 6.Quit  \n Enter your Choice: ",
    );
    try {
      int? choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          print("Add Expense: ");
          addExpense();
          break;
        case 2:
          ViewExpense();
          break;
        case 3:
          clearTerminal();
          deleteExpense();
          break;
        case 4:
          editExpense();
          break;
        case 5:
          clearExpense();
          print("Every Data Cleared");
          break;
        case 6:
          clearTerminal();
          print("Thank you");
          run = false;
          break;
        default:
          print("enter a Valid input");
      }
    } catch (e) {
      clearTerminal();
      print("!!You should enter the number of the choice!!");
    }
  }
}

void addExpense() {
  clearTerminal();
  print("Enter your Expense name: ");
  String expenseName = stdin.readLineSync()!;
  if (expenseName.isEmpty) {
    print("invaild");
    return;
  }
  if (expense.containsKey(expenseName)) {
    clearTerminal();
    print("same name found");
    return;
  }
  print("Enter the Amount");
  String? input = stdin.readLineSync();

  double? amount;
  try {
    amount = double.parse(input!);
    if (amount == Null || amount <= 0) {
      clearTerminal();
      print("invalid Amount");
      return;
    }
  } catch (e) {
    clearTerminal();
    print("!!!you must enter a number!!!");
    return;
  }

  expense[expenseName] = amount;
  total = total + amount;
}

void ViewExpense() {
  clearTerminal();
  print("===Expense Tracker===");
  if (expense.isEmpty) {
    print(" !! Enter an Expense !!!!");
  }
  expense.forEach((key, value) => print("Name: $key  Amount: $value \n "));
  print("Total = \t$total");
}

void deleteExpense() {
  clearTerminal();
  ViewExpense();
  print("Enter Your Expense to Delete");
  String? deleteExpense = stdin.readLineSync();
  clearTerminal();
  if (!expense.containsKey(deleteExpense)) {
    print("not founded");
  } else {
    expense.containsKey(deleteExpense);
    double? deletedValue = expense[deleteExpense];
    expense.remove(deleteExpense);
    total = total - deletedValue!;
    print("Updated List ");
    ViewExpense();
  }
}

void editExpense() {
  if (expense.isEmpty) {
    print(" !! Expense is Empty !!");

    return;
  }
  ViewExpense();

  print("Enter the Expensne Name to edit: ");
  String? editExpenseName = stdin.readLineSync();
  if (expense.containsKey(editExpenseName)) {
    print("1.Edit Expense Name:  \n2.Edit Expense Amount: \n3.Edit Both");
    int? editChoice = int.parse(stdin.readLineSync()!);
    try {
      switch (editChoice) {
        case 1:
          print("Enter the New Name");
          String? editName = stdin.readLineSync();
          if (!expense.containsKey(editName)) {
            double oldName = expense[editExpenseName]!;
            expense.remove(editExpenseName);

            expense[editName!] = oldName;
            ViewExpense();
          } else {
            print("existing name");
          }

        case 2:
          print("Enter the new Amount: ");
          double? editAmount = double.parse(stdin.readLineSync()!);
          double oldtotal = expense[editExpenseName]!;
          total = total - oldtotal;
          total = total + editAmount;
          print(total);
          expense[editExpenseName!] = editAmount;
          ViewExpense();
          break;
        case 3:
          print("Enter the new Name");
          String? editNameBoth = stdin.readLineSync();
          double oldNameBoth =0;
          if (!expense.containsKey(editNameBoth)) {
           oldNameBoth =
                expense[editExpenseName]!; //here we just take the old name and assign the value to newvarabile named as oldName and then remove the existing name which we want to edit then it assign to the new name
            expense.remove(editExpenseName);
            expense[editNameBoth!] = oldNameBoth;
          } else {
            print("exisitng");
          }

          print("Enter the New Amount");
          double? newAmountBoth = double.parse(stdin.readLineSync()!);
          total = total - oldNameBoth;
          total = total + newAmountBoth;
          expense[editNameBoth!] = newAmountBoth;
          ViewExpense();
          break;
      }
    } catch (e) {
      print("Enter a valid ");
    }
  } else {
    print("Expense name not founded");
    return;
  }
}

void clearExpense() {
  clearTerminal();
  expense.clear();
}

void clearTerminal() {
  print("\x1B[2J\x1B[0;0H");
}
