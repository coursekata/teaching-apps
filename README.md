# teaching-apps
A repository for HTML apps to support CourseKata teaching. Here are the current apps:

## 1. Shuffle Demo
This is an app to support students' understanding of the `shuffle()` function in R. It takes in data from two groups with 5 cases in each group. In the url, you can define the 10 datapoints, the name of the outcome variable, the name of the grouping variable, and the names of each of the two categories for the grouping variable. Here's an example to show how data and label's are embeded in the url. You simply start the url with a link like this

> https://coursekata.github.io/teaching-apps/shuffle-demo-6.html
 
Then add the custom settings right afterwards starting with ?data...
Here's an example:

> ...html?data=72,68,75,71,74,58,62,55,60,59&groupA=Treatment&groupB=Control&outcome=Score&group=Condition

You also can configure which of the three tabs to show by adding at the end, for example, `&tabs=1,2`. This would show only the first two tabs. If not specified, all tabs appear by default.

We have a simple app to generate a url based on your requirements; it is 

> https://coursekata.github.io/teaching-apps/shuffle-url-generator.html

And finally, showing hands shuffling is the default, but if you add &hands=false to the url it will turn the hands off.

## 2. Confidence Demo
This is an app for grounding discussions about the concept of confidence interval. Here's a link to the app:

> https://coursekata.github.io/teaching-apps/confidence-demo-4.html

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

# Draggable Histogram - URL Parameters Reference

This document describes all URL parameters that can be used to customize the draggable histogram visualization.

## Display Mode Parameters

These parameters control which visualization features are enabled by default.

| Parameter | Options | Default | Description |
|-----------|---------|---------|-------------|
| `histogram` | `on`, `off` | `on` | Show or hide histogram bars |
| `curve` | `off`, `normal`, `t` | `off` | Set curve overlay mode (none, normal distribution, or t-distribution) |
| `alpha` | `off`, `.10`, `.05`, `.01` | `off` | Set alpha level (α=.10, α=.05, α=.01). For backwards compatibility, also accepts `90`, `95`, `99` (converted to `.10`, `.05`, `.01`) |
| `seconddist` | `on`, `off` | `off` | Enable the second distribution (β′) |
| `powermode` | `tails`, `power` | `tails` | Set shading mode for second distribution (tail shading or power analysis) |
| `vertlines` | `on`, `off` | `off` | Show vertical confidence interval lines |

### Examples

```
?histogram=off&curve=normal
?curve=t&alpha=.05
?seconddist=on&powermode=power&alpha=.05
```

## Default Value Parameters

These parameters set the initial values for various controls.

| Parameter | Type | Default | Range/Notes | Description |
|-----------|------|---------|-------------|-------------|
| `beta` | number | `0` | any number | Population parameter value (β) |
| `se` | number | `1` | > 0 | Standard error |
| `df` | integer | `10` | ≥ 1 | Degrees of freedom (for t-distribution) |
| `n` | integer | `1000` | 10-200000 | Number of random draws to simulate |
| `scale` | number | `1.75` | 0.5-3+ | Horizontal scale/zoom level |
| `bins` | integer | `30` | 1-200 | Number of histogram bins |

### Examples

```
?beta=5&se=2&n=5000
?beta=0&se=1.5&df=15&curve=t
?scale=2.5&bins=50
```

## Hide Control Parameters

These parameters hide specific UI controls. All hide parameters use the format `hide_[control]=true`.

| Parameter | Description |
|-----------|-------------|
| `hide_simulate` | Hide the "Simulate" button |
| `hide_beta` | Hide the β input field |
| `hide_se` | Hide the SE input and slider |
| `hide_n` | Hide the n draws input |
| `hide_scale` | Hide the Scale slider |
| `hide_bins` | Hide the Bins slider |
| `hide_curve` | Hide the curve mode selector (Off/N/t buttons) |
| `hide_df` | Hide the degrees of freedom input |
| `hide_ci` | Hide the alpha level selector buttons |
| `hide_vertlines` | Hide the vertical lines toggle button |
| `hide_histogram` | Hide the histogram toggle button |
| `hide_seconddist` | Hide the β′ button and power mode selector |
| `hide_powermode` | Hide only the power mode selector (Tails/Power) |
| `hide_b` | Hide the b input and Update button |

