function obj = element(obj,FEM)
% find matching GRID
h = find(FEM.gnum==obj.G);
if size(h,2)~=1; error(['There should be one and only one GRID with ID# ',num2str(obj.G)]); end

% nodal locations
obj.x1 = [FEM.GRID(h).X1;FEM.GRID(h).X2;FEM.GRID(h).X3];

if obj.CID == -1
    obj.X1 = obj.X1 - obj.x1(1);
    obj.X2 = obj.X2 - obj.x1(2);
    obj.X3 = obj.X3 - obj.x1(3);
else
    error(['CID > 0 not supported yet for CONM2, EID=', num2str(obj.EID)]);
end

% global dof
obj.gdof = FEM.gnum2gdof(:,obj.G==FEM.gnum);

% plot dof
obj.gdof_plot = FEM.gnum2gdof(1:3,obj.G==FEM.gnum);

% element matricies
obj.ke = zeros(6);

obj.me = zeros(6);
obj.me(1,1) = obj.M;
obj.me(2,2) = obj.M;
obj.me(3,3) = obj.M;
obj.me(1:3,4:6) = obj.M*[0 obj.X3 -obj.X2;-obj.X3 0 obj.X1; obj.X2 -obj.X1 0];
obj.me(4:6,1:3) = obj.me(1:3,4:6).';
obj.me(4,4) = obj.I11 + obj.M*( obj.X2^2 + obj.X3^2 );
obj.me(5,5) = obj.I22 + obj.M*( obj.X1^2 + obj.X3^2 );
obj.me(6,6) = obj.I33 + obj.M*( obj.X1^2 + obj.X2^2 );
obj.me(5,4) = -obj.I21 - obj.M*(obj.X1*obj.X2);
obj.me(6,4) = -obj.I31 - obj.M*(obj.X1*obj.X3);
obj.me(6,5) = -obj.I32 - obj.M*(obj.X2*obj.X3);
obj.me(4,5) = obj.me(5,4);
obj.me(4,6) = obj.me(6,4);
obj.me(5,6) = obj.me(6,5);