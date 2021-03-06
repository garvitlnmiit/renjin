

testApprox <- function() {
	x <- c(2,2:4,4,4,5,5,7,7,7)
	y <- c(1:6, 5:4, 3:1)
	approx(x,y, xout=x)$y # warning
	(ay <- approx(x,y, xout=x, ties = "ordered")$y)
	stopifnot(ay == c(2,2,3,6,6,6,4,4,1,1,1))
	
}

testMassdist <- function() {
	n <- 10L
	y <- .C("massdist",
			x = c(-0.44577826, -1.20585657,  0.04112631,  0.63938841, -0.78655436, -0.38548930,
					-0.47586788,  0.71975069, -0.01850562, -1.37311776),
			xmass = rep.int(0.10, 10),
			nx = 10L,
			xlo =  -3.55375188693167,
			xhi = 2.90038481693167,
			y = double(2 * n),
			ny = n,	
			PACKAGE = "stats" )$y
	
	assertThat(y, closeTo(c(0.0000000, 0.0000000, 0.0000000, 0.1826441, 0.3199924, 0.3154393, 0.1819242,
							0.0000000, 0.0000000, 0.0000000, 0.0000000, 0.0000000, 0.0000000, 0.0000000,
							0.0000000, 0.0000000, 0.0000000, 0.0000000, 0.0000000, 0.0000000), 0.001))
	
		
}

testDensity <- function() {
  cat(c("testDensity Starting...\n"))
	x <- c(-0.44577826, -1.20585657,  0.04112631,  0.63938841, -0.78655436, -0.38548930,
		   -0.47586788,  0.71975069, -0.01850562, -1.37311776)


  d <- density(x)
	print(d)
	assertThat(d$bw, closeTo(0.3115, 0.0001))
	assertThat(mean(d$y), closeTo(0.2520675, 0.0001))
}

ignoreTestLm <- function() {
	x <- seq(1,15)
	y <- sin(x)
	fit <- lm(y~x)
}