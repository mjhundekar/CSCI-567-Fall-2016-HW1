function [] = final_naive_bayes( train,test )
% test = csvread('test.txt');
% train = csvread('train.txt');




train_split = arrayfun(@(x) train(train(:,11) == x, :), unique(train(:,11)), 'uniformoutput', false);
test_split = arrayfun(@(x) test(test(:,11) == x, :), unique(test(:,11)), 'uniformoutput', false);

train_pdf_all = cell(6,1);
for i=1:length(train_split)
   m = train_split{i};
   vector_pdf = [];
   for  j =2:10
       vector_pdf = [vector_pdf,fitdist(m(:,j),'Normal')]; 
   end
   train_pdf_all{i,2} = vector_pdf;
   train_pdf_all{i,1} = m(1,11); 
end

test_pdf_all = cell(6,1);
for i=1:length(test_split)
   m = test_split{i};
   vector_pdf = [];
   for  j =2:10
       vector_pdf = [vector_pdf,fitdist(m(:,j),'Normal')]; 
   end
   test_pdf_all{i,2} = vector_pdf;
   test_pdf_all{i,1} = m(1,11); 
end

%Calculate the probabily of Y on training set

y_label_prb=unique(train(:,11));

y_prob = [];
for i =1:length(y_label_prb(:,1))
    j = y_label_prb(i);
    y_cnt = length(train(train(:,11) == j));
    p = y_cnt / length(train(:,1));
    y_prob = [y_prob;p];
end

y_label_prb = [y_label_prb,y_prob];

p_y_curr_row = [];
for i = 1: length(train(:,1))
    curr_row = train(i,:);
    orig_label = curr_row(11);
    %y = pdf(pd, 1.51)
    %simulates P(X=1.51/y=c)
    p_y_curr_row_curr_label=[];
    for j =1:length(y_label_prb(:,1))
        
        curr_label = y_label_prb(j,1);
        p_y = 1;
        for k =1:9
            curr_Xn_pdf = train_pdf_all{j,2};
            p_y = p_y * pdf(curr_Xn_pdf(k),curr_row(k+1));
        end
        p_y = p_y *  y_label_prb(j,2);
        p_y_curr_row_curr_label = [p_y_curr_row_curr_label;curr_label,p_y];
    end
    %[M,I] = max(A(:))
    %ind2sub(size(A),5)
    [M,I] = max(p_y_curr_row_curr_label(:,2));
    [r,c] = ind2sub(size(p_y_curr_row_curr_label),I);
    %p_y_curr_row_curr_label = sortrows(p_y_curr_row_curr_label,2);
    top_row = p_y_curr_row_curr_label(r,:);
    p_y_curr_row = [p_y_curr_row; curr_row(1), orig_label,top_row];
    
end

acc = 0;
for i =1: length(p_y_curr_row(:,1))
    if p_y_curr_row(i,2) == p_y_curr_row(i,3)
        acc = acc+1;
    end
end


disp('--------------------------------------------------------------------------------------------');
disp('Naive Bayes');
disp ('ACCURACY ON TRAINING DATA')
(acc/length(p_y_curr_row(:,1)))*100


p_y_curr_row = [];
for i = 1: length(test(:,1))
    curr_row = test(i,:);
    orig_label = curr_row(11);
    %y = pdf(pd, 1.51)
    %simulates P(X=1.51/y=c)
    p_y_curr_row_curr_label=[];
    for j =1:length(y_label_prb(:,1))
        
        curr_label = y_label_prb(j,1);
        p_y = 1;
        for k =1:9
            curr_Xn_pdf = test_pdf_all{j,2};
            p_y = p_y * pdf(curr_Xn_pdf(k),curr_row(k+1));
        end
        p_y = p_y *  y_label_prb(j,2);
        p_y_curr_row_curr_label = [p_y_curr_row_curr_label;curr_label,p_y];
    end
    %[M,I] = max(A(:))
    %ind2sub(size(A),5)
    [M,I] = max(p_y_curr_row_curr_label(:,2));
    [r,c] = ind2sub(size(p_y_curr_row_curr_label),I);
    %p_y_curr_row_curr_label = sortrows(p_y_curr_row_curr_label,2);
    top_row = p_y_curr_row_curr_label(r,:);
    p_y_curr_row = [p_y_curr_row; curr_row(1), orig_label,top_row];
    
end

acc = 0;
for i =1: length(p_y_curr_row(:,1))
    if p_y_curr_row(i,2) == p_y_curr_row(i,3)
        acc = acc+1;
    end
end

disp ('ACCURACY ON TESTING DATA')
(acc/length(p_y_curr_row(:,1)))*100


disp('--------------------------------------------------------------------------------------------');



end

