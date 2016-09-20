function op_accuracy = new_accuracy(ip_matrix, kernel)
    i =1;
    acc = 0;
    %train_name,train_class,l2_inst,test_name,test_class
    for i=1:kernel:length(ip_matrix(:,1))
        curr_block = ip_matrix(i:i+kernel-1,:);
        assigned_label = mode(curr_block(:,5));
        orig_label = mode(curr_block(:,2));
        if orig_label == assigned_label
            acc = acc+1;
        end
    end
        
%     while (i <=length(ip_matrix(:,1)))
%         match = 0;
%         unmatch = 0;
%         if kernel > 1
%             for j = 1 : kernel
%                 if ip_matrix(i,2)==ip_matrix(i,5)
%                     match = match + 1;
%                 else
%                     unmatch = unmatch + 1;
%                 end
%                 i = i + 1;
%             end
%             if match >= (kernel/2)
%                 acc = acc+1;
%             end
%         else
%             if ip_matrix(i,2)==ip_matrix(i,5)
%                 acc = acc + 1;
%             end
%             i = i + 1;
%         end
%     end
    
    op_accuracy = [(acc/( length(ip_matrix(:,1))/ kernel) )*100, acc];
   
end

