% Class for PBAR property entries.  Tapered beams are not supported.
% Nishit Joseph
% Anthony Ricciardi
%
classdef pbar < entry
    
    % entry data
    properties
        PID
        MID
        A
        I1
        I2
        J
        NSM
        C1
        C2
        D1
        D2
        E1
        E2
        F1
        F2
        K1
        K2
        I12
    end
    
    methods
        
        %%
        function obj = initialize(obj,data)
            obj.PID  = set_data('PBAR','PID',data{2},'int',[],1);
            obj.MID  = set_data('PBAR','MID',data{3},'int',[] ,1);
            obj.A    = set_data('PBAR','A',data{4},'dec',[]);
            obj.I1   = set_data('PBAR','I1',data{5},'dec',[]);
            obj.I2   = set_data('PBAR','I2',data{6},'dec',[]);
            obj.J    = set_data('PBAR','J',data{7},'dec',0.0);
            obj.NSM = set_data('PBAR','NSM',data{8},'dec',0.0);
%             obj.I12  = set_data('PBAR','I12',data{7},'dec',0.0);
%             if obj.I12 ~= 0; errro('Nonzero I12 field on PBAR entry not supported'); end
            
            
            if size(data,2)>10
                obj.C1 = set_data('PBAR','C1',data{12},'dec',0.0);
                obj.C2 = set_data('PBAR','C2',data{13},'dec',0.0);
                obj.D1 = set_data('PBAR','D1',data{14},'dec',0.0);
                obj.D2 = set_data('PBAR','D2',data{15},'dec',0.0);
                obj.E1 = set_data('PBAR','E1',data{16},'dec',0.0);
                obj.E2 = set_data('PBAR','E2',data{17},'dec',0.0);
                obj.F1 = set_data('PBAR','F1',data{18},'dec',0.0);
                obj.F2 = set_data('PBAR','F2',data{19},'dec',0.0);
            else
                obj.C1 = 0.0;
                obj.C2 = 0.0;
                obj.D1 = 0.0;
                obj.D2 = 0.0;
                obj.E1 = 0.0;
                obj.E2 = 0.0;
                obj.F1 = 0.0;
                obj.F2 = 0.0;
            end
            
            if size(data,2)>20
                obj.K1 = set_data('PBAR','K1',data{22},'dec',1.0);
                obj.K2 = set_data('PBAR','K2',data{23},'dec',1.0);
                obj.I12  = set_data('PBAR','I12',data{24},'dec',0.0);
            else
                obj.K1 = 1.0;
                obj.K2 = 1.0;
                obj.I12 = 0.0;
            end
        end
        
        %%
        function echo(obj,fid)
            fprintf(fid,'PBAR,%d,%d,%f,%f,%f,%f,%f,%f\n',obj.PID,obj.MID,obj.A,obj.I1,obj.I2,obj.I12,obj.J,obj.NSM);
            fprintf(fid,',%d,%d,%d,%d,%d,%d,%d,%d\n',obj.C1,obj.C2,obj.D1,obj.D2,obj.E1,obj.E2,obj.F1,obj.F2);
            fprintf(fid,',%d,%d\n',obj.K1,obj.K2);
        end
    end
    
end

