#pragma once
#include <iostream>

using namespace std;

template <class T>
class clsDblLinkedList
{
protected:

	int _Size = 0;

public:

	class Node
	{
	public:

		T Value;
		Node* Next;
		Node* Prev;
	};

	Node* Head = NULL;

	void PrintList()
	{
		Node* Current = Head;

		while (Current != NULL)
		{
			cout << Current->Value << " ";

			Current = Current->Next;
		}

		cout << "\n";
	}

	Node* Find(T Value)
	{
		Node* Current = Head;

		while (Current != NULL)
		{
			if (Current->Value == Value)
				return Current;

			Current = Current->Next;
		}

		return NULL;
	}

	void InsertAtBeginning(T Value)
	{
		Node* NewNode = new Node;

		NewNode->Value = Value;
		NewNode->Next = Head;
		NewNode->Prev = NULL;

		if (Head != NULL)
		{
			Head->Prev = NewNode;
		}

		Head = NewNode;

		_Size++;
	}

	void InsertAfter(Node* Current, T Value)
	{
		if (Current == NULL)
		{
			return;
		}

		Node* NewNode = new Node;

		NewNode->Value = Value;
		NewNode->Next = Current->Next;
		NewNode->Prev = Current;

		if (Current->Next != NULL)
		{
			Current->Next->Prev = NewNode;
		}

		Current->Next = NewNode;

		_Size++;
	}

	void InsertAtEnd(T Value)
	{
		Node* NewNode = new Node;

		NewNode->Value = Value;
		NewNode->Next = NULL;

		if (Head == NULL)
		{
			NewNode->Prev = NULL;
			Head = NewNode;
		}
		else
		{
			Node* LastNode = Head;

			while (LastNode->Next != NULL)
			{
				LastNode = LastNode->Next;
			}

			NewNode->Prev = LastNode;
			LastNode->Next = NewNode;
		}

		_Size++;
	}

	void DeleteNode(Node*& NodeToDelete)
	{
		if (Head == NULL || NodeToDelete == NULL)
		{
			return;
		}

		if (Head == NodeToDelete)
		{
			Head = NodeToDelete->Next;
		}

		if (NodeToDelete->Next != NULL)
		{
			NodeToDelete->Next->Prev = NodeToDelete->Prev;
		}

		if (NodeToDelete->Prev != NULL)
		{
			NodeToDelete->Prev->Next = NodeToDelete->Next;
		}

		delete NodeToDelete;

		_Size--;
	}

	void DeleteFirstNode()
	{
		if (Head == NULL)
		{
			return;
		}

		Node* Temp = Head;

		Head = Head->Next;

		if (Head != NULL)
		{
			Head->Prev = NULL;
		}

		delete Temp;

		_Size--;
	}

	void DeleteLastNode()
	{
		if (Head == NULL)
		{
			return;
		}

		if (Head->Next == NULL)
		{
			delete Head;
			Head = NULL;
			_Size--;
			return;
		}

		Node* Currenct = Head;

		while (Currenct->Next->Next != NULL)
		{
			Currenct = Currenct->Next;
		}

		Node* Temp = Currenct->Next;

		Currenct->Next = NULL;
		delete Temp;

		_Size--;
	}

	int Size()
	{
		return _Size;
	}

	bool IsEmpty()
	{
		return (_Size == 0);
	}

	void Clear()
	{
		while (!IsEmpty())
		{
			DeleteFirstNode();
		}
	}

	void Reverse()
	{
		Node* Current = Head;
		Node* Temp = nullptr;

		while (Current != nullptr)
		{
			Temp = Current->Prev;
			Current->Prev = Current->Next;
			Current->Next = Temp;

			Current = Current->Prev;
		}

		if (Temp != nullptr)
		{
			Head = Temp->Prev;
		}
	}

	Node* GetNode(int Index)
	{
		if (Index > (_Size - 1) || Index < 0)
			return NULL;

		Node* Current = Head;
		int Counter = 0;

		while (Counter != Index)
		{
			Current = Current->Next;
			Counter++;
		}

		return Current;
	}

	T GetItem(int Index)
	{
		Node* ItemNode = GetNode(Index);

		if (ItemNode == NULL)
			return NULL;
		else
			return ItemNode->Value;
	}

	bool UpdateItem(int Index, T NewValue)
	{
		Node* ItemNode = GetNode(Index);

		if (ItemNode != NULL)
		{
			ItemNode->Value = NewValue;
			return true;
		}
		else
		{
			return false;
		}
	}

	bool InsertAfter(int Index, T Value)
	{
		Node* ItemNode = GetNode(Index);

		if (ItemNode != NULL)
		{
			InsertAfter(ItemNode, Value);
			return true;
		}
		else
		{
			return false;
		}
	}
};

