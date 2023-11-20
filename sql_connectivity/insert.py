import mysql.connector as c
con = c.connect(host="localhost", user="root",
                passwd="SDT123@#", database="TECO2324A020")

cursor = con.cursor()

while True:
    id = int(input("Enter the Employee Id: "))
    name = input("Enter the Employee Name: ")
    salary = int(input("Enter the Salary of the Employee: "))
    query = "insert into emp(id, name, salary) values({},'{}',{})".format(
        id, name, salary)
    cursor.execute(query)
    con.commit()
    print("Inserted Successfuly..")
    exit = input("Do you Want to Insert Again...(y/n): ")
    if (exit == "Y" or "y"):
        continue
    else:
        break
