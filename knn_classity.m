function [opt_m_l1, opt_m_l2] = knn_classity(ip_train, ip_test, kernel) 
    output_matrix_l2 = [];
    output_matrix_l1 = [];
    
%     [Z,mu,sigma] = zscore(ip_train(:,2:10));
%     
%     ip_train_1 = [ip_train(:,1),Z,ip_train(:,11)];
%     ip_train  = ip_train_1;
%     
%     for i = 1: length(ip_test(:,1))
%         ip_test(i,2:10) = ((ip_test(i,2:10) - mu))./(sigma);
%     end
    
    
    
    for train_r = 1: length(ip_train(:,1))
        train_class = ip_train(train_r,11);
        train_name = ip_train(train_r,1);
	
        for test_r = 1: length(ip_test(:,1))
            test_name = ip_test(test_r,1);
            test_class = ip_test(test_r,11);
            l2_inst = 0;
            l1_inst = 0;
            
%             l2_inst = sqrt(sum ( ( (ip_train(train_r,2:10)) - (ip_test(test_r,2:10)) ).^2));
%             l1_inst = sum( abs( (ip_train(train_r,2:10)) - (ip_test(test_r,2:10)) ));
            diff = ip_train(train_r,2:10) - ip_test(test_r,2:10);
            l2_inst = norm(diff,2);
            l1_inst = norm(diff,1);

%             for col = 2: length(ip_train(1,:))-1
%                 l2_inst = l2_inst + sqrt( (ip_train(train_r,col) - ip_test(test_r,col)) ^2 );
%                 l1_inst = l1_inst + abs( ip_train(train_r,col) - ip_test(test_r,col) );
%             end
        output_matrix_l2 = [output_matrix_l2; train_name,train_class,l2_inst,test_name,test_class];
        output_matrix_l1 = [output_matrix_l1; train_name,train_class,l1_inst,test_name,test_class];
        end
    end



sorted_output_l2 = output_matrix_l2;
sorted_output_l2 = sortrows(sorted_output_l2,[4,3]);

sorted_output_l1 = output_matrix_l1;
sorted_output_l1 = sortrows(sorted_output_l1,[4,3]);

opt_m_l1 = sorted_output_l1(1:kernel,:);
opt_m_l2 = sorted_output_l2(1:kernel,:);
end

