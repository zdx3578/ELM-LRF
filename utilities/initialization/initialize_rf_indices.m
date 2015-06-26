function [rf_index, h_dim, num_windows] = initialize_rf_indices (param)
disp('--rf index file');
% Create index for overlaping receptive fields (1 input channel)
h_dim = length(1:param.step:param.image_size-param.window_size+1);
	fprintf('h_dim is :%f \n',h_dim );
rf_index = zeros(h_dim^2,param.image_size^2);
        fprintf('in init rf indices .now run 3 line rf_index is : %f,%f \n',size(rf_index)) ;
temp = [ones(param.window_size),zeros(param.window_size,param.image_size);zeros(param.image_size,param.window_size+param.image_size)];
	fprintf('temp size is : %f  %f \n ',size(temp));
	fprintf('size of zeros(param.window_size,param.image_size);zeros(param.image_size,param.window_size+param.image_size) : %f %f %f  %f \n',size(zeros(param.window_size,param.image_size)),size(zeros(param.image_size,param.window_size+param.image_size)) ) ;
	fprintf('size of ones(param.window_size) %f %f  \n \n ',size(ones(param.window_size)));

n = 0;
        fprintf('in init rf indices .now run for and for 4 line \n');
for a = 0:h_dim-1
    for b = 0:h_dim-1
         n = n + 1; 
         curr_rf = circshift(temp,[a*param.step,b*param.step]);
	%fprintf('curr_rf size is : %f  %f \n ',size(curr_rf));
         rf_index(n,:) = reshape(curr_rf(1:param.image_size,1:param.image_size),param.image_size^2,1);
	%fprintf('rf_index size is : %f  %f \n ',size(rf_index));
    end
end
        fprintf('in init rf indices .now run repmat 5 part \n');

        fprintf('rf_index size is : %f  %f \n ',size(rf_index));
rf_index = repmat (rf_index, param.num_maps, 1);
        fprintf('rf_index size is : %f  %f \n ',size(rf_index));
num_windows = h_dim^2 * param.num_maps;
        fprintf('num_windows is : %f  \n \n ',num_windows );
rf_index = repmat(rf_index,1,param.input_ch);
        fprintf('rf_index size is : %f  %f \n ',size(rf_index));
rf_index = sparse(logical(rf_index));
        fprintf('rf_index size is : %f  %f \n ',size(rf_index));
end
