/*********************************************
 * OPL 20.1.0.0 Model
 * Author: almog
 * Creation Date: Aug 25, 2021 at 8:18:20 PM
 *********************************************/
int S=...;
range stations_index = 0..(S-1);

int n=...;
range requests_index = 1..n; 

int V=...;
range vehicles_index = 1..V; 

int L=...;
range rounds_index = 1..L; 

int alpha1=...;
int alpha2=...;
int Capacity=...;
int sigma=...;

float t[stations_index] = ...;
int requests[requests_index][1..5] = ...;

int B_round[stations_index][stations_index] = ...;
int Num_Stations_in_Between[stations_index ,stations_index] = ...;
float Time_Between_Stations[stations_index ,stations_index] = ...;

dvar int y[vehicles_index];
dvar float p[requests_index];
dvar float dr[requests_index];
dvar int num[requests_index][vehicles_index][rounds_index][stations_index]; 
dvar boolean treatment[requests_index][vehicles_index][rounds_index]; 
dvar boolean BPick[vehicles_index][rounds_index][stations_index]; 
dvar boolean Bdrop[requests_index][vehicles_index][rounds_index][stations_index]; 
dvar float Time_vehicle[vehicles_index][rounds_index][stations_index]; 

minimize alpha1*(sum (k in vehicles_index)y[k]) + alpha2*(sum(i in requests_index) requests[i][1]*dr[i]) ;

subject to {
  //sum (i in requests_index, k in vehicles_index,r in rounds_index) treatment[i][k][r]== n ; //Every request is served	
  forall (i in requests_index) (sum (k in vehicles_index ,r in rounds_index) treatment[i][k][r]) == 1 ; //Every request is served exactly once
  forall (i in requests_index, k in vehicles_index,r in rounds_index) 
  	treatment[i][k][r] <= BPick[k][r][requests[i][2]] ;
  forall (i in requests_index) p[i] >= requests[i][3] ; //Make sure request pick-up time is relevant
  forall (i in requests_index) dr[i] <= requests[i][5] ; //Make sure request drop-up time is relevant
  forall (k in vehicles_index) Time_vehicle[k][1][0]== 0 ;
//  forall (k in vehicles_index, r in 1..L-1)
//  	Time_vehicle[k][r+1][0] == Time_vehicle[k][r][S-1] + t[S-1] + sigma*BPick[k][r][S-1] ;
//  forall (k in vehicles_index ,r in rounds_index, s in 1..S-2)
//  	Time_vehicle[k][r][s+1] == Time_vehicle[k][r][s] + t[s] + sigma*BPick[k][r][s];

}


