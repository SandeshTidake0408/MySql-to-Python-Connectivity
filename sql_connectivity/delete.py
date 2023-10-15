import mysql.connector as c
con = c.connect(host="localhost", user="root",
                passwd="SDT123@#", database="TECO2324A020")
while True:
    cursor = con.cursor()
    id = int(input("Enter the Employee id for Delete Employee: "))
    query = "delete from emp where id={}".format(id)
    cursor.execute(query)
    con.commit()
    if cursor.rowcount > 0:
        print("Employee Deleted Successfully..")
    else:
        print("No Data Found!!!")
    exit = input("Do you Want to Update Again...(y/n): ")
    if (exit == "n" or "N"):
        break
