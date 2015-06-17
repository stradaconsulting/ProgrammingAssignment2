## R-Programming Coursera
## Assignment 2
## Prepared by: Santiago Oleas - soleas@gmail.com
## Caching the INVERSE of a MATRIX to avoid unnecessary
## calculations for an unchanged matrix

## This solution is made up of two functions:
##    - makeCacheMatrix: this will allow us to create and store a matrix along
##                       with some embedded functions for getting the stored matrix value,
##                       setting a new matrix, getting the inverse of the stored matrix
##                       and setting the inverse of the stored matrix
##    - cacheSolve:      this function is used in conjunction with the stored object after
##                       executing and calling makeCacheMatrix. It essentially returns the
##                       inverse of the matrix provided by making use of the existing
##                       functions to get the inverse and set the inverse.  If the "get inverse"
##                       function is NULL then calculate and return the inverse.  If it is NOT
##                       NULL then simply return the cached inverse


## The makeCacheMatrix function will create a matrix along with a list of four functions
## that can be used against the created matrix.  These four functions are:
## - get; this will return the matrix that was stored upon first calling makeCacheMatrix or
##        upon calling the 'set' function described below
## - set; this will set a new matrix to the already existing variable that was created with makeCacheMatrix
## - setinverse; this will set local variable 'inv' inside the function with the inverse of the matrix
## - getinverse; this will return the inverse of the matrix as it is stored in the local variable 'inv'
##
## Usage:
## - upon first creating we set a matrix to variable using this function
##   eg - myMatrix <- makeCacheMatrix(matrix(c(4,3, 3, 2), 2, 2) #makes a 2x2 matrix
## - get the matrix value: myMatrix$get()  #get back what was stored
## - set a new matrix: myMatrix$set(matrix(c(2,.25, .25, 2),2,2))

makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL #initialize the inverse matrix to NULL
        
        # SET usage myMatrix$set(...)
        set <- function(y) {
                x   <<- y    # a new matrix is provided so we replace
                inv <<- NULL # with a new matrix we re-initialize the inverse to NULL
        }
        
        # GET usage myMatrix$get()
        get <- function() x # simply return the matrix we have
        
        # SETINVERSE usage myMatrix$setInverse(...)
        setinverse <- function(i) inv <<- i # set the inverse matrix to the one provided
        
        # GETINVERSE usage myMatrix$getInverse()
        getinverse <- function() inv # simply returns the inverse matrix we have
        
        # create the list of functions accessible
        list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
        
}


## The cacheSolve function is used in conjunction with the stored variable created through makeCacheMatrix()
## defined above.  With the cacheSolve we pass the variable previously created and are essentially requesting 
## the inverse matrix of what was originally provided.
## $getinverse() is called
## if this result is NOT NULL
##      then we simply return the inverse that was previously created
## if the result is NULL 
##     we pull the original matrix ($get)
##     calculate the inverse using the solve() function
##     we store the inverse using $setinverse
##     finally we return the inverse we just calculated 

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        i <- x$getinverse()                              #get the inverse value
        if(!is.null(i)) {                                #if inverse is not NULL
                message("Getting cached inverse matrix") #provide message stating we are using cached inverse
                return(i)                                #return the inverse matrix we got
        }
                
        #if the inverse matrix IS NULL
        data <- x$get()       #pull the original matrix
        i <- solve(data, ...) #determine inverse and store in 'i'
        x$setinverse(i)       #set the inverse into our previously created object
        i                     #return the inverse matrix
}
