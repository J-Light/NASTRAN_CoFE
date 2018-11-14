% Class for RBAR entries.
% Defines a rigid bar with six degrees-of-freedom at each end
%
% Nishit Joseph
%
classdef rbar < mpc
    
    %% input data
    properties
        EID
        GA
        GB
        CNA
        CNB
        CMA
        CMB
        ALPHA
    end
    
    %% model
    properties (Access = public)
        % element universal
        RnRm   % [#CM x #element m] element constraint matrix in global reference frame
        gdofn  % [#CMx1] global index numbers of element n dof
        gdofm  % [#CM * #element m x 1] global index numbers of element m dof
    end
    
    properties (Access = private)
        xn    % [3 x 1] independant node position
        xm    % [3 x #m nodes] dependant node positions 
        gdofn_plot % [3 x 1] global index of node with independant dof
        gdofm_plot % [3 x #m nodes] global index of nodes with dependant dof
    end
    
    methods
        
        %%
        function obj = initialize(obj,data)
            obj.EID = set_data('RBAR','EID',data{2},'int',[],1,100000000);
            obj.GA = set_data('RBAR','GA',data{3},'int',[],1);
            obj.GB = set_data('RBAR','GB',data{4},'int',[],1);
            obj.CNA = set_data('RBAR','CNA',data{5},'int',[]);
            obj.CNB = set_data('RBAR','CNB',data{6},'int', -999);
            obj.CMA = set_data('RBAR','CMA',data{7},'int', -999);
            obj.CMB = set_data('RBAR','CMB',data{8},'int',[]);
            obj.ALPHA = set_data('RBAR','ALPHA',data{9},'dec',0.0);
            if obj.ALPHA ~= 0.0
                error('RBAR does not support thermal expansion coefficient')
            end
            if obj.CNB ~= -999
                error('RBAR does not support independent dof on Grid B');
            end
            if obj.CMA ~= -999
                error('RBAR does not support dependent dof on Grid A');
            end
        end
        
        %%
        function echo(obj,fid)
            fprintf(fid,'RBAR,%d,%d,%d,%d, , ,%d',obj.EID,obj.GA,obj.GB,obj.CNA,obj.CMB);
        end
        
    end
end
