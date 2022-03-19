/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Almog, Daniel, Nir 
 * Creation Date: Aug 26, 2021 at 11:44:07 AM
 *********************************************/
int S=...;
range stations_index = 0..(S-1);

/* Part A - Calculation of B_round - a boolean matrix which sets '1' if we pass station '0'
   on the way between station i to station j, and sets '0' otherwise. */
/*
int M=100*S;

dvar boolean B_round[stations_index ,stations_index];

minimize 0;

subject to{
  forall (o in stations_index, d in stations_index) B_round[o][d] * (d-o) * M <= 0 ;
  forall (o in stations_index, d in stations_index) d-(o*(1-B_round[o][d]))>= 0 ;
  }
*/
  
/* Part B - Once we have the 'B_round' matrix, calculate the matrix:
   1 - 'Num_Stations_in_Between' - Calculate the number of stations between station i station j
   2 - 'Time_Between_Stations'  - Calculate the ride-time between station i station j */

/* Before running this part - delete '/*' from part B , and add for Part A */

int B_round[stations_index][stations_index] = ...;
float t[stations_index] = ...;

dvar int Num_Stations_in_Between[stations_index ,stations_index];
dvar float Time_Between_Stations[stations_index ,stations_index];

minimize 0;

subject to{
  forall (o in stations_index, d in stations_index)
    Num_Stations_in_Between[o,d]==((1-B_round[o,d])*(d-o)+(B_round[o,d])*(S-o+d));
  forall (o in stations_index, d in stations_index)
    Time_Between_Stations[o,d]==
    (1-B_round[o,d])*(sum (i in (o..d-1)) t[i]) + 
    (B_round[o,d])*(sum (i in (o..S-1)) t[i] + sum (i in (0..d-1)) t[i]); 
  }
