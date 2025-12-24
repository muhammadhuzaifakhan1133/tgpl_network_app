String getGreeting() {
  DateTime now = DateTime.now();
   String greeting = ""; 
    int hours=now.hour;


    if(hours>=1 && hours<=12){ 
    greeting = "Good Morning"; 
    } else if(hours>=12 && hours<=16){
     greeting = "Good Afternoon"; 
    } else { 
    greeting = "Good Evening";
     }
  return greeting;
}