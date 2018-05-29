function [] = linAct(s,butt1,butt2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    lval = 0;
    if butt1 && butt2
        
        lval = 0;
        
    elseif butt1
        lval = 1;
        
    elseif butt2
        
        lval = -1;
        
    end
    
    lval = num2str(lval);
    
    fprintf(s,['L',lval]);
   
end

