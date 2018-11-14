% Class for zero displacement single-point constraints
% Anthony Ricciardi
%
classdef spc1 < entry

    % entry data
    properties
        SID
        C
        Gi
    end
    methods
        function obj = initialize(obj,data)
            obj.SID = set_data('SPC1','SID',data{2},'int',[],1);
            obj.C   = set_data('SPC1','C',data{3},'int',[],1);
            obj.Gi(1,1)  = set_data('SPC1','Gi',data{4},'int',[],1);

            i = 1;
            cn = 5;
            for j =5:size(data,2)
                if cn == 10
                    cn = 0;
                elseif cn == 1
                else
                    if isempty(data{j})
                        break
                    end
                    i = i+1;
                    obj.Gi(1,i) = set_data('SPC1','Gi',data{j},'int',1);
                end
                cn = cn + 1;
            end

        end

        function echo(obj,fid)
            fprintf(fid,'SPC1,%d,%d,%d\n',obj.SID,obj.C,obj.G1);
        end
    end
end
