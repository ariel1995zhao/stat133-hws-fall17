HW-03
================
Tianshu Zhao
10/15/2017

Ranking of Teams
----------------

Basic Rankings
==============

``` r
library(ggplot2)
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)
library(scales)
```

    ## 
    ## Attaching package: 'scales'

    ## The following object is masked from 'package:readr':
    ## 
    ##     col_factor

``` r
setwd("/Users/ariel/stat133/stat133-hws-fall17/hw03")
teams <- read_csv('./data/nba2017-teams.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   team = col_character(),
    ##   experience = col_integer(),
    ##   salary = col_double(),
    ##   points3 = col_integer(),
    ##   points2 = col_integer(),
    ##   free_throws = col_integer(),
    ##   points = col_integer(),
    ##   off_rebounds = col_integer(),
    ##   def_rebounds = col_integer(),
    ##   assists = col_integer(),
    ##   steals = col_integer(),
    ##   blocks = col_integer(),
    ##   turnovers = col_integer(),
    ##   fouls = col_integer(),
    ##   efficiency = col_double()
    ## )

``` r
teams %>% ggplot() + geom_bar(aes(x=reorder(team, salary), y=salary/1e6), stat="Identity") +
   geom_hline(yintercept = mean(teams$salary) / 1e6, color = "orange", size = 2)+ 
  coord_flip() +
  xlab("Team") + ylab("Salary (in millions)") + 
  ggtitle("NBA Teams ranked by Total Salary")
```

![](hw03-Tianshu-Zhao_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-1.png)

``` r
teams %>% ggplot() + geom_bar(aes(x=reorder(team, points), y=points), stat="Identity") +
   geom_hline(yintercept = mean(teams$points), color = "red",size = 2) + coord_flip() +
  xlab("Team") + ylab("Points") +
  ggtitle("NBA Teams ranked by Total Points")
```

![](hw03-Tianshu-Zhao_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
teams %>% ggplot() + geom_bar(aes(x=reorder(team, efficiency), y=efficiency), stat="Identity") +
   geom_hline(yintercept = mean(teams$efficiency), color = "purple", size = 2) + coord_flip() +
  xlab("Team") + ylab("Efficiency") + ggtitle("NBA Teams ranked by Total Efficiency")
```

![](hw03-Tianshu-Zhao_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

Principal Components Analysis (PCA)
-----------------------------------

``` r
# select the variables that we are interested in from teams
team_new <- teams[, -c(1, 2, 3, 7, 15)]
# create pca object (containnig all the PC's)
pca <- prcomp(team_new, scale. = TRUE)
# add PC1 PC2 back to teams
teams_with_pc <- mutate(teams, pc1 = pca$x[ ,1], pc2 = pca$x[ ,2])
# rearrrange team by PC1 in descending order
select(arrange(teams_with_pc, desc(pc1)), team)
```

    ## # A tibble: 30 x 1
    ##     team
    ##    <chr>
    ##  1   GSW
    ##  2   MIN
    ##  3   SAS
    ##  4   PHO
    ##  5   LAC
    ##  6   BOS
    ##  7   OKC
    ##  8   MIL
    ##  9   MIA
    ## 10   DEN
    ## # ... with 20 more rows

Createa a data frame with the eigenvalues:

``` r
eigs <- data.frame(
  eigenvalue = round(pca$sdev^2, 4),
  prop = round(pca$sdev^2 / sum(pca$sdev^2), 4),
  cumprop = round(cumsum(pca$sdev^2 / sum(pca$sdev^2)), 4)
  )
eigs
```

    ##    eigenvalue   prop cumprop
    ## 1      4.6959 0.4696  0.4696
    ## 2      1.7020 0.1702  0.6398
    ## 3      0.9795 0.0980  0.7377
    ## 4      0.7717 0.0772  0.8149
    ## 5      0.5341 0.0534  0.8683
    ## 6      0.4780 0.0478  0.9161
    ## 7      0.3822 0.0382  0.9543
    ## 8      0.2603 0.0260  0.9804
    ## 9      0.1336 0.0134  0.9937
    ## 10     0.0627 0.0063  1.0000

``` r
teams_factors <- select(teams, points3, points2, free_throws, off_rebounds,
                        def_rebounds, assists, steals, blocks, turnovers, fouls)
pca <- prcomp(teams_factors, scale. = TRUE)
teams_pc <- mutate(teams, pc1 = pca$x[ ,1], pc2 = pca$x[ ,2])
teams_pc %>% ggplot(aes(x=pc1, y=pc2, label = team)) + 
  geom_text(aes(label = team)) + 
  xlab("PC1") + ylab("PC2") + ggtitle("NBA Teams ranked by Total Points") +
  geom_hline(yintercept=0) + geom_vline(xintercept=0)
```

![](hw03-Tianshu-Zhao_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

``` r
teams_pc <- mutate(teams_pc, pc1_rescaled = 100 * (pc1 - min(pc1)) / (max(pc1) - min(pc1)))
teams_pc %>% ggplot() + geom_bar(aes(x=reorder(team, pc1_rescaled), y=pc1_rescaled), stat="Identity") + coord_flip() +
  xlab("Team") + ylab("First PC (scaled from 0 to 100)") + 
  ggtitle("NBA Teams ranked by scaled PC1")
```

![](hw03-Tianshu-Zhao_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

Use the scaled PC1 to rank the teams:

``` r
select(arrange(teams_pc, desc(pc1_rescaled)), team)
```

    ## # A tibble: 30 x 1
    ##     team
    ##    <chr>
    ##  1   GSW
    ##  2   MIN
    ##  3   SAS
    ##  4   PHO
    ##  5   LAC
    ##  6   BOS
    ##  7   OKC
    ##  8   MIL
    ##  9   MIA
    ## 10   DEN
    ## # ... with 20 more rows

Comments and Reflection
=======================

Was this your first time working on a project with such file structure? If yes, how do you feel about it? 
yes

Was this your first time using relative paths? If yes, can you tell why they are important for reproducibility purposes? 
yes

Was this your first time using an R script? If yes, what do you think about just writing code? 
No

What things were hard, even though you saw them in class/lab? 
I still don't understand how to code pca part

What was easy(-ish) even though we haven’t done it in class/lab? 
Rscript

Did anyone help you completing the assignment? If so, who? 
yes, one of my CS classmates

How much time did it take to complete this HW? 
3 days ,seriously

What was the most time consuming part? 
google search how to use the ggplot function

Was there anything interesting? 
no
