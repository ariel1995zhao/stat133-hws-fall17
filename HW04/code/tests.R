library(stringr)
context("Function remove_missing")

test_that("Function to remove missing value", {
  expect_equal(remove_missing(c(1,4,7, NA, 10)), c(1,4,7, 10))
  expect_equal(remove_missing(c(2,5,NA, NA, 10)), c(2,5, 10))
  expect_equal(remove_missing(c(NA,2,NA, NA, 110)), c(2, 110))
  expect_equal(remove_missing(c(6,8,10,20,NA),c(6,8,10,20)))
})



context("Function get_minimum")

test_that("Function to get minimum", {
  expect_equal(get_minimum(c(1,4,7, NA, 10)), 1)
  expect_equal(get_minimum(c(7,5,NA, NA, 10)), 5)
  expect_equal(get_minimum(c(NA,2,NA, NA, 110)), 2)
  expect_equal(get_minimum(c(2,4,6,8,NA)),2)
})

context("Function get_maximum")

test_that("Function to get maxium", {
  expect_equal(get_maximum(c(1,4,7, NA, 10)), 10)
  expect_equal(get_maximum(c(7,5,NA, NA, 20)), 20)
  expect_equal(get_maximum(c(NA,2,NA, NA, 110)), 110)
  expect_equal(get_maximum(c(3,4,5,6,NA)),6)
})

context("Function get_range")

test_that("Function to get range", {
  expect_equal(get_range(c(1,4,7, NA, 10)), 9)
  expect_equal(get_range(c(7,5,NA, NA, 20)), 15)
  expect_equal(get_range(c(NA,2,NA, NA, 110)), 108)
  expect_equal(get_range(c(2,3,4,5,NA)),3)
})

context("Function get_median")

test_that("Function to remove missing value", {
  expect_equal(get_median(c(1,4,7, NA, 10)), 5.5)
  expect_equal(get_median(c(7,5,NA, NA, 20)), 5)
  expect_equal(get_median(c(NA,2,NA, NA, 110)), 56)
  expect_equal(get_median(c(1,2,3,NA,4)),2.5)
})

context("Function get_average")

test_that("Function to get average", {
  expect_equal(get_average(c(1,4,7, NA, 10)), 5.5)
  expect_equal(get_average(c(7,5,NA, NA, 20)), 10.66667)
  expect_equal(get_average(c(NA,2,NA, NA, 110)), 56)
  expect_equal(get_average(c(3,5,NA,8,9)),6.25)
})

context("Function get_stdev")

test_that("Function to get standard deviation", {
  expect_equal(get_stdev(c(1,4,7, NA, 10)), 3.872983)
  expect_equal(get_stdev(c(7,5,NA, NA, 20)), 8.144528)
  expect_equal(get_stdev(c(NA,2,NA, NA, 110)), 76.36753)
  expect_equal(get_stdev(c(3,5,NA,8,9)),2.753785)
})

context("Function get_quartile1")

test_that("Function to get first quartitle", {
  expect_equal(get_quartile1(c(1,4,7,2, 10)), 2)
  expect_equal(get_quartile1(c(7,5,3, NA, 20)), 4.5)
  expect_equal(get_quartile1(c(1,2,21, NA, 110)), 1.75)
  
})

context("Function get_percentile10")

test_that("Function to get 10 percentile", {
  expect_equal(get_percentile10(c(1,4,7,2, 10)), 1.4)
  expect_equal(get_percentile10(c(7,5,3, NA, 20)), 3.6)
  expect_equal(get_percentile10(c(1,2,21, NA, 110)), 1.3)
  expect_equal(get_percentile10(c(2,4,6,8,NA)),2.6)
})

context("Function get_quartile3")

test_that("Function to get second quartitle", {
  expect_equal(get_quartile3(c(1,4,7,2, 10)), 7)
  expect_equal(get_quartile3(c(7,5,3, NA, 20)), 10.25)
  expect_equal(get_quartile3(c(1,2,21, NA, 110)), 43.25)
  expect_equal(get_quartile3(c(2,4,6,8,NA)),6.5)
})

context("Function get_percentile90")

test_that("Function to remove missing value", {
  expect_equal(get_percentile90(c(1,4,7,2, 10)), 8.8)
  expect_equal(get_percentile90(c(7,5,3, NA, 20)), 16.1)
  expect_equal(get_percentile90(c(1,2,21, NA, 110)), 83.3)
  expect_equal(get_percentile90(c(2,4,6,8,NA)),7.4)
})

context("Function count_missing")

test_that("Function to count numbers of  missing value", {
  expect_equal(count_missing(c(1,4,7, NA, 10)), 1)
  expect_equal(count_missing(c(7,5,NA, NA, 20)), 2)
  expect_equal(count_missing(c(NA,2,NA, NA, 110)), 3)
  expect_equal(count_missing(c(NA,NA,NA,NA,1)),4)
})

context("Function rescale100")

test_that("Function to rescale", {
  expect_equal(rescale100(c(1,4,7, NA, 10), 0, 100),
               c(1,4,7, NA, 10))
  expect_equal(rescale100(c(7,5,NA, NA, 20), 1, 20),
               c(31.57895,21.05263,NA,NA,100.00000))
  expect_equal(rescale100(c(NA,2,110),3,50),
               c(NA,-2.12766,227.65957))
  expect_equal(rescale100(c(2,4,6,8,NA)),c(10,20,30,40,NA))
})

cotext("Function drop_lowest")

test_that("Function to drop the lowest value",{
  expect_equal(drop_lowest(c(1,4,7,NA,10),c(4,7,NA,10)))
  expect_equal(drop_lowest(c(7,5,NA,NA,20),c(7,20)))
  expect_equal(drop_lowest(c(3,2,NA,NA,110)),c(110))
  expect_equal(drop_lowest(c(2,4,6,7,NA),c(4,6,7)))
})

contest("Function score_homework,drop = TURE")

test_that("Function to compute a single homework value with drop the lowest homework",{
  expect_equal(score_homework(c(100,80,30,70,75,85),82))
  expect_equal(score_homework(c(100,100,90,85,89,82),92.8))
  expect_equal(score_homework(c(90,92,94,94,95,96),94.2))
  expect_equal(scroe_homework(c(89,88,87,86,85,84),87))
})

contest("Function score_homework,drop = FALSE")

test_that("Function to compute a single homework value without drop the lowest homework",{
  expect_equal(score_homework(c(100,80,30,70,75,85),73.33333))
  expect_equal(score_homework(c(100,100,90,85,89,82),91))
  expect_equal(score_homework(c(90,92,94,94,95,96),93.5))
  expect_equal(scroe_homework(c(89,88,87,86,85,84),86.5))
})

contest("Function score_quiz")

test_that("Function to compute a single quiz value with drop the lowest score",{
  expect_equal(score_quiz(c(100,80,70,0),83.33333))
  expect_equal(score_quiz(c(60,80,99,100),93))
  expect_equal(score_quiz(c(77,78,79,90),82.33333))
  expect_equal(score_quiz(c(89,100,100,99),99.66667)) 
})

contest("Function score_lab")

test_that("Function to compute the overall lab score",{
  expect_equal(score_lab(12),100)
  expect_equal(score_lab(9),60)
  expect_equal(score_lab(8),40)
  expect_equal(score_lab(3),0)
})

