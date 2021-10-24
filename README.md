
# Cyclistic-Bike-Share-Analysis

### OBJECTIVE

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?


## The data used here and our data sources

The dataset used: https://divvy-tripdata.s3.amazonaws.com/index.html

There is tripdata from 2003 to August 2021.

| Variable                     | Description                                                                                                                                                                                                                                |
|:-----------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `ride_id`                   | Rider's ID used                                                                                                                                                                                           |
| `rideable_type`                  | Cycle Type being used                                                                                                                                                                                                   |
| `started_at`                   | Start of Subscription                                                                                                                                                                                                                     |
| `ended_at`                       | End of Subscription                                                                                                                                                                                                                         |
| `member_casual`                 | Membership type: Annual or Casual Member                                                                                                                                                                                                                        |

## Data Preparation & Data Exploration

- We individually remove all the Features that aren't relevant to the problem.
- The Data we take from the Database is from 2020 to 2021 to get the most upto date data with the current pandemic changing everything.
- We start by preparing the New Database by loading all the dataset into to SQL Server.
- We first combine all the dataset to one including the duplicates to account for the resubscriptions.
- We now export the new dataset named Trips.csv.

## Data Cleaning & Data Analysis

- We start by Finding the Total Data Present which is 6,422,279.
- We then check the no. of Annual Members and no. of Casual Members
- Seeing that the sum of both the member type is lesser then the total data we filter the irrelevant Data out.
- We then Delete the junk Data.
- We filter out the incorrect dates to get the relevant dates.
- We then create a Duration column from the difference of ended_at and started_at column.
- We then start using aggregate functions to find intersting trends in the dataset.
- We export the cleaned dataset for visualization.

## Data Visualization

We then finally perform the Visualization in Tableau of :
        
        - Subscription Growth over time.
        - Subscription Distribution based on the Day.
        - Total Yearly Subscription
        - Average Subscription Duration
       

## Tableau Dashboard


[Dashboard](https://public.tableau.com/views/CyclisticMembership/Dashboard1?:language=en-GB&:display_count=n&:origin=viz_share_link)


## Authors


[Sumit Chaudhury](www.linkedin.com/in/sumit-chaudhury)

  
## License



[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
