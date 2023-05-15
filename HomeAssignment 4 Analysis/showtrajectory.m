function showtrajectory(X_true,X_est,X_p,W_p,bp)
%X_est,X_p,W_p,bp
%X_true     true trajectory
%X_est      estimated trajectory
%bp         boolean false - no particles, true - plot particles
%X_p        particles
%W_p        weight of particles

figure(1)
clf
hold on
plot([1+i 1+9*i 5+9*i])
plot([7+9*i 11+9*i 11+i 7+i]);plot([5+i 1+i])
plot([2+5.2*i 2+8.3*i 4+8.3*i 4+5.2*i 2+5.2*i])%House 1
plot([2+3.7*i 2+4.4*i 4+4.4*i 4+3.7*i 2+3.7*i])%House 2
plot([2+2*i 2+3.2*i 4+3.2*i 4+2*i 2+2*i])%House 3
plot([5+i 5+2.2*i 7+2.2*i 7+i])%House 4
plot([5+2.8*i 5+5.5*i 7+5.5*i 7+2.8*i 5+2.8*i])%House 5

plot([5+6.2*i 5+9*i]);plot([7+9*i 7+6.2*i 5+6.2*i])%House 6
plot([8+4.6*i 8+8.4*i 10+8.4*i 10+4.6*i 8+4.6*i])%House 7
plot([8+2.4*i 8+4*i 10+4*i 10+2.4*i 8+2.4*i])%House 8
plot([8+1.7*i 8+1.8*i 10+1.8*i 10+1.7*i 8+1.7*i])%House 9

axis([0.8 11.2 0.8 9.2])
title('A map of the village','FontSize',20)

plot([X_true(1,:)+X_true(2,:)*1i],'-*')
plot([X_est(1,:)+X_est(2,:)*1i],'-*','Color','cyan',lineWidth=1)

if bp==1
    n = length(X_est);
    Pblue=[];
    Pred=[];
    for k= 1:5:n
        m = length(X_p(:,:,k));
        for j=1:m
            if W_p(j,k)==0
                Pblue=[Pblue X_p(:,j,k)];
            else
                Pred=[Pred X_p(:,j,k)];
            end
        end
    end
    scatter(Pblue(1,:),Pblue(2,:),5,'blue','filled')
    scatter(Pred(1,:),Pred(2,:),5,'red','filled')
end

end