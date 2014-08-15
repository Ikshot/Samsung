# codebook
Valeriy V. Artukhin  
Friday, August 15, 2014  

*tidyData.txt* is a stripped and aggregated version of *Human Activity Recognition Using Smartphones Dataset*. Raw data was processed, columns with mean and standart deviation of features (68 variables in total) aggregated (averaged) on type of activity and each subject as explained in *README.md*. There were 6 types of activities and 30 subjects, so resulting dataset consists of 180 rows.

Dataset contains followinf columns:

- **Activity** - descriptive name of activity performed (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS).
- **Subject** - numeric code of the subject who performed activity ([1:30]).
- other 66 columns are averaged on activity type and subject versions of corresponding columns in the initial raw dataset.
