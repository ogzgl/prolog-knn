Oğuz GÜL - 220201015
Gülenay Kayadibi - 240201030

+We have updated the data file to remove the line that 
mentions about iris dataset to use it properly, dataset is in the zip folder.

+We used module dcg/basics to read data.

+2 calc_dist_helper functions one of them is for, base case and the other to continue recursion,
in this function distance is calculated and put on a list which is DR, (DistanceRow).

+calc dist helps us to iterate over 150 points

+current iris is starter function 

+runit is main function works as a wrapper

+take mins remover removes the [*] element which indicates start and 
keeps track of the row we are dealing with. Terminates at 150.

+take mins recur finds the minimum points in the list for a given k number.

+append to list appends to end of the list.

+iris file for reading

+we declared a dynamic predicate iris(For example (iris,1,0.5,0.2,0.5,0.4,setosa)) 
and created new ones as we are reading lines.

+++We used swipl, you can run the program using runit(K).
