function [] = Stepper(s,xval,yval,zval)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



val = [xval,yval,zval];

for i = 1:3
    
    if val(i) > .15
        
        val(i) = 1;
        
    elseif val(i) < -.15
        
        val(i) = -1;
        
    else
        
        val(i) = 0;
        
    end
    
    
    
end

xval = num2str(val(1));
yval = num2str(val(2));
zval = num2str(val(3));

end

