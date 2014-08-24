The entire code in run_analysis works in 3 chunks:

##Part 1: Collecting data and preparing for analysis
First section of the code downloads the zip file, unzips it and stores all relevant data in memory

##Part 2: Cleaning, combining data and making it interpretable
Secondly, the data frames are given column names from the features data frame which makes the variables interpretable. The test datasets are merged together to create a uniform data frame (test_data) and similarly for the train datasets (train_data). Both these datasets are then combined together resulting in master_data. The data is further augmented by adding the descriptive activity names.

##Part 3: Create the two required tidy data sets
This chunk of the code takes the combined data set and then takes only those columns which are related to mean and std dev. To achieve this, all column names that have mean and std dev are selected and the data about subject and activity is retained. This gives selected_data which is one of the required outputs.
The second dataset requires an average of each variable for each subject and each activity. This is prepared using the aggregate function and is stored in tidy_data.