### Examples

```
?hide_simulate=true&hide_scale=true
?hide_beta=true&hide_se=true&beta=5&se=2
?hide_n=true&hide_bins=true&hide_scale=true
```

## Label Customization

The `labels` parameter allows you to customize the variable names displayed in the visualization using LaTeX notation.

| Parameter | Format | Default | Description |
|-----------|--------|---------|-------------|
| `labels` | `param,stat,mean` | `\beta,b,\bar{b}` | Comma-separated LaTeX strings for: population parameter, sample statistic, and sampling mean |

**Notes:**
- Enclose LaTeX in the URL without dollar signs
- Use URL encoding for special characters if needed
- Greek letters: `\alpha`, `\beta`, `\mu`, `\sigma`, etc.
- Common notation: `\bar{x}` (x-bar), `\hat{p}` (p-hat), `x_0` (subscript)

### Examples

```
?labels=\mu,\bar{x},\bar{x}
?labels=p,\hat{p},\bar{\hat{p}}
?labels=\theta,t,\bar{t}
```

## Complete Examples

### Example 1: Simple t-test demonstration
```
?beta=0&se=2&n=1000&curve=t&df=20&alpha=.05&hide_scale=true&hide_bins=true
```
Shows a t-distribution with α=.05, hides some advanced controls.

### Example 2: Power analysis
```
?beta=0&se=1&seconddist=on&curve=normal&alpha=.05&powermode=power&labels=\mu_0,\bar{x},\bar{x}
```
Set up for demonstrating statistical power with customized labels.

### Example 3: Minimal interface
```
?histogram=off&curve=normal&alpha=.05&hide_simulate=true&hide_scale=true&hide_bins=true&hide_curve=true&hide_df=true&hide_vertlines=true&hide_histogram=true&hide_seconddist=true
```
Shows only the essential visualization with most controls hidden.

### Example 4: Proportion testing
```
?beta=0.5&se=0.05&labels=p,\hat{p},\bar{\hat{p}}&curve=normal&alpha=.05&n=1000
```
Configured for demonstrating proportion hypothesis testing.

### Example 5: Custom scenario with locked parameters
```
?beta=10&se=3&n=2000&bins=40&curve=normal&alpha=.01&hide_beta=true&hide_se=true&hide_n=true
```
Shows a specific scenario with parameters locked (hidden from user control).

## URL Parameter Tips

1. **Combine parameters** with `&`: `?param1=value1&param2=value2`
2. **Order doesn't matter**: Parameters can be in any sequence
3. **Case sensitive**: Use lowercase for parameter names
4. **Boolean values**: Use `true` for hide parameters, `on`/`off` for toggle parameters
5. **URL encoding**: Special characters in labels may need encoding (e.g., spaces as `%20`)
6. **Alpha values**: Use `.10`, `.05`, `.01` for alpha levels (old values `90`, `95`, `99` still work for backwards compatibility)

## Common Use Cases

### Teaching Confidence Intervals
```
?beta=0&se=1&curve=normal&alpha=.05&hide_seconddist=true
```

### Demonstrating Type I vs Type II Errors
```
?seconddist=on&powermode=power&alpha=.05&curve=normal&vertlines=on
```

### Fixed Scenario Exploration
```
?beta=5&se=2&hide_beta=true&hide_se=true&hide_simulate=true&curve=normal
```

### T-distribution Comparison
```
?curve=t&df=5&alpha=.05&hide_seconddist=true
```


## 3. Regression Line Demo
This is an app that lets us explore whether changing the $b_0$ and $b_1$ of the best-fitting line can possibly reduce the Sum of Squares Error from a regression model. 

You can specify variable names and data points in the url. Here's an example for one dataset:

> https://coursekata.github.io/teaching-apps/regression-line-1.html?xlabel=active&ylabel=exam&x=40,53,45,21,68,60,82,11,34,75&y=83,85,75,70,84,88,79,66,71,68
