## Put comments here that give an overall description of what your
## functions do

# There are two functions. The first one is used to create a special matrix whose
# inverse will be computed and stored (in other words "cached"). The second one will
# compute the inverse of the special matrix created by the first function, but not
# without checking first if this inverse exist already. If so, it will retrieve it
# instead of computing it again. If not, then it will compute it and saved
# (or cached) the value for future use.

## Write a short comment describing this function

# The purpose of this function is to create a special matrix, to compute its
# inverse (which, for this assignment, always exist by assumption) and stored it
# for future use.

makeCacheMatrix <- function(special_matrix = matrix()) {
        # initialize the stored or cached value to "nothing"
        inverse_special_matrix <- NULL
        
        # initialize the value of the special matrix by creating a function
        # named "setSpecialMatrix" that will store the studied matrix (the one we
        # are interested in) in the "special matrix". The special matrix plays the
        # role of a container (named "special_matrix") and this container will 
        # contain the studied matrix (named "studied_matrix" in what follows).
        # This is also the case with the inverse_special_matrix object. We need to
        # initialize the value of this object in order to start "fresh" with each
        # new studied matrix. Not doing this could lead to some problems. For
        # instance, assume A is the first studied matrix, then letting Inv_A denotes
        # its inverse, we would have special_matrix == A and
        # inverse_special_matrix == Inv_A. Assume now that we are interested in
        # another matrix B, if the "set" function does not (re)initialize the value
        # of inverse_special_matrix, then we would have
        # special_matrix == B and inverse_special_matrix == Inv_A (which is
        # problematic) instead of inverse_special_matrix == NULL (which is not
        # problematic).
        setSpecialMatrix <- function(studied_matrix) {
                special_matrix <<- studied_matrix
                inverse_special_matrix <<- NULL
        }
        
        # the function below, named "getSpecialMatrix", is used to retrieve the
        # value of special_matrix which is the studied matrix thanks to the function
        # "setSpecialMatrix" above. The "getSpecialMatrix" function has no arguments,
        # because it does no actions or computations. Another name could have been
        # "fetchSpecialMatrix".
        getSpecialMatrix <- function() {
                special_matrix
        }
        
        # the function below, named "setInverseSpecialMatrix", will "store" or
        # "cache" the value of the inverse of the studied matrix (named
        # inverse_studied_matrix) by assigning its value to inverse_special_matrix
        setInverseSpecialMatrix <- function(inverse_studied_matrix) {
                inverse_special_matrix <<- inverse_studied_matrix
        }
        
        # the function below, named "getInverseSpecialMatrix", is used to retrieve
        # the value of inverse_special_matrix which has been set to (or is equal to)
        # inverse_studied_matrix by the function "setInverseSpecialMatrix"
        getInverseSpecialMatrix <- function() {
                inverse_special_matrix
        }
        
        # make a list containing the values given by the functions defined above
        list(set = setSpecialMatrix,
             get = getSpecialMatrix,
             setinverse = setInverseSpecialMatrix
             getinverse = getInverseSpecialMatrix)
}


## Write a short comment describing this function

# The purpose of this function is to compute the inverse of the special matrix
# created by the first function in case it has not been previously computed. To
# know that, it will look at the cached or stored value. If this value exists,
# it means that the inverse has already been computed and there is no need to do
# it a second time.

cacheSolve <- function(studied_matrix, ...) {
        # we pull from the result of the makeCacheMatrix function the value of
        # the inverse of the studied matrix
        inverse_studied_matrix <- studied_matrix$getinverse()
        
        # to see if the inverse of the studied matrix has already been computed
        # we test the value of inverse_studied_matrix. If it is "NULL", then we
        # know the inverse of the studied matrix has not been already computed
        if (!is.null(inverse_studied_matrix)) {
                message("getting inverse of the matrix from cached data")
                return(inverse_studied_matrix)
        }
        
        # in what follows, we are in the case when the inverse of the studied has
        # not been already computed (the above if statement failed). We first need
        # to get the studied matrix whose value is stored in special_matrix which
        # we will now retrieve
        temp_studied_matrix <- studied_matrix$get()
        
        # now that we have retrieved our special matrix, we compute its inverse
        inverse_studied_matrix <- solve(temp_studied_matrix)
        
        # having computed the inverse of the studied matrix, we cache its value
        # for future use by using the function "setInverseSpecialMatrix" through
        # its label in the result or output (which is a list) of the function
        # "makeCacheMatrix"
        studied_matrix$setinverse(inverse_studied_matrix)
        
        # having cached the value of the inverse of the studied matrix, this value
        # becomes the result or the output of the function "cacheSolve"
        inverse_studied_matrix
}
