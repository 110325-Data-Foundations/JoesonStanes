#File handling in python
import json

#We can interact with giles directky from within our appp this is usedful for things like text files json fiels and many more like binary strings such as images
# Write content to the file
with open('testfile.txt', "w") as file:
    file.write("Hello\n")
    file.write("Today is a good day")

#the secind thing we can optionnaly pass is a mode
# "r" reading a file will raise an exception if the file doest exist 
# "w" opens the fiel for writing this truncate the data within 
# "a" opens te file for appending if the file exists it writes onto the end of the file 
#"x" creates a files thath we can work with later will raise an exception of the file does exist or if it alredy exist 
# By default pytin assumes we are readig a file as text.

# Read the content back from the file
with open('testfile.txt', "r") as file:
    file_cont = file.read()


#Module is just a .py fiels which has python code in it and t=you could you it the functions and files inside to twork wit#

#JSON is a way to store and exchange data.

with open("json_test.json","w") as jfile:
    #By default you built in json module can map certain data types/default objects 
    #lists strings integers float boolean ,none type and dictionaries
    list_of_names=["Joe","bob","albert"]
    json_names =json.dumps(list_of_names)
    print(json_names)
    jfile.write(json_names+"\n")
    pancakes={"name":"pancakes","price":8.99}



    jfile.write(json.dumps(pancakes))

with open("ellie.json", "r") as efile:
    ellie = json.load(efile)
    print(ellie)
    
