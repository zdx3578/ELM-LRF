function [pool_index] = initialize_pooling_indices_my2 (param, h_dim)

num_pool = 0;
pool_index = [];
spatial_pool_index = eye(h_dim^2);
poolstep = 1;

% Spatial pooling
if param.pooling_size ~= 0

    p_dim = floor(h_dim/poolstep);

    spatial_pool_index = zeros(p_dim^2,h_dim^2);

        fprintf('in init pool ind my2 now run if temp line \n');
        fprintf('old spatial pool index is %f %f \n',p_dim^2,h_dim^2);
	fprintf('p_dim is: %f;spatial_pool_index size is %f %f \n \n',p_dim, size( spatial_pool_index)  );

    temp = [ones(param.pooling_size*2+1),zeros(param.pooling_size*2+1,h_dim);zeros(h_dim,param.pooling_size*2+1+h_dim)];
    n = 0; 
        fprintf('pooling_size is %f \n',param.pooling_size );
        fprintf('temp size is %f %f   \n',size(temp) );
    for a = 0:p_dim-1
        for b = 0:p_dim-1
            n = n + 1;
            curr_pool = circshift(temp,[b*poolstep,a*poolstep]);
%            fprintf('circshift(temp,[%f,%f]) \n',b*poolstep,a*poolstep);

            spatial_pool_index(n,:) = reshape(curr_pool(param.pooling_size+1:h_dim+param.pooling_size,param.pooling_size+1:h_dim+param.pooling_size),h_dim^2,1);
%		fprintf('reshape(curr_pool(%f:%f,%f:%f),%f,1\n',param.pooling_size+1,h_dim+param.pooling_size,param.pooling_size+1,h_dim+param.pooling_size,h_dim^2 );

        end
    end

        fprintf('spatial pool index  size is %f %f   \n',size( spatial_pool_index) );
%	! sleep 0.3 ;
%	! free -m ;!sleep 0.21; ! free -m
%        fprintf('in init pool ind my2 now run if expanded pool index line \n');    
	fprintf(1,'\n p_dim is : %f;h_dim is : %f; num_maps is : %f \n ',p_dim,h_dim,param.num_maps );
        fprintf('  expand_pool_index is zeors(%f,%f) \n \n ',p_dim^2*param.num_maps,h_dim^2*param.num_maps );
    expanded_pool_index = zeros(p_dim^2*param.num_maps,h_dim^2*param.num_maps);
        fprintf('now expanded_pool index is %f %f \n',size(expanded_pool_index));
    % Replicate for num maps
%        fprintf('in init pool ind my2 now run if expanded pool index for   \n');
    for a = 0:param.num_maps-1
        expanded_pool_index(a*p_dim^2 + 1:(a+1)*p_dim^2, a*h_dim^2+1 : (a+1)*h_dim^2 ) = spatial_pool_index;
%	fprintf('expanded_pool_index(%f:%f,%f:%f) = spatial_pool_index \n', (a*p_dim^2 + 1) ,(a+1)*p_dim^2, (a*h_dim^2+1) , (a+1)*h_dim^2 ) ;
%        fprintf(' expanded_pool index is %f %f \n',size(expanded_pool_index));
    end
    
    pool_index = expanded_pool_index;
    num_pool = p_dim^2*param.num_maps;        
	fprintf('num_pool is: %f ==pdim^2*param.num_maps\n',num_pool);
end
        fprintf('in init pool ind my2 now run sparse \n');
pool_index = sparse(logical(pool_index));
	fprintf('pool index size is %f %f  \n',size(pool_index));
end

