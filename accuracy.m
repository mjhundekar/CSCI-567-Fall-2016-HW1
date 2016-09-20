function op_accuracy = accuracy(ip_matrix, kernel)
    i =1;
    acc = 0;
    while (i <=length(ip_matrix(:,1)))
        match = 0;
        unmatch = 0;
        if kernel > 1
            for j = 1 : kernel
                if ip_matrix(i,2)==ip_matrix(i,5)
                    match = match + 1;
                else
                    unmatch = unmatch + 1;
                end
                i = i + 1;
            end
            if match >= (kernel/2)
                acc = acc+1;
            end
        else
            if ip_matrix(i,2)==ip_matrix(i,5)
                acc = acc + 1;
            end
            i = i + 1;
        end
    end
    
    op_accuracy = [(acc/( length(ip_matrix(:,1))/ kernel) )*100, acc];
   
end

