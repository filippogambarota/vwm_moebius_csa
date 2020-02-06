weight.IC <- function(x) {
    (delta <- x-x[which.min(x)])
    num <- exp(-.5*delta)
    den <- sum(num,na.rm=TRUE)
    return(list(delta=delta,w=num/den))
}