
import pandas as pd

df=pd.read_csv('Electric_Vehicle_Population_Data.csv')
#print(df.head)
print(df.info())
print(df.describe())
print(df.shape)
print(df.loc[5:1])

print(df.loc[0:5,['Model','Electric Range']])

#Data Filtering/Cleaninng
print(df.isna().sum())# Beyond subbing in some default values we can select and drop some values
# To replace nulls with missing values you can use fillna()
df.fillna(value='Missing',inplace=True)
# we can get more granular by column and column if we need to it depens on you data set ad your use case
#dropping rows that cointains any messing walues can be any values but yiu will loose values in the data frame