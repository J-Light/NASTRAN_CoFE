function obj = element(obj,FEM)

%% independent degrees of freedom (n set) 

% numbers and locations
hn = find(FEM.gnum==obj.GA);
if size(hn,2)~=1; error(['There should be one and only one GRID with ID#',num2str(obj.GN),'']); end
obj.xn = [FEM.GRID(hn).X1;FEM.GRID(hn).X2;FEM.GRID(hn).X3];

% dof
cna = str2num(num2str(obj.CNA)');
ldofn = cna';
obj.gdofn = FEM.gnum2gdof(cna, hn)';
num_cna = size(cna,1);

% plot indices
obj.gdofn_plot = FEM.gnum2gdof(1:3,hn)';

%% dependent degrees of freedom (m set) 

hmj = find(FEM.gnum == obj.GB);
if size(hmj,2)~=1; error(['There should be one and only one GRID with ID#',num2str(obj.(obj.fields{4})),'']); end
obj.xm = [FEM.GRID(hmj).X1;FEM.GRID(hmj).X2;FEM.GRID(hmj).X3];

cmb = str2num(num2str(obj.CMB)'); 
ldofm = cmb';
obj.gdofm = FEM.gnum2gdof(cmb, hmj)';

% plot indices
obj.gdofm_plot = FEM.gnum2gdof(1:3, hmj);

% constraint equation matrix
RnRm = zeros(6,12);
RnRm(:,1:6) = repmat(eye(6),[1,1]);

% constraint equation matrix
D = obj.xm - obj.xn;

RnRm((1:6),(1:6)+6) = ...
     -1*[1     0     0     0    -D(3)  D(2) 
         0     1     0     D(3)  0    -D(1)
         0     0     1    -D(2)  D(1)  0
         0     0     0     1     0     0
         0     0     0     0     1     0
         0     0     0     0     0     1   ];

%% Element Constraint Matrix
obj.RnRm = RnRm(ldofm,[ldofn,6+ldofm]);

end