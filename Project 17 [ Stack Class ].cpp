#include <iostream>
#include "clsMyStack.h"

using namespace std;

int main()
{
    clsMyStack <short> MyStack;

    MyStack.Push(10);
    MyStack.Push(20);
    MyStack.Push(30);
    MyStack.Push(40);
    MyStack.Push(50);

    cout << "\nStack :\n";
    MyStack.Print();

    cout << "\nStack Size  : " << MyStack.Size() << endl;
    cout << "\nStack Top : " << MyStack.Top() << endl;
    cout << "\nStack Bottom  : " << MyStack.Bottom() << endl;

    MyStack.Pop();
    cout << "\n\nStack after pop() :\n";
    MyStack.Print();

    cout << "\n\nItem (2) : " << MyStack.GetItem(2);

    MyStack.Reverse();
    cout << "\n\nStack after Reverse() :\n";
    MyStack.Print();

    MyStack.UpdateItem(2, 600);
    cout << "\n\nStack after updating Item(2) to 600 :\n";
    MyStack.Print();

    MyStack.InsertAfter(2, 800);
    cout << "\n\nStack after Inserting 800 after Item(2) :\n";
    MyStack.Print();

    MyStack.InsertAtFront(1000);
    cout << "\n\nStack after Inserting 1000 at Front :\n";
    MyStack.Print();

    MyStack.InsertAtBack(2000);
    cout << "\n\nStack after Inserting 2000 at Back :\n";
    MyStack.Print();

    MyStack.Clear();
    cout << "\n\nStack after Clear() :\n";
    MyStack.Print();

    system("pause>0");
    return 0;
}