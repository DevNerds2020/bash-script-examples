#! /bin/bash
shape=$1
x=$2
y=$3
function area {
    if [ $shape = "square" ]; then
        echo "Square Area is : $((x*x))" 
    fi
    if [ $shape = "rectangle" ]; then
        echo "Rectangle Area is : $((x*y))"
    fi
    if [ $shape = "triangle" ]; then
        echo "Triangle Area is : $((x*y/2))"
    fi
    if [ $shape = "circle" ]; then
        echo "scale=2; 3.14 * $((x*x))"
    fi
}
area
