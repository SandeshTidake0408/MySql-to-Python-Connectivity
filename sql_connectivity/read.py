import mysql.connector as c
con = c.connect(host="localhost", user="root",
                passwd="SDT123@#", database="TECO2324A020")

cursor = con.cursor()
cursor.execute("select *from emp")
# data = cursor.fetchone()
data = cursor.fetchmany(2)
# data = cursor.fetchall()
# print(data)
for i in data:
    print(i)
