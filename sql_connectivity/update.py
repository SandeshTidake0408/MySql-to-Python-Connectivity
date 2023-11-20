import mysql.connector as c
con = c.connect(host="localhost", user="root",
                passwd="SDT123@#", database="TECO2324A020")
while True:
    cursor = con.cursor()
    id = int(input("Enter the Employee Id for which do you want to change Salary: "))
    salary = int(input("Enter the New Salary: "))
    query = "update emp set salary = {} where id = {}".format(salary, id)
    cursor.execute(query)
    con.commit()
    if cursor.rowcount > 0:
        print("Salary Updated Successfully..")
    else:
        print("No Data Found!!!")
    exit = input("Do you Want to Update Again...(y/n): ")
    if (exit == "Y" or "y"):
        continue
    else:
        break
