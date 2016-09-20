function [ ] = final_kNN( train, test )

% train = csvread('train.txt');
% test = csvread('test.txt');
length(unique(train(:,11)));
tab = tabulate(train(:,11));
figure
plot(tab(:,1),tab(:,2))
title('Class Distribution')
xlabel('Class')
ylabel('Number of points in Class')


% preprocessing for Knn
% norm_train = train;
% [Z,mu,sigma] = zscore(norm_train(:,2:10));
% 
% tmp = [norm_train(:,1),Z,norm_train(:,11)];
% norm_train  = tmp;
% train = norm_train;

%     for i = 1: length(train(:,1))
%         train(i,2:10) = ((train(i,2:10) - mu))./(sigma);
%     end
% for loop for train data
input_cell = cell(8,4);
i_cell_count = 1;
for k=1:2:7
    
    tmp_train = train;
    final_l1_output = [];
    final_l2_output = [];
    %kkn classify on the input set
    
    for i = 1: length(train(:,1))
        ip_row = train(i,:);
        tmp_train(i,:) = [];
        
        
        norm_train = tmp_train;
        [Z,mu,sigma] = zscore(norm_train(:,2:10));
        
        tmp = [norm_train(:,1),Z,norm_train(:,11)];
        norm_train  = tmp;
        tmp_train = norm_train;
        aaaa = ip_row(2:10);
        ip_row(2:10) = ((ip_row(2:10) - mu))./(sigma);

        [opt_m_l1, opt_m_l2] = knn_classity(tmp_train, ip_row, k);
        tmp_train = train;
        final_l1_output = [final_l1_output;opt_m_l1];
        final_l2_output = [final_l2_output;opt_m_l2];
    end
    
    %disp('k =1 l1 TRAIN accuracy')
    acc = new_accuracy(final_l1_output,k);
    input_cell{i_cell_count,1} = k;
    input_cell{i_cell_count,2} = 'L1';
    input_cell{i_cell_count,3} = acc(1);
    input_cell{i_cell_count,4} = acc(2);
    i_cell_count =i_cell_count + 1;
    %%acc
    %disp('k =1 l2 TRAIN accuracy')
    acc = new_accuracy(final_l2_output,k);
    input_cell{i_cell_count,1} = k;
    input_cell{i_cell_count,2} = 'L2';
    input_cell{i_cell_count,3} = acc(1);
    input_cell{i_cell_count,4} = acc(2);
    i_cell_count =  i_cell_count + 1;
    %acc
    
end
disp('--------------------------------------------------------------------------------------------');
disp('kNN');
disp ('ACCURACY ON TRINING DATA USING LEAVE ONE OUT')
input_cell


output_cell = cell(8,4);
o_cell_count = 1;




norm_train = train;
[Z,mu,sigma] = zscore(norm_train(:,2:10));

tmp = [norm_train(:,1),Z,norm_train(:,11)];
norm_train  = tmp;
train = norm_train;

for k=1:2:7
    tmp_train = train;
    final_l1_output = [];
    final_l2_output = [];
    %kkn classify on the test set
    for i = 1: length(test(:,1))
        ip_row = test(i,:);
        %tmp_train(i,:) = [];
        
        ip_row(2:10) = ((ip_row(2:10) - mu))./(sigma);
        
        [opt_m_l1, opt_m_l2] = knn_classity(tmp_train, ip_row, k);
        %tmp_train = [tmp_train;ip_row];
        %         if k ==7 && i==4
        %             disp('Here')
        %         end
        
        final_l1_output = [final_l1_output;opt_m_l1];
        final_l2_output = [final_l2_output;opt_m_l2];
    end
    
    % disp('k =1 l1 TEST accuracy')
    acc = new_accuracy(final_l1_output,k);
    output_cell{o_cell_count,1} = k;
    output_cell{o_cell_count,2} = 'L1';
    output_cell{o_cell_count,3} = acc(1);
    output_cell{o_cell_count,4} = acc(2);
    o_cell_count = o_cell_count + 1;
    %acc
    %disp('k =1 l2 TEST accuracy')
    acc = new_accuracy(final_l2_output,k);
    output_cell{o_cell_count,1} = k;
    output_cell{o_cell_count,2} = 'L2';
    output_cell{o_cell_count,3} = acc(1);
    output_cell{o_cell_count,4} = acc(2);
    o_cell_count = o_cell_count + 1;
    %acc
    
end
disp ('ACCURACY ON TEST DATA')
output_cell

disp('--------------------------------------------------------------------------------------------');


end

