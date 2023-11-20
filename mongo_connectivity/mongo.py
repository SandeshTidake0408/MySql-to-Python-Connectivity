import pymongo

client = pymongo.MongoClient(
    "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.1")
dbN = client['new_db']
collectionN = dbN['new_collection']


def insert(data, collection):
    insert = collection.insert_one(data)
    if (insert):
        print("after inserting a data", insert.inserted_id)


def Read(data, collection):
    find = collection.find_one(data)
    if (find):
        print("data is--", find)


def updateRecord(dataF, dataU, collection):
    update = collection.update_one(dataF, dataU)
    if (update):
        print("updated", update)


def remove(data, collection):
    remove = collection.delete_one(data)
    if (remove):
        print("data removed", remove)


def getAllData(collection):
    data = collectionN.find()

    for document in data:
        print(document)


def deleteAllDocuments(collection):
    delete = collection.delete_many({})


def menu():
    print("1 for display menu")
    print("2 for  for insert")
    print("3 for read")
    print("4 for take update a record")

    print("5 for delete data")
    print("6 for delete all documents from collection")
    print("7 for display all data")
    print("10 for exit")


fail = 1

menu()
while fail != 10:
    digit = int(input("Enter your choice: "))

    if digit == 1:
        menu()
    elif digit == 2:

        roll = int(input("Enter roll: "))
        name = input("Enter name: ")
        age = int(input("Enter age: "))
        insert_data = {'roll': roll, 'name': name, 'age': age}
        insert(insert_data, collectionN)

    elif digit == 3:

        roll = int(input("Enter roll to read: "))
        read_data = {'roll': roll}
        Read(read_data, collectionN)
    elif digit == 4:
        roll = int(input("Enter roll to update: "))
        updated_dataF = {'roll': roll}
        new_name = input("Enter updated name: ")
        updated_dataU = {"$set": {"name": new_name}}
        updateRecord(updated_dataF, updated_dataU, collectionN)

    elif digit == 5:
        name = input("Enter name to delete: ")
        deleteF = {'name': name}
        remove(deleteF, collectionN)
        print("After removing")
    elif digit == 6:
        deleteAllDocuments(collectionN)
    elif digit == 7:
        getAllData(collectionN)
    elif digit == 10:
        fail = 10
    else:
        print("Invalid choice. Please select a valid option from the menu.")
