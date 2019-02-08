

public int[][] numericalOrder(){
  int[][] rV = new int[passengerNum][2];
  
  for(int i = 0; i < rV.length; i ++){
    rV[i][0] = i % seatLength;
    rV[i][1] = i / seatLength;
    if(rV[i][1] > 2){
      rV[i][1] ++;
    }
  }
  
  return rV;
}