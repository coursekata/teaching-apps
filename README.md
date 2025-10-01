# teaching-apps
A repository for HTML apps to support CourseKata teaching. Here are the current apps:

## 1. Shuffle Demo
This is an app to support students' understanding of the `shuffle()` function in R. It takes in data from two groups with 5 cases in each group. In the url, you can define the 10 datapoints, the name of the outcome variable, the name of the grouping variable, and the names of each of the two categories for the grouping variable. Here's an example to show how data and label's are embeded in the url. You simply start the url with a link like this

> https://coursekata.github.io/teaching-apps/shuffle-demo-6.html
 
Then add the custom settings right afterwards starting with ?data...
Here's an example:

> ...html?data=72,68,75,71,74,58,62,55,60,59&groupA=Treatment&groupB=Control&outcome=Score&group=Condition

You also can configure which of the three tabs to show by adding at the end, for example, `&tabs=1,2`. This would show only the first two tabs. If not specified, all tabs appear by default.

## 2. Confidence Demo
This is an app for demonstrating the concept of confidence interval. Here's a link to the app:

> https://coursekata.github.io/teaching-apps/confidence-demo-11.html
