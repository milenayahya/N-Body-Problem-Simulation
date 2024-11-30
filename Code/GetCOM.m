function [COM] = GetCOM(Bins)
COM = zeros(length(Bins),3);

for i=1:length(Bins)
    if isempty(Bins{i})==0
        COM(i,1)=((Bins{i}(:,1))'*(Bins{i}(:,4)))/(sum(Bins{i}(:,4)));
        COM(i,2)=((Bins{i}(:,2))'*(Bins{i}(:,4)))/(sum(Bins{i}(:,4)));
        COM(i,3)=((Bins{i}(:,3))'*(Bins{i}(:,4)))/(sum(Bins{i}(:,4)));
    else
        COM(i,1)=nan;
        COM(i,2)=nan;
        COM(i,3)=nan;
    end
    
end

end

