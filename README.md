# teaching-apps
A repository for HTML apps to support CourseKata teaching. Here are the current apps:

## 1. Shuffle Demo
This is an app to support students' understanding of the `shuffle()` function in R. It takes in data from two groups with 5 cases in each group. In the url, you can define the 10 datapoints, the name of the outcome variable, the name of the grouping variable, and the names of each of the two categories for the grouping variable. Here's an example to show how data and label's are embeded in the url. You simply start the url with a link like this

> https://coursekata.github.io/teaching-apps/shuffle-demo-6.html
 
Then add the custom settings right afterwards starting with ?data...
Here's an example:

> ...html?data=72,68,75,71,74,58,62,55,60,59&groupA=Treatment&groupB=Control&outcome=Score&group=Condition

You also can configure which of the three tabs to show by adding at the end, for example, `&tabs=1,2`. This would show only the first two tabs. If not specified, all tabs appear by default.

And finally, showing hands shuffling is the default, but if you add &hands=false to the url it will turn the hands off.

## 2. Confidence Demo
This is an app for grounding discussions about the concept of confidence interval. Here's a link to the app:

> https://coursekata.github.io/teaching-apps/confidence-demo-3.html

Several parameters can be set within the url:

- beta - Population Mean (default: 0)
- se - Standard Error (default: 1)
- labels - LaTeX notation for labels (optional)

The labels setting can include these elements, separated by commas:

- Population parameter (labelParam)
- Sample statistic (labelSampleStat)
- Sampling mean (labelSamplingMean)

For example, you could add this to the url: 

- ?beta=5&se=2&labels=$\beta_1$,$b_1$,$\bar{b}_1$   -or-
- ?beta=100&se=15&labels=$\mu$,$\bar{X}$,$E[\bar{X}]$

## 3. Regression Line Demo
This is an app that lets us explore whether changing the $b_0$ and $b_1$ of the best-fitting line can possibly reduce the Sum of Squares Error from a regression model. 

You can specify variable names and data points in the url. Here's an example for one dataset:

> https://coursekata.github.io/teaching-apps/regression-line-1.html?xlabel=active&ylabel=exam&x=40,53,45,21,68,60,82,11,34,75&y=83,85,75,70,84,88,79,66,71,68